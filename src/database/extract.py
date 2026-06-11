import pandas as pd

from .connection import get_connection

def load_gold_data():

    conn = get_connection()

    query = """
    SELECT *
    FROM gold.telco_customer
    """

    df = pd.read_sql(query, conn)

    conn.close()

    return df