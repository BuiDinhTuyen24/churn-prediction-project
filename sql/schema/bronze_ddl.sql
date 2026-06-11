

DROP TABLE IF EXISTS bronze.telco_customer_raw;
GO

CREATE TABLE bronze.telco_customer_raw (
    customer_id         VARCHAR(50),
    [count]             VARCHAR(20),

    country             VARCHAR(100),
    [state]               VARCHAR(100),
    city                VARCHAR(100),
    zip_code            VARCHAR(20),

    lat_long            VARCHAR(100),
    latitude            VARCHAR(50),
    longitude           VARCHAR(50),

    gender              VARCHAR(20),
    senior_citizen      VARCHAR(10),
    [partner]             VARCHAR(10),
    dependents          VARCHAR(10),

    tenure_months       VARCHAR(20),

    phone_service       VARCHAR(10),
    multiple_lines      VARCHAR(30),

    internet_service    VARCHAR(50),

    online_security     VARCHAR(30),
    online_backup       VARCHAR(30),
    device_protection   VARCHAR(30),
    tech_support        VARCHAR(30),

    streaming_tv        VARCHAR(30),
    streaming_movies    VARCHAR(30),

    [contract]            VARCHAR(50),
    paperless_billing   VARCHAR(10),
    payment_method      VARCHAR(50),

    monthly_charge      VARCHAR(50),
    total_charges       VARCHAR(50),

    churn_label         VARCHAR(10),
    churn_value         VARCHAR(10),

    churn_score         VARCHAR(20),
    cltv                VARCHAR(50),

    churn_reason        VARCHAR(255)
);
