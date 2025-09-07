# Diabetes Health Indicators Project  

## Project Overview  
This project applies **Business Analytics with R** to analyze the **2015 Behavioral Risk Factor Surveillance System (BRFSS) dataset** with over 253,000 responses. The goal is to identify key health indicators and risk factors for diabetes and to build predictive models that support early detection and targeted interventions.  

Diabetes is a growing global challenge, with prevalence projected to reach 1 in 8 adults by 2045. Using predictive analytics, this study provides actionable insights for healthcare providers, policymakers, and public health campaigns.  

---

## Key Objectives  
- Identify critical predictors of diabetes.  
- Build and evaluate predictive models using **logistic regression, classification trees, and neural networks**.  
- Address data imbalance and ensure reliable performance through sensitivity, specificity, and AUC metrics.  
- Provide actionable insights for **healthcare strategy, policy design, and resource allocation**.  

---

## Dataset  
- **Source**: 2015 BRFSS dataset (CDC), accessed via Kaggle.  
- **Size**: 253,680 responses.  
- **Target Variable**:  
  - `0`: No diabetes or diabetes only during pregnancy  
  - `1`: Diabetes  
- **Key Features Used** (13 selected): BMI, High Blood Pressure, High Cholesterol, Smoking Status, Physical Activity, General Health, Age, Income, and others.  
- **Imbalance**: 218,334 non-diabetic vs. 35,346 diabetic cases.  

---

## Data Preparation  
- Removed records with missing values.  
- Converted categorical variables into factors.  
- Encoded categorical predictors for model compatibility.  
- Selected the 13 most predictive variables.  
- Conducted summary statistics, correlation analysis, and visualizations (e.g., BMI distribution, health indicators by diabetes status).  

---

## Models & Results  

### Logistic Regression  
- **AUC**: 0.818  
- **Accuracy**: 86.53%  
- **Key Predictors**: High Blood Pressure, Cholesterol, BMI  
- Provides interpretable and actionable results for healthcare decision-making.  

### Classification Tree  
- **Validation Accuracy**: 86.52%  
- Dimension reduction applied using Correspondence Analysis.  
- Achieved strong balance between simplicity and predictive accuracy.  

### Neural Network  
- **Architecture**: 1 hidden layer, 10 neurons, decay = 0.1, 200 iterations  
- **Accuracy**: 86.53%  
- **Recall (Sensitivity)**: 87.75%  
- High recall but higher false positive rate compared to other models.  

---

## Managerial Implications  
- **Healthcare Strategy**: Focus prevention programs on individuals with high blood pressure, cholesterol, and BMI.  
- **Policy Design**: Leverage high recall from neural networks to guide screening and early detection in at-risk populations.  
- **Public Health Campaigns**: Promote lifestyle changes (diet, exercise) backed by data-driven evidence.  
- **Resource Allocation**: Use interpretable logistic regression metrics to support budget justifications and targeted interventions.  

---

## Tools & Technologies  
- **R Programming** (tidyverse, caret, nnet, rpart, NeuralNetTools)  
- **Data Visualization**: Boxplots, correlation matrices, health indicator distributions  
- **Techniques**: Logistic Regression, Classification Trees, Neural Networks, Correspondence Analysis  

---

## Conclusion  
This study demonstrates the power of predictive analytics in healthcare.  
- **Logistic regression** offers interpretability and robust insights.  
- **Classification trees** provide simplicity and effectiveness.  
- **Neural networks** deliver strong recall but need refinement for precision.  

Key takeaway: **High blood pressure, cholesterol, and BMI are critical predictors of diabetes risk.**  
Predictive modeling can inform early detection, improve resource allocation, and support better healthcare outcomes.  

---

## Contributors  
- Aishwarya Balmoori  
- Krishna Priyanka Challa  
- Peihua Tsai  
- Tara Canugovi  

3. [National Diabetes Statistics Report – CDC](https://www.cdc.gov/diabetes/php/data-research/index.html)  
4. [WHO – Urgent action needed on rising diabetes cases](https://www.who.int/news/item/13-11-2024-urgent-action-needed-as-global-diabetes-cases-increase-four-fold-over-past-decades)  
