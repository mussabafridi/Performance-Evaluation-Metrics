select *
from interns_list;
select *
from intern_tasks;

select *
from mentor_feedback;


SELECT 
    interns_list.name,
    COUNT(intern_tasks.task_id) AS total_tasks,
    ROUND(AVG(DATEDIFF(intern_tasks.completion_date, intern_tasks.assigned_date)), 1) AS avg_completion_days,
    ROUND(AVG(intern_tasks.quality_score), 1) AS avg_quality,
    mentor_feedback.mentor_rating
FROM interns_list
JOIN intern_tasks ON interns_list.intern_id = intern_tasks.intern_id
JOIN mentor_feedback ON interns_list.intern_id = mentor_feedback.intern_id
GROUP BY interns_list.intern_id, interns_list.name, mentor_feedback.mentor_rating;

select intern_id,
round(avg(datediff(completion_date , assigned_date)),2)
as avg_completion_days
from intern_tasks
group by intern_id;

select intern_id,
round(avg(quality_score),2)
as avg_score
from intern_tasks
group by intern_id;

SELECT
    intern_id,
    mentor_rating,
    soft_skills_score
FROM mentor_feedback;

SELECT
    i.intern_id,
    i.name,
    i.department,

    ROUND(AVG(DATEDIFF(t.completion_date, t.assigned_date)), 2)
        AS avg_completion_days,

    ROUND(AVG(t.quality_score), 2)
        AS avg_quality_score,

    f.mentor_rating,
    f.soft_skills_score

FROM interns_list i
LEFT JOIN intern_tasks t
    ON i.intern_id = t.intern_id
LEFT JOIN mentor_feedback f
    ON i.intern_id = f.intern_id

GROUP BY
    i.intern_id,
    i.name,
    i.department,
    f.mentor_rating,
    f.soft_skills_score;
SELECT
    i.name,
    YEAR(t.completion_date) AS year,
    MONTH(t.completion_date) AS month,

    ROUND(AVG(DATEDIFF(t.completion_date, t.assigned_date)), 2)
        AS avg_completion_days,

    ROUND(AVG(t.quality_score), 2)
        AS avg_quality_score

FROM interns_list i
JOIN intern_tasks t
    ON i.intern_id = t.intern_id

GROUP BY
    i.name,
    YEAR(t.completion_date),
    MONTH(t.completion_date)

ORDER BY year, month, i.name;


SELECT
    i.name,

    ROUND(
        (AVG(t.quality_score) * 0.4) +
        (f.mentor_rating * 0.4) +
        (10 - AVG(DATEDIFF(t.completion_date, t.assigned_date))) * 0.2
    , 2) AS overall_performance_score

FROM interns_list i
JOIN intern_tasks t ON i.intern_id = t.intern_id
JOIN mentor_feedback f ON i.intern_id = f.intern_id

GROUP BY
    i.name,
    f.mentor_rating

ORDER BY overall_performance_score DESC;

CREATE VIEW intern_performance_view AS
SELECT
    i.intern_id,
    i.name,
    i.department,
    COUNT(t.task_id) AS total_tasks,
    ROUND(AVG(DATEDIFF(t.completion_date, t.assigned_date)), 1) AS avg_completion_days,
    ROUND(AVG(t.quality_score), 1) AS avg_quality,
    f.mentor_rating,
    f.soft_skills_score
FROM interns_list i
LEFT JOIN intern_tasks t ON i.intern_id = t.intern_id
LEFT JOIN mentor_feedback f ON i.intern_id = f.intern_id
GROUP BY
    i.intern_id,
    i.name,
    i.department,
    f.mentor_rating,
    f.soft_skills_score;

