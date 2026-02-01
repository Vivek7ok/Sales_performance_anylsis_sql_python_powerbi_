select gender, sum(purchase_amount) 
from customer_sales
group by gender;

select customer_id, purchase_amount 
from customer_sales
where purchase_amount > (select avg(purchase_amount) from customer_sales) and discount_applied = 'Yes';

select item_purchased ,(avg(review_rating),2)
from customer_sales
group by item_purchased
order by avg(review_rating) desc
limit 5;

select shipping_type, round(avg(purchase_amount),2)
from customer_sales
where shipping_type in ('Express' ,'Standard')
group by shipping_type ;

select subscription_status, count(subscription_status) as cutomer, round(avg(purchase_amount),2) as avgrage_spend, sum(purchase_amount) as Total_revenue
from customer_sales
group by subscription_status;

select item_purchased, 
100 * sum(case when discount_applied = 'Yes' then 1 else 0 end)/count(*) as dicount
from customer_sales
group by item_purchased
order by dicount desc
limit 5;

select 
case 
	when previous_purchases between 0 and 1 then 'New'
	when previous_purchases between 2 and 10 then 'Recturing'
	when previous_purchases between 10 and 50 then 'loyel'
	else 0 end as compare ,
count(*) as count_of_cus
from customer_sales
group by compare;

with order_rank as
(select category ,item_purchased ,
count(customer_id) as no,
row_number() over(partition by category order by count(customer_id) desc) as rk
from customer_sales
group by category ,item_purchased)
select *
from order_rank
where rk <= 3;

select 
subscription_status,
count(customer_id) as reapte_buyer
from customer_sales
where previous_purchases > 5
group by subscription_status;

select age_group,
sum(purchase_amount) as Total_revenue
from customer_sales
group by age_group;



