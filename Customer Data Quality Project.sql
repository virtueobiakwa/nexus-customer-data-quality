CREATE DATABASE customer_data_quality;

USE customer_data_quality;
USE customer_data_quality;

CREATE TABLE master_customers (
    Customer_ID VARCHAR(20) PRIMARY KEY,
    Full_Name VARCHAR(100),
    Phone VARCHAR(30),
    Email VARCHAR(150),
    State VARCHAR(50),
    Customer_Type VARCHAR(50),
    Registration_Date_Raw VARCHAR(50),
    Source_Channel VARCHAR(50),
    Branch VARCHAR(100),
    Record_Load_Date DATE,
    Data_Quality_Status VARCHAR(20),
    ID_Count INT,
    Duplicate_Status VARCHAR(30),
    Registration_Date_Clean DATE,
    Completeness_Score INT,
    Quality_Priority INT,
    Original_Index INT
);
USE customer_data_quality;

ALTER TABLE master_customers
MODIFY COLUMN Record_Load_Date VARCHAR(20);
USE customer_data_quality;

ALTER TABLE master_customers
MODIFY COLUMN Registration_Date_Clean VARCHAR(20);
USE customer_data_quality;

SELECT COUNT(*) AS Total_Customers
FROM master_customers;
SELECT 
    Data_Quality_Status,
    COUNT(*) AS Customer_Count
FROM master_customers
GROUP BY Data_Quality_Status;
SELECT
    Duplicate_Status,
    COUNT(*) AS Customer_Count
FROM master_customers
GROUP BY Duplicate_Status;
SELECT
    Completeness_Score,
    COUNT(*) AS Customer_Count
FROM master_customers
GROUP BY Completeness_Score
ORDER BY Completeness_Score;
SELECT
    State,
    COUNT(*) AS Customer_Count
FROM master_customers
GROUP BY State
ORDER BY Customer_Count DESC;
SELECT
    Customer_Type,
    COUNT(*) AS Customer_Count,
    ROUND(COUNT(*) * 100.0 / 601, 2) AS Percentage
FROM master_customers
GROUP BY Customer_Type
ORDER BY Customer_Count DESC;
SELECT
    Source_Channel,
    COUNT(*) AS Total_Customers,
    SUM(CASE WHEN Data_Quality_Status = 'Valid' THEN 1 ELSE 0 END) AS Valid_Customers,
    SUM(CASE WHEN Data_Quality_Status = 'Invalid' THEN 1 ELSE 0 END) AS Invalid_Customers
FROM master_customers
GROUP BY Source_Channel
ORDER BY Total_Customers DESC;
-- =====================================================
-- DATA QUALITY RATE BY SOURCE CHANNEL
-- Purpose: Calculate the percentage of valid customer
-- records contributed by each source channel
-- =====================================================

SELECT
    Source_Channel,
    COUNT(*) AS Total_Customers,
    ROUND(
        SUM(CASE 
            WHEN Data_Quality_Status = 'Valid' THEN 1 
            ELSE 0 
        END) * 100.0 / COUNT(*),
        2
    ) AS Valid_Rate_Percent
FROM master_customers
GROUP BY Source_Channel
ORDER BY Valid_Rate_Percent DESC;
-- =====================================================
-- INVALID CUSTOMER RECORD INVESTIGATION
-- Purpose: Identify master customer records that still
-- fail the established data-quality requirements
-- =====================================================

SELECT
    Customer_ID,
    Full_Name,
    Phone,
    Email,
    State,
    Source_Channel,
    Completeness_Score,
    Data_Quality_Status
FROM master_customers
WHERE Data_Quality_Status = 'Invalid'
ORDER BY Completeness_Score ASC, Source_Channel;
-- =====================================================
-- COUNT INVALID CUSTOMER RECORDS
-- Purpose: Count the number of master customer records
-- that fail the established data-quality requirements
-- =====================================================

SELECT
    COUNT(*) AS Total_Invalid_Records
FROM master_customers
WHERE Data_Quality_Status = 'Invalid';
-- =====================================================
-- INVALID RECORD ROOT-CAUSE ANALYSIS
-- Purpose: Count missing or malformed critical fields
-- among invalid customer records
-- =====================================================

SELECT
    SUM(CASE WHEN Phone IS NULL OR TRIM(Phone) = '' THEN 1 ELSE 0 END) 
        AS Missing_Phone,

    SUM(CASE WHEN Email IS NULL OR TRIM(Email) = '' THEN 1 ELSE 0 END) 
        AS Missing_Email,

    SUM(CASE 
        WHEN Email IS NOT NULL 
             AND TRIM(Email) <> ''
             AND (Email NOT LIKE '%@%' OR Email NOT LIKE '%.%')
        THEN 1 ELSE 0 
    END) AS Malformed_Email

FROM master_customers
WHERE Data_Quality_Status = 'Invalid';
-- =====================================================
-- MULTIPLE DATA-QUALITY ISSUE ANALYSIS
-- Purpose: Identify invalid customers with more than
-- one critical data-quality problem
-- =====================================================

SELECT
    Customer_ID,
    Full_Name,
    (CASE WHEN Phone IS NULL OR TRIM(Phone) = '' 
          THEN 1 ELSE 0 END
     +
     CASE WHEN Email IS NULL OR TRIM(Email) = '' 
          THEN 1 ELSE 0 END
     +
     CASE WHEN Email IS NOT NULL
               AND TRIM(Email) <> ''
               AND (Email NOT LIKE '%@%' OR Email NOT LIKE '%.%')
          THEN 1 ELSE 0 END
    ) AS Issue_Count
FROM master_customers
WHERE Data_Quality_Status = 'Invalid'
HAVING Issue_Count > 1
ORDER BY Issue_Count DESC;
-- =====================================================
-- DATA QUALITY BY CUSTOMER TYPE
-- Purpose: Compare valid and invalid records across
-- different customer segments
-- =====================================================

SELECT
    Customer_Type,
    COUNT(*) AS Total_Customers,
    
    SUM(CASE 
        WHEN Data_Quality_Status = 'Valid' THEN 1 
        ELSE 0 
    END) AS Valid_Customers,
    
    SUM(CASE 
        WHEN Data_Quality_Status = 'Invalid' THEN 1 
        ELSE 0 
    END) AS Invalid_Customers,

    ROUND(
        SUM(CASE 
            WHEN Data_Quality_Status = 'Valid' THEN 1 
            ELSE 0 
        END) * 100.0 / COUNT(*),
        2
    ) AS Valid_Rate_Percent

FROM master_customers
GROUP BY Customer_Type
ORDER BY Valid_Rate_Percent DESC;
-- =====================================================
-- MASTER CUSTOMER UNIQUENESS CHECK
-- Purpose: Confirm that no Customer_ID appears more
-- than once in the final master customer table
-- =====================================================

SELECT
    Customer_ID,
    COUNT(*) AS Record_Count
FROM master_customers
GROUP BY Customer_ID
HAVING COUNT(*) > 1;