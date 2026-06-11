import matplotlib.pyplot as plt
from sklearn.metrics import roc_curve, auc
import pandas as pd

def plot_feature_importance(importance_df, top_n=10):

    top_features = importance_df.head(top_n)

    plt.figure(figsize=(10, 6))

    plt.barh(
        top_features["feature"],
        top_features["importance"]
    )

    plt.xlabel("Importance")
    plt.ylabel("Feature")
    plt.title("Top Feature Importance")

    plt.tight_layout()

    plt.savefig(
        "outputs/figures/feature_importance.png"
    )

    plt.close()


def plot_roc_curve(model, X_test, y_test):

    probs = model.predict_proba(X_test)[:, 1]

    fpr, tpr, _ = roc_curve(
        y_test,
        probs
    )

    roc_auc = auc(
        fpr,
        tpr
    )

    plt.figure(figsize=(8, 6))

    plt.plot(
        fpr,
        tpr,
        label=f"AUC = {roc_auc:.3f}"
    )

    plt.plot(
        [0, 1],
        [0, 1],
        linestyle="--"
    )

    plt.xlabel("False Positive Rate")
    plt.ylabel("True Positive Rate")
    plt.title("ROC Curve")

    plt.legend()

    plt.tight_layout()

    plt.savefig(
        "outputs/figures/roc_curve.png"
    )

    plt.close()

def plot_churn_by_contract(df):

    churn_rate = (
        df.groupby("contract")["churn_value"]
        .mean()
        .sort_values(ascending=False)
    )

    plt.figure(figsize=(8, 5))

    churn_rate.plot(kind="bar")

    plt.title("Churn Rate by Contract Type")
    plt.ylabel("Churn Rate")

    plt.tight_layout()

    plt.savefig(
        "outputs/figures/churn_by_contract.png"
    )

    plt.close()


def plot_churn_by_contract(df):

    churn_rate = (
        df.groupby("contract")["churn_value"]
        .mean()
        .sort_values(ascending=False)
    )

    plt.figure(figsize=(8, 5))

    churn_rate.plot(kind="bar")

    plt.title("Churn Rate by Contract Type")
    plt.ylabel("Churn Rate")

    plt.tight_layout()

    plt.savefig(
        "outputs/figures/churn_by_contract.png"
    )

    plt.close()

def plot_churn_by_internet_service(df):

    churn_rate = (
        df.groupby("internet_service")["churn_value"]
        .mean()
        .sort_values(ascending=False)
    )

    plt.figure(figsize=(8, 5))

    churn_rate.plot(kind="bar")

    plt.title("Churn Rate by Internet Service")
    plt.ylabel("Churn Rate")

    plt.tight_layout()

    plt.savefig(
        "outputs/figures/churn_by_internet_service.png"
    )

    plt.close()