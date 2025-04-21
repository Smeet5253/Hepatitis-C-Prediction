# Hepatitis-C-Prediction

This project focuses on predicting Hepatitis C infection stages using various machine learning models. The work involves data preprocessing, oversampling techniques to handle imbalanced data, feature selection, and model evaluation to determine the best classifier for the task.

📁 Dataset
Source: Kaggle - Hepatitis C Dataset
Original Reference: UCI Machine Learning Repository
Records: 615
Features: 14 (Numerical & Categorical)

🧪 Preprocessing Steps
Handled missing values using Mean Imputation
Converted categorical variables (like Category and Sex) to numeric using as.factor
Dealt with class imbalance using SMOTE (Synthetic Minority Oversampling Technique)
Split the dataset into 70% training and 30% testing
Feature selection using Random Forest Recursive Feature Elimination (RFE)

⚙️ Machine Learning Models Used
Algorithm	Accuracy	Precision	Sensitivity	Specificity
Logistic Regression	89.40%	86.70%	93.62%	85.00%
Random Forest	88.59%	82.88%	97.87%	78.89%
KNN	87.50%	86.59%	89.36%	85.56%
SVM	86.41%	82.55%	93.09%	79.44%
Naive Bayes	85.33%	83.50%	88.83%	81.67%

📂 Files Included
CP_imputed.csv: Cleaned and preprocessed dataset
RF_Final.R: Final code for Random Forest implementation
KNN_Final.R: Final code for KNN and other models using caret
CP_Final.R: Combined workflow for preprocessing, SMOTE, and modeling
Project_Report.docx: Detailed report including methodology, algorithms, results, and literature survey

🔍 Feature Selection
Initial features: All 14 features
Final selected features: Sex, AST, ALT, GGT, Age
Method used: RFE with Random Forest

🧠 Libraries Used
caret – model training and cross-validation
ROSE – SMOTE implementation
randomForest – Random Forest algorithm
e1071 – Naive Bayes
imputeTS – Handling missing values
dplyr – Data manipulation

📊 Evaluation Metrics
Accuracy
Precision
Sensitivity (Recall)
Specificity
Confusion Matrix
ROC Curve (through caret)

📝 Conclusion
Random Forest gave the best results in terms of sensitivity.
Logistic Regression showed the highest overall accuracy.
Naive Bayes and KNN performed reasonably well, though KNN suffered from overfitting initially.
SVM required kernel tuning for optimal results.
Feature selection improved model performance and reduced overfitting.

📚 References
A detailed literature survey is included in Project_Report.docx with insights from 15+ recent papers published in journals like IEEE, Hindawi, Springer, MDPI, etc.

🧪 How to Run
Open any of the .R scripts in RStudio.
Make sure all required libraries are installed.
Run the script step-by-step. Make sure the CP_imputed.csv file is in your working directory.
Review model performance metrics printed in the console.
