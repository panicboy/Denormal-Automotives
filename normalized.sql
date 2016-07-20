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
DROP TABLE IF EXISTS car_models;

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



-- --   \d+ car_model;

SELECT schemaname,relname,n_live_tup
  FROM pg_stat_user_tables
  ORDER BY n_live_tup DESC;




\c andrew;