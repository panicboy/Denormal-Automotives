\c andrew;

\echo Modeling a Normalized Schema 1.
DROP ROLE IF EXISTS normal_user;
CREATE ROLE normal_user;

\echo Modeling a Normalized Schema 2.
DROP DATABASE IF EXISTS normal_cars;
CREATE DATABASE normal_cars;
ALTER DATABASE normal_cars OWNER TO normal_user;
\c normal_cars;


\echo Modeling a Normalized Schema 5.
\i scripts/denormal_data.sql;

DROP TABLE IF EXISTS car_make;
CREATE TABLE IF NOT EXISTS car_make
(
  make_id SERIAL PRIMARY KEY NOT NULL,
  make_code VARCHAR(125) NOT NULL,
  make_title VARCHAR(125) NOT NULL
);

DROP TABLE IF EXISTS car_model;
CREATE TABLE IF NOT EXISTS car_model
(
  model_id SERIAL PRIMARY KEY NOT NULL,
  make_id INTEGER REFERENCES car_make(make_id),
  model_code VARCHAR(125) NOT NULL,
  model_title VARCHAR(125) NOT NULL,
  model_year INTEGER NOT NULL
);

\echo Modeling a Normalized Schema 6.

INSERT INTO car_make (make_code, make_title)
  SELECT DISTINCT make_code, make_title
     FROM car_models
     ORDER BY make_code;

INSERT INTO car_model ( make_id, model_code, model_title, model_year)
  SELECT DISTINCT car_make.make_id,
                  car_models.model_code,
                  car_models.model_title,
                  car_models.year
    FROM car_models, car_make
    WHERE (car_make.make_code = car_models.make_code
      AND car_make.make_title = car_models.make_title);

DROP TABLE IF EXISTS car_models;


\echo Modeling a Normalized Schema 7.
SELECT make_title
  FROM car_make
    ORDER BY make_title;

\echo Modeling a Normalized Schema 8.
SELECT DISTINCT model_title
  FROM car_model
  INNER JOIN car_make
    ON car_model.make_id = car_make.make_id
    AND car_make.make_code = 'VOLKS'
    ORDER BY model_title;
-- --   \d+ car_model;

\echo Modeling a Normalized Schema 9.
SELECT DISTINCT make_code, model_code, model_title, model_year
  FROM car_model
  INNER JOIN car_make
    ON car_model.make_id = car_make.make_id
    AND car_make.make_code = 'LAM'
    ORDER BY model_title;

\echo Modeling a Normalized Schema 10.
SELECT DISTINCT make_code, make_title, model_code, model_title, model_year
  FROM car_model
  INNER JOIN car_make
    ON car_model.make_id = car_make.make_id
    WHERE model_year BETWEEN 2010 AND 2015
    ORDER BY make_code, model_code, model_year;



\c andrew;