----CREATE DATABASE
create database KMS
-----IMPORT TABLE
-----dbo.KMS Sql Case Study
-----dbo.Order_Status
-------(1) Which product category had the highest sales?
Select product_category,
Sum ([Sales]) AS [TotalSales]
FROM "KMS Sql Case Study"
Group By product_category
Order By [TotalSales] Desc


--------2a TOP 3 REGION IN TERMS OF SALES
SELECT TOP 3 Region, SUM(Sales) AS TotalSales
FROM "KMS Sql Case Study"
Group BY Region
ORDER BY TotalSales DESC


------- BOTTOM 3 REGION IN TERMS OF SALES
SELECT TOP 3  Region, SUM(Sales) AS TotalSales
FROM "KMS Sql Case Study"
GROUP BY Region
ORDER BY TotalSales ASC

--------3
--------THE TOTAL SALES OF APPLIANCES IN ONTARIO
SELECT SUM(SALES) AS TOTAL_APPLIANCE_SALES_IN_ONTARIO
FROM "KMS Sql Case Study"
WHERE Product_Sub_Category = 'Appliances' AND Province = 'Ontario'



----------4
-------HOW TO INCREASE THE REVENUE FROM THE BOTTOM 10 CUSTOMER
SELECT TOP 10 "CUSTOMER_NAME", SUM(SALES) AS TOTALSALES
FROM "KMS Sql Case Study"
GROUP BY CUSTOMER_NAME
ORDER BY TOTALSALES ASC
----------TO INCREASE REVENUE FROM THE BOTTOM 10 CUSTOMERS , MANAGEMENT SHOULD CONSIDER;
---(1)target promotion
---(2)personalized outreach
----(3)feedback collection
----(4)loyalty program
-----(5)re-engagement campaigns



-----------5
--------MOST SHIPPING COST INCURRED 
SELECT "Ship_Mode", SUM("Shipping_Cost") AS TOTAL_SHIPPING_COST
FROM "KMS Sql Case Study"
GROUP BY "Ship_Mode"
ORDER BY TOTAL_SHIPPING_COST DESC


----------6
-------MOST VALUABLE CUSTOMERS AND PRODUCT OR SERVICE THEY DO PURCHASE
SELECT TOP 5 Customer_Segment,Product_Sub_Category,Customer_Name, SUM(SALES) AS TOTALSALES
FROM "KMS Sql Case Study"
GROUP BY Customer_Segment,Product_Sub_Category,Customer_Name
ORDER BY TOTALSALES DESC


---------7
--------SMALL BUSINESS CUSTOMER WITH THE HIGHEST SALES
SELECT TOP 1 Customer_Name, sum(sales) AS TOTALSALES
FROM "KMS Sql Case Study"
WHERE "Customer_Segment"='SMALL BUSINESS'
GROUP BY "Customer_Name"
ORDER BY TOTALSALES DESC

--------8
-------THE MOST NUMBER OF ORDER PLACED BY CORPORATE CUSTOMER BETWEEN 2009-2012
SELECT Customer_Name, count(distinct "Order_ID") AS NUMBEROFORDERS
FROM "KMS Sql Case Study"
WHERE "Customer_Segment"='Corporate'
group by "Customer_Name"
order by NUMBEROFORDERS DESC


----------9
---------THE MOST PROFITABLE CUSTOMER
SELECT TOP 1 "Customer_Name",SUM(Profit) AS TOTALPROFIT
FROM "KMS Sql Case Study"
WHERE "Customer_Segment"='Consumer'
GROUP BY "Customer_Name"
ORDER BY "TOTALPROFIT" DESC


-------10
--------CUSTOMER RETURNED ITEMS AND SEGMENT IT BELONG TO
SELECT DISTINCT KMS."Customer_Name",
				KMS."Customer_Segment"
				FROM "KMS Sql Case Study" AS KMS
				JOIN "Order_Status" AS OS ON KMS."Order_ID"=OS."Order_ID"
				WHERE OS.Status='RETURNED'

---------11
---------MOST ECONOMICAL DELIVERY TRUCK BUT SLOWEST 
SELECT "Order_Priority","Ship_Mode",
SUM ("Shipping_Cost") AS TotalShippingCost,
COUNT("Order_Id") AS NumberOfOrders,
AVG("Shipping_Cost") AS AverageShippingCostPerOrder
FROM "KMS Sql Case Study"
	GROUP BY "Order_Priority","Ship_Mode"
	ORDER BY 
		CASE "Order_Priority"
			when 'critical' then 1
			when 'high' then 2
			when 'medium' then 3
			when 'low' then 4
			when 'not specified' then 5
			else 6
			end,
		AverageShippingCostPerOrder desc;

