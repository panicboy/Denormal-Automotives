\echo Denormal Cars 1.
DROP ROLE IF EXISTS denormal_user;
CREATE ROLE denormal_user;

\echo Denormal Cars 2.
DROP DATABASE IF EXISTS denormal_cars;
CREATE DATABASE denormal_cars;
ALTER DATABASE denormal_cars OWNER TO denormal_user;
\c denormal_cars;

\echo Denormal Cars 3.
\i scripts/denormal_data.sql;

\dS car_models;
SELECT COUNT(*) FROM car_models;

\echo Denormal Cars 5.
SELECT DISTINCT
  make_title, COUNT(*)
  FROM car_models
  GROUP BY make_title
  ORDER BY make_title;

\echo Denormal Cars 6.
SELECT DISTINCT
  model_title, COUNT(*)
  FROM car_models
  WHERE make_code = 'VOLKS'
  GROUP BY model_title
  ORDER BY model_title;

\echo Denormal Cars 7.
SELECT make_code, model_code, model_title, year
  FROM car_models
  WHERE make_code = 'LAM'
  ORDER BY make_code, model_code, model_title, year;

\echo Denormal Cars 8.
SELECT *
  FROM car_models
  WHERE year BETWEEN 2010 AND 2015
  ORDER BY make_code, model_code, model_title, year;

\c andrew;