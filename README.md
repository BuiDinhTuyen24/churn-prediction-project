# 📊 Customer Churn Prediction Pipeline

End-to-end Data Science project for predicting customer churn using machine learning and a layered data architecture (Bronze – Silver – Gold). The project includes data engineering, feature engineering, model training, evaluation, and Power BI dashboard visualization.

---

## 🚀 Project Overview

This project aims to:
- Predict customer churn for a telco dataset
- Build a scalable data pipeline (Bronze → Silver → Gold)
- Perform feature engineering and preprocessing
- Train multiple ML models and compare performance
- Provide explainability and business insights
- Visualize results using Power BI

---

## 🏗️ Architecture
```
ChurnPrediction/
│
├── sql/                  # Data warehouse layer (Bronze, Silver, Gold)
│   ├── schemas/          # Table definitions
│   ├── procedures/       # ETL stored procedures
│   └── views/            # Feature engineering views
│
├── data/                 # Original dataset
│
├── src/
│   ├── database/         # DB connection & data extraction
│   ├── features/         # Feature engineering pipeline
│   ├── models/           # Model training & prediction scripts
│   ├── evaluation/       # Metrics & explainability
│   └── visualization/    # Plot generation
│
├── outputs/
│   ├── figures/          # Visualizations (ROC, feature importance, etc.)
│   └── reports/          # Model performance summary
│
├── powerbi/
│   ├── ChurnDashboard.pbix
│   └── dashboard_screenshots/
│
├── main.py               # Pipeline entry point
├── requirements.txt
└── README.md
```

## 🔄 Workflow

### 1. Data Ingestion
- Load raw Telco customer churn dataset
- Store into **Bronze layer**

### 2. Data Transformation
- Clean missing values
- Encode categorical variables
- Feature engineering (contract type, tenure groups, charges, etc.)
- Store into **Silver layer**

### 3. Feature Engineering (Gold Layer)
- Create final ML-ready dataset
- Export as `feature_dataset.csv`

### 4. Model Training
Multiple models are trained and compared:
- Logistic Regression
- Random Forest
- XGBoost

### 5. Evaluation
- Accuracy, Precision, Recall, F1-score
- ROC-AUC Curve
- Feature importance analysis
- Model comparison report

### 6. Prediction Output
- Generate churn predictions
- Export to `data/predictions/churn_predictions.csv`

### 7. Visualization
- Churn distribution by contract type
- Internet service vs churn rate
- Feature importance chart
- ROC curve

### 8. Power BI Dashboard
- Customer churn overview
- KPI tracking
- Segmentation insights
- Model-driven business insights

---

## 📊 Key Outputs

- Clean feature dataset
- Trained ML models (stored locally via gitignore)
- Performance report (`model_performance.csv`)
- Prediction file (`churn_predictions.csv`)
- Power BI dashboard

---

## 📈 Example Insights

- Customers with month-to-month contracts have highest churn rate
- Higher monthly charges correlate with churn probability
- Tenure is a strong predictor of churn behavior

---

## ▶️ How to Run

```bash
# Install dependencies
pip install -r requirements.txt

# Run full pipeline
python main.py
```

## 👤 About Me


I am a Data Science / Data Analytics enthusiast with experience in building end-to-end machine learning pipelines, from raw data processing to model deployment and business visualization.

This project demonstrates my ability to:
- Design a layered data architecture (Bronze – Silver – Gold)
- Build ETL pipelines using SQL and Python
- Perform feature engineering and machine learning modeling
- Evaluate models using standard metrics and interpret results
- Build dashboards for business insights using Power BI

---

## 📝 Notes

- This project is designed as an end-to-end churn prediction system for portfolio and internship applications.
- Model files (`.pkl`) are excluded from version control using `.gitignore`.
- The pipeline is modular and can be extended to support:
  - Real-time inference API (FastAPI/Flask)
  - Cloud deployment (AWS / GCP / Azure)
  - Automated retraining pipeline (MLOps)
- Dataset used: Telco Customer Churn dataset (public dataset)
