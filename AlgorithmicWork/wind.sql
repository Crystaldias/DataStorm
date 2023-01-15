select state, station, count(observation) as number_of_observations, observation from datastorm.observations where observation in ('TMAX','TMIN', 'WT03', 'WSFG', 'WT11', 'WT12', 'WT10', 'DATX', 'MDTX', 'DATN', 'MDTN', 'WDFI', 'WDFG', 'WSFG') group by station, observation, state order by number_of_observations desc;

-- TMAX
-- count of tmax
select state, station, count(observation) as number_of_observations, observation from datastorm.observations where observation = 'TMAX' group by station, observation, state order by number_of_observations desc;
-- stats for tmax
select state, max(value)/10 as max_tmax, avg(value)/10 as avg_tmax, min(value)/10 as min_tmax from datastorm.observations where observation = 'TMAX' group by state, observation order by avg_tmax desc;

-- TMIN
-- stats for tmin
select state, max(value)/10 as max_tmin, avg(value)/10 as avg_tmin, min(value)/10 as min_tmin from datastorm.observations where observation = 'TMIN' group by state, observation order by avg_tmin desc;

-- TAVG
-- stats for tavg
select state, max(value)/10 as max_tavg, avg(value)/10 as avg_tavg, min(value)/10 as min_tavg from datastorm.observations where observation = 'TAVG' group by state, observation order by avg_tavg desc;


-- WT03
-- stats for wt03
select state, max(value) as max_wt03, avg(value) as avg_wt03, min(value) as min_wt03 from datastorm.observations where observation = 'WT03' group by state, observation order by avg_wt03 desc;
-- doesn't make any sense. returns 1 for min and max. only 3 states

-- number of WT03 per year per state (sorted by state and count)
select state, count(observation) as count_wt03, date_format(date_parse(date,'%Y%m%d'), '%Y') as year from datastorm.observations where observation = 'WT03' group by state, observation, date_format(date_parse(date,'%Y%m%d'), '%Y') order by year, state, count_wt03 desc
-- problem: 1945-1970 collected for NL, 1949 for NU (1) and 1949 for QC (11)

-- WSFG
-- stats for WSFG
select state, max(value) as max_wsfg, avg(value) as avg_wsfg, min(value) as min_wsfg from datastorm.observations where observation = 'WSFG' group by state, observation order by avg_wsfg desc
-- meters per second, always positive (0 is the min)

-- stats for WSFG after 2000
select state, max(value) as max_wsfg, avg(value) as avg_wsfg, min(value) as min_wsfg, min(date) as min_date from datastorm.observations where observation = 'WSFG' and date_parse(date,'%Y%m%d') > CAST('2000-01-01' AS DATE) group by state, observation order by avg_wsfg desc
-- returns for the min date only values for 2015?? wtf

-- number of WSFG per year per state (sorted by state and count)
select state, count(observation) as count_wsfg, date_format(date_parse(date,'%Y%m%d'), '%Y') as year from datastorm.observations where observation = 'WSFG' group by state, observation, date_format(date_parse(date,'%Y%m%d'), '%Y') order by state, count_wsfg desc, year
-- the most values come from 2016 and 2017 (one exception: PE: 2016, 2020, 2017). Collection seems to have started in 2015. Exception: NL (1950-1970)

-- combine elements of interest
SELECT
    t1.station as station,
    t1.date as date,
    t1.observation as wsfg,
    t1.value as wsfg_val,
    t2.observation as tmax,
    t2.value as tmax_val,
    t3.observation as tmin,
    t3.value as tmin_val,
    t4.observation as tavg,
    t4.value as tavg_val
FROM datastorm.observations t1
    LEFT JOIN datastorm.observations t2 ON t1.station = t2.station AND t1.date = t2.date
    LEFT JOIN datastorm.observations t3 ON t1.station = t3.station AND t1.date = t3.date
    LEFT JOIN datastorm.observations t4 ON t1.station = t4.station AND t1.date = t4.date
    WHERE t2.observation = 'TMAX' AND t1.observation = 'WSFG' AND t3.observation = 'TMIN' AND t3.observation = 'TAVG'


-- alternative
SELECT
    t1.station as station,
    t1.date as date,
    t1.value as wsfg_val,
    t2.value/10 as tmax_val,
    t3.value/10 as tmin_val,
    t4.value/10 as tavg_val
FROM datastorm.observations t1
    INNER JOIN datastorm.observations t2 ON t1.station = t2.station AND t1.date = t2.date AND t2.observation = 'TMAX'
    INNER JOIN datastorm.observations t3 ON t1.station = t3.station AND t1.date = t3.date AND t1.observation = 'WSFG' AND t3.observation = 'TMIN'
    INNER JOIN datastorm.observations t4 ON t1.station = t4.station AND t1.date = t4.date AND t4.observation = 'TAVG'


-- with casting since 2015
SELECT
    t1.station as station,
    t1.date as date,
    t1.elevation,
    t1.longitude,
    t1.latitude,
    t1.state,
    cast(t1.value AS DOUBLE) as wsfg,
    (cast(t2.value AS DOUBLE)/10) as tmax,
    (cast(t3.value AS DOUBLE)/10) as tmin,
    (cast(t4.value AS DOUBLE)/10) as tavg
FROM datastorm.observations t1
    INNER JOIN datastorm.observations t2 ON t1.station = t2.station AND t1.date = t2.date AND t2.observation = 'TMAX'
    INNER JOIN datastorm.observations t3 ON t1.station = t3.station AND t1.date = t3.date AND t1.observation = 'WSFG' AND t3.observation = 'TMIN'
    INNER JOIN datastorm.observations t4 ON t1.station = t4.station AND t1.date = t4.date AND t4.observation = 'TAVG'
WHERE date_parse(t1.date,'%Y%m%d') > CAST('2015-01-01' AS DATE)


-- All observations of interest
-- grouped by YYYYMM, state
SELECT
    t1.state,
    date_format(date_parse(t1.date,'%Y%m%d'), '%Y%m') as date,
    avg(cast(t1.value AS DOUBLE)) as wsfg,
    avg(cast(t2.value AS DOUBLE)/10) as tmax,
    avg(cast(t3.value AS DOUBLE)/10) as tmin,
    avg(cast(t4.value AS DOUBLE)/10) as tavg
FROM datastorm.observations t1
    INNER JOIN datastorm.observations t2 ON t1.station = t2.station AND t1.date = t2.date AND t2.observation = 'TMAX'
    INNER JOIN datastorm.observations t3 ON t1.station = t3.station AND t1.date = t3.date AND t1.observation = 'WSFG' AND t3.observation = 'TMIN'
    INNER JOIN datastorm.observations t4 ON t1.station = t4.station AND t1.date = t4.date AND t4.observation = 'TAVG'
GROUP BY t1.state, date_format(date_parse(t1.date,'%Y%m%d'), '%Y%m')

-- grouped by YYYYMM, station and state
SELECT
    t1.station,
    t1.state,
    t1.latitude,
    t1.longitude,
    date_format(date_parse(t1.date,'%Y%m%d'), '%Y%m') as date,
    avg(cast(t1.value AS DOUBLE)) as wsfg,
    avg(cast(t2.value AS DOUBLE)/10) as tmax,
    avg(cast(t3.value AS DOUBLE)/10) as tmin,
    avg(cast(t4.value AS DOUBLE)/10) as tavg
FROM datastorm.observations t1
    INNER JOIN datastorm.observations t2 ON t1.station = t2.station AND t1.date = t2.date AND t2.observation = 'TMAX'
    INNER JOIN datastorm.observations t3 ON t1.station = t3.station AND t1.date = t3.date AND t1.observation = 'WSFG' AND t3.observation = 'TMIN'
    INNER JOIN datastorm.observations t4 ON t1.station = t4.station AND t1.date = t4.date AND t4.observation = 'TAVG'
GROUP BY t1.station, date_format(date_parse(t1.date,'%Y%m%d'), '%Y%m'), t1.state, t1.latitude, t1.longitude


-- SQL query for the geo heatmap
SELECT
    t1.station,
    t1.state,
    t1.latitude,
    t1.longitude,
    t1.observation,
    avg(value) as avg_value,
    date_format(date_parse(t1.date,'%Y%m%d'), '%Y%m') as date
FROM datastorm.observations t1
WHERE observation in ('WSFG', 'TMAX', 'TMIN', 'TAVG')
GROUP BY t1.station, date_format(date_parse(t1.date,'%Y%m%d'), '%Y%m'), t1.state, t1.latitude, t1.longitude, t1.observation



