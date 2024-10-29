------------------------------------
-- ROLES GROUP
------------------------------------

CREATE ROLE brazona WITH SUPERUSER CREATEDB CREATEROLE NOINHERIT LOGIN PASSWORD 'DKC2LTEN4L';
CREATE ROLE dba WITH NOSUPERUSER CREATEDB CREATEROLE NOINHERIT LOGIN PASSWORD 'G4WC99HK9W';
CREATE ROLE app WITH NOSUPERUSER NOCREATEDB NOCREATEROLE NOINHERIT LOGIN PASSWORD '45EO3PDBS2';
CREATE ROLE developer WITH NOSUPERUSER NOCREATEDB NOCREATEROLE NOINHERIT LOGIN PASSWORD 'QYXGI21Q6R';

------------------------------------
-- SCHEMA
------------------------------------

DROP SCHEMA IF EXISTS idp;
CREATE SCHEMA idp AUTHORIZATION brazona;

------------------------------------
-- GRANT
------------------------------------

GRANT USAGE ON SCHEMA idp TO dba;
GRANT ALL PRIVILEGES ON SCHEMA idp TO dba;
GRANT USAGE ON SCHEMA idp TO app;
GRANT USAGE ON SCHEMA idp TO developer;

------------------------------------
-- USERS
------------------------------------

DROP ROLE IF EXISTS cezar_admin;
CREATE ROLE cezar_admin LOGIN PASSWORD 'EMPOTXYCXG' IN ROLE dba;

DROP ROLE IF EXISTS cezar_develop;
CREATE ROLE cezar_develop LOGIN PASSWORD '459159' IN ROLE developer;

DROP ROLE IF EXISTS idp_app;
CREATE ROLE idp_app LOGIN PASSWORD 'FKDRAK4DFF' IN ROLE app;

-- DROP SCHEMA IF EXISTS keycloak;
-- CREATE SCHEMA keycloak AUTHORIZATION develop;



-----------------------------------------------------------------------

