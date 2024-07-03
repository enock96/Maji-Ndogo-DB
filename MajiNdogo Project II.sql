Use md_water_services;
show tables;
select * from employee;

SET SQL_SAFE_UPDATES=0;

UPDATE employee
SET email =CONCAT(LOWER(REPLACE(employee_name, ' ', '.')),'@ndogowater.gov')
where email IS NULL;

SELECT length(trim(phone_number)) from employee;

UPDATE employee
SET phone_number = trim(phone_number);
 
SELECT length(phone_number) from employee;

select town_name, count(*) from employee
group by town_name;

select assigned_employee_id, count(visit_count) from visits
group by assigned_employee_id
order by assigned_employee_id LIMIT 3;

select * from location;

select town_name, Count(town_name) as number_of_records
from location
group by town_name
order by number_of_records desc;

select province_name, Count(province_name) as number_of_records
from location
group by province_name
order by number_of_records desc;

select 
	province_name,
    town_name,
    count(town_name) AS records_per_town
from 
	location
group by province_name, town_name
order by province_name, records_per_town desc;

select location_type, count(location_type) AS number_of_records
from location
group by location_type
order by number_of_records desc;

select ROUND(23740/(15910+23740)*100);

SELECT * FROM WATER_SOURCE;

select sum(number_of_people_served) AS total_people_served 
	from water_source;

select type_of_water_source, count(type_of_water_source) AS number_of_wells 
from water_source
group by type_of_water_source
order by type_of_water_source;

select type_of_water_source, ROUND(AVG(number_of_people_served)) as number_of_people_sharing
FROM water_source
GROUP by type_of_water_source;

select type_of_water_source, ROUND(AVG(number_of_people_served)) AS Avg_no_of_pple_served
from water_source
group by type_of_water_source
;

SELECT current_date() AS Date_Today;

-- current date and time of the system
SELECT now() AS Now_Date_of_system; 

-- current date and time
SELECT current_timestamp() AS Now_time;

/*check why it did nott work*/
SELECT DISTINCT type_of_water_source,
    SUM(number_of_people_served) OVER (PARTITION BY number_of_people_served)/SUM(number_of_people_served)*100
    FROM water_source
    GROUP BY type_of_water_source;


SELECT DISTINCT type_of_water_source,
SUM(number_of_people_served) OVER (PARTITION BY type_of_water_source)/
(select sum(number_of_people_served) from water_source) * 100 AS Percentage_ppl_per_source
FROM water_source
ORDER BY Percentage_ppl_per_source desc;
  
    
SELECT DISTINCT type_of_water_source, SUM(number_of_people_served),
RANK() OVER (PARTITION BY type_of_water_source 
	ORDER BY SUM(number_of_people_served)) AS Ranks
FROM water_source
GROUP BY type_of_water_source;

SELECT type_of_water_source
	,Total_pop
    ,RANK() OVER(ORDER BY Total_pop DESC) AS Rnk
FROM(
	SELECT DISTINCT type_of_water_source,
	SUM(number_of_people_served) OVER (PARTITION BY type_of_water_source) AS Total_pop
	FROM water_source) Tbl;
    
select * from visits;

SELECT time_format(TIME(time_of_record),'%H:00') AS hour_of_day,
ROUND(AVG(CASE
	WHEN DAYNAME(time_of_record) = 'Sunday' THEN time_in_queue
    ELSE null
    END)) AS Sunday,
ROUND(AVG(CASE
	WHEN DAYNAME(time_of_record) = 'Monday' THEN time_in_queue
    ELSE null
    END)) AS Monday,
ROUND(AVG(CASE
	WHEN DAYNAME(time_of_record) = 'Tuesday' THEN time_in_queue
    ELSE null
    END)) AS Tuesday,
    ROUND(AVG(CASE
	WHEN DAYNAME(time_of_record) = 'Wednesday' THEN time_in_queue
    ELSE null
    END)) AS Wednesday,
    ROUND(AVG(CASE
	WHEN DAYNAME(time_of_record) = 'Thursday' THEN time_in_queue
    ELSE null
    END)) AS Thursday,
    ROUND(AVG(CASE
	WHEN DAYNAME(time_of_record) = 'Friday' THEN time_in_queue
    ELSE null
    END)) AS Friday,
    ROUND(AVG(CASE
	WHEN DAYNAME(time_of_record) = 'Saturday' THEN time_in_queue
    ELSE null
    END)) AS Saturday
    FROM visits
    WHERE 
		time_in_queue != 0
        GROUP BY hour_of_day
        ORDER BY hour_of_day;
        
SELECT time_format(TIME(time_of_record),'%H:00') AS hour_of_day,
DAYNAME(time_of_record),
CASE
	WHEN DAYNAME(time_of_record) = 'Sunday' THEN time_in_queue
    ELSE null
    END AS Sunday
    FROM visits
    WHERE 
		time_in_queue != 0;
        
        SELECT CONCAT(day(time_of_record), " ", monthname(time_of_record), " ", year(time_of_record)) FROM visits;