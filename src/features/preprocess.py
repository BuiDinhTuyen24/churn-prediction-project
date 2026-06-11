import pandas as pd

def preprocess(df):

    y = df["churn_value"]

    X = df.drop(
        columns=[
            "customer_id",
            "churn_value",
            "city",
            "state"
        ]
    )

    X = pd.get_dummies(
        X,
        drop_first=True
    )

    return X, y