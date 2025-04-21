# Load the required packages
library(caret)
library(ROSE)  # For SMOTE
library(randomForest)

# Assuming you have data containing both input features and target variable
data <- read.csv("CP_imputed.csv")

# Convert the target variable to a factor with two levels
data$Category <- as.factor(data$Category)

levels(data$Category) <- make.names(levels(data$Category))

# Split the data into training (70%) and testing (30%) sets
set.seed(123)
trainIndex <- createDataPartition(data$Category, p = 0.7, 
                                  list = FALSE,
                                  times = 1)
data_train <- data[trainIndex,]
data_test <- data[-trainIndex,]

# Apply SMOTE to balance the class distribution in the training data
data_balanced <- ovun.sample(Category ~ ., data = data_train, method = "both", N = 2 * nrow(data_train), seed = 42)$data

# Set up cross-validation control with 10-fold cross-validation
ctrl <- trainControl(
  method = "cv",        # Cross-validation
  number = 10,          # Number of folds (10-fold)
  classProbs = TRUE,    # To get class probabilities
  summaryFunction = twoClassSummary,  # Evaluation metrics
  preProcOptions = list(thresh = 0.8),  # Threshold for removing near-zero variance predictors
  selectionFunction = "best",  # Select the best model based on Accuracy
  savePredictions = "final"  # Save final predictions for test set
)

# Train the Random Forest model with cross-validation
model <- train(
  Category ~ .,
  data = data_balanced,  # Use the balanced training dataset
  method = "rf",        # Random Forest
  trControl = ctrl
)

# Print the cross-validation results
print(model)

# Make predictions on the test data
predictions <- predict(model, newdata = data_test)

# Access confusion matrix and ROC values for the test predictions
confusion_matrix <- confusionMatrix(predictions, data_test$Category)
roc_values <- model$results$ROC

print("Confusion Matrix:")
print(confusion_matrix)
print("ROC Values:")
print(roc_values)
