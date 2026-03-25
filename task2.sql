-- area
INSERT INTO area (area_name)
VALUES
    ('Москва'),
    ('Санкт-Петербург'),
    ('Новосибирск'),
    ('Екатеринбург'),
    ('Казань'),
    ('Иркутск'),
    ('Зима'),
    ('Бирск'),
    ('Рыбинск');

-- employer
INSERT INTO employer (employer_name)
VALUES
    ('Яндекс'),
    ('Сбербанк'),
    ('Газпром'),
    ('VK'),
    ('Тинькофф'),
    ('Ozon'),
    ('Wildberries'),
    ('1С'),
    ('Лаборатория Касперского'),
    ('Mail.ru Group'),
    ('МТС'),
    ('Билайн'),
    ('МегаФон'),
    ('Альфа-Банк');

-- profession
INSERT INTO profession (profession_name)
VALUES
    ('Официант'),
    ('Бариста'),
    ('Уборщик'),
    ('Охранник'),
    ('Электрик'),
    ('Сварщик'),
    ('Инженер'),
    ('Врач'),
    ('Медсестра');

-- vacancy
WITH test_data(
               id,
               title,
               employer_id,
               description,
               created_at,
               salary,
               area_id,
               profession_id
    )
        AS (
        SELECT
            generate_series(1, 10000) as id,
            md5(random()::text) as title,
            floor((random() * 14) + 1)::int as employer_id,
            md5(random()::text) as description,
            '2023-01-01 00:00:00'::timestamp + random() * (now() - '2023-01-01 00:00:00') as created_at,
            round((random() * 100000)::int, -3)::int as salary,
            floor((random() * 9) + 1)::int as area_id,
            floor((random() * 9) + 1)::int as profession_id
    )
INSERT INTO vacancy (
    vacancy_title,
    employer_id,
    description,
    created_at,
    compensation_from,
    compensation_to,
    area_id,
    profession_id
)
SELECT
    test_data.title as vacancy_title,
    test_data.employer_id as employer_id,
    test_data.description as description,
    test_data.created_at as created_at,
    test_data.salary as compensation_from,
    test_data.salary + 25000 as compensation_to,
    test_data.area_id as area_id,
    test_data.profession_id as profession_id
FROM test_data

-- employee
WITH test_data(
           id,
           first_name,
           second_name,
           middle_name,
           area_id
)
    AS (
    SELECT
        generate_series(1, 1000000) as id,
        md5(random()::text) as first_name,
        md5(random()::text) as second_name,
        md5(random()::text) as middle_name,
        floor((random() * 9) + 1)::int as area_id
)
INSERT INTO employee (
    first_name,
    second_name,
    middle_name,
    area_id
)
SELECT
    test_data.first_name,
    test_data.second_name,
    test_data.middle_name ,
    test_data.area_id
FROM test_data

-- resume
WITH test_data(
        id,
        employee_id,
        resume_title,
        compensations,
        profession_id,
        created_at
)
    AS (
    SELECT
        generate_series(1, 100000) as id,
        floor((random() * 14) + 1)::int as employer_id,
        md5(random()::text) as resume_title,
        round((random() * 100000)::int, -3)::int as salary,
        floor((random() * 9) + 1)::int as profession_id,
        '2023-01-01 00:00:00'::timestamp + random() * (now() - '2023-01-01 00:00:00') as created_at

)
INSERT INTO resume (
    employee_id,
    resume_title,
    compensations,
    profession_id,
    created_at
)
SELECT
    test_data.employee_id,
    test_data.resume_title,
    test_data.compensations ,
    test_data.profession_id,
    test_data.created_at
FROM test_data

-- response
    INSERT INTO response (
    vacancy_id,
    resume_id,
    cover_letter,
    created_at
)
SELECT v.vacancy_id,
       r.resume_id,
       md5(random()::text),
       GREATEST(v.created_at, r.created_at) + (random() * interval '60 days')
FROM vacancy v
JOIN resume r ON v.profession_id=r.profession_id
JOIN employee e ON e.employee_id=r.employee_id
WHERE random()< 0.15
AND v.area_id = e.area_id
