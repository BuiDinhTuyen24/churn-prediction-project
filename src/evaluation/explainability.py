import pandas as pd


def get_feature_importance(model, X):

    importance_df = pd.DataFrame({
        "feature": X.columns,
        "importance": model.feature_importances_
    })

    importance_df = importance_df.sort_values(
        by="importance",
        ascending=False
    )

    return importance_df