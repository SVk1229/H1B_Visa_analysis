create table visa(id String, cstatus string, emp_name string, s_name string, job string, type_job string, sal double,year int, worksite string,longi double, lati double)
ROW FORMAT SERDE 'org.apache.hadoop.hive.serde2.OpenCSVSerde'
WITH SERDEPROPERTIES (
"separatorChar" = ",",
"quoteChar" = "\""
) STORED AS TEXTFILE
tblproperties("skip.header.line.count=1");

--Is the number of petitions with Data Engineer job title increasing over time?

select year, count(year) as cnt, RANK() over ( order  by count(year))  as rank from visa where job LIKE '%DATA ENGINEER%' group by year;

--Which part of the US has the most Data Engineer jobs?

select split(worksite, '[,]')[1] as state, count(split(worksite, '[,]')[1]) as cnt from visa where job like '%DATA ENGINEER%' group by split(worksite, '[,]')[1] order by cnt;

--Which industry has the most number of Data Scientist positions?

select emp_name, count(emp_name) as cnt from visa where job like '%DATA SCIENTIST%' group by emp_name order by cnt;
