# Sql-Analysis-ecommerce-db

# 🛒 SQL for Data Analysis (Task 4)

## 📌 Project Overview
This project demonstrates the use of **SQL in MySQL Workbench** for analyzing an **ecommerce database (`ecommerce_db`)**.  
The analysis covers data extraction, aggregation, joins, subqueries, views, and indexing — aligning with the requirements of **Task 4: SQL for Data Analysis**.

---

## 🗂️ Database Schema
The database **`ecommerce_db`** contains the following tables:

- **`customers`** → stores customer information  
- **`orders`** → captures customer orders (order ID, customer ID, date, amount)  
- **`products`** → product catalog with categories and prices  
- **`order_items`** → connects orders with products, including quantity and unit price  

Additionally, a **view** was created:
- **`vw_daily_revenue`** → aggregates total revenue per day for easy reporting

---

## 🎯 SQL Skills Demonstrated
✔️ **Data filtering & sorting** → `SELECT`, `WHERE`, `ORDER BY`  
✔️ **Aggregations** → `GROUP BY`, `SUM`, `AVG`  
✔️ **Joins** → `INNER JOIN`, `LEFT JOIN`, `RIGHT JOIN`  
✔️ **Subqueries** → customers spending above the average  
✔️ **Views** → reusable query (`vw_daily_revenue`) for daily revenue  
✔️ **Indexes** → optimizing performance for `orders` and `order_items`  

---

## 📊 Key Insights from Queries
- Top 10 most recent customer orders  
- Monthly revenue trends  
- Average order value (AOV)  
- Revenue breakdown by product category  
- Customer total spend (including those with no orders)  
- Products sold vs. unsold using `RIGHT JOIN`  
- Customers who spend above the average customer spend  
- Daily revenue trend via the view `vw_daily_revenue`  


---

## 🛠️ Tools Used
- **MySQL Workbench** – SQL query execution and schema management  
- **GitHub** – version control and submission repository  

---

## 🚀 How to Run
1. Clone the repository:  
   ```bash
   git clone https://github.com/<your-username>/task-4-sql-analysis.git
2.Open MySQL Workbench.
3.Run the script:
   SOURCE mysql_task4_full_script.sql;
4.Execute the queries step by step and verify the outputs in the result grid.
5.Refer to the screenshots folder for expected outputs.
