IF OBJECT_ID('silver.sales_teams', 'U') IS NOT NULL
    DROP TABLE silver.sales_teams;
GO
CREATE TABLE silver.sales_teams(
    sales_agent NVARCHAR(50),
    manager  NVARCHAR(50),
    regional_office NVARCHAR(50),
    gender NVARCHAR(50),
    base_salary DECIMAL(18,2);
    hire_date DATE);
GO
IF OBJECT_ID('silver.products', 'U') IS NOT NULL
    DROP TABLE silver.products;
GO
CREATE TABLE silver.products (
    product      NVARCHAR(50),
    series       NVARCHAR(50), 
    sales_price  DECIMAL(18,2)
);
GO
IF OBJECT_ID('silver.accounts', 'U') IS NOT NULL
    DROP TABLE silver.accounts;
GO
CREATE TABLE silver.accounts(
    account          NVARCHAR(50),
    sector           NVARCHAR(50),
    year_established INT,
    revenue          DECIMAL(18,2),
    employees        INT,
    office_location  NVARCHAR(50),
    subsidiary_of    NVARCHAR(50)
);
GO
IF OBJECT_ID('silver.sales_pipeline', 'U') IS NOT NULL
    DROP TABLE silver.sales_pipeline;
GO
CREATE TABLE silver.sales_pipeline(
    opportunity_id NVARCHAR(50),
    sales_agent    NVARCHAR(50),
    product        NVARCHAR(50),
    account        NVARCHAR(50),
    deal_stage     NVARCHAR(50),
    engage_date    DATE,
    close_date     DATE, 
    close_value    DECIMAL(18,2)?
    sales_cycle_days INT ;
);
