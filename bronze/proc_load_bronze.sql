TRUNCATE TABLE bronze.sales_teams;
BULK INSERT bronze.sales_teams
FROM 'C:\Users\USER\Desktop\career\CRM+Sales+Opportunities\sales_teams.csv'
WITH (
	FIRSTROW = 2,
	FIELDTERMINATOR = ',',
    TABLOCK );

TRUNCATE TABLE bronze.products;
BULK INSERT bronze.products
FROM 'C:\Users\USER\Desktop\career\CRM+Sales+Opportunities\products.csv'
WITH (
	FIRSTROW = 2,
	FIELDTERMINATOR = ',',
    TABLOCK );

TRUNCATE TABLE bronze.accounts;
BULK INSERT bronze.accounts
FROM 'C:\Users\USER\Desktop\career\CRM+Sales+Opportunities\accounts.csv'
WITH (
	FIRSTROW = 2,
	FIELDTERMINATOR = ',',
    TABLOCK );

ALTER TABLE bronze.sales_pipeline
ALTER COLUMN opportunity_id NVARCHAR(50);

TRUNCATE TABLE bronze.sales_pipeline;
BULK INSERT bronze.sales_pipeline
FROM 'C:\Users\USER\Desktop\career\CRM+Sales+Opportunities\sales_pipeline.csv'
WITH (
	FIRSTROW = 2,
	FIELDTERMINATOR = ',',
    TABLOCK );
