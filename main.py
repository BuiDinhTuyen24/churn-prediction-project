from src.database.extract import load_gold_data
from src.features.preprocess import preprocess
from src.features.split import split_data
from src.model.train_logistic import train_logistic
from src.model.train_random_forest import train_random_forest
from src.model.train_xgboost import train_xgboost
from src.evaluation.metrics import evaluate_model
from src.evaluation.explainability import get_feature_importance
from src.visualization.plot import plot_feature_importance
from src.visualization.plot import plot_roc_curve
from src.evaluation.export_results import export_model_results
from src.visualization.plot import (
    plot_churn_by_contract,
    plot_churn_by_internet_service
)
    
df = load_gold_data()

X, y = preprocess(df)

X_train, X_test, y_train, y_test = split_data(X, y)

print("Train:", X_train.shape)
print("Test :", X_test.shape)

print(y_train.value_counts(normalize=True))
print(y_test.value_counts(normalize=True))

log_model = train_logistic(
    X_train,
    y_train
)
log_report, log_auc = evaluate_model(
    log_model,
    X_test,
    y_test
)

print("=== Logistic ===")
print(log_report)
print("ROC-AUC:", log_auc)

rf_model = train_random_forest(
    X_train,
    y_train
)

rf_report, rf_auc = evaluate_model(
    rf_model,
    X_test,
    y_test
)

print("=== Random Forest ===")
print(rf_report)
print("ROC-AUC:", rf_auc)


xb_model = train_xgboost(
    X_train,
    y_train
)

xb_report, xb_auc = evaluate_model(
    xb_model,
    X_test,
    y_test
)

print("=== XGBoost ===")
print(xb_report)
print("ROC-AUC:", xb_auc)


import joblib

joblib.dump(
    log_model,
    "models/logistic_regression.pkl"
)

joblib.dump(
    rf_model,
    "models/random_forest.pkl"
)

joblib.dump(
    xb_model,
    "models/xgboost.pkl"
)

print("Models saved successfully!")

importance_df = get_feature_importance(
    rf_model,
    X_train
)

print(
    importance_df.head(10)
)

plot_feature_importance(importance_df)
print("Feature importance plot saved!")

plot_roc_curve(
    log_model,
    X_test,
    y_test
)

print("ROC curve saved!")
plot_churn_by_contract(df)

plot_churn_by_internet_service(df)

print("Business charts saved!")
results = {
    "Model": [
        "Logistic Regression",
        "Random Forest",
        "XGBoost"
    ],

    "ROC_AUC": [
        log_auc,
        rf_auc,
        xb_auc
    ]
}

export_model_results(
    results, log_model, rf_model, xb_model, X_test, y_test, importance_df, df
)

print("Model performance report exported!")

