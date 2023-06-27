SELECT *
FROM pizza_sales

--Total Revenue (The sum of the total price of all pizzas)
SELECT SUM(total_price) Total_Revenue
FROM pizza_sales

--Average Order Value (The average amount spent per order, calculated by dividing the total revenue by the total number of orders)
SELECT SUM(total_price)/ COUNT(DISTINCT order_id)  Avg_Order_Value
FROM pizza_sales

--Total Pizzas Sold (The sum of the quantities of all pizzas sold)
SELECT SUM(quantity) Total_Pizzas_Sold
FROM pizza_sales

--Total Orders (The total number of orders placed)
SELECT COUNT(DISTINCT order_id) Total_Orders
FROM pizza_sales

--Average Pizzas Per Order (The average number of Pizzas sold per order, calculated by dividing the total number of pizzas sold by the total number of orders)
SELECT CAST(SUM(quantity) / COUNT(DISTINCT order_id) AS DECIMAL(10,2))  Average_Pizzas_Per_Order
FROM pizza_sales

--Daily Trend for Total orders
SELECT DATENAME(DW, order_date) as Order_Day, COUNT(DISTINCT order_id) as Total_orders
FROM pizza_sales
GROUP BY DATENAME(DW, order_date)
ORDER BY Total_orders DESC

--Hourly Trend for Total Orders
SELECT DATEPART(HOUR, order_time) as Order_hours, COUNT(DISTINCT order_id) as Total_orders
FROM pizza_sales
GROUP BY DATEPART(HOUR, order_time)
ORDER BY DATEPART(HOUR, order_time) 

--Percentage of Sales by Pizza Category
SELECT pizza_category, CAST(SUM(total_price)*100 / (SELECT sum(total_price) from pizza_sales)AS DECIMAL(10,2)) AS Total_Sale_Percentage
FROM pizza_sales 
GROUP BY pizza_category

--Percentage of Sales by Pizza Category (For only the Month of January)
SELECT pizza_category, CAST(SUM(total_price)*100 / (SELECT sum(total_price) from pizza_sales WHERE MONTH(order_date) = 1) AS DECIMAL (10,2))AS January_Sale_Percentage
FROM pizza_sales 
WHERE MONTH(order_date) = 1
GROUP BY pizza_category

--Percentage of Sales by Pizza Size 
SELECT pizza_size, CAST(SUM(total_price)*100 / (SELECT sum(total_price)  from pizza_sales) AS DECIMAL (10,2)) AS Total_Sale_Percentage
FROM pizza_sales 
GROUP BY pizza_size
ORDER BY Total_Sale_Percentage DESC

--Percentage of Sales by Pizza Size (For quarter of the year)
SELECT pizza_size, CAST(SUM(total_price)*100 / (SELECT sum(total_price)  from pizza_sales WHERE DATEPART(QUARTER, order_date)=1) AS DECIMAL (10,2)) AS Quarter_Sale_Percentage
FROM pizza_sales 
WHERE DATEPART(QUARTER, order_date)=1
GROUP BY pizza_size
ORDER BY Quarter_Sale_Percentage DESC

--Total Pizza Sold by Pizza Category
SELECT pizza_category, SUM(quantity) AS Total_Pizzas_Sold
FROM pizza_sales
GROUP BY pizza_category
ORDER BY Total_Pizzas_Sold DESC

--Top 5 Best Sellers by Total Pizzas Sold
SELECT TOP 5 pizza_name, SUM(quantity) as Top5_Pizzas_Sold
FROM pizza_sales
GROUP BY pizza_name
ORDER BY Top5_Pizzas_Sold DESC

--Bottom 5 Worst Sellers by Total Pizzas Sold
SELECT TOP 5 pizza_name, SUM(quantity) as Bottom5_Pizzas_Sold
FROM pizza_sales
GROUP BY pizza_name
ORDER BY Bottom5_Pizzas_Sold ASC

--Bottom 5 Worst Sellers by Total Pizzas Sold (For only August)
SELECT TOP 5 pizza_name, SUM(quantity) as August_Bottom5_Pizzas_Sold
FROM pizza_sales
WHERE MONTH(order_date) = 8
GROUP BY pizza_name
ORDER BY August_Bottom5_Pizzas_Sold ASC
