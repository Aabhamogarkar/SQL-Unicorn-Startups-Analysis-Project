CREATE DATABASE if not exists unicorns_db;
USE unicorns_db;

DROP TABLE IF EXISTS unicorns_startups;

CREATE TABLE unicorns_startups (
    `startup_name` VARCHAR(255),
    `industry` VARCHAR(255),
    `founding_year` INT,
    `unicorn_entry_year` INT,
    `profit_loss_fy22` VARCHAR(100),
    `current_valuation` VARCHAR(100),
    `acquisitions` INT,
    `status` VARCHAR(100)
);
select * from unicorns_startups;

SHOW VARIABLES LIKE 'SECURE_FILE_PRIV'; 

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/Unicorn Startups.csv'
INTO TABLE unicorns_startups
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(@startup_name, @industry, @founding_year, @unicorn_entry_year,
 @profit_loss_fy22, @current_valuation, @acquisitions, @status)
SET
    startup_name        = @startup_name,
    industry            = @industry,
    founding_year       = NULLIF(@founding_year, 'NA'),
    unicorn_entry_year  = NULLIF(@unicorn_entry_year, 'NA'),
    profit_loss_fy22    = @profit_loss_fy22,
    current_valuation   = @current_valuation,
    acquisitions        = NULLIF(@acquisitions, 'NA'),
    status              = @status;
    
    SELECT COUNT(*) FROM unicorns_startups;
SELECT * FROM unicorns_startups LIMIT 10;


# QUESTIONS BASIS ON THIS
 
 /* Q1. DISPLAY ALL THE RECORDS */
 SELECT * FROM unicorns_startups;
 
 /* Q2. SHOW STARTUP NAME, INDUSRTY AND CURRENT_EVALUATION */
 SELECT startup_name, industry, current_valuation
FROM unicorns_startups;

/* Q3. LIST ALL WITH STATUS ACTIVE */
SELECT startup_name, status 
FROM unicorns_startups 
LIMIT 20;

/* Q4. List all active (private) startups */
SELECT *
FROM unicorns_startups
WHERE LOWER(TRIM(status)) = 'private';

/*Q5. FIND THE STARTUP FOUNDED AFTER 2015 */
SELECT startup_name, founding_year
FROM unicorns_startups
WHERE founding_year > 2015;

/* Q6. Show startups from Fintech industry */
SELECT *
FROM unicorns_startups
WHERE industry = 'Fintech';

/*Q7. Show startups ordered by founding year */
SELECT startup_name, founding_year
FROM unicorns_startups
ORDER BY founding_year;

/* Q8.Show first 10 startups using LIMIT */
SELECT *
FROM unicorns_startups
LIMIT 10;

/*Q9. Startups starting with letter “A” */
SELECT startup_name
FROM unicorns_startups
WHERE startup_name LIKE 'A%';

/* Q10.Startups containing "tech" */
SELECT startup_name
FROM unicorns_startups
WHERE startup_name LIKE '%tech%';

/* Q10. Startups with no acquisitions */
SELECT startup_name
FROM unicorns_startups
WHERE acquisitions IS NULL;

/* Q11. Replace NULL acquisitions with 0 */
SELECT startup_name,
IFNULL(acquisitions,0) AS acquisitions
FROM unicorns_startups;

/* Q12. Total number of startups */
SELECT COUNT(*) AS TOTALROWS
FROM unicorns_startups;