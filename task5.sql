SELECT v.vacancy_id, v.vacancy_title, COUNT(*) as count_response
FROM vacancy v
JOIN response resp ON v.vacancy_id = resp.vacancy_id
WHERE (resp.created_at - v.created_at) <= INTERVAL '7 days'
GROUP BY v.vacancy_id
HAVING COUNT(*)>5
ORDER BY count_response DESC