SELECT * FROM public.retail_buy
ORDER BY transactions_id ASC LIMIT 100
  select * from retail_buy;
  limit 10;
--- data cleaning
  select 
   count(*)
  from retail_buy;
  SELECT*
  FROM retail_buy
  delete from retail_buy
  where 
     transactions_id is null 
	 or 
	 sale_date is null
	 or
	 sale_time is null
	 or
	 gender is null
	 or
	 category is null
	 or
	 retail_buy.quantiy is null
	 or
	 price_per_unit is null
	 or
	 cogs is null
	 or
	 total_sale is null;

	 --- data exploration
	 ----how many sales we have?
	 select count(*)  as total_sales
	 from retail_buy;
	 ------ how many unique customers we have?
	  select count( distinct customer_id)  as total_customer
	  from retail_buy;
	  ---- how many category we have
	  select count( distinct category)  as total_customer
	  from retail_buy;
	  ------ category we have
	  select  distinct category  as total_customer
	  from retail_buy;
	  ----- business key problem and answers
	   --q1 write a SQL query to retrieve all columns for sales made on '2022-11-05'

	  select*
	  from retail_buy
	  where sale_date ='2022-11-05';
	 -----q2  write a sql query to retrieve all transaction where category is'clothing' and the quantity sold is more than 4
           in the month of Nov 2022

		    select
			*
			from retail_buy
			where category ='Clothing'
			and
			To_char(sale_date,'YYYY-MM')='2022-11'
			and
			quantiy>=4;
		--q.3  write a sql query to calculate the total sale(total_sale) for each category
		   select
		   category,
		   sum(total_sale) as net_sale
		   from retail_buy
			group by category;
	 ---q.4 write a sql to find  the average age of customers who purchased item from the'Beauty'category.
	 select
	  round(avg(age),2) as avg_age
	 from retail_buy
	 where category='Beauty';
	 ----q.5 write a sql to find all transaction where the total_sale is greater than 1000
	 select*
	 from retail_buy
	 where total_sale>1000;
	 ------q6 write a sql query to find the total number of transactions(transaction_id) made by each gender in each category
      select
	 count ( transactions_id) as total_transaction,
	  gender,
	  category
	  from retail_buy
	  group by category,gender
	  order by category;
	  -------q7 write a sql query to calculate the avg sale of each month.Find the best selling month in each year
select year, month, avg_sale
from(
select
	  Extract(Year from sale_date) as year,
	  Extract(Month from sale_date) as month,
	avg(total_sale) as avg_sale,
	RANK() over(partition by Extract(Year from sale_date) order by avg(total_sale)Desc) as rank
	  from retail_buy
	  group by 1,2
	  ) as t1
	  where rank=1;
	  ----- q8 write a sql query to find the top 5 customers based on the highest total sale
	  select
	  customer_id,
	  sum(total_sale) as total_sales
	  from retail_buy
	  group by customer_id
	  order by 2 desc
	  limit 5;
	  -----q9 write a sql query to find the number of unique customers who purchased item from each category
	  select
	   count (distinct customer_id),
	  category
	  from retail_buy
	  group by category;
	  -- q10 write  a sql query to create each shift and number of order(Example morning<=12,afternoon between12&17,evening>17)
      with hourly_base
	  as(
	  select*,
	case
	   when extract( hour from sale_time)<12 then'morning'
	   when extract( hour from sale_time) between 12 and 17 then'afternoon'
	   else'evening'
	   end as shift
	  from retail_buy
	  )
	  select
	  shift,
	  count(*) as total_orders
	  from hourly_base
	  group by shift
	   
------ end of project	  
	  
	  
	  
	  