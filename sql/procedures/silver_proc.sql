/*
====================================================================
Procedure Name : silver.sp_load_telco_customer
Layer          : Silver
Purpose        : Transform and load data from
                 bronze.telco_customer
                 to silver.telco_customer

Source         : bronze.telco_customer
Target         : silver.telco_customer

Transformations:
    - Remove unused columns
    - Convert Yes/No -> BIT
    - Convert numeric fields
    - Standardize data types

How to execute:
    - Run EXEC silver_proc_telco_customer
====================================================================
*/

CREATE OR ALTER PROCEDURE silver_proc_telco_customer
AS
BEGIN

    SET NOCOUNT ON;

    DECLARE @StartTime DATETIME2(3);
    DECLARE @EndTime DATETIME2(3);
    DECLARE @DurationSeconds INT;
    DECLARE @RowsLoaded INT;

    SET @StartTime = SYSDATETIME();

    BEGIN TRY

        ------------------------------------------------------------
        -- Refresh Silver Layer
        ------------------------------------------------------------
        TRUNCATE TABLE silver.telco_customer;

        ------------------------------------------------------------
        -- Load Data From Bronze
        ------------------------------------------------------------
        INSERT INTO silver.telco_customer
        (
            customer_id,
            country,
            state,
            city,
            zip_code,
            latitude,
            longitude,
            gender,
            senior_citizen,
            partner,
            dependents,
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
            churn_label,
            churn_value,
            churn_score,
            cltv,
            churn_reason,
            load_datetime
        )
        SELECT
            customer_id,

            country,
            state,
            city,
            zip_code,

            TRY_CAST(latitude AS DECIMAL(10,7)),
            TRY_CAST(longitude AS DECIMAL(10,7)),

            gender,

            CASE WHEN senior_citizen = 'Yes' THEN 1 ELSE 0 END,
            CASE WHEN partner = 'Yes' THEN 1 ELSE 0 END,
            CASE WHEN dependents = 'Yes' THEN 1 ELSE 0 END,

            TRY_CAST(tenure_months AS INT),

            CASE WHEN phone_service = 'Yes' THEN 1 ELSE 0 END,
            CASE WHEN multiple_lines = 'Yes' THEN 1 ELSE 0 END,

            internet_service,

            CASE WHEN online_security = 'Yes' THEN 1 ELSE 0 END,
            CASE WHEN online_backup = 'Yes' THEN 1 ELSE 0 END,
            CASE WHEN device_protection = 'Yes' THEN 1 ELSE 0 END,
            CASE WHEN tech_support = 'Yes' THEN 1 ELSE 0 END,

            CASE WHEN streaming_tv = 'Yes' THEN 1 ELSE 0 END,
            CASE WHEN streaming_movies = 'Yes' THEN 1 ELSE 0 END,

            contract,

            CASE WHEN paperless_billing = 'Yes' THEN 1 ELSE 0 END,

            payment_method,

            TRY_CAST(monthly_charge AS DECIMAL(10,2)),
            ISNULL(
                TRY_CAST(total_charges AS DECIMAL(12,2)),0
                )AS total_charges,

            churn_label,

            TRY_CAST(churn_value AS BIT),

            TRY_CAST(churn_score AS INT),

            TRY_CAST(cltv AS DECIMAL(12,2)),

            churn_reason = ISNULL(churn_reason, 'N/A'),

            SYSDATETIME()

        FROM bronze.telco_customer;

        ------------------------------------------------------------
        -- Metrics
        ------------------------------------------------------------
        SELECT
            @RowsLoaded = COUNT(*)
        FROM silver.telco_customer;

        SET @EndTime = SYSDATETIME();

        SET @DurationSeconds =
            DATEDIFF(SECOND, @StartTime, @EndTime);

        ------------------------------------------------------------
        -- Success Log
        ------------------------------------------------------------
        SELECT
            'SUCCESS' AS status,
            @StartTime AS start_time,
            @EndTime AS end_time,
            @DurationSeconds AS duration_seconds,
            @RowsLoaded AS rows_loaded;

    END TRY

    BEGIN CATCH

        SET @EndTime = SYSDATETIME();

        SET @DurationSeconds =
            DATEDIFF(SECOND, @StartTime, @EndTime);

        ------------------------------------------------------------
        -- Error Log
        ------------------------------------------------------------
        SELECT
            'FAILED' AS status,
            @StartTime AS start_time,
            @EndTime AS end_time,
            @DurationSeconds AS duration_seconds,
            ERROR_NUMBER() AS error_number,
            ERROR_LINE() AS error_line,
            ERROR_MESSAGE() AS error_message;

        THROW;

    END CATCH

END;
GO


EXEC silver_proc_telco_customer