CREATE TABLE area (
                        area_id integer GENERATED ALWAYS AS IDENTITY PRIMARY KEY ,
                        area_name text NOT NULL
);

CREATE TABLE employer (
                        employer_id integer GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
                        employer_name text NOT NULL
);

CREATE TABLE profession (
                        profession_id integer GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
                        profession_name text NOT NULL
);

CREATE TABLE vacancy (
                        vacancy_id integer GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
                        vacancy_title text NOT NULL,
                        employer_id integer NOT NULL,
                        FOREIGN KEY (employer_id) REFERENCES employer (employer_id),
                        description text NOT NULL,
                        created_at TIMESTAMP DEFAULT now(),
                        compensation_from integer,
                        compensation_to integer,
                        area_id integer NOT NULL,
                        FOREIGN KEY (area_id) REFERENCES area (area_id),
                        profession_id integer NOT NULL,
                        FOREIGN KEY (profession_id) REFERENCES profession (profession_id)
);

CREATE TABLE employee (
                        employee_id integer GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
                        first_name text NOT NULL,
                        second_name text NOT NULL,
                        middle_name text,
                        area_id integer NOT NULL ,
                        FOREIGN KEY (area_id) REFERENCES area (area_id)
);

CREATE TABLE resume (
                        resume_id integer GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
                        employee_id integer NOT NULL,
                        resume_title text NOT NULL,
                        compensations integer,
                        profession_id integer NOT NULL,
                        FOREIGN KEY (profession_id) REFERENCES profession(profession_id),
                        created_at TIMESTAMP DEFAULT now()
);

CREATE TABLE response (
                        response_id integer GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
                        vacancy_id integer NOT NULL,
                        FOREIGN KEY (vacancy_id) REFERENCES vacancy (vacancy_id),
                        resume_id integer NOT NULL,
                        FOREIGN KEY (resume_id) REFERENCES resume (resume_id),
                        cover_letter text,
                        created_at TIMESTAMP DEFAULT now(),
                        UNIQUE (vacancy_id, resume_id)
);