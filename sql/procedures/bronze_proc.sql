/*
====================================================================
Procedure Name : bronze.sp_load_telco_customer
Layer          : Bronze
Purpose        : Load Telco Customer Churn CSV file into
                 bronze.telco_customer

Source File    : D:\Project\Churn prediction\Telco_customer_churn.csv

Process:
    1. Truncate bronze.telco_customer
    2. Bulk load source CSV
    3. Capture execution metadata
    4. Return execution summary

How to execute:
    Run EXEC bronze.proc_telco_customer
====================================================================
*/

CREATE OR ALTER PROCEDURE bronze.proc_telco_customer
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
        -- Clear Bronze Table
        ------------------------------------------------------------
        TRUNCATE TABLE bronze.telco_customer;

        ------------------------------------------------------------
        -- Load Source File
        ------------------------------------------------------------
        BULK INSERT bronze.telco_customer
        FROM 'D:\Project\Churn prediction\Telco_customer_churn.csv'
        WITH (
            FORMAT = 'CSV',
            FIRSTROW = 2,
            FIELDQUOTE = '"',
            CODEPAGE = '65001'
        );

        ------------------------------------------------------------
        -- Capture Metrics
        ------------------------------------------------------------
        SELECT
            @RowsLoaded = COUNT(*)
        FROM bronze.telco_customer;

        SET @EndTime = SYSDATETIME();

        SET @DurationSeconds =
            DATEDIFF(SECOND, @StartTime, @EndTime);

        ------------------------------------------------------------
        -- Return Success Metadata
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
        -- Return Error Metadata
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

EXEC bronze.proc_telco_customer