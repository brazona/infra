
------------------------------------
-- TABLE IDP.USERS
------------------------------------
INSERT INTO idp.users (email,is_account_non_expired,is_account_non_locked,is_credentials_non_expired,is_enabled,"name","password") VALUES
	 ('cezar.silva@gmail.com',true,true,true,true,'Cezar Silva','$2a$10$0aFkQ9xFY.tLmmnymiY0puLAGFkin3n0MDMfqJWJ//XaskkpLmOF.'),
	 ('jadina@gmail.com',true,true,true,true,'Jadina','$2a$10$0aFkQ9xFY.tLmmnymiY0puLAGFkin3n0MDMfqJWJ//XaskkpLmOF.');


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

