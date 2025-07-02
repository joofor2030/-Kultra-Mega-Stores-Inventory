# -Kultra-Mega-Stores-Inventory
Kulta-Mega-Stores-Inventory is a SQL project carried out in my journey as a data analyst from DSA Hub
Here's the GitHub documentation (README.md) prepared with a focus on SQL, detailing the step-by-step process for analysis:

````markdown
# Kultra Mega Stores (KMS) Inventory Analysis - Abuja Division (SQL-Focused)

## Project Overview

This project provides a business intelligence analysis of order and sales data for Kultra Mega Stores (KMS), a company specializing in office supplies and furniture. The analysis covers the Abuja division's operations from 2009 to 2012, aiming to deliver data-driven insights to support management decisions and address specific business challenges using SQL.

## Objectives

The primary objective of this analysis is to answer key business questions related to sales performance, customer behavior, and shipping cost efficiency. This documentation outlines the step-by-step SQL approach to derive these insights, providing a blueprint for data analysts.

## Data Sources

The analysis is based on two primary datasets, assumed to be loaded into a relational database for SQL querying:

1.  `KMS_Sales_Data`: Corresponds to the `KMS Sql Case Study.csv` file, containing detailed order information such as sales figures, product categories, customer demographics, shipping costs, and profit margins.
2.  `Order_Status`: Corresponds to the `Order_Status.csv` file, containing `Order ID` and `Status`, primarily used for identifying returned items.

## Tools Used

* **SQL (Structured Query Language)**: For querying and manipulating data within a relational database.
* **Relational Database System (e.g., PostgreSQL, MySQL, SQL Server, SQLite)**: The environment where the data would be loaded and SQL queries executed.
* **Database Client Tool**: Any tool capable of connecting to and executing SQL queries against the chosen database (e.g., DBeaver, SQL Workbench, pgAdmin, MySQL Workbench).

## Step-by-Step Analysis Process (using SQL)

This section details the SQL queries and the thought process behind answering each business question.

---

### Case Scenario I: Sales and Operational Efficiency

#### 1. Which product category had the highest sales?

* **Process:** To determine the product category with the highest sales, we need to aggregate the `Sales` for each `Product Category`. We will then order these aggregated sales in descending order and limit the result to the top entry.
* **SQL Query:**
    ```sql
    SELECT "Product Category", SUM(Sales) AS TotalSales
    FROM KMS_Sales_Data
    GROUP BY "Product Category"
    ORDER BY TotalSales DESC
    LIMIT 1;
    ```

#### 2. What are the Top 3 and Bottom 3 regions in terms of sales?

* **Process:** To find the top and bottom regions by sales, we group the sales data by `Region`, sum the `Sales` for each region, and then order the results. For the top 3, we order in descending sales and take the top 3. For the bottom 3, we order in ascending sales and take the top 3.
* **SQL Queries:**
    ```sql
    -- Top 3 Regions
    SELECT Region, SUM(Sales) AS TotalSales
    FROM KMS_Sales_Data
    GROUP BY Region
    ORDER BY TotalSales DESC
    LIMIT 3;

    -- Bottom 3 Regions
    SELECT Region, SUM(Sales) AS TotalSales
    FROM KMS_Sales_Data
    GROUP BY Region
    ORDER BY TotalSales ASC
    LIMIT 3;
    ```

#### 3. What were the total sales of appliances in Ontario?

* **Process:** This requires filtering the data. We select rows where `Product Category` is 'Office Supplies' (as 'Appliances' is a sub-category here), `Product Sub-Category` is 'Appliances', and the `Province` is 'Ontario'. Then, we sum the `Sales` for these filtered rows.
* **SQL Query:**
    ```sql
    SELECT SUM(Sales) AS TotalSales
    FROM KMS_Sales_Data
    WHERE "Product Category" = 'Office Supplies'
    AND "Product Sub-Category" = 'Appliances'
    AND Province = 'Ontario';
    ```

#### 4. Advise the management of KMS on what to do to increase the revenue from the bottom 10 customers.

* **Process (SQL part):** First, identify the bottom 10 customers by summing their total `Sales`, ordering in ascending order, and taking the top 10.
* **SQL Query (to identify customers):**
    ```sql
    SELECT "Customer Name", SUM(Sales) AS TotalSales
    FROM KMS_Sales_Data
    GROUP BY "Customer Name"
    ORDER BY TotalSales ASC
    LIMIT 10;
    ```
* **Business Advice (derived from analysis):** Based on the identified customers, management could:
    * Offer personalized promotions or discounts tailored to their past purchases or expressed interests.
    * Engage directly to understand their needs, feedback, and any pain points to improve their experience.
    * Implement a loyalty program to incentivize repeat purchases or higher spending.
    * Strategically cross-sell or up-sell relevant products by analyzing their purchase patterns or similar customer profiles.
    * Prioritize excellent customer service to foster stronger relationships and encourage more frequent transactions.

#### 5. KMS incurred the most shipping cost using which shipping method?

* **Process:** We group the data by `Ship Mode` and sum the `Shipping Cost` for each mode. Then, we order by the total shipping cost in descending order and select the top one.
* **SQL Query:**
    ```sql
    SELECT "Ship Mode", SUM("Shipping Cost") AS TotalShippingCost
    FROM KMS_Sales_Data
    GROUP BY "Ship Mode"
    ORDER BY TotalShippingCost DESC
    LIMIT 1;
    ```

---

### Case Scenario II: Customer Behavior and Profitability

#### 6. Who are the most valuable customers, and what products or services do they typically purchase?

* **Process:** To find the most valuable customers, we group by `Customer Name` and sum their `Profit`. We order this in descending order to find the top performers. To identify typical purchases, for each top customer, we count the frequency of `Product Category` and `Product Sub-Category` and find the most common ones.
* **SQL Queries:**
    ```sql
    -- To identify Most Valuable Customers by Profit
    SELECT "Customer Name", SUM(Profit) AS TotalProfit
    FROM KMS_Sales_Data
    GROUP BY "Customer Name"
    ORDER BY TotalProfit DESC
    LIMIT 5;

    -- To find typical products for a specific valuable customer (e.g., 'Emily Phan'):
    SELECT "Product Category", "Product Sub-Category", COUNT(*) AS PurchaseCount
    FROM KMS_Sales_Data
    WHERE "Customer Name" = 'Emily Phan' -- Replace with each valuable customer's name
    GROUP BY "Product Category", "Product Sub-Category"
    ORDER BY PurchaseCount DESC
    LIMIT 1;
    ```

#### 7. Which small business customer had the highest sales?

* **Process:** We first filter the data for `Customer Segment` equal to 'Small Business'. Then, we group the results by `Customer Name`, sum their `Sales`, and order in descending order to find the customer with the highest sales.
* **SQL Query:**
    ```sql
    SELECT "Customer Name", SUM(Sales) AS TotalSales
    FROM KMS_Sales_Data
    WHERE "Customer Segment" = 'Small Business'
    GROUP BY "Customer Name"
    ORDER BY TotalSales DESC
    LIMIT 1;
    ```

#### 8. Which Corporate Customer placed the most number of orders in 2009 – 2012?

* **Process:** We filter the data for `Customer Segment` as 'Corporate' and `Order Date` within the years 2009 to 2012. We then group by `Customer Name` and count the distinct `Order ID`s to find the number of unique orders placed by each corporate customer. Finally, we order by the count of orders in descending order and select the top customer.
* **SQL Query:**
    ```sql
    SELECT "Customer Name", COUNT(DISTINCT "Order ID") AS NumberOfOrders
    FROM KMS_Sales_Data
    WHERE "Customer Segment" = 'Corporate'
    AND STRFTIME('%Y', "Order Date") BETWEEN '2009' AND '2012' -- Example for SQLite, adjust date function for other SQL dialects (e.g., YEAR("Order Date") for MySQL/SQL Server)
    GROUP BY "Customer Name"
    ORDER BY NumberOfOrders DESC
    LIMIT 1;
    ```

#### 9. Which consumer customer was the most profitable one?

* **Process:** We filter the data for `Customer Segment` as 'Consumer'. Then, we group by `Customer Name`, sum their `Profit`, and order in descending order to find the most profitable consumer customer.
* **SQL Query:**
    ```sql
    SELECT "Customer Name", SUM(Profit) AS TotalProfit
    FROM KMS_Sales_Data
    WHERE "Customer Segment" = 'Consumer'
    GROUP BY "Customer Name"
    ORDER BY TotalProfit DESC
    LIMIT 1;
    ```

#### 10. Which customer returned items, and what segment do they belong to?

* **Process:** To identify customers who returned items, we need to join `KMS_Sales_Data` with the `Order_Status` table on `Order ID`. We then filter the joined result where `Status` is 'Returned' and select distinct `Customer Name` and `Customer Segment`.
* **SQL Query:**
    ```sql
    SELECT DISTINCT
        k."Customer Name",
        k."Customer Segment"
    FROM KMS_Sales_Data k
    INNER JOIN Order_Status o ON k."Order ID" = o."Order ID"
    WHERE o.Status = 'Returned';
    ```

#### 11. If the delivery truck is the most economical but the slowest shipping method and Express Air is the fastest but the most expensive one, do you think the company appropriately spent shipping costs based on the Order Priority? Explain your answer.

* **Process (SQL part):** We calculate the average `Shipping Cost` for each combination of `Ship Mode` and `Order Priority`. This allows us to compare the typical cost for each shipping method under different urgency levels.
* **SQL Query (to analyze average shipping cost by mode and priority):**
    ```sql
    SELECT
        "Ship Mode",
        "Order Priority",
        AVG("Shipping Cost") AS AverageShippingCost
    FROM KMS_Sales_Data
    GROUP BY "Ship Mode", "Order Priority"
    ORDER BY "Ship Mode", "Order Priority";
    ```
* **Analysis and Explanation:**
    * **Observation:** By examining the results of the above query, we can observe the average shipping costs for 'Delivery Truck' (generally higher, slower) and 'Express Air' (generally lower, faster) across different `Order Priority` levels (Critical, High, Medium, Low, Not Specified).
    * **Conclusion:** If higher priority orders (Critical, High) show a higher average shipping cost (implying the use of faster methods like 'Express Air' or a mix including it), and lower priority orders (Low, Not Specified) show lower average shipping costs (implying more use of economical methods like 'Delivery Truck' or 'Regular Air'), then it suggests appropriate spending. The data generally indicated that KMS aligns shipping choices with priority, with higher priority orders incurring higher average costs, and lower priority orders utilizing more economical options.

---

## Key Insights and Summary

This SQL-driven analysis provides valuable insights into KMS's sales, customer behavior, and shipping logistics. Key takeaways include:

* **Technology** is the highest-grossing product category, indicating strong demand in this area.
* Sales performance varies significantly by region, highlighting areas for focused marketing or operational improvements (e.g., Nunavut as a low-performing region).
* Specific customer segments and individual customers drive a substantial portion of profits and sales, requiring targeted engagement strategies.
* Shipping cost allocation generally aligns with order priority, suggesting a reasonable balance between speed and cost-effectiveness.
* Identification of bottom-performing customers and customers who return items provides actionable data for customer retention and service improvement initiatives.

## How to Set Up and Run

1.  **Database Setup:**
    * Choose a relational database system (e.g., PostgreSQL, SQLite, MySQL).
    * Create a database (e.g., `kms_inventory_db`).
    * Create two tables: `KMS_Sales_Data` and `Order_Status`, defining appropriate columns and data types based on the CSV files. Ensure `Order ID` is consistent for joining.

2.  **Data Loading:**
    * Import the `KMS Sql Case Study.csv` data into the `KMS_Sales_Data` table.
    * Import the `Order_Status.csv` data into the `Order_Status` table.
    * Ensure date columns (e.g., `Order Date` in `KMS_Sales_Data`) are loaded as a date or datetime data type in your database.

3.  **Execute Queries:**
    * Connect to your database using a SQL client tool.
    * Copy and paste the SQL queries provided in this documentation into your client's query editor.
    * Execute each query to retrieve the results for the respective questions.

This comprehensive documentation should allow a data analyst to understand the analytical approach and reproduce the results using SQL.
````
