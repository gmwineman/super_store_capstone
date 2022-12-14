-- Exploratory analysis of the Super Store dataset 

SELECT * FROM Store_Orders$
ORDER BY 3

--want to see total orders by ship_mode, segment, city, category
SELECT Ship_Mode, COUNT(*) AS Total_Orders
FROM Store_Orders$
GROUP BY Ship_Mode

SELECT Segment, count(*) AS Total_Orders
FROM Store_Orders$
GROUP BY Segment

SELECT City, State, Count(*) AS Total_Orders
FROM Store_Orders$
GROUP BY City, State
ORDER BY Total_Orders DESC

SELECT Category, Count(*) AS Total_Orders
FROM Store_Orders$
GROUP BY Category
ORDER BY  Category

-- total sales by year
SELECT YEAR(Order_date)AS Year, ROUND(SUM(Sales),2) AS Total_Sales
FROM Store_Orders$
GROUP BY YEAR(Order_Date)
ORDER BY Year

-- Total Number of customers per segment
SELECT Segment, COUNT(DISTINCT Customer_ID) AS Customer_Count
FROM Store_Orders$
GROUP BY Segment

-- Total Orders by SubCategory
SELECT Sub_Category, COUNT(DISTINCT Order_ID) AS Total_Orders
FROM Store_Orders$
GROUP BY Sub_Category

-- Total Number of Orders by Month & Year for each Subcategory
SELECT Sub_Category, MONTH(Order_Date) AS Month, YEAR(Order_Date) AS Year, COUNT(DISTINCT Order_ID) AS Total_Orders
FROM Store_Orders$
GROUP BY Sub_Category, MONTH(Order_Date), YEAR(Order_Date)
ORDER BY 3,2

-- calculate total sales by month, by year for tech products at the sub product level
SELECT Month, Year, Sub_Category, SUM(Total_Sales) Total_Month_Sales FROM (
SELECT MONTH(Order_Date) as Month, YEAR(Order_Date) as Year, Sub_Category, SUM(Sales) AS Total_Sales
FROM Store_Orders$
WHERE Category = 'Technology'
GROUP BY Sub_Category, Order_Date
) as Temp
GROUP BY Month, YEAR, Sub_Category
ORDER BY 2,1


-- total tech sales by month by year for only tech products
SELECT Month, Year, Category, SUM(Total_Sales) AS Total_Months_Sales FROM (
	SELECT MONTH(Order_Date) as Month, YEAR(Order_Date) as Year, Category, SUM(Sales) AS Total_Sales
	FROM Store_Orders$
	WHERE Category = 'Technology'
	GROUP BY Category, Order_Date
) as temp
GROUP BY Month, Year, Category
ORDER BY 2,1
-- we will use the above query results for our SARIMAX forecast
