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
	"name" varchar(255) NULL,
	"password" varchar(255) NULL,
	CONSTRAINT users_pkey PRIMARY KEY (id),
	CONSTRAINT users_email_unique UNIQUE (email),
	CONSTRAINT users_name_unique UNIQUE (name)
);
COMMENT ON TABLE idp.users IS 'Tabela para persistencia dos dados de usuários';

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

------------------------------------
-- TABLE IDP.ROLES
------------------------------------
DROP TABLE IF EXISTS idp."roles";

CREATE TABLE idp.roles (
	id int8 NOT NULL,
	name varchar(255) NOT NULL,
	CONSTRAINT roles_pkey PRIMARY KEY (id)
);
COMMENT ON TABLE idp.services IS 'Tabela dedicada para armazena informações dos serviços oferecido pela Brazona Tech.';

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
	CONSTRAINT business_partners_unique UNIQUE (document),
	CONSTRAINT organizations_owners_fk FOREIGN KEY (id) REFERENCES idp.owners(id)
);
COMMENT ON TABLE idp.organizations IS 'Tabela que registra dados das organizações.';

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

COMMENT ON TABLE idp.services IS 'Tabela responsável por registrar o relacionamento dos papeis de algum parceiro de negócio dentro da organização.';

------------------------------------
-- TABLE IDP.SESSION
------------------------------------

DROP TABLE IF EXISTS idp."session";

CREATE TABLE idp."session" (
	access_token varchar(10012) NOT NULL,
	expires_in varchar(255) NULL,
	jwt_token varchar(10012) NOT NULL,
	refresh_expires_in varchar(255) NULL,
	refresh_token varchar(10012) NOT NULL,
	user_id int8 NOT NULL,
	id int8 GENERATED ALWAYS AS IDENTITY( INCREMENT BY 1 MINVALUE 1 MAXVALUE 9223372036854775807 START 1 CACHE 1 NO CYCLE) NOT NULL,
	CONSTRAINT session_pk PRIMARY KEY (id),
	CONSTRAINT user_fk FOREIGN KEY (user_id) REFERENCES idp.users(id)
);

COMMENT ON TABLE idp.services IS 'Tabela dedicada para administrar dados da sessão do usuário.';
----------------------------------------------------------------------------------------------