library(readr)
diabetes_dataset <- read_csv("diabetes_dataset.csv")
head(diabetes_dataset)

#sub-setting data variables -- to consider only useful variables
diabetes.df<-diabetes_dataset[,-c(4,6,8,10,11,13,14,16,21)]
head(diabetes.df)

#------------Data summarization------------
summary(diabetes.df)

data.frame(
  mean = sapply(diabetes.df, mean),
  sd = sapply(diabetes.df, sd),
  min = sapply(diabetes.df, min),
  max = sapply(diabetes.df, max),
  median = sapply(diabetes.df, median),
  length = sapply(diabetes.df, length),
  miss.val = sapply(diabetes.df, function(x) sum(is.na(x)))
)

#------------Correlation-------------
round(cor(diabetes.df),2)
library(ggplot2)
library(dplyr)

# BMI Statistics by Diabetes Status
cat("BMI Statistics by Diabetes Status:\n")
diabetes.df %>%
  group_by(Diabetes_012) %>%
  summarise(mean_BMI = mean(BMI), 
            median_BMI = median(BMI),
            sd_BMI = sd(BMI))

#-------------Data Visualization-----------
## heatmap with correlation values
library(gplots)
heatmap.2(cor(diabetes.df), Rowv = FALSE, Colv = FALSE, dendrogram = "none",
          col = my_colors, cellnote = round(cor(diabetes.df),2),
          notecol = "black", key = FALSE, trace = 'none', margins = c(10,10))
my_colors <- colorRampPalette(c("blue", "white", "purple"))(n = 100)

# BMI Distribution with Diabetes
ggplot(diabetes.df, aes(x = BMI, fill = factor(Diabetes_binary))) + 
  geom_density(alpha = 0.5) + 
  labs(title = "BMI Distribution by Diabetes Status",
       x = "BMI",
       fill = "Diabetes") + 
  theme_minimal()


# Check for outliers in BMI with a boxplot
ggplot(diabetes.df, aes(y = BMI)) +
  geom_boxplot(fill = "lightblue") +
  labs(title = "Boxplot of BMI", y = "BMI") +
  theme_minimal()

# High Blood Pressure Distribution by Diabetes Status
ggplot(diabetes.df, aes(x = factor(HighBP), fill = factor(Diabetes_binary))) +
  geom_bar(position = "dodge") +
  labs(title = "High Blood Pressure by Diabetes Status",
       x = "High Blood Pressure (1 = Yes, 0 = No)",
       fill = "Diabetes") +
  theme_minimal()

ggplot(diabetes.df, aes(x = factor(Diabetes_binary))) +
  geom_bar(position = "dodge") +
  labs(title = "High Blood Pressure by Diabetes Status",
       x = "High Blood Pressure (1 = Yes, 0 = No)",
       fill = "Diabetes") +
  theme_minimal()


# Physical Activity and Diabetes Status 
ggplot(diabetes.df, aes(x = factor(PhysActivity), fill = factor(Diabetes_binary))) +
  geom_bar(position="dodge")+
labs(title = "Physical Activity by Diabetes Status",
     x = "Physical Activity (1 = Yes, 0 = No)",
     fill = "Diabetes") +
  theme_minimal()

#Health and Demographic Factors by Diabetes
# General Health by Diabetes Status
ggplot(diabetes.df, aes(x = factor(GenHlth), fill = factor(Diabetes_binary))) +
  geom_bar(position = "dodge") +
  labs(title = "General Health by Diabetes Status",
       x = "General Health (1 = Excellent, 5 = Poor)",
       fill = "Diabetes") +
  theme_minimal()

# Age and Diabetes
ggplot(diabetes.df, aes(x = factor(Age), fill = factor(Diabetes_binary))) +
  geom_bar(position = "dodge") +
  labs(title = "Age Distribution by Diabetes Status",
       x = "Age Category",
       fill = "Diabetes") +
  theme_minimal()



#-------------Logistic regression-----------------

library(caret)
library(nnet)

diabetes.df$Diabetes_binary<-as.factor(diabetes.df$Diabetes_binary)

# Split the data into training (60%) and test (40%) sets
set.seed(1234)
train_index <- createDataPartition(diabetes.df$Diabetes_binary, p = 0.6, list = FALSE)
train_data <- diabetes.df[train_index, ]
test_data <- diabetes.df[-train_index, ]

# Multinomial logistic regression using 'multinom'
log_model <- train(Diabetes_binary ~ ., data = train_data, method = "multinom")
summary(log_model)

# Make predictions on the test set
log_pred <- predict(log_model, newdata = test_data, type="prob")
summary(log_pred)

library(pROC)
roc_curve <- roc(test_data$Diabetes_binary, log_pred[,2])  # Actual vs predicted probabilities

# Plot the ROC curve
plot(roc_curve, col = "blue", lwd = 2, main = "ROC Curve: Logistic Regression")
abline(a = 0, b = 1, lty = 2, col = "red")  # Add diagonal line for reference

# Calculate AUC (Area Under Curve)
auc_value <- auc(roc_curve)
cat("AUC:", auc_value, "\n")

# Evaluate model performance
conf_matrix_lm <- confusionMatrix(log_pred, test_data$Diabetes_binary)
print(conf_matrix_lm)

# Visualize the Confusion Matrix
conf_matrix_table_lm <- as.data.frame(conf_matrix_lm$table)
ggplot(conf_matrix_table_lm, aes(x = Prediction, y = Reference, fill = Freq)) +
  geom_tile() +
  geom_text(aes(label = Freq), color = "white") +
  scale_fill_gradient(low = "blue", high = "red") +
  labs(title = "Confusion Matrix: Logistic Regression", x = "Predicted Class", y = "Actual Class") +
  theme_minimal()

# Calculate and display performance metrics
accuracy <- sum(diag(conf_matrix_lm$table)) / sum(conf_matrix_lm$table)
cat("Logistic Regression Accuracy:", round(accuracy * 100, 2), "%\n")

#-------Classification-------
#change type of target variable to factor
diabetes_dataset$Diabetes_binary<-as.factor(diabetes_dataset$Diabetes_binary)

#change type of nominal variable to factor
diabetes_dataset$HighBP<-as.factor(diabetes_dataset$HighBP)
diabetes_dataset$HighChol<-as.factor(diabetes_dataset$HighChol)
diabetes_dataset$CholCheck<-as.factor(diabetes_dataset$CholCheck)
diabetes_dataset$Smoker<-as.factor(diabetes_dataset$Smoker)
diabetes_dataset$Stroke<-as.factor(diabetes_dataset$Stroke)
diabetes_dataset$HeartDiseaseorAttack<-as.factor(diabetes_dataset$HeartDiseaseorAttack)
diabetes_dataset$PhysActivity<-as.factor(diabetes_dataset$PhysActivity)
diabetes_dataset$Fruits<-as.factor(diabetes_dataset$Fruits)
diabetes_dataset$Veggies<-as.factor(diabetes_dataset$Veggies)
diabetes_dataset$HvyAlcoholConsump<-as.factor(diabetes_dataset$HvyAlcoholConsump)
diabetes_dataset$AnyHealthcare<-as.factor(diabetes_dataset$AnyHealthcare)
diabetes_dataset$NoDocbcCost<-as.factor(diabetes_dataset$NoDocbcCost)
diabetes_dataset$GenHlth<-as.factor(diabetes_dataset$GenHlth)
diabetes_dataset$DiffWalk<-as.factor(diabetes_dataset$DiffWalk)
diabetes_dataset$Sex<-as.factor(diabetes_dataset$Sex)
diabetes_dataset$Education<-as.factor(diabetes_dataset$Education)
diabetes_dataset$Income<-as.factor(diabetes_dataset$Income)

library(rpart)
library(rpart.plot)
library(caret)

#classification tree
tree1<-rpart(Diabetes_binary ~ ., data = train_data, parms = list(split = 'information'),method = "class", control = rpart.control(cp = 0.001))
#plot tree
prp(tree1, type = 1, extra = 2, under = TRUE, split.font = 1, varlen = -10)
# count number of leaves
length(tree1$frame$var[tree1$frame$var == "<leaf>"])
#predict
predT_tree<-predict(tree1, train_data, na.action = na.pass)
predV_tree<-predict(tree1, test_data, na.action = na.pass)

pred_class <- predict(tree1, train_data, type = "class")
accuracy <- mean(pred_class == train_data$Diabetes_binary)
print(paste("Training Accuracy:", round(accuracy * 100, 2), "%"))

#----------------- dimension reduction--------------
library(FactoMineR)
library(factoextra)

# Perform Correspondence Analysis
ca_result <- CA(diabetes.df[,c(8,9,10)], graph = FALSE)
# Summary of results
summary(ca_result)
# Plot results
plot(ca_result)

# Visualize results
fviz_ca_biplot(ca_result, repel = TRUE)
dim_diabetes.df<-diabetes.df[,-c(9,10)]

#tree2 with cp = 0.0005
set.seed(123)  
train2.index <- sample(c(1:dim(dim_diabetes.df)[1]), dim(dim_diabetes.df)[1]*0.6)  
train2<- dim_diabetes.df[train2.index, ]
test2<- dim_diabetes.df[-train2.index, ]

tree2<-rpart(Diabetes_binary ~ ., data = train2, parms = list(split = 'information'),method = "class", control = rpart.control(cp = 0.0005))
#plot tree
prp(tree2, type = 1, extra = 2, under = TRUE, split.font = 1, varlen = -10)
#predict
pred_class <- predict(tree2, test2, type = "class")
accuracy <- mean(pred_class == test2$Diabetes_binary)
print(paste("Testing Accuracy:", round(accuracy * 100, 2), "%"))

# Evaluate the model using confusion matrix
conf_matrix_ct <- confusionMatrix(pred_class, test2$Diabetes_binary)  # Corrected the target variable
print(conf_matrix_ct)

# Visualize the Confusion Matrix
conf_matrix_table_ct <- as.data.frame(conf_matrix_ct$table)
ggplot(conf_matrix_table_ct, aes(x = Prediction, y = Reference, fill = Freq)) +
  geom_tile() +
  geom_text(aes(label = Freq), color = "white") +
  scale_fill_gradient(low = "blue", high = "red") +
  labs(title = "Confusion Matrix: Classification Tree", x = "Predicted Class", y = "Actual Class") +
  theme_minimal()

# Calculate and display performance metrics
accuracy <- sum(diag(conf_matrix_ct$table)) / sum(conf_matrix_ct$table)
cat("Classification Tree Accuracy:", round(accuracy * 100, 2), "%\n")


#----------------- Neural Network (independent variable should be numeric)-------
# Load necessary libraries
library(nnet)
library(caret)
library(ggplot2)
library(Neuralnettools)

# Ensure the target variable is a factor
data$Diabetes_binary <- as.factor(data$Diabetes_binary)

# Split the data into training (60%) and test (40%) sets
set.seed(1234)
train_index <- createDataPartition(data$Diabetes_binary, p = 0.6, list = FALSE)
train_data <- data[train_index, ]
test_data <- data[-train_index, ]

# Train a Neural Network
set.seed(123)
nn_model <- nnet(
  Diabetes_binary ~ .,                # Formula: target ~ predictors
  data = train_data,                  # Training dataset
  size = 10,                          # Number of neurons in the hidden layer
  decay = 0.1,                        # Regularization parameter to avoid overfitting
  maxit = 200,                        # Maximum number of iterations
  linout = FALSE                      # Classification task (not linear output)
)

# Display the summary of the neural network model
summary(nn_model)

# Predict on the test dataset
nn_predictions <- predict(nn_model, test_data, type = "class")
nn_predictions <- factor(nn_predictions, levels = levels(test_data$Diabetes_binary))  # Match factor levels

# Evaluate the model using confusion matrix
conf_matrix_nn <- confusionMatrix(nn_predictions, test_data$Diabetes_binary)  # Corrected the target variable
print(conf_matrix_nn)

# Visualize the Confusion Matrix
conf_matrix_table_nn <- as.data.frame(conf_matrix_nn$table)
ggplot(conf_matrix_table_nn, aes(x = Prediction, y = Reference, fill = Freq)) +
  geom_tile() +
  geom_text(aes(label = Freq), color = "white") +
  scale_fill_gradient(low = "blue", high = "red") +
  labs(title = "Confusion Matrix: Neural Network", x = "Predicted Class", y = "Actual Class") +
  theme_minimal()

# Plot the Neural Network Structure
plotnet(nn_model, circle_col = "lightblue", node_labs = TRUE)

# Calculate and display performance metrics
accuracy <- sum(diag(conf_matrix_nn$table)) / sum(conf_matrix_nn$table)
cat("Neural Network Accuracy:", round(accuracy * 100, 2), "%\n")
