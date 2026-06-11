import pyodbc

def get_connection():

    return pyodbc.connect(
        "DRIVER={ODBC Driver 18 for SQL Server};"
        "SERVER=MSI\\SQLEXPRESS;"
        "DATABASE=ChurnPrediction;"
        "Trusted_Connection=yes;"
        "TrustServerCertificate=yes;"
    )