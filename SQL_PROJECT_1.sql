#Create Table
DROP TABLE IF EXISTS retail_sales;
CREATE TABLE retail_sales(
transactions_id INT PRIMARY KEY,
sale_date DATE,
sale_time TIME,
customer_id	INT,
gender VARCHAR(10),
age INT,
category VARCHAR (15),
quantity INT,
price_per_unit FLOAT,
cogs FLOAT,
total_sale FLOAT
);
# import data from excel
--
SELECT * FROM sql_project_1.retail_sales;
SELECT COUNT(*) FROM retail_sales;

# data cleaning
SELECT * FROM retail_sales 
WHERE transactions_id IS NULL
OR 
sale_date IS NULL
OR 
sale_time IS NULL
OR 
customer_id IS NULL 
OR
gender IS NULL
OR
age IS NULL
OR 
category IS NULL
OR
quantity IS NULL
OR
price_per_unit IS NULL
OR
cogs IS NULL
OR
total_sale IS NULL;

#data exploration
#how many transactions 
SELECT COUNT(*) FROM retail_sales AS total_transactions;

# how many customers 
SELECT COUNT(DISTINCT customer_id)AS total_customers FROM retail_sales;
# how many catogories
SELECT DISTINCT category AS total_catogories FROM retail_sales;

# main anlysis problems

#Write a SQL query to retrieve all columns for sales made on '2022-11-05:
SELECT * FROM retail_sales WHERE sale_date = '2022-11-05';

#Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 4 in the month of Nov-2022:
SELECT * FROM retail_sales WHERE category = 'Clothing'
  AND DATE_FORMAT(sale_date, '%Y-%m') = '2022-11'
  AND quantity >= 4;
  
#Write a SQL query to calculate the total sales (total_sale) for each category.
SELECT category, SUM(total_sale) AS net_sale, COUNT(*) AS total_orders FROM retail_sales GROUP BY category;

#Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.:
SELECT ROUND(AVG(age), 2) AS avg_age FROM retail_sales WHERE category = 'Beauty';

#Write a SQL query to find all transactions where the total_sale is greater than 1000.
SELECT * FROM retail_sales WHERE total_sale > 1000;

#Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.
select category, gender,count(*) from retail_sales group by gender, category order by category;

#Write a SQL query to calculate the average sale for each month. Find out best selling month in each year.
SELECT year, month, avg_sale FROM (
	SELECT YEAR(sale_date) AS year, MONTH(sale_date) AS month, AVG(total_sale) AS avg_sale, 
	RANK() OVER(PARTITION BY YEAR(sale_date) ORDER BY AVG(total_sale) DESC) AS drank 
	FROM retail_sales 
	GROUP BY YEAR(sale_date), MONTH(sale_date) 
	ORDER BY YEAR(sale_date),AVG(total_sale)
) AS t1 
WHERE drank= 1;

#Write a SQL query to find the top 5 customers based on the highest total sales
SELECT DISTINCT(customer_id), SUM(total_sale) 
FROM retail_sales 
GROUP BY customer_id 
ORDER BY SUM(total_sale) DESC LIMIT 5;

#Write a SQL query to find the number of unique customers who purchased items from each category.
SELECT COUNT(DISTINCT customer_id) AS unique_cust, category FROM retail_sales GROUP BY category;

#Write a SQL query to create each shift and number of orders (Example Morning <12, Afternoon Between 12 & 17, Evening >17):
SELECT COUNT(transactions_id) AS orders,
	CASE WHEN HOUR(sale_time)<12 THEN 'Morning'
		WHEN HOUR(sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
        ELSE 'Evening'
        END AS shift 
FROM retail_sales
GROUP BY shift 


# END OF PROJECT













