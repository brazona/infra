------------------------------------
-- USERS
------------------------------------
CREATE ROLE brazona WITH SUPERUSER CREATEDB CREATEROLE NOINHERIT LOGIN PASSWORD 'DKC2LTEN4L';
CREATE ROLE wiki NOSUPERUSER NOCREATEDB NOCREATEROLE NOINHERIT LOGIN NOREPLICATION NOBYPASSRLS PASSWORD '8SLB8GWU8L';
CREATE ROLE idp NOSUPERUSER NOCREATEDB NOCREATEROLE NOINHERIT LOGIN NOREPLICATION NOBYPASSRLS PASSWORD 'Z4HKTFW5WY';
------------------------------------
-- SCHEMAS
------------------------------------
DROP SCHEMA IF EXISTS idp;
CREATE SCHEMA idp AUTHORIZATION idp;
DROP SCHEMA IF EXISTS wiki;
CREATE SCHEMA wiki AUTHORIZATION wiki;
------------------------------------
-- GRANT
------------------------------------
GRANT ALL ON ALL TABLES IN SCHEMA idp TO idp;
GRANT ALL ON ALL TABLES IN SCHEMA wiki TO wiki;
------------------------------------
-- SEARCH PATH
------------------------------------
ALTER ROLE idp SET search_path to idp;
ALTER ROLE wiki SET search_path to wiki;

------------------------------------
-- TABLE IDP.USERS
------------------------------------
DROP TABLE IF EXISTS idp."users";
CREATE TABLE idp.users (
	id int8 GENERATED ALWAYS AS IDENTITY( INCREMENT BY 1 MINVALUE 1 MAXVALUE 9223372036854775807 START 1 CACHE 1 NO CYCLE) NOT NULL,
	email varchar(255) NULL,
	is_account_non_expired bool NULL,
	is_account_non_locked bool NULL,
	is_credentials_non_expired bool NULL,
	is_enabled bool NULL,
	is_update_password bool NULL,
	"name" varchar(255) NULL,
	"password" varchar(255) NULL,
	CONSTRAINT users_pkey PRIMARY KEY (id),
	CONSTRAINT users_email_unique UNIQUE (email),
	CONSTRAINT users_name_unique UNIQUE (name)
);
COMMENT ON TABLE idp.users IS 'Tabela para persistencia dos dados de usuários';
ALTER TABLE idp.users OWNER TO idp;

------------------------------------
-- TABLE IDP.OWNERS
------------------------------------
DROP TABLE IF EXISTS idp."owners";

CREATE TABLE idp.owners (
	id int8 GENERATED ALWAYS AS IDENTITY( INCREMENT BY 1 MINVALUE 1 MAXVALUE 9223372036854775807 START 1 CACHE 1 NO CYCLE) NOT NULL,
	full_name varchar(255) NOT NULL,
	"document" varchar(255) NOT NULL,
	user_id int8 NOT NULL,
	CONSTRAINT owners_pk PRIMARY KEY (id),
	CONSTRAINT owners_document_unique UNIQUE (document),
	CONSTRAINT user_id_fk FOREIGN KEY (user_id) REFERENCES idp.users(id)
);
COMMENT ON TABLE idp.owners IS 'Tabela que registra dados de algum proprietário de organização.';
ALTER TABLE idp.owners OWNER TO idp;
------------------------------------
-- TABLE IDP.BUSINESS PARTNERS
------------------------------------
DROP TABLE IF EXISTS idp."business_partners";

CREATE TABLE idp.business_partners (
	full_name varchar(255) NOT NULL,
	"document" varchar(255) NOT NULL,
	gender varchar(255) NULL,
	user_id int8 NULL,
	id int8 GENERATED ALWAYS AS IDENTITY( INCREMENT BY 1 MINVALUE 1 MAXVALUE 9223372036854775807 START 1 CACHE 1 NO CYCLE) NOT NULL,
	CONSTRAINT business_partners_pk PRIMARY KEY (id),
	CONSTRAINT business_partners_unique UNIQUE (document),
	CONSTRAINT user_id FOREIGN KEY (user_id) REFERENCES idp.users(id)
);
COMMENT ON TABLE idp.business_partners IS 'Tabela que registra os dados dos parceiros de negócio.';
ALTER TABLE idp.business_partners OWNER TO idp;

------------------------------------
-- TABLE IDP.ADDRESSES
------------------------------------
DROP TABLE IF EXISTS idp."addresses";

CREATE TABLE idp.addresses (
	street varchar(255) NOT NULL,
	neighborhood varchar(100) NOT NULL,
	"number" varchar(100) NOT NULL,
	complement varchar(255) NOT NULL,
	state varchar(100) NOT NULL,
	zipcode varchar(100) NOT NULL,
	country varchar(100) NOT NULL,
	id int8 GENERATED ALWAYS AS IDENTITY( INCREMENT BY 1 MINVALUE 1 MAXVALUE 9223372036854775807 START 1 CACHE 1 NO CYCLE) NOT NULL,
	business_partner_id int8 NOT NULL,
	CONSTRAINT addresses_pk PRIMARY KEY (id),
	CONSTRAINT business_partner_fk FOREIGN KEY (business_partner_id) REFERENCES idp.business_partners(id) ON DELETE CASCADE ON UPDATE CASCADE
);
COMMENT ON TABLE idp.addresses IS 'Tabela que registra os endereços dos parceiros de negócio.';
ALTER TABLE idp.addresses OWNER TO idp;
------------------------------------
-- TABLE IDP.SERVICES
------------------------------------
DROP TABLE IF EXISTS idp."services";

CREATE TABLE idp.services (
	id int8 NOT NULL,
	"name" varchar(255) NULL,
	sigla varchar(100) NOT NULL,
	CONSTRAINT services_pkey PRIMARY KEY (id)
);
COMMENT ON TABLE idp.services IS 'Tabela dedicada para armazena informações dos serviços oferecido pela Brazona Tech.';
ALTER TABLE idp.services OWNER TO idp;
------------------------------------
-- TABLE IDP.ROLES
------------------------------------
DROP TABLE IF EXISTS idp."roles";

CREATE TABLE idp.roles (
	id int8 NOT NULL,
	name varchar(255) NOT NULL,
	CONSTRAINT roles_pkey PRIMARY KEY (id)
);
COMMENT ON TABLE idp.roles IS 'Tabela dedicada para armazena informações dos serviços oferecido pela Brazona Tech.';
ALTER TABLE idp.roles OWNER TO idp;
------------------------------------
-- TABLE IDP.ORGANIZATION
------------------------------------

DROP TABLE IF EXISTS idp."organizations";
CREATE TABLE idp.organizations (
	id int8 GENERATED ALWAYS AS IDENTITY( INCREMENT BY 1 MINVALUE 1 MAXVALUE 9223372036854775807 START 1 CACHE 1 NO CYCLE) NOT NULL,
	fantasy_name varchar(255) NULL,
	corporate_reason varchar(100) NOT NULL,
	"document" varchar(255) NOT NULL,
	CONSTRAINT organizations_pkey PRIMARY KEY (id),
	CONSTRAINT organizations_unique UNIQUE (document),
	CONSTRAINT organizations_owners_fk FOREIGN KEY (id) REFERENCES idp.owners(id)
);
COMMENT ON TABLE idp.organizations IS 'Tabela que registra dados das organizações.';
ALTER TABLE idp.organizations OWNER TO idp;
------------------------------------
-- TABLE IDP.SERVICE BY ORGANIZATION
------------------------------------

DROP TABLE IF EXISTS idp."services_by_organizations";

CREATE TABLE idp.services_by_organizations (
	id int8 GENERATED ALWAYS AS IDENTITY( INCREMENT BY 1 MINVALUE 1 MAXVALUE 9223372036854775807 START 1 CACHE 1 NO CYCLE) NOT NULL,
	organization_id int8 NOT NULL,
	service_id int8 NOT NULL,
	business_partner_id int8 NOT NULL,
	role_id int8 NOT NULL,
	"name" varchar NOT NULL,
	CONSTRAINT services_by_organizations_pk PRIMARY KEY (id),
	CONSTRAINT business_partner_fk FOREIGN KEY (business_partner_id) REFERENCES idp.business_partners(id),
	CONSTRAINT organization_fk FOREIGN KEY (organization_id) REFERENCES idp.organizations(id),
	CONSTRAINT role_fk FOREIGN KEY (role_id) REFERENCES idp.roles(id),
	CONSTRAINT service_fk FOREIGN KEY (service_id) REFERENCES idp.services(id)
);

COMMENT ON TABLE idp.services_by_organizations IS 'Tabela responsável por registrar o relacionamento dos papeis de algum parceiro de negócio dentro da organização.';
ALTER TABLE idp.services_by_organizations OWNER TO idp;
------------------------------------
-- TABLE IDP.SESSION
------------------------------------

DROP TABLE IF EXISTS idp."session";

CREATE TABLE idp."session" (
	access_token varchar(10012) NOT NULL,
	expires_in varchar(255) NULL,
	jwt_token varchar(10012) NOT NULL,
	refresh_expires_in varchar(255) NULL,
	refresh_token varchar(10012) NULL,
	user_id int8 NOT NULL,
	id int8 GENERATED ALWAYS AS IDENTITY( INCREMENT BY 1 MINVALUE 1 MAXVALUE 9223372036854775807 START 1 CACHE 1 NO CYCLE) NOT NULL,
	CONSTRAINT session_pk PRIMARY KEY (id),
	CONSTRAINT user_fk FOREIGN KEY (user_id) REFERENCES idp.users(id)
);

COMMENT ON TABLE idp.session IS 'Tabela dedicada para administrar dados da sessão do usuário.';
ALTER TABLE idp.session OWNER TO idp;
------------------------------------
-- TABLE IDP.USERS
------------------------------------
INSERT INTO idp.users (email,is_account_non_expired,is_account_non_locked,is_credentials_non_expired,is_enabled, is_update_password, "name","password") VALUES
	 ('cezar.silva@gmail.com',true,true,true,true, false, 'Cezar Silva','$2a$10$6WXEuerXchYDhCw6X6fIfOWssaPRGZ8xrm0hbBhlJYndSIEFg7x2.'),
	 ('jadina@gmail.com',true,true,true,true, false, 'Jadina','$2a$10$6WXEuerXchYDhCw6X6fIfOWssaPRGZ8xrm0hbBhlJYndSIEFg7x2.'),
	 ('brazonatech@gmail.com',true,true,true,true, false, 'Esther','$2a$10$6WXEuerXchYDhCw6X6fIfOWssaPRGZ8xrm0hbBhlJYndSIEFg7x2.'),
	 ('cezarfelipe2008@gmail.com',true,true,true,true, false, 'Julio','$2a$10$6WXEuerXchYDhCw6X6fIfOWssaPRGZ8xrm0hbBhlJYndSIEFg7x2.');


------------------------------------
-- TABLE IDP.OWNERS
------------------------------------

INSERT INTO idp.owners (full_name,"document",user_id) VALUES
	 ('Jadina Quele Gomes Felipe','598.169.180-80',2);


------------------------------------
-- TABLE IDP.BUSINESS PARTNERS
------------------------------------

INSERT INTO idp.business_partners (full_name,"document",gender,user_id) VALUES
	 ('Cezar Felipe da Silva','38096186833','masculino',1);


------------------------------------
-- TABLE IDP.ADDRESSES
------------------------------------
INSERT INTO idp.addresses (street,neighborhood,"number",complement,state,zipcode,country,business_partner_id) VALUES
	 ('Norman Cordon','Eldorado','10','2','SP','04476500','Brasil',1);


------------------------------------
-- TABLE IDP.SERVICES
------------------------------------
INSERT INTO idp.services (id,"name",sigla) VALUES
	 (1,'Business Administration Game','bag');

------------------------------------
-- TABLE IDP.ROLES
------------------------------------

INSERT INTO idp.roles (id,"name") VALUES
	 (1,'OWNER_SYS'),
	 (2,'ADM_SYS'),
	 (3,'USER_SYS'),
	 (4,'OWNER_ORG'),
	 (5,'ADM_ORG'),
	 (6,'USER_ORG');


------------------------------------
-- TABLE IDP.ORGANIZATION
------------------------------------	 

INSERT INTO idp.organizations
(fantasy_name, corporate_reason, "document")
VALUES('Brazona Tech', 'Brazona LTDA', '56.984.829/0001-20');

------------------------------------
-- TABLE IDP.SERVICE BY ORGANIZATION
------------------------------------

INSERT INTO idp.services_by_organizations (organization_id,service_id,business_partner_id,role_id,"name") VALUES
	 (1,1,1,2,'Administrador do Sistema');


