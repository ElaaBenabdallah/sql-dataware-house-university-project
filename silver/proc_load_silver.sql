TRUNCATE TABLE silver.accounts;
INSERT INTO silver.accounts (
    account,
    sector,
    year_established,
    revenue,
    employees,
    office_location,
    subsidiary_of
)
SELECT
    TRIM(account) AS account,
    CASE 
        WHEN UPPER(TRIM(sector)) = 'TECHNOLGY' THEN 'technology'   -- fix typo
        ELSE TRIM(sector)
    END AS sector,
    year_established,
    revenue,
    employees,
    CASE 
        WHEN UPPER(TRIM(office_location)) = 'PHILIPINES' THEN 'Philippines'
        WHEN UPPER(TRIM(office_location)) = 'KOREA'      THEN 'South Korea'
        ELSE TRIM(office_location)
    END AS office_location,
    CASE 
        WHEN subsidiary_of IS NULL THEN 'n/a'
        ELSE subsidiary_of
    END AS subsidiary_of
FROM bronze.accounts;

TRUNCATE TABLE silver.products;
INSERT INTO silver.products(
product ,
series,
sales_price
)
SELECT product, series, sales_price
FROM bronze.products;

TRUNCATE TABLE silver.sales_teams;
INSERT INTO silver.sales_teams (
    sales_agent,
    manager,
    regional_office,
    gender,
    base_salary,
    hire_date
)
SELECT
    t.sales_agent,
    t.manager,
    t.regional_office,
    CASE
        WHEN UPPER(LTRIM(RTRIM(e.gender))) = 'F' THEN 'Female'
        WHEN UPPER(LTRIM(RTRIM(e.gender))) = 'M' THEN 'Male'
        ELSE 'n/a'
    END AS gender,
    e.base_salary,
    e.hire_date
FROM bronze.sales_teams t
LEFT JOIN bronze.sales_agents_extra e
    ON t.sales_agent = e.sales_agent;

TRUNCATE TABLE silver.sales_pipeline;
INSERT INTO silver.sales_pipeline (
    opportunity_id,
    sales_agent,
    product,
    account,
    deal_stage,
    engage_date,
    close_date,
    close_value,
    sales_cycle_days )
SELECT
    opportunity_id,
    sales_agent,
    product,
    account,
    deal_stage,
    engage_date,
    close_date,
    close_value,
    CASE 
        WHEN engage_date IS NOT NULL
         AND close_date  IS NOT NULL
         AND deal_stage IN ('Won', 'Lost')  -- use deal_stage_clean if that's your column
        THEN DATEDIFF(DAY, engage_date, close_date)
        ELSE NULL
    END AS sales_cycle_days
FROM bronze.sales_pipeline;

UPDATE silver.sales_pipeline
SET account = 'n/a'
WHERE account IS NULL
  AND engage_date IS NULL
  AND close_date IS NULL;
