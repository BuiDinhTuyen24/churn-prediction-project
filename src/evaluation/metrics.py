from sklearn.metrics import (
    classification_report,
    roc_auc_score
)


def evaluate_model(model, X_test, y_test):

    preds = model.predict(X_test)

    probs = model.predict_proba(X_test)[:, 1]

    report = classification_report(
        y_test,
        preds
    )

    auc = roc_auc_score(
        y_test,
        probs
    )

    return report, auc