CREATE OR ALTER VIEW gold.telco_customer
AS
SELECT
    customer_id,

    gender,
    senior_citizen,
    partner,
    dependents,

    state,
    city,

    tenure_months,

    phone_service,
    multiple_lines,

    internet_service,

    online_security,
    online_backup,
    device_protection,
    tech_support,

    streaming_tv,
    streaming_movies,

    contract,
    paperless_billing,
    payment_method,

    monthly_charge,
    total_charges,

    churn_value

FROM silver.telco_customer;
GO