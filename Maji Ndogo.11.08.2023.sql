SELECT
	* FROM employee;
SHOW tables;
SELECT
	* FROM location
    LIMIT 5;
SELECT 
	* FROM visits
    LIMIT 5;
SELECT 
* FROM water_source
LIMIT 6;
SELECT DISTINCT
	type_of_water_source FROM water_source;
SELECT *
	FROM visits
    LIMIT 5;
SELECT * 
	FROM visits
    WHERE time_in_queue > 500;
SELECT DISTINCT source_id 
	FROM visits
    WHERE time_in_queue = 0;
SELECT *
	FROM water_source
    WHERE source_id IN ('SoRu35083224','SoKo33124224','KiRu26095224');
SELECT * 
	FROM water_source
    WHERE source_id IN('KiRu28935224','AkLu01628224','AkRu05234224');
SELECT * 
	FROM water_source
     WHERE source_id IN('AkKi00881224','SoRu37635224','SoRu36096224');
SELECT WS.*,VS.time_in_queue FROM visits AS VS JOIN water_source AS WS 
	WHERE time_in_queue > 500;
SELECT * 
	FROM water_quality
    LIMIT 10;
SELECT WQ.record_id FROM visits AS VS JOIN water_quality AS WQ  ON VS.record_id = WQ.record_id JOIN water_source AS WS ON VS.source_id=WS.source_id
	WHERE WQ.subjective_quality_score = 10 AND WQ.visit_count > 1 AND WS.type_of_water_source IN ('tap_in_home','tap_in_home_broken');
SELECT count(record_id) 
	FROM water_quality
		WHERE subjective_quality_score = 10 AND visit_count > 1;
SELECT count(record_id) 
FROM water_quality AS WQ JOIN visits AS VS  ON WQ.record_id=VS.record_id JOIN water_source AS WS ON VS.source_id=WS.source_id
WHERE subjective_quality_score = 10 AND VS.visit_count > 1 AND type_of_water_source = 'shared_tap';
SELECT * 
	FROM well_pollution
    LIMIT 10;
SELECT count(source_id)
	FROM well_pollution;
SELECT count(source_id)
	FROM water_source WHERE type_of_water_source = 'well';
SELECT type_of_water_source
	FROM water_source WHERE source_id IN (SELECT source_id FROM well_pollution);
SELECT *
	FROM well_pollution WHERE biological > 0.01 AND results = 'clean';
SELECT *
	FROM well_pollution
	WHERE description LIKE 'clean_%' AND biological > 0.01;
SET sql_safe_updates = 0;
UPDATE well_pollution
SET description = CASE 
    WHEN description = 'Clean Bacteria: Giardia Lamblia' THEN 'Bacteria: Giardia Lamblia'
    WHEN description = 'Clean Bacteria: E. coli' THEN 'Bacteria: E. coli'
    ELSE description
END
WHERE description IN ('Clean Bacteria: Giardia Lamblia', 'Clean Bacteria: E. coli');
UPDATE well_pollution 
	SET results = 'Contaminated: Biological'
    WHERE biological > 0.01;
SELECT address 
	FROM employee
    WHERE employee_name = 'Bello Azibo';
SELECT
	* FROM employee
    WHERE position = 'Micro biologist';
SELECT * 
FROM data_dictionary;
SELECT * 
	FROM water_source 
    ORDER BY number_of_people_served DESC
    LIMIT 10 ;
SELECT sum(pop_n)*1000
	FROM global_water_access;
SELECT sum(number_of_people_served)
	FROM water_source;
SELECT count(source_id)
FROM well_pollution
WHERE description LIKE 'Clean_%' OR results = 'Clean' AND biological < 0.01;
SELECT * 
FROM well_pollution
WHERE description
IN ('Parasite: Cryptosporidium', 'biologically contaminated')
OR (results = 'Clean' AND biological > 0.01);
SELECT *
	FROM employee
    WHERE (phone_number LIKE '%86%' OR phone_number LIKE '%11%') AND (employee_name LIKE '% A%' OR employee_name LIKE '% M%') AND position = 'Field Surveyor';

