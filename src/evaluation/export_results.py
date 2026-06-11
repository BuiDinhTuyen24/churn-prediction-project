import os
import pandas as pd
from sklearn.metrics import roc_curve, roc_auc_score


def export_model_results(results_dict, log_model, rf_model, xb_model, X_test, y_test, importance_df, df_origin):
    # 1. Ghi đè/Lưu file model_performance.csv gốc của bạn
    df_perf = pd.DataFrame(results_dict)
    os.makedirs("outputs/reports", exist_ok=True)
    df_perf.to_csv("outputs/reports/model_performance.csv", index=False)
    print("Saved: outputs/reports/model_performance.csv")

    # 2. Xuất dữ liệu tọa độ ROC-AUC cho biểu đồ đường
    roc_data_list = []
    models_dict = {
        "Logistic Regression": log_model,
        "Random Forest": rf_model,
        "XGBoost": xb_model,
    }

    for model_name, model in models_dict.items():
        if hasattr(model, "predict_proba"):
            y_probs = model.predict_proba(X_test)[:, 1]
        else:
            y_probs = model.predict(X_test)

        fpr, tpr, _ = roc_curve(y_test, y_probs)
        auc_score = roc_auc_score(y_test, y_probs)

        df_temp = pd.DataFrame(
            {"Model": model_name, "FPR": fpr, "TPR": tpr, "AUC": auc_score}
        )
        roc_data_list.append(df_temp)

    model_performance_df = pd.concat(roc_data_list, ignore_index=True)
    model_performance_df.to_csv(
        "outputs/reports/model_performance_roc.csv", index=False
    )
    print("Saved: outputs/reports/model_performance_roc.csv")

    # 3. Feature Importance
    importance_df.to_csv("outputs/reports/feature_importance.csv", index=False)
    print("Saved: outputs/reports/feature_importance.csv")

    # 4. Dashboard 
    df_origin.to_csv("outputs/reports/churn_business_data.csv", index=False)
    print("Saved: outputs/reports/churn_business_data.csv")

    return df_perf