WITH skills_demand AS (
    SELECT 
    skills_job_dim.skill_id,
    skills,
    COUNT(job_postings_fact.job_id) AS demand_count
    FROM job_postings_fact
    INNER JOIN skills_job_dim  ON skills_job_dim.job_id = job_postings_fact.job_id
    INNER JOIN skills_dim AS skills ON skills.skill_id = skills_job_dim.skill_id 
    WHERE job_title_short = 'Data Analyst' AND salary_year_avg IS NOT NULL 
    GROUP BY skills_job_dim.skill_id, skills
), 
avrage_salary AS (
    SELECT 
    skills_job_dim.skill_id,
    skills,
    ROUND(AVG(salary_year_avg)) AS avg_salary
    FROM job_postings_fact
    INNER JOIN skills_job_dim ON skills_job_dim.job_id = job_postings_fact.job_id
    INNER JOIN skills_dim AS skills ON skills.skill_id = skills_job_dim.skill_id 
    WHERE job_title_short = 'Data Analyst' AND salary_year_avg IS NOT NULL 
    GROUP BY skills_job_dim.skill_id, skills
)

SELECT 
skills_demand.skill_id, 
skills_demand.skills,
skills_demand.demand_count,
avrage_salary.avg_salary
FROM skills_demand
INNER JOIN avrage_salary ON avrage_salary.skill_id = skills_demand.skill_id
ORDER BY skills_demand.demand_count DESC, avrage_salary.avg_salary DESC