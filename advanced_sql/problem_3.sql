SELECT job_title_short,
job_title,
job_location,
job_via,
job_posted_date::DATE , 
salary_year_avg


FROM (
SELECT *
FROM january_job
UNION ALL
SELECT *
FROM february_job
UNION ALL
SELECT *
FROM march_job
) AS quarter1_job_postings 
WHERE 
salary_year_avg > 70000 AND job_title_short IN ('Data Scientist', 'Data Analyst')
ORDER BY salary_year_avg DESC;