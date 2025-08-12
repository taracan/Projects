####################################################
# Load Libraries and Dataset
####################################################

library(readr)
library(dplyr)
library(caret)
library(e1071)
library(forcats)
library(randomForest)
library(ranger)
library(Metrics)
library(iml)
library(fastshap)
library(ggplot2)
library(reshape2)

# Read data
df <- read_csv("DataCoSupplyChainDataset.csv")

# Clean column names
names(df) <- make.names(names(df))

# Convert date columns
df$order_date <- as.Date(df$order.date..DateOrders., format = "%m/%d/%Y")
df$ship_date <- as.Date(df$shipping.date..DateOrders., format = "%m/%d/%Y")
df$order.date..DateOrders. <- NULL
df$shipping.date..DateOrders. <- NULL

####################################################
# Drop Irrelevant/PII/Leaky Columns
####################################################

drop_cols <- c(
  "Customer.Email", "Customer.Fname", "Customer.Lname", "Customer.Password", 
  "Customer.Street", "Customer.Zipcode", "Order.Id", "Order.Customer.Id", 
  "Order.Item.Id", "Product.Card.Id", "Product.Category.Id", "Product.Image", 
  "Product.Description", "Product.Name", "Category.Id", "Customer.Id", 
  "Department.Id", "Order.Item.Cardprod.Id", "Product.Status", 
  "Late_delivery_risk"
)
df <- df[ , !(names(df) %in% drop_cols)]

####################################################
# Feature Engineering
####################################################

df$delay_days <- df$Days.for.shipping..real. - df$Days.for.shipment..scheduled.
df$is_late <- ifelse(df$delay_days > 0, 1, 0)
df$discount_ratio <- df$Order.Item.Discount / df$Product.Price
df$high_margin <- ifelse(df$Benefit.per.order > median(df$Benefit.per.order, na.rm = TRUE), 1, 0)
df$heavy_order <- factor(ifelse(df$Order.Item.Quantity >= 3, 1, 0))

# Convert to factor
cat_vars <- c(
  "Shipping.Mode", "Customer.Segment", "Category.Name", "Department.Name", 
  "Market", "Order.City", "Order.Country", "Order.Region", "Order.State", 
  "Order.Status", "Delivery.Status"
)
df[cat_vars] <- lapply(df[cat_vars], as.factor)

# Final NA check
df <- df[ , !(names(df) %in% c("Order.Zipcode"))]
colSums(is.na(df))

####################################################
# Limit Cardinality and Sample
####################################################

df <- df %>%
  mutate(
    Order.State = fct_lump(Order.State, n = 10),
    Order.Region = fct_lump(Order.Region, n = 10),
    Customer.Segment = fct_lump(Customer.Segment, n = 5),
    Shipping.Mode = fct_lump(Shipping.Mode, n = 5)
  )

set.seed(123)
df_sample <- df %>%
  select(is_late, Shipping.Mode, Customer.Segment, discount_ratio,
         Order.Item.Quantity, Benefit.per.order, high_margin, heavy_order,
         Order.Region, Order.State) %>%
  na.omit() %>%
  sample_n(10000)
df_sample$is_late <- as.factor(df_sample$is_late)

# Train-Test Split
set.seed(42)
split_index <- createDataPartition(df_sample$is_late, p = 0.8, list = FALSE)
train_data <- df_sample[split_index, ]
test_data  <- df_sample[-split_index, ]

# Align factor levels
factor_cols <- sapply(train_data, is.factor)
for (col in names(train_data)[factor_cols]) {
  test_data[[col]] <- factor(test_data[[col]], levels = levels(train_data[[col]]))
}

####################################################
# Logistic Regression Model
####################################################

log_model <- glm(is_late ~ ., data = train_data, family = "binomial")
log_probs <- predict(log_model, newdata = test_data, type = "response")
log_preds <- ifelse(log_probs > 0.5, "1", "0") |> factor(levels = c("0", "1"))

cat("\nLogistic Regression Performance:\n")
print(confusionMatrix(log_preds, test_data$is_late, positive = "1"))

####################################################
# Random Forest Classification Model
####################################################

rf_model <- randomForest(is_late ~ ., data = train_data, ntree = 100, importance = TRUE)
rf_preds <- predict(rf_model, newdata = test_data)

cat("\nRandom Forest Classification Performance:\n")
print(confusionMatrix(rf_preds, test_data$is_late, positive = "1"))

####################################################
# Linear & Random Forest Regression (is_late == 1)
####################################################

df_reg <- df %>%
  filter(is_late == 1) %>%
  select(delay_days, discount_ratio, Order.Item.Quantity, Benefit.per.order, 
         high_margin, heavy_order, Shipping.Mode, Customer.Segment,
         Order.Region, Order.State) %>%
  na.omit() %>%
  mutate(
    Shipping.Mode = fct_lump(Shipping.Mode, n = 5),
    Customer.Segment = fct_lump(Customer.Segment, n = 5),
    Order.Region = fct_lump(Order.Region, n = 10),
    Order.State = fct_lump(Order.State, n = 10)
  )

set.seed(42)
split_index <- createDataPartition(df_reg$delay_days, p = 0.8, list = FALSE)
train_data <- df_reg[split_index, ]
test_data  <- df_reg[-split_index, ]

# Linear Regression
lm_model <- lm(delay_days ~ ., data = train_data)
pred_lm <- predict(lm_model, test_data)

# Random Forest Regression using ranger
rf_model <- ranger(delay_days ~ ., data = train_data, num.trees = 50, importance = "impurity", seed = 123)
pred_rf <- rf_model$predictions

# Evaluation Metrics
mae_lm <- mae(test_data$delay_days, pred_lm)
rmse_lm <- rmse(test_data$delay_days, pred_lm)
rsq_lm <- summary(lm_model)$r.squared

mae_rf <- mae(test_data$delay_days, pred_rf)
rmse_rf <- rmse(test_data$delay_days, pred_rf)
rsq_rf <- summary(rf_model)$r.squared

cat("\nLinear Regression – MAE:", round(mae_lm, 4), "| RMSE:", round(rmse_lm, 4), "| R²:", round(rsq_lm, 4), "\n")
cat("Random Forest     – MAE:", round(mae_rf, 4), "| RMSE:", round(rmse_rf, 4), "| R²:", round(rsq_rf, 4), "\n")

####################################################
# SHAP Values Using fastshap
####################################################
# Subset features for SHAP
X <- train_data[, setdiff(names(train_data), "delay_days")]
y <- train_data$delay_days

# ✅ Ensure X is a proper data frame
X <- as.data.frame(X)

# ✅ Sample 500 rows
set.seed(42)
X_small <- X[sample(nrow(X), 500), ]

# ✅ SHAP: fastshap with ranger
shap_values <- fastshap::explain(
  object = rf_model,
  X = X_small,
  pred_wrapper = function(object, newdata) {
    predict(object, data = newdata)$predictions
  },
  nsim = 30,
  n_jobs = parallel::detectCores(logical = FALSE)
)
library(reshape2)
library(ggplot2)

shap_long <- melt(abs(shap_values))

ggplot(shap_long, aes(x = value, y = variable)) +
  geom_boxplot() +
  labs(
    x = "SHAP Value (|impact|)", 
    y = "Feature", 
    title = "SHAP Feature Importance (Ranger)"
  ) +
  theme_minimal()
