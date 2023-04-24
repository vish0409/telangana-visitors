select * from [domestic_data(1)]
select * from foreign_data

-- Top 10 districts by overall domestic visitors --
select top 10 district,SUM(visitors) as total_visitors
from domestic_data(1)
group by district
order by total_visitors desc

-- Top 10 districts by overall foreign visitors--
select top 10 district,SUM(visitors) as total_visitors
from foreign_data
group by district 
order by total_visitors desc

-- Top 3 district based on cagr in domestic and foreign visitors
select top 3 district,round(((Power(MAX(visitors)/MIN(visitors),1/(MAX(year)-MIN(year)+1)))-1),2) as CAGR
from domestic_data
group by district
order by CAGR desc

select top 3 district,round(((Power(MAX(visitors)/MIN(visitors),1/(MAX(year)-MIN(year)+1)))-1),2) as CAGR
from foreign_data
group by district
order by CAGR desc

-- Bottom 3 district based on cagr in domestic and foreign visitors

select top 3 district,round(((Power(MAX(visitors)/MIN(visitors),1/(MAX(year)-MIN(year)+1)))-1),2) as CAGR
from domestic_data
group by district
order by CAGR 

select top 3 district,round(((Power(MAX(visitors)/MIN(visitors),1/(MAX(year)-MIN(year)+1)))-1),2) as CAGR
from foreign_data
group by district
order by CAGR 

--Peak and low season months for Hyd


SELECT district, date,month,SUM(visitors) as hyd_visitors
FROM [domestic_data(1)]
where district='Hyderabad'
group by district,date,month
order by hyd_visitors desc


select district,month,SUM(visitors) as hyd_visitors
from foreign_data
where district='Hyderabad'
group by district, month
order by hyd_visitors desc

-- Domestic to foreign tourist ratio--
select d.district,sum(d.visitors) as domestic_visitors,sum(f.visitors) as foreign_visitors,
ROUND((SUM(d.visitors)/SUM(f.visitors)),2) as ratio
from [domestic_data(1)] d join [foreign_data(1)] f on d.district=f.district
group by d.district
order by ratio asc

-- Foreign to domestic tourist ratio--
select d.district,sum(d.visitors) as domestic_visitors,sum(f.visitors) as foreign_visitors,
ROUND((SUM(f.visitors)/SUM(d.visitors))*100,3) as ratio
from domestic_data d join foreign_data f on d.district=f.district
group by d.district
order by ratio desc

select f.district,sum(d.visitors) as domestic_visitors,sum(f.visitors) as foreign_visitors,
SUM(f.visitors)/SUM(d.visitors) as ratio
from [domestic_data(1)] d join [foreign_data(1)] f on d.district=f.district
group by f.district
order by ratio asc