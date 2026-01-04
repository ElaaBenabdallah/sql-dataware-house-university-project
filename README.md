# Omnichannel Fashion Retail Performance Analysis

## Project Description
This project presents a complete Business Intelligence pipeline for analyzing the performance of an omnichannel fashion retailer. It covers data ingestion, transformation, analytical modeling, and visualization using SQL and Power BI. The goal is to extract meaningful insights related to revenue, profitability, customer behavior, and channel performance, and to translate them into actionable business recommendations.

---

## Project Objectives
- Build a clean and scalable data architecture using a bronze–silver–gold approach
- Design an analytical star schema optimized for reporting
- Create meaningful KPIs using DAX in Power BI
- Develop interactive dashboards to support business decision-making
- Provide insights, recommendations, and future improvement directions

---

## Data Architecture
The project follows a layered architecture to ensure data quality and clarity.

### Bronze Layer
- Raw data ingestion
- Minimal transformations
- Source-level structure preserved

### Silver Layer
- Data cleaning and standardization
- Data quality checks and validation
- Preparation for analytical modeling

### Gold Layer
- Business-ready analytical tables
- Star schema implementation
- Optimized for Power BI reporting


## Analytical Data Model
The gold layer implements a **star schema** with:
- **Fact table:** Sales transactions at item level
- **Dimension tables:** Products, Customers, Date, Channels, Campaigns

This model supports consistent KPI calculations, flexible filtering, and efficient performance in Power BI.


## Power BI Dashboard
The Power BI dashboard is built on top of the gold layer and provides an interactive analysis of business performance.

### Main KPIs
- Net Revenue  
- Gross Margin & Gross Margin %  
- Total Orders and Total Quantity  
- Average Order Value (AOV)  
- Units per Transaction (UPT)  
- Active Customers  
- Customer Lifetime Value (CLV – simplified)

### Key Analyses
- Revenue trends over time
- Category and product performance
- Revenue vs profitability at product level
- Discount behavior by category
- Channel comparison (E-commerce vs App Mobile)
- Geographic distribution of revenue



## Repository Structure
