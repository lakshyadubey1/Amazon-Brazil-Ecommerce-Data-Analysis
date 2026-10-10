# Amazon Brazil E-commerce Data Analysis

## Project Overview

This project analyzes Amazon Brazil's e-commerce data using **MySQL** to understand marketplace performance and identify opportunities for business improvement.

The analysis explores sales and order activity, customer purchasing behaviour, seller performance, product category revenue, payment preferences, delivery time, customer reviews, and demand patterns.

The goal is to transform transactional data into meaningful business insights that can support decisions across marketing, merchandising, seller management, logistics, and customer experience.

## Business Objectives

The project focuses on five main areas:

- **Sales and Revenue Analysis:** Evaluate category-level revenue, cumulative revenue growth, and top-performing product categories.
- **Customer Analysis:** Identify high-value customers, examine order frequency across states, and understand review participation.
- **Seller Performance:** Analyze seller-state order volume, identify inactive sellers, and compare seller performance against the platform average.
- **Operations and Customer Experience:** Explore payment methods, delivery time, category-level satisfaction, and regional review scores.
- **Demand Planning:** Identify the busiest month across the platform's order history.

## Tools & Technologies

- **MySQL** — database querying and analysis
- **SQL** — data retrieval, transformation, aggregation, and business analysis

## Dataset

The project uses the Amazon Brazil e-commerce dataset provided for the analysis, along with its data dictionary.

The database includes information about customers, orders, order items, products, sellers, payments, reviews, and product category translations.

### Key Tables

| Table | Purpose |
|---|---|
| `customers` | Customer identifiers and location |
| `orders` | Order details and timestamps |
| `order_items` | Products, sellers, prices, and order items |
| `products` | Product information and categories |
| `sellers` | Seller details and locations |
| `order_payments` | Payment methods and values |
| `order_reviews` | Customer review scores |
| `product_category_name_translation` | Translated product category names |

## Analysis Performed

The project contains 14 business-focused SQL analyses:

1. Order volume by seller state
2. Cumulative revenue by product category over time
3. Payment method usage and average order value by payment type
4. Highest-spending customer
5. Average review score by product category
6. Customer order frequency by state
7. Sellers with no fulfilled orders
8. Top five product categories by revenue
9. Median delivery time
10. Products that have never been ordered
11. Sellers performing above the average fulfilled-order count
12. State with the highest average customer review score
13. Customers who have never left a review
14. Month with the highest total order volume across the platform

## SQL Skills Demonstrated

- Multi-table joins
- Aggregate functions: `SUM()`, `AVG()`, and `COUNT()`
- Grouping and sorting with `GROUP BY` and `ORDER BY`
- Common Table Expressions (CTEs)
- Window functions and running totals
- Subqueries and `NOT EXISTS`
- Date functions, including `MONTH()`, `YEAR()`, and `DATEDIFF()`
- Median calculation using `ROW_NUMBER()`, `FLOOR()`, and `CEIL()`
- `CROSS JOIN` for comparing seller performance with an average benchmark
- Choosing appropriate aggregation levels based on table grain

## Key Findings

This section will summarize the most important findings after the query results have been reviewed.

Planned areas include:

- Highest-spending customer and customer purchasing patterns
- Leading product categories by revenue
- Seller activity and above-average performers
- Payment preferences and order value
- Delivery-time performance and customer satisfaction
- Peak order month and its implications for demand planning

*Specific findings and numerical values will be added after validating the final query outputs.*

## Business Recommendations

The analysis can inform the following actions:

- Use regional seller activity to support fulfillment and infrastructure planning.
- Prioritize high-revenue categories when planning promotions.
- Explore loyalty and retention strategies for high-value customers.
- Re-engage dormant sellers and recognize consistently strong performers.
- Investigate delivery performance and satisfaction differences across regions.
- Encourage review participation and evaluate products with no recorded orders.
- Use historical order patterns to inform staffing and inventory planning.

These recommendations should be refined against the actual query results before being treated as final conclusions.

## Project Deliverables

The repository include:

- SQL scripts containing the analysis
- Dataset documentation and data dictionary
- Project presentation
- Documented findings and business recommendations

## Conclusion

This project demonstrates how SQL can be used to investigate e-commerce performance, answer business questions, and develop data-driven recommendations. It brings together customer, seller, product, payment, delivery, and review analysis in a structured project suitable for further exploration and portfolio presentation.
