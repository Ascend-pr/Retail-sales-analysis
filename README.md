# Retail-sales-analysis
End-to-end retail sales analysis using PostgreSQL, schema design, CTEs, window functions, stored procedures, and views.
# 🛒 Retail Sales Performance Analysis
### A PostgreSQL Data Analysis Project

---

## 📌 Project Overview

This project analyzes 12 months of retail sales data using PostgreSQL. It covers the full data analyst workflow — from database design and data loading, through to business analysis and reporting. The goal is to uncover actionable insights about revenue trends, product performance, regional sales, and customer value.

**Tools Used:** PostgreSQL · pgAdmin · SQL (CTEs, Window Functions, Stored Procedures, Views)

---

## 🗂️ Database Schema

The database `retail_sales_dbp` consists of 5 tables:

| Table | Description |
|---|---|
| `customers` | Customer profiles including city and state |
| `products` | Product catalog with pricing |
| `categories` | Product category groupings |
| `orders` | Order records with status and payment method |
| `order_items` | Line items linking orders to products |

**Key design decision:** `unit_price` is stored on `order_items` rather than pulled from `products.price` at query time. This preserves historical order accuracy even when product prices change — a real-world requirement in any transactional system.

---

## 📊 Key Findings

### 1. Regional Performance
Lagos was the dominant market, generating **₦1,316.58** in revenue across 14 orders — nearly 3x the next highest state (Oyo at ₦527.87). However, Edo ranked 7th overall yet topped December's monthly report, driven by a single high-value customer. This highlights the risk of reading regional data at only the annual level.

| State | Orders | Revenue |
|---|---|---|
| Lagos | 14 | ₦1,316.58 |
| Oyo | 5 | ₦527.87 |
| Kano | 5 | ₦447.88 |
| Kaduna | 4 | ₦442.91 |
| Enugu | 4 | ₦369.91 |

### 2. Product Performance
Unit count alone does not tell the full story. **Resistance Bands** was the highest-selling product by units (15 sold) but ranked 7th by revenue due to its low price point (₦15.99). **Dumbbell Set** sold only 6 units but ranked 2nd by revenue at ₦539.94, nearly matching Wireless Earbuds' top position.

| Product | Units Sold | Revenue | Rank |
|---|---|---|---|
| Wireless Earbuds | 11 | ₦549.89 | 1 |
| Dumbbell Set | 6 | ₦539.94 | 2 |
| Bluetooth Speaker | 6 | ₦479.94 | 3 |
| Blender | 4 | ₦279.96 | 4 |
| Men's Polo Shirt | 10 | ₦249.90 | 5 |

### 3. Monthly Revenue Trend
Q4 was the strongest quarter, with December peaking at **₦701.80** — an 82.33% month-over-month increase from November. April recorded the sharpest dip at ₦242.90 (-20.08% from March). May showed the strongest mid-year recovery at +62.58%.

| Month | Revenue | MoM Growth |
|---|---|---|
| 2024-01 | ₦264.93 | — |
| 2024-04 | ₦242.90 | -20.08% |
| 2024-05 | ₦394.90 | +62.58% |
| 2024-12 | ₦701.80 | +82.33% |

### 4. Customer Segmentation
Of 20 customers, 13 were classified as **High Value** (total spend ≥ ₦200), 6 as **Mid Value**, and only 1 as **Low Value**. The single Low Value customer (Damilola Afolabi, Lagos) placed only one order — a re-engagement opportunity for any marketing team.

**Average Order Value:** ₦94.23

---

## 🔧 SQL Features Demonstrated

- **Schema design** with primary keys, foreign keys, and constraints
- **Multi-table JOINs** across 4 related tables
- **CTEs** for readable, multi-step analysis
- **Window functions** — `LAG()` for month-over-month growth, `RANK()` and `PARTITION BY` for product rankings within categories
- **Views** — saved queries for monthly revenue, product performance, and customer segments
- **Stored Procedure** — `generate_monthly_report(target_month)` outputs a full sales summary for any given month
- **Indexes** — on `order_date`, `customer_id`, `order_id`, and `product_id` for query optimization

---

## 🚀 How to Run This Project

1. Install PostgreSQL and open pgAdmin
2. Create a new database called `retail_sales_db`
3. Open the Query Tool and run the scripts in this order:
   - `01_schema.sql` — creates all tables
   - `02_data.sql` — inserts categories, products, customers, orders, and order items
   - `03_analysis.sql` — runs all analytical queries
   - `04_views.sql` — creates the three views
   - `05_procedure.sql` — creates the stored procedure
   - `06_indexes.sql` — adds performance indexes

4. To generate a monthly report, run:
```sql
CALL generate_monthly_report('2024-12');
```

---

## 📁 Project Structure

```
retail-sales-analysis/
│
├── README.md
├── 01_schema.sql
├── 02_data.sql
├── 03_analysis.sql
├── 04_views.sql
├── 05_procedure.sql
└── 06_indexes.sql
```

---

## 👤 Author

**Promise Odufuwa(Ascend)**  
Data Analyst | Excel · Power BI · Tableau · PostgreSQL  
[LinkedIn](#) · [GitHub](#)

---

*This project was built as part of a personal data analytics portfolio to demonstrate end-to-end SQL skills for data analyst roles.*
