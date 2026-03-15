-- Получаю месяц в который было создано максимальное количество вакансий за все время существования бд
SELECT TO_CHAR(created_at, 'YYYY-MM') as month, COUNT(*) as count_vacancy
FROM vacancy
GROUP BY TO_CHAR(created_at, 'YYYY-MM')
ORDER BY count_vacancy DESC
LIMIT 1;

-- Получаю месяц в который было создано максимальное количество резюме за все время существования бд
SELECT TO_CHAR(created_at, 'YYYY-MM') as month, COUNT(*) as count_resume
FROM resume
GROUP BY TO_CHAR(created_at, 'YYYY-MM')
ORDER BY count_resume DESC
LIMIT 1;
