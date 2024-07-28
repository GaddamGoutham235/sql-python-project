SELECT * FROM project.laptop;
USE project;

CREATE TABLE laptop_backup LIKE laptop;

INSERT INTO laptop_backup 
SELECT * FROM laptop;

SELECT DATA_LENGTH/1024 FROM information_schema.TABLES WHERE TABLE_SCHEMA='project' AND TABLE_NAME='laptop';

SELECT * FROM laptop;

ALTER TABLE laptop RENAME COLUMN `Unnamed: 0` TO `index`;

SELECT * FROM laptop
WHERE Company IS NULL AND TypeName IS NULL AND Inches IS NULL
AND ScreenResolution IS NULL AND Cpu IS NULL AND Ram IS NULL
AND Memory IS NULL AND Gpu IS NULL AND OpSys IS NULL AND
WEIGHT IS NULL AND Price IS NULL;

ALTER TABLE laptop MODIFY COLUMN Inches DECIMAL(10,1);

UPDATE laptop SET Ram = (REPLACE(Ram,'GB',''));

ALTER TABLE laptop MODIFY COLUMN Ram INTEGER;

SELECT * FROM laptop;

UPDATE laptop SET Weight = REPLACE(Weight,'kg','');

UPDATE laptop SET Price = ROUND(Price);

ALTER TABLE laptop MODIFY COLUMN Price INTEGER;

SELECT OpSys,
CASE 
	WHEN OpSys LIKE '%mac%' THEN 'macos'
    WHEN OpSys LIKE 'windows%' THEN 'windows'
    WHEN OpSys LIKE '%linux%' THEN 'linux'
    WHEN OpSys='No OS' THEN 'N/A'
    ELSE 'other'
END AS 'os_brand'
FROM laptop;

UPDATE laptop SET OpSys= CASE 
	WHEN OpSys LIKE '%mac%' THEN 'macos'
    WHEN OpSys LIKE 'windows%' THEN 'windows'
    WHEN OpSys LIKE '%linux%' THEN 'linux'
    WHEN OpSys='No OS' THEN 'N/A'
    ELSE 'other'
END;

SELECT * FROM laptop;

ALTER TABLE laptop 
ADD COLUMN gpu_brand VARCHAR(255) AFTER Gpu,
ADD COLUMN gpu_name VARCHAR(255) AFTER gpu_brand;

SELECT SUBSTRING_INDEX(Gpu,' ',1) FROM laptop;

UPDATE laptop SET gpu_brand = SUBSTRING_INDEX(Gpu,' ',1);

SELECT REPLACE(Gpu,gpu_brand," ") FROM laptop;

UPDATE laptop SET gpu_name = REPLACE(Gpu,gpu_brand," ");

SELECT * FROM laptop;


SELECT gpu_name,TRIM(gpu_name) FROM laptop;

UPDATE laptop SET gpu_name = TRIM(gpu_name);

ALTER TABLE laptop DROP COLUMN Gpu;

ALTER TABLE laptop ADD COLUMN cpu_brand VARCHAR(255) AFTER Cpu,
ADD COLUMN cpu_name VARCHAR(255) AFTER cpu_brand,
ADD COLUMN cpu_speed DECIMAL(10,1) AFTER cpu_name;

SELECT SUBSTRING_INDEX(Cpu,' ',1) FROM laptop;

UPDATE laptop SET cpu_brand = SUBSTRING_INDEX(Cpu,' ',1);

SELECT REPLACE(SUBSTRING_INDEX(Cpu," ",-1),'GHz',' ') FROM laptop;

UPDATE laptop SET cpu_speed= CAST(REPLACE(SUBSTRING_INDEX(Cpu," ",-1),'GHz','') AS DECIMAL(10,2));


ALTER TABLE laptop DROP COLUMN cpu_speed;

SELECT * FROM laptop;

SELECT Cpu,REPLACE(REPLACE(Cpu,cpu_brand,''),SUBSTRING_INDEX(Cpu,' ',-1),'') FROM laptop;

UPDATE laptop SET cpu_name= REPLACE(REPLACE(Cpu,cpu_brand,''),SUBSTRING_INDEX(Cpu,' ',-1),'');

ALTER TABLE laptop DROP COLUMN Cpu;

SELECT ScreenResolution,
SUBSTRING_INDEX(SUBSTRING_INDEX(ScreenResolution,' ',-1),'x',1),
SUBSTRING_INDEX(SUBSTRING_INDEX(ScreenResolution,' ',-1),'x',-1)
FROM laptop;

ALTER TABLE laptop 
ADD COLUMN resolution_width INTEGER AFTER ScreenResolution,
ADD COLUMN resolution_height INTEGER AFTER resolution_width;


UPDATE laptop
SET resolution_width = SUBSTRING_INDEX(SUBSTRING_INDEX(ScreenResolution,' ',-1),'x',1),
resolution_height = SUBSTRING_INDEX(SUBSTRING_INDEX(ScreenResolution,' ',-1),'x',-1);


ALTER TABLE laptop 
ADD COLUMN touchscreen INTEGER AFTER resolution_height;

SELECT ScreenResolution LIKE '%Touch%' FROM laptop; 

UPDATE laptop SET touchscreen = ScreenResolution LIKE '%Touch%';

ALTER TABLE laptop DROP COLUMN ScreenResolution;

SELECT cpu_name,SUBSTRING_INDEX(TRIM(cpu_name),' ',2) FROM laptop;

UPDATE laptop SET cpu_name = SUBSTRING_INDEX(TRIM(cpu_name)," ",2);

ALTER TABLE laptop 
ADD COLUMN primary_storage INTEGER AFTER memory_type,
ADD COLUMN secondary_storage INTEGER AFTER primary_storage;

ALTER TABLE laptop DROP COLUMN primary_storage, DROP COLUMN secondary_storage;
SELECT * FROM laptop;

UPDATE laptop SET memory_type =
CASE 
	 WHEN Memory LIKE '%SSD%' AND Memory LIKE '%HDD%' THEN 'Hybrid'
  	 WHEN Memory LIKE '%SSD' THEN 'SSD'
   	 WHEN Memory LIKE '%HDD%' THEN 'HDD' 
	 WHEN Memory LIKE '%Flash Storage%' THEN 'Flash Storage' 
   	 WHEN Memory LIKE '%Hybrid%' THEN 'Hybrid'
	 WHEN Memory LIKE '%Flash Storage%' AND Memory LIKE '%HDD%' THEN 'Hybrid'
    ELSE NULL
END;

  


SELECT Memory,REGEXP_SUBSTR(SUBSTRING_INDEX(Memory,'+',1),'[0-9]+'),
CASE WHEN Memory LIKE '%+%' THEN REGEXP_SUBSTR(SUBSTRING_INDEX(Memory,'+',-1),'[0-9]+') ELSE 0 END
FROM laptop;

UPDATE laptop SET  primary_storage = REGEXP_SUBSTR(SUBSTRING_INDEX(Memory,'+',1),'[0-9]+'),
secondary_storage = CASE WHEN Memory LIKE '%+%' THEN REGEXP_SUBSTR(SUBSTRING_INDEX(Memory,'+',-1),'[0-9]+') ELSE 0 END;

SELECT primary_storage,
CASE WHEN primary_storage<=2 THEN primary_storage*1024 ELSE primary_storage END,
secondary_storage,
CASE 
WHEN secondary_storage<=2 THEN secondary_storage*1024 ELSE secondary_storage
END 
FROM laptop;

UPDATE laptop 
SET primary_storage = CASE WHEN primary_storage<=2 THEN primary_storage*1024 ELSE primary_storage END,
secondary_storage = CASE WHEN secondary_storage<=2 THEN secondary_storage*1024 ELSE secondary_storage END;


SELECT * FROM laptop;

ALTER TABLE laptop DROP COLUMN Memory;

 

SELECT * FROM laptop ORDER BY `index` LIMIT 5;
SELECT * FROM laptop ORDER BY `index` DESC LIMIT 5;
SELECT * FROM laptop ORDER BY rand() LIMIT 5;

SELECT COUNT(price),MIN(price),MAX(price),AVG(price),STD(price)
FROM laptop;

SELECT Company,COUNT(Company) FROM laptop GROUP BY Company;

SELECT cpu_speed,Price FROM laptop;

SELECT Company, SUM(CASE WHEN Touchscreen = 1 THEN 1 ELSE 0 END) AS 'Touchscreen_yes', 
SUM(CASE WHEN Touchscreen=0 THEN 1 ELSE 0 END) AS 'Touchscreen_no' FROM laptop
GROUP BY Company;

SELECT Company,
SUM(CASE WHEN cpu_brand = 'Intel' THEN 1 ELSE 0 END) AS 'intel',
SUM(CASE WHEN cpu_brand = 'AMD' THEN 1 ELSE 0 END) AS 'amd',
SUM(CASE WHEN cpu_brand = 'Samsung' THEN 1 ELSE 0 END) AS 'samsung'
FROM laptop
GROUP BY Company;

SELECT Company,MIN(Price),MAX(price),AVG(price),STD(price) 
FROM laptop GROUP BY Company;

SELECT * FROM laptop WHERE price IS NULL;






