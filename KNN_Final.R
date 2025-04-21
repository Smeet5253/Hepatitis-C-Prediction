# Load the required packages
library(caret)
library(ROSE)  # For SMOTE
library(e1071) # For Naive Bayes

# Assuming you have data containing both input features and target variable
data <- read.csv("CP_imputed.csv")

# Convert the target variable to a factor with two levels
data$Category <- as.factor(data$Category)

levels(data$Category) <- make.names(levels(data$Category))

# Split the data into 70% training and 30% testing
set.seed(123)
trainIndex <- createDataPartition(data$Category, p = 0.7, 
                                  list = FALSE, 
                                  times = 1)
data_train <- data[trainIndex,]
data_test <- data[-trainIndex,]

# Set up 10-fold cross-validation control with Accuracy as the evaluation metric
ctrl <- trainControl(
  method = "cv",        # Cross-validation
  number = 10,          # Number of folds (10-fold)
  classProbs = TRUE,    # To get class probabilities
  summaryFunction = twoClassSummary,  # Evaluation metrics
  preProcOptions = list(thresh = 0.8),  # Threshold for removing near-zero variance predictors
  selectionFunction = "best",  # Select the best model based on Accuracy
  savePredictions = "final"  # Save final predictions for test set
)

# Apply SMOTE to balance the class distribution in the training data
data_train_balanced <- ovun.sample(Category ~ ., data = data_train, method = "both", N = 2 * nrow(data_train), seed = 42)$data

# Train the Naive Bayes model with cross-validation
model <- train(
  Category ~ .,
  data = data_train_balanced,  # Use the balanced training dataset
  method = "rf",
  trControl = ctrl
)

# Print the cross-validation results
print(model)

# Predict on the test data
predictions <- predict(model, newdata = data_test)

# Access confusion matrix and ROC values from the results
confusion_matrix <- confusionMatrix(predictions, data_test$Category)
roc_values <- model$results$ROC

print("Confusion Matrix:")
print(confusion_matrix)
print("ROC Values:")
print(roc_values)