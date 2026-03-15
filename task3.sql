SELECT a.area_id, a.area_name,
       AVG(compensation_from) as avg_compensation_from,
       AVG(compensation_to) as avg_compensation_to,
       AVG(
               CASE
                   WHEN compensation_from IS NOT NULL AND compensation_to IS NOT NULL
                       THEN (compensation_from + compensation_to) / 2.0
                   WHEN compensation_from IS NOT NULL
                       THEN  compensation_to
                   WHEN compensation_from IS NOT NULL
                       THEN  compensation_to
                   ELSE 0
                   END
       ) as avg_compensation_from_to
FROM vacancy v
JOIN area a ON a.area_id = v.area_id
GROUP BY a.area_id
ORDER BY avg_compensation_from_to