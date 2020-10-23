-------------------------------------------------------------------------------------------------------------------------
--The following code is used to create the database table, load the CSV file and apply AddressBase Core Full Supply data
-------------------------------------------------------------------------------------------------------------------------
------------------------------------
--Create AddressBase Core table
------------------------------------
CREATE TABLE addressbase_core (
	uprn int8 NOT NULL,
	parent_uprn int8 NULL,
	udprn int8 NULL,
	usrn int8 NOT NULL,
	toid varchar(20) NULL,
	classification_code varchar(4) NOT NULL,
	easting float8 NOT NULL,
	northing float8 NOT NULL,
	latitude float8 NOT NULL,
	longitude float8 NOT NULL,
	rpc integer NOT NULL,
	last_update_date varchar(10) NOT NULL,
	single_line_address varchar(500) NOT NULL,
	po_box varchar(13) NULL,
	organisation varchar(100) NULL,
	sub_building varchar(110) NULL,
	building_name varchar(110) NULL,
	building_number varchar(13) NULL,
	street_name varchar(100) NULL,
	locality varchar(35) NULL,
	town_name varchar(35) NULL,
	post_town varchar(30) NULL,
	island varchar(50) NULL,
	postcode varchar(8) NOT NULL,
	delivery_point_suffix varchar(2) NULL,
	gss_code varchar(9) NULL,
	change_code varchar(1) NOT NULL,
	tilename varchar(6) NOT NULL
);
COMMIT;

---------------------------------------------------------
--Use Copy to load in the processed Full Supply CSV File
---------------------------------------------------------
COPY addressbase_core FROM 'PATH TO CSV FILE' DELIMITER ',' CSV HEADER;
COMMIT;

------------------------------------------------------
--Add a geometry column to the AddressBase Core table
------------------------------------------------------
SELECT AddGeometryColumn ('public', 'addressbase_core', 'geom', 27700, 'POINT', 2); 
COMMIT;

------------------------------------------------------------------------------
--Update the AddressBase Core geometry column using easting/northing data
------------------------------------------------------------------------------
UPDATE addressbase_core SET geom = ST_GeomFromText('POINT(' || easting || ' ' || northing || ') ', 27700 );
COMMIT;

----------------------------------------------------------------
--Create Index on the AddressBase Core table tilename field
----------------------------------------------------------------
CREATE INDEX ON addressbase_core (tilename);
COMMIT;

---------------------------------------------------------------------------------------------------------------------
--The following code is used to create the database table, load the CSV file and apply AddressBase Core COU data
---------------------------------------------------------------------------------------------------------------------
------------------------------------
--Create AddressBase Core COU table
------------------------------------
CREATE TABLE addressbase_core_cou (
	uprn int8 NOT NULL,
	parent_uprn int8 NULL,
	udprn int8 NULL,
	usrn int8 NOT NULL,
	toid varchar(20) NULL,
	classification_code varchar(4) NOT NULL,
	easting float8 NOT NULL,
	northing float8 NOT NULL,
	latitude float8 NOT NULL,
	longitude float8 NOT NULL,
	rpc integer NOT NULL,
	last_update_date varchar(10) NOT NULL,
	single_line_address varchar(500) NOT NULL,
	po_box varchar(13) NULL,
	organisation varchar(100) NULL,
	sub_building varchar(110) NULL,
	building_name varchar(110) NULL,
	building_number varchar(13) NULL,
	street_name varchar(100) NULL,
	locality varchar(35) NULL,
	town_name varchar(35) NULL,
	post_town varchar(30) NULL,
	island varchar(50) NULL,
	postcode varchar(8) NOT NULL,
	delivery_point_suffix varchar(2) NULL,
	gss_code varchar(9) NULL,
	change_code varchar(1) NOT NULL,
	tilename varchar(6) NOT NULL
);
COMMIT;

-------------------------------------------------
--Use Copy to load in the processed COU CSV File
-------------------------------------------------
COPY addressbase_core_cou FROM 'PATH TO CSV FILE' DELIMITER ',' CSV HEADER;
COMMIT;

----------------------------------------------------------
--Add a geometry column to the AddressBase Core COU table
----------------------------------------------------------
SELECT AddGeometryColumn ('public', 'addressbase_core_cou', 'geom', 27700, 'POINT', 2); 
COMMIT;

------------------------------------------------------------------------------
--Update the AddressBase Core COU geometry column using easting/northing data
------------------------------------------------------------------------------
UPDATE addressbase_core_cou SET geom = ST_GeomFromText('POINT(' || easting || ' ' || northing || ') ', 27700 );
COMMIT;

----------------------------------------------------------------
--Create Index on the AddressBase Core COU table tilename field
----------------------------------------------------------------
CREATE INDEX ON addressbase_core_cou (tilename);
COMMIT;

------------------------------------------------------------------------------------------------
--Delete from AddressBase Core table using the tilenames from the AddressBase Core COU table
------------------------------------------------------------------------------------------------
DELETE FROM addressbase_core WHERE tilename IN (SELECT DISTINCT(tilename) FROM addressbase_core_cou);
COMMIT;

-----------------------------------------------------------------------------------------
--Insert the records from the AddressBase Core COU table into our AddressBase Core table
-----------------------------------------------------------------------------------------
INSERT INTO addressbase_core SELECT * FROM addressbase_core_cou;
COMMIT;
