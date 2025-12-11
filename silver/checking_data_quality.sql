------------------------------------------------------------
-- BRONZE.SALES_PIPELINE – basic inspection & quality checks
------------------------------------------------------------

-- 1) Quick look at all the raw rows in the sales_pipeline table (Bronze layer)
--    Use this just to inspect the data structure and sample values.
SELECT * 
FROM bronze.sales_pipeline;

-- 2) Find rows where the close_date is earlier than the engage_date.
--    This checks for logical date errors: a deal cannot close before it was engaged.
SELECT close_date, engage_date, opportunity_id, deal_stage
FROM bronze.sales_pipeline 
WHERE close_date < engage_date;

-- 3) List all distinct deal stages present in the data.
--    This helps you see how many categories you have and if there are typos like 'won', 'WON', 'Closed', etc.
SELECT DISTINCT deal_stage 
FROM bronze.sales_pipeline;

-- 4) Check for duplicate opportunity_id values.
--    Ideally, each opportunity_id should appear only once (1 row = 1 opportunity).
--    If cnt > 1, it means the same opportunity_id appears multiple times and you need to investigate why.
SELECT opportunity_id, COUNT(*) AS cnt
FROM bronze.sales_pipeline
GROUP BY opportunity_id
HAVING COUNT(*) > 1;

-- 5) Find Won/Lost deals that are missing close information.
--    Business logic check:
--      - For 'Won' or 'Lost' deals, we expect both close_date and close_value to be filled.
--    This query shows rows where:
--      - the deal is closed (Won/Lost)
--      - but close_date OR close_value is NULL (incomplete data).
SELECT *
FROM bronze.sales_pipeline
WHERE deal_stage IN ('Won', 'Lost')
  AND (close_date IS NULL OR close_value IS NULL);

-- 6) Find open pipeline deals that already have a close date.
--    Business logic check:
--      - For 'Engaging' or 'Prospecting' deals (still open),
--        we normally expect close_date to be NULL.
--    This query shows rows where:
--      - deal_stage is still open
--      - but close_date is already filled → suspicious / inconsistent data.
SELECT *
FROM bronze.sales_pipeline
WHERE deal_stage IN ('Engaging', 'Prospecting')
  AND close_date IS NOT NULL;


------------------------------------------------------------
-- BRONZE.SALES_TEAMS – basic inspection
------------------------------------------------------------

-- 1) Look at all rows in the raw sales_teams table
--    Just to understand the structure and sample values.
SELECT *
FROM bronze.sales_teams;

-- 2) How many rows do we have in this table?
--    Good for checking that loads/imports worked as expected.
SELECT COUNT(*) AS row_count
FROM bronze.sales_teams;

-- 3) List the distinct regional offices.
--    Helps to see all possible regions and spot typos / inconsistent labels.
SELECT DISTINCT regional_office
FROM bronze.sales_teams;

-- 4) List the distinct managers.
--    Helps understand team structure and spot spelling differences.
SELECT DISTINCT manager
FROM bronze.sales_teams;

-- 5) Check for duplicate sales agents.
--    Normally, we expect 1 row per sales_agent in this table.
SELECT sales_agent, COUNT(*) AS cnt
FROM bronze.sales_teams
GROUP BY sales_agent
HAVING COUNT(*) > 1;

-- 6) Look for missing key information (NULLs) in important columns.
--    These are potential data quality issues.
SELECT *
FROM bronze.sales_teams
WHERE sales_agent IS NULL
   OR manager IS NULL
   OR regional_office IS NULL;

------------------------------------------------------------
-- BRONZE.ACCOUNTS – basic inspection & quality checks
------------------------------------------------------------

-- 1) Look at all rows in the raw accounts table.
SELECT *
FROM bronze.accounts;

-- 2) How many rows (accounts) do we have?
SELECT COUNT(*) AS row_count
FROM bronze.accounts;

-- 3) List distinct sectors.
--    Used to see categories and detect typos (e.g. 'technolgy' vs 'technology').
SELECT DISTINCT sector
FROM bronze.accounts;

-- 4) List distinct office locations.
--    Useful to spot spelling issues (e.g. 'Philipines' vs 'Philippines').
SELECT DISTINCT office_location
FROM bronze.accounts;

-- 5) Check for duplicate accounts.
--    Normally, each account should appear only once.
SELECT account, COUNT(*) AS cnt
FROM bronze.accounts
GROUP BY account
HAVING COUNT(*) > 1;

-- 6) Look for suspicious year_established values.
--    Example: before 1900 or after the current year.
SELECT *
FROM bronze.accounts
WHERE year_established < 1900
   OR year_established > YEAR(GETDATE());

-- 7) Look for accounts with negative or zero revenue.
--    Usually, revenue should be positive (unless 0 is meaningful in your data).
SELECT *
FROM bronze.accounts
WHERE revenue <= 0
   OR revenue IS NULL;

-- 8) Look for accounts with negative or zero employees.
SELECT *
FROM bronze.accounts
WHERE employees <= 0
   OR employees IS NULL;

-- 9) Check accounts where subsidiary_of is missing.
--    This helps you see how many "independent" accounts you have
--    (and if you want to replace NULL with 'n/a' later).
SELECT *
FROM bronze.accounts
WHERE subsidiary_of IS NULL;

------------------------------------------------------------
-- BRONZE.PRODUCTS – basic inspection & quality checks
------------------------------------------------------------

-- 1) Look at all rows in the raw products table.
SELECT *
FROM bronze.products;

-- 2) List distinct product names.
--    Helps check for obvious duplication or naming issues.
SELECT DISTINCT product
FROM bronze.products;


-- 3) Check for duplicate products by name.
--    If you expect one row per product, duplicates could be a data issue.
SELECT product, COUNT(*) AS cnt
FROM bronze.products
GROUP BY product
HAVING COUNT(*) > 1;

-- 4) Look for products with NULL or zero/negative sales_price.
--    Price should normally be positive and not NULL.
SELECT *
FROM bronze.products
WHERE sales_price IS NULL
   OR sales_price <= 0;
