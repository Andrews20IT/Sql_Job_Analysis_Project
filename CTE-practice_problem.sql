
/*Practice Problem 1
Question:
Identify the top 5 skills that are most frequently mentioned in job postings. 
Use a subquery to find the skill IDs with the highest counts in the skills_job_dim table and
 then join this result with the skills_dim table to get the skill names.
*/

WITH skill_count_id_set AS(
    SELECT 
        skill_id,
        count(*) AS skill_count_needed
    FROM
        skills_job_dim
    GROUP BY
        skill_id
)

SELECT
    skills,
    skill_count_needed
FROM
    skills_dim
INNER JOIN skill_count_id_set ON
    skill_count_id_set.skill_id = skills_dim.skill_id
ORDER BY
    skill_count_needed DESC
LIMIT 5


WITH no_of_job_set AS(
    SELECT
        company_id,
        COUNT(*) as job_postings
    FROM
        job_postings_fact
    GROUP BY
        company_id
)

SELECT
    company_dim.name,
    no_of_job_set.job_postings,
    CASE
        WHEN no_of_job_set.job_postings > 50 THEN 'Large'
        WHEN no_of_job_set.job_postings BETWEEN 10 AND 50 THEN 'Medium'
        ELSE 'Small'
    END AS size_category
FROM
    company_dim
LEFT JOIN
    no_of_job_set
ON
    no_of_job_set.company_id = company_dim.company_id
