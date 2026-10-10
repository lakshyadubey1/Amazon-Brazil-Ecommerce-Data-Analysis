select * from customers;
select * from geolocation;
select * from leads_closed;
select * from leads_qualified;
select * from order_items;
select * from order_payments;
select * from order_reviews;
select * from orders;
select * from product_category_name_translation;
select * from products;
select * from sellers;


--Q1. Find the total number of orders fulfilled by each seller state.

select
    t1.seller_state, count(distinct t2.order_id) as total_orders
from sellers as t1
join order_items as t2
    using(seller_id)
group by 1
order by total_orders desc;




--Q2. For each product category, 
--    calculate the cumulative revenue generated as orders come in over time.

with category_revenue as (
    select
        t1.product_category_name_english as product_category_name, 
        DATE(t4.order_purchase_timestamp) as order_date,
        sum(t3.price) as revenue
    from product_category_name_translation as t1
    join products as t2
        using(product_category_name)
    join order_items as t3
        using(product_id)
    join orders as t4
        using(order_id)
    group by 1,2)
select
    product_category_name, order_date, revenue,
    round(sum(revenue) over(partition by product_category_name order by order_date
             rows between unbounded preceding and current row), 2) as cumulative_sum
from category_revenue;



--Q3. Which payment method do customers use the most, and what is the average order value for each payment type?

with payments as (select 
    order_id, payment_type, sum(payment_value) as order_value
from order_payments
group by 1, 2)
select
    payment_type, count(DISTINCT order_id) as total_orders,
    avg(order_value) as avg_order_value
from payments
group by payment_type
order by total_orders desc;


--Q4. Find the customer who has spent the most money across all their orders.

select
    t1.customer_unique_id,sum(t3.payment_value) as money_spent
from customers as t1
join orders as t2
    using(customer_id)
join order_payments as t3
    using(order_id)
group by 1
order by money_spent desc limit 1;


--Q5. Find the average review score for each product category.

select
    t1.product_category_name_english as product_category,
    avg(t4.review_score) as avg_review_score
from product_category_name_translation as t1
join products as t2
    using(product_category_name)
join order_items as t3
    using(product_id)
join order_reviews as t4
    using(order_id)
group by 1;



--Q6. Find the total number of orders placed by each customer, broken down by the state they live in.

select
    t1.customer_unique_id as customer_unique_id,
    t1.customer_state as customer_state,
    count(t2.order_id) as total_orders
from customers as t1
join orders as t2
    using(customer_id)
group by 1, 2;



--Q7. Identify sellers who registered on the platform but have never fulfilled a single order.

select
    t1.seller_id,
    t1.seller_city,
    t1.seller_state
from sellers as t1
where not exists(select 1 
                 from order_items as t2 
                 where t2.seller_id = t1.seller_id);



--Q8. Find the top 5 product categories by total revenue.

select
    t1.product_category_name_english as product_category,
    sum(t3.price) as total_revenue
from product_category_name_translation as t1
join products as t2
    using(product_category_name)
join order_items as t3
    using(product_id)
group by 1
order by total_revenue desc limit 5;


--Q9. Find the median delivery time (in days) between order placement and actual delivery.

with delivery as (select
    DATEDIFF(order_delivered_customer_date, order_purchase_timestamp) as delivery_days,
    ROW_NUMBER() 
    over(order by DATEDIFF(order_delivered_customer_date, order_purchase_timestamp))as row_num,
    count(*) over() total_rows
from orders
where order_delivered_customer_date is not null)
select
    round(avg(delivery_days),0) as median_delivery_time
from delivery
where row_num in(
            floor((total_rows + 1) / 2),
            ceil((total_rows + 1) / 2));



--Q10. Find all products that have never been ordered.

select
    product_id
from products
where not EXISTS(
        select 1
        from order_items
        where 
            order_items.product_id = products.product_id);



--Q11. Find sellers who have fulfilled more orders than the average seller on the platform.

with fulfilled_orders as (
    select
    seller_id, count(DISTINCT order_id) total_orders
    from order_items
    group by 1),
average as (
    select avg(total_orders) as avg_orders
    from fulfilled_orders)
select
    t1.seller_id, t1.total_orders
from fulfilled_orders as t1
cross join average as t2
where t1.total_orders > t2.avg_orders;



--Q12. Find which Brazilian states have the 
--highest average customer review score for orders delivered there.

select
    t1.customer_state as state, 
    avg(t3.review_score) as avg_customer_review
from customers as t1
join orders as t2
    using(customer_id)
join order_reviews as t3
    using(order_id)
group by 1
order by avg_customer_review desc limit 1;



--Q13. Identify customers who have placed orders but never left a review.

select
    customer_unique_id
from customers
join orders
    using(customer_id)
where not EXISTS(
    select 1
    from order_reviews
    where order_reviews.order_id = orders.order_id);



--Q14. Find the month with the highest number of orders placed across the entire platform.

select
    month(order_purchase_timestamp) as order_month,
    count(order_id) as total_orders
from orders
group by 1
order by total_orders desc limit 1;