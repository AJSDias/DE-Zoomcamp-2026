/*
select count(*) from {{ref ('fct_monthly_zone_revenue')}}
*/

/*
select
    pickup_zone,
    service_type,
    YEAR(cast(revenue_month as date)) as revenue_year,
    sum(revenue_monthly_total_amount) as revenue_monthly_total_amount
from {{ref ('fct_monthly_zone_revenue')}}
where service_type = 'Green' 
and revenue_year = 2020
group by 1,2,3
order by revenue_monthly_total_amount desc
*/

/*
select sum(total_monthly_trips) as total_trips
from {{ref ('fct_monthly_zone_revenue')}}
where service_type = 'Green'
and YEAR(cast(revenue_month as date)) = 2019
and MONTH(cast(revenue_month as date)) = 10
*/

select count(*) from {{ref ('stg_fhv_tripdata')}}