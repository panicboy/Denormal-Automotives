\echo Modeling a Normalized Schema 1.
DROP ROLE IF EXISTS normal_user;
CREATE ROLE normal_user;

\echo Modeling a Normalized Schema 2.
DROP DATABASE IF EXISTS normal_cars;
CREATE DATABASE normal_cars;
ALTER DATABASE normal_cars OWNER TO normal_user;
\c normal_cars;