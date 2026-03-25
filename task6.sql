-- Нужен чтобы быстро находить всех работников в конкретном регионе (потом можно найти их вакансии)
CREATE INDEX area_id_in_employee_index ON employee (area_id);

-- Нужен чтобы быстро находить все вакансии конкретного работадателя
CREATE INDEX employer_id_in_vacancy_index ON vacancy (employer_id);

-- Нужен чтобы быстро находить все вакансии по конкретной профессии
CREATE INDEX profession_id_in_vacancy_index ON vacancy (profession_id);

-- Нужен чтобы быстро находить все вакансии в конкретном регионе
CREATE INDEX area_id_in_vacancy_index ON vacancy (area_id);

-- Нужен чтобы быстро находить вакансии по дате публикации
CREATE INDEX created_at_in_vacancy_index ON vacancy (created_at);

-- Нужен чтобы быстро находить вакансии по диапазону или по начальной зп
CREATE INDEX compensation_in_vacancy_index ON vacancy (compensation_from, compensation_to);

-- Нужен чтобы быстро находить все резюме конкретного работника
CREATE INDEX employee_id_in_resume_index ON resume (employee_id);

-- Нужен чтобы быстро находить все резюме по конкретной профессии
CREATE INDEX profession_id_in_resume_index ON resume (profession_id);

-- Нужен чтобы быстро находить все отклики по конкретной вакансии
CREATE INDEX vacancy_id_in_response_index ON response (vacancy_id);

-- Нужен чтобы быстро находить все отклики по конкретному резюме
CREATE INDEX resume_id_in_response_index ON response (resume_id);
