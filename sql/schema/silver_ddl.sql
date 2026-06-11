DROP TABLE IF EXISTS silver.telco_customer;
GO

CREATE TABLE silver.telco_customer (

    customer_id         VARCHAR(50) NOT NULL,

    country             VARCHAR(100),
    state               VARCHAR(100),
    city                VARCHAR(100),
    zip_code            VARCHAR(20),

    latitude            DECIMAL(10,7),
    longitude           DECIMAL(10,7),

    gender              VARCHAR(20),

    senior_citizen      BIT,
    partner             BIT,
    dependents          BIT,

    tenure_months       INT,

    phone_service       BIT,
    multiple_lines      BIT,

    internet_service    VARCHAR(50),

    online_security     BIT,
    online_backup       BIT,
    device_protection   BIT,
    tech_support        BIT,

    streaming_tv        BIT,
    streaming_movies    BIT,

    contract            VARCHAR(50),

    paperless_billing   BIT,

    payment_method      VARCHAR(50),

    monthly_charge      DECIMAL(10,2),
    total_charges       DECIMAL(12,2),

    churn_label         VARCHAR(10),
    churn_value         BIT,

    churn_score         INT,

    cltv                DECIMAL(12,2),

    churn_reason        VARCHAR(255),

    load_datetime       DATETIME2(3)
        CONSTRAINT DF_silver_telco_customer_load_datetime
        DEFAULT SYSDATETIME(),

    CONSTRAINT PK_silver_telco_customer
        PRIMARY KEY (customer_id)

);
GO