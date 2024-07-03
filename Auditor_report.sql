use md_water_services;

DROP TABLE IF EXISTS `auditor_report`;
CREATE TABLE `auditor_report` (
`location_id` VARCHAR(32),
`type_of_water_source` VARCHAR(64),
`true_water_source_score` int DEFAULT NULL,
`statements` VARCHAR(255)
);

SELECT * FROM auditor_report;
SELECT * FROM Visits;
SELECT * FROM water_quality;

WITH Incorrect_records AS(
SELECT 
		ar.location_id AS "Audit_location",
		vs.record_id AS "Record_id",
		ar.true_water_source_score AS "Auditor_score",
        em.assigned_employee_id,
        em.employee_name,
		wq.subjective_quality_score AS "Employee_score"
        /*ws.type_of_water_source AS "survey_source",
        ar.type_of_water_source AS "auditor source"*/
	FROM
		auditor_report  AS ar
	JOIN
		visits AS vs
	JOIN 
		Water_quality AS wq
        
		ON vs.record_id = wq.record_id
		ON vs.location_id = ar.location_id
        
										/*JOIN 
											water_source AS ws
										ON ws.source_id = vs.source_id
										*/
	JOIN 
		employee AS em
        ON em.assigned_employee_id = vs.assigned_employee_id
        
		WHERE ar.true_water_source_score <> wq.subjective_quality_score
		AND vs.visit_count = 1
        )
        
	SELECT * FROM Incorrect_records
     ;

WITH Incorrect_records AS(
SELECT 
		ar.location_id AS "Audit_location",
		vs.record_id AS "Record_id",
		ar.true_water_source_score AS "Auditor_score",
        em.assigned_employee_id,
        em.employee_name,
		wq.subjective_quality_score AS "Employee_score"
        /*ws.type_of_water_source AS "survey_source",
        ar.type_of_water_source AS "auditor source"*/
	FROM
		auditor_report  AS ar
	JOIN
		visits AS vs
	JOIN 
		Water_quality AS wq
        
		ON vs.record_id = wq.record_id
		ON vs.location_id = ar.location_id
        
										/*JOIN 
											water_source AS ws
										ON ws.source_id = vs.source_id
										*/
	JOIN 
		employee AS em
        ON em.assigned_employee_id = vs.assigned_employee_id
        
		WHERE ar.true_water_source_score <> wq.subjective_quality_score
		AND vs.visit_count = 1
        )
        
	SELECT DISTINCT employee_name FROM Incorrect_records
     ;
	
WITH Incorrect_records AS(
SELECT 
		ar.location_id AS "Audit_location",
		vs.record_id AS "Record_id",
		ar.true_water_source_score AS "Auditor_score",
        em.assigned_employee_id,
        em.employee_name,
		wq.subjective_quality_score AS "Employee_score"
        /*ws.type_of_water_source AS "survey_source",
        ar.type_of_water_source AS "auditor source"*/
	FROM
		auditor_report  AS ar
	JOIN
		visits AS vs
	JOIN 
		Water_quality AS wq
        
		ON vs.record_id = wq.record_id
		ON vs.location_id = ar.location_id
        
										/*JOIN 
											water_source AS ws
										ON ws.source_id = vs.source_id
										*/
	JOIN 
		employee AS em
        ON em.assigned_employee_id = vs.assigned_employee_id
        
		WHERE ar.true_water_source_score <> wq.subjective_quality_score
		AND vs.visit_count = 1
        )
        
	SELECT employee_name, COUNT(employee_name) AS Number_of_mistakes
    FROM Incorrect_records GROUP BY employee_name
     ;
	
WITH Incorrect_records AS(
SELECT 
		ar.location_id AS "Audit_location",
		vs.record_id AS "Record_id",
		ar.true_water_source_score AS "Auditor_score",
        em.assigned_employee_id,
        em.employee_name,
		wq.subjective_quality_score AS "Employee_score"
        /*ws.type_of_water_source AS "survey_source",
        ar.type_of_water_source AS "auditor source"*/
	FROM
		auditor_report  AS ar
	JOIN
		visits AS vs
	JOIN 
		Water_quality AS wq
        
		ON vs.record_id = wq.record_id
		ON vs.location_id = ar.location_id
        
										/*JOIN 
											water_source AS ws
										ON ws.source_id = vs.source_id
										*/
	JOIN 
		employee AS em
        ON em.assigned_employee_id = vs.assigned_employee_id
        
		WHERE ar.true_water_source_score <> wq.subjective_quality_score
		AND vs.visit_count = 1
        )
        
	SELECT employee_name, COUNT(employee_name) AS Number_of_mistakes
    FROM Incorrect_records GROUP BY employee_name ORDER BY Number_of_mistakes
     ;
     
WITH Incorrect_records AS(
SELECT 
		ar.location_id AS "Audit_location",
		vs.record_id AS "Record_id",
		ar.true_water_source_score AS "Auditor_score",
        em.assigned_employee_id,
        em.employee_name,
		wq.subjective_quality_score AS "Employee_score"
        /*ws.type_of_water_source AS "survey_source",
        ar.type_of_water_source AS "auditor source"*/
	FROM
		auditor_report  AS ar
	JOIN
		visits AS vs
	JOIN 
		Water_quality AS wq
        
		ON vs.record_id = wq.record_id
		ON vs.location_id = ar.location_id
        
										/*JOIN 
											water_source AS ws
										ON ws.source_id = vs.source_id
										*/
	JOIN 
		employee AS em
        ON em.assigned_employee_id = vs.assigned_employee_id
        
		WHERE ar.true_water_source_score <> wq.subjective_quality_score
		AND vs.visit_count = 1
        ),
        
       error_count AS ( 
SELECT employee_name, COUNT(employee_name) AS Number_of_mistakes
    FROM Incorrect_records GROUP BY employee_name ORDER BY Number_of_mistakes
    ),
    
    avg_mistakes AS(
    SELECT AVG(Number_of_mistakes) AS avg_error_count_per_empl
    FROM
		error_count
    )
    
select * from avg_mistakes
     ;

-- slide 19.3


SELECT 
		ar.location_id AS "Audit_location",
		vs.record_id AS "Record_id",
		ar.true_water_source_score AS "Auditor_score",
        em.assigned_employee_id,
        em.employee_name,
		wq.subjective_quality_score AS "Employee_score",
        ar.statements AS statements
        /*ws.type_of_water_source AS "survey_source",
        ar.type_of_water_source AS "auditor source"*/
	FROM
		auditor_report  AS ar
	JOIN
		visits AS vs
	JOIN 
		Water_quality AS wq
        
		ON vs.record_id = wq.record_id
		ON vs.location_id = ar.location_id
        
										/*JOIN 
											water_source AS ws
										ON ws.source_id = vs.source_id
										*/
	JOIN 
		employee AS em
        ON em.assigned_employee_id = vs.assigned_employee_id
        
		WHERE ar.true_water_source_score <> wq.subjective_quality_score
		AND vs.visit_count = 1
        )
     ;
     
	SELECT * FROM Incorrect_records;
    
    WITH Incorrect_records AS(
SELECT 
		ar.location_id AS "Audit_location",
		vs.record_id AS "Record_id",
		ar.true_water_source_score AS "Auditor_score",
        em.assigned_employee_id,
        em.employee_name,
        ar.statements,
		wq.subjective_quality_score AS "Employee_score"
        /*ws.type_of_water_source AS "survey_source",
        ar.type_of_water_source AS "auditor source"*/
	FROM
		auditor_report  AS ar
	JOIN
		visits AS vs
	JOIN 
		Water_quality AS wq
        
		ON vs.record_id = wq.record_id
		ON vs.location_id = ar.location_id
        
										/*JOIN 
											water_source AS ws
										ON ws.source_id = vs.source_id
										*/
	JOIN 
		employee AS em
        ON em.assigned_employee_id = vs.assigned_employee_id
        
		WHERE ar.true_water_source_score <> wq.subjective_quality_score
		AND vs.visit_count = 1
        ),
        
       error_count AS ( 
SELECT employee_name, COUNT(employee_name) AS Number_of_mistakes
    FROM Incorrect_records GROUP BY employee_name ORDER BY Number_of_mistakes
    ),
    
    avg_mistakes AS(
    SELECT AVG(Number_of_mistakes) AS avg_error_count_per_empl
    FROM
		error_count
    ),
    
suspect_list AS(
SELECT
employee_name,
number_of_mistakes
FROM
error_count
WHERE
number_of_mistakes > (SELECT AVG(Number_of_mistakes) from error_count)
)
select employee_name, audit_location, statements from incorrect_records where employee_name 
IN (SELECT employee_name FROM suspect_list)
;
select * from location;

WITH combined_analysis_table AS(
select 
	loc.province_name,
    loc.town_name,
    loc.location_type,
    vs.time_in_queue,
    wp.results,
    ws.type_of_water_source,
	ws.number_of_people_served
from location as loc
join
	visits as vs
on vs.location_id = loc.location_id and vs.visit_count = 1
join
	water_source as ws
on ws.source_id = vs.source_id 
left join 
	well_pollution as wp
    on wp.source_id = vs.source_id
),

	pivot_province_pop as(
Select 
	province_name,
    SUM(number_of_people_served) as total_pop
from combined_analysis_table
group by province_name
)

SELECT 
	ppp.province_name,
    
SUM(CASE 
	when type_of_water_source = 'river' then
	 number_of_people_served else 0 
     end)/total_pop * 100
		 as 'River',
SUM(CASE 
	when type_of_water_source = 'well' then
	 number_of_people_served else 0 
     end)/total_pop * 100
		 as 'Well',
SUM(CASE 
	when type_of_water_source = 'Shared_tap' then
	 number_of_people_served else 0 
     end)/total_pop * 100
		 as 'Shared_tap',
SUM(CASE 
	when type_of_water_source = 'Tap_in_home' then
	 number_of_people_served else 0 
     end)/total_pop * 100
		 as 'Tap_in_home',
SUM(CASE 
	when type_of_water_source = 'Tap_in_home_broken' then
	 number_of_people_served else 0 
     end)/total_pop * 100
		 as 'Tap_in_home_broken'
         
	from pivot_province_pop as ppp
    join
		combined_analysis_table as ct
	on ppp.province_name = ct.province_name
    group by ppp.province_name;
            
            
	WITH combined_analysis_table AS(
select 
	loc.province_name,
    loc.town_name,
    loc.location_type,
    vs.time_in_queue,
    wp.results,
    ws.type_of_water_source,
	ws.number_of_people_served
from location as loc
join
	visits as vs
on vs.location_id = loc.location_id and vs.visit_count = 1
join
	water_source as ws
on ws.source_id = vs.source_id 
left join 
	well_pollution as wp
    on wp.source_id = vs.source_id
),

	pivot_town_pop as(
Select 
	province_name,
    town_name,
    SUM(number_of_people_served) as total_pop
from combined_analysis_table
group by province_name, town_name
)

SELECT 
	ppp.province_name,
    ppp.town_name,
    
SUM(CASE 
	when type_of_water_source = 'river' then
	 number_of_people_served else 0 
     end)/total_pop * 100
		 as 'River',
SUM(CASE 
	when type_of_water_source = 'well' then
	 number_of_people_served else 0 
     end)/total_pop * 100
		 as 'Well',
SUM(CASE 
	when type_of_water_source = 'Shared_tap' then
	 number_of_people_served else 0 
     end)/total_pop * 100
		 as 'Shared_tap',
SUM(CASE 
	when type_of_water_source = 'Tap_in_home' then
	 number_of_people_served else 0 
     end)/total_pop * 100
		 as 'Tap_in_home',
SUM(CASE 
	when type_of_water_source = 'Tap_in_home_broken' then
	 number_of_people_served else 0 
     end)/total_pop * 100
		 as 'Tap_in_home_broken'
         
	from pivot_town_pop as ppp
    join
		combined_analysis_table as ct
	on ppp.province_name = ct.province_name and ppp.town_name = ct.town_name
    group by ppp.province_name, ct.town_name
    order by ppp.town_name;	
	
   CREATE TEMPORARY TABLE town_aggregated_water_access AS (
   
WITH combined_analysis_table AS(
	SELECT 
		LOC.Province_name,
		LOC.town_name,
		LOC.Location_type,WS.type_of_water_source,
		WS.number_of_people_served,
		VS.time_in_queue,
        WP.results
	FROM Visits AS VS
LEFT JOIN
	well_pollution AS WP
ON 
	VS.source_id = WP.source_id
JOIN
	Location AS LOC
ON 
	VS.location_id = LOC.location_id and  VS.visit_count = 1
JOIN
	Water_source AS WS
ON
	VS.source_id = WS.source_id
), 
town_totals AS(
	SELECT 
		province_name,
		town_name,
		SUM(number_of_people_served) AS Total_pop 
	FROM combined_analysis_table
GROUP BY province_name,town_name
	)
   SELECT 
	ppp.province_name,
    ppp.town_name,
    
SUM(CASE 
	when type_of_water_source = 'river' then
	 number_of_people_served else 0 
     end)/total_pop * 100
		 as 'River',
SUM(CASE 
	when type_of_water_source = 'well' then
	 number_of_people_served else 0 
     end)/total_pop * 100
		 as 'Well',
SUM(CASE 
	when type_of_water_source = 'Shared_tap' then
	 number_of_people_served else 0 
     end)/total_pop * 100
		 as 'Shared_tap',
SUM(CASE 
	when type_of_water_source = 'Tap_in_home' then
	 number_of_people_served else 0 
     end)/total_pop * 100
		 as 'Tap_in_home',
SUM(CASE 
	when type_of_water_source = 'Tap_in_home_broken' then
	 number_of_people_served else 0 
     end)/total_pop * 100
		 as 'Tap_in_home_broken'
         
	from town_totals as ppp
    join
		combined_analysis_table as ct
	on ppp.province_name = ct.province_name and ppp.town_name = ct.town_name
    group by ppp.province_name, ct.town_name
    order by ppp.town_name
   ) ;
    select * from town_aggregated_water_access 
    where province_name = 'Amanzi' and town_name = 'Amina'
    order by province_name;
    
SELECT
	province_name,
	town_name,
	ROUND(tap_in_home_broken / (tap_in_home_broken + tap_in_home) *100,0) AS Pct_broken_taps
FROM
town_aggregated_water_access;
    
CREATE TABLE Project_progress (
Project_id SERIAL PRIMARY KEY,
source_id VARCHAR(20) NOT NULL REFERENCES water_source(source_id) ON DELETE CASCADE ON UPDATE CASCADE,
Address VARCHAR(50),
Town VARCHAR(30),
Province VARCHAR(30),
Source_type VARCHAR(50),
Improvement VARCHAR(50) ,
Source_status VARCHAR(50) DEFAULT 'Backlog' CHECK (Source_status IN ('Backlog', 'In progress', 'Complete')),
Date_of_completion DATE,
Comments TEXT
);

INSERT INTO project_progress(
	source_id,
	address,
	town,
	province,
	source_type,
    Improvement
)
SELECT
	water_source.source_id,
	location.address,
	location.town_name,
	location.province_name,
	water_source.type_of_water_source    
FROM
water_source
LEFT JOIN
well_pollution ON water_source.source_id = well_pollution.source_id
INNER JOIN
visits ON water_source.source_id = visits.source_id
INNER JOIN
location ON location.location_id = visits.location_id;

DROP TABLE IF EXISTS project_progress;
CREATE TABLE Project_progress (
Project_id SERIAL PRIMARY KEY,
source_id VARCHAR(20) NOT NULL REFERENCES water_source(source_id) ON DELETE CASCADE ON UPDATE CASCADE,
Address VARCHAR(50),
Town VARCHAR(30),
Province VARCHAR(30),
Source_type VARCHAR(50),
Improvement VARCHAR(50) ,
Source_status VARCHAR(50) DEFAULT 'Backlog' CHECK (Source_status IN ('Backlog', 'In progress', 'Complete')),
Date_of_completion DATE,
Comments TEXT
);

INSERT INTO project_progress(
	source_id,
	address,
	town,
	province,
	source_type,
    Improvement
)
SELECT
	water_source.source_id,
	location.address,
	location.town_name,
	location.province_name,
	water_source.type_of_water_source,
--    results,
--    time_in_queue,
    CASE
		WHEN results='Contaminated: Biological' THEN 'Install UV filter' 
        WHEN results='Contaminated: Chemical' THEN 'Install RO filter'
        WHEN type_of_water_source = 'river' THEN 'Drill well' 
        WHEN type_of_water_source ='shared_tap' /*AND time_in_queue > 30*/ THEN
			CONCAT("Install ", FLOOR(time_in_queue/30), " taps nearby")
        WHEN type_of_water_source = 'tap_in_home_broken' THEN 'inspect'
        ELSE NULL END AS Improvement
FROM
	water_source
LEFT JOIN
	well_pollution ON water_source.source_id = well_pollution.source_id
INNER JOIN
	visits ON water_source.source_id = visits.source_id
INNER JOIN
	location ON location.location_id = visits.location_id
where  visit_count = 1 
and (
		(type_of_water_source = 'shared_tap' and time_in_queue >= 30) 
    OR results != 'clean'     
    OR type_of_water_source IN('river','tap_in_home_broken')
    );
    
select * from project_progress;

select 
	town,
	source_type,
		improvement
from 
	project_progress
		where source_type = 'shared_tap' and Improvement = '%CONCAT("Install ", CONCAT(time_in_queue/30), " taps nearby"';
select 
		distinct province,
				town,
		source_type,
		improvement
        from project_progress
			where Improvement LIKE '%Install _ taps nearby%'
				order by province, town;
			

DROP TABLE IF EXISTS well_pollution;
CREATE TABLE well_pollution (
  source_id varchar(258) DEFAULT NULL,
  date datetime DEFAULT NULL,
  description varchar(255) DEFAULT NULL,
  pollutant_ppm float DEFAULT NULL,
  biological float DEFAULT NULL,
  results varchar(255) DEFAULT NULL,
  KEY source_id (source_id),
  CONSTRAINT well_pollution_ibfk_1 FOREIGN KEY (source_id) REFERENCES water_source (source_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

select * from project_progress where Improvement LIKE "%UV filter";

SELECT
project_progress.Project_id, 
project_progress.Town, 
project_progress.Province, 
project_progress.Source_type, 
project_progress.Improvement,
Water_source.number_of_people_served,
RANK() OVER(PARTITION BY Province ORDER BY number_of_people_served)
FROM  project_progress 
JOIN water_source 
ON water_source.source_id = project_progress.source_id
WHERE Improvement = "Drill Well"
ORDER BY Province DESC, number_of_people_served