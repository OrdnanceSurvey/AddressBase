#-------------------------------------------------------------------------------
# Name:        `AddressBase Premium and AddressBase Premium Islands
#								Create Table SQL for Oracle AddressBase Premium
# Purpose:     `This SQL code is to be used along side the Getting Started Guide
#				to setup the OS AddressBase Premium tables within a database
# Created:     `19/02/2016
# Copyright:   `(c) Ordnance Survey 2016
# Licence:     `THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
#               "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
#               LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS
#               FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE
#               COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT,
#               INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING,
#               BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS
#               OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED
#               AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
#               OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF
#               THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE
#-------------------------------------------------------------------------------

--------------------------------------------------------------------------------
-- Please note all instances of <TablespaceName> need to be updated with the relevant
--information for the user before running these scripts.
--------------------------------------------------------------------------------
--First you need to ensure there are no tables already in your database named as per 
-- the names you intend to put in below

-- All table names can be changed to suit your requirements, and are only provided as an
-- example

--==============================================
-- Create the tables for the AddressBase Premium load
--==============================================

--The 11 record table (Street)
CREATE TABLE STREET
(
   RECORD_IDENTIFIER       NUMBER,
   CHANGE_TYPE             VARCHAR2 (1),
   PRO_ORDER               NUMBER,
   USRN                    NUMBER,
   RECORD_TYPE             NUMBER,
   SWA_ORG_REF_NAMING      NUMBER,
   STATE                   NUMBER,
   STATE_DATE              DATE,
   STREET_SURFACE          NUMBER,
   STREET_CLASSIFICATION   NUMBER,
   VERSION                 NUMBER,
   STREET_START_DATE       DATE,
   STREET_END_DATE         DATE,
   LAST_UPDATE_DATE        DATE,
   RECORD_ENTRY_DATE       DATE,
   STREET_START_X          FLOAT,
   STREET_START_Y          FLOAT,
   STREET_START_LAT        FLOAT,
   STREET_START_LONG       FLOAT,
   STREET_END_X            FLOAT,
   STREET_END_Y            FLOAT,
   STREET_END_LAT          FLOAT,
   STREET_END_LONG         FLOAT,
   STREET_TOLERANCE        NUMBER
);

--The 15 record table (Street Descriptor)
CREATE TABLE STREET_DESC
(
   RECORD_IDENTIFIER    NUMBER,
   CHANGE_TYPE          VARCHAR2 (1),
   PRO_ORDER            NUMBER,
   USRN                 NUMBER,
   STREET_DESCRIPTION   VARCHAR2 (100),
   LOCALITY             VARCHAR2 (35),
   TOWN_NAME            VARCHAR2 (30),
   ADMINSTRATIVE_AREA   VARCHAR2 (30),
   LANGUAGE             VARCHAR2 (3),
  START_DATE            DATE,
   END_DATE             DATE,
   LAST_UPDATE_DATE     DATE,
   ENTRY_DATE           DATE

);

--The 21 record table (BLPU)
CREATE TABLE BLPU
(
   RECORD_IDENTIFIER      NUMBER,
   CHANGE_TYPE            VARCHAR2 (1),
   PRO_ORDER              NUMBER,
   UPRN                   NUMBER,
   LOGICAL_STATUS         NUMBER,
   BLPU_STATE             NUMBER,
   BLPU_STATE_DATE        DATE,
   PARENT_UPRN            NUMBER,
   X_COORDINATE           FLOAT,
   Y_COORDINATE           FLOAT,
   LATITUDE               FLOAT,
   LONGITUDE              FLOAT,
   RPC                    NUMBER,
   LOCAL_CUSTODIAN_CODE   NUMBER,
   COUNTRY 		            VARCHAR2 (1),
   START_DATE             DATE,
   END_DATE               DATE,
   LAST_UPDATE_DATE       DATE,
   ENTRY_DATE             DATE,
   ADDRESSBASE_POSTAL     VARCHAR2 (1),
   POSTCODE_LOCATOR       VARCHAR2 (8),
   MULTI_OCC_COUNT        NUMBER,
   GEOMETRY               MDSYS.SDO_GEOMETRY
);

-- Update USER_SDO_GEOM_METADATA
-- If loading AddressBase Premium Islands you may wish to use the Latitude
-- and Longitude fields and not X_COORDINATE, Y_COORDINATE ensuring you also
-- input the correct SRID and grid coordinates.
/*
INSERT INTO USER_SDO_GEOM_METADATA
  VALUES   (
               'BLPU',
               'GEOMETRY',
               MDSYS.SDO_DIM_ARRAY (MDSYS.SDO_DIM_ELEMENT ('X',
                                                           0,
                                                           750000,
                                                           0.001),
                                    MDSYS.SDO_DIM_ELEMENT ('Y',
                                                           0,
                                                           1350000,
                                                           0.001)),
               27700
           );
*/

--The 23 record table (Application Cross Reference)
CREATE TABLE XREF
(
   RECORD_IDENTIFIER   NUMBER,
   CHANGE_TYPE         VARCHAR2 (1),
   PRO_ORDER           NUMBER,
   UPRN                NUMBER,
   XREF_KEY            VARCHAR2 (14),
   CROSS_REFERENCE     VARCHAR2 (50),
   VERSION             NUMBER,
   SOURCE              VARCHAR2 (6),
   START_DATE          DATE,
   END_DATE            DATE,
   LAST_UPDATE_DATE    DATE,
   ENTRY_DATE          DATE
);

--The 24 record table (LPI)
CREATE TABLE LPI
(
   RECORD_IDENTIFIER   NUMBER,
   CHANGE_TYPE         VARCHAR2 (1),
   PRO_ORDER           NUMBER,
   UPRN                NUMBER,
   LPI_KEY             VARCHAR2 (14),
   LANGUAGE            VARCHAR2 (3),
   LOGICAL_STATUS      NUMBER,
   START_DATE          DATE,
   END_DATE            DATE,
   LAST_UPDATE_DATE    DATE,
   ENTRY_DATE          DATE,
   SAO_START_NUMBER    NUMBER,
   SAO_START_SUFFIX    VARCHAR2 (2),
   SAO_END_NUMBER      NUMBER,
   SAO_END_SUFFIX      VARCHAR2 (2),
   SAO_TEXT            VARCHAR2 (90),
   PAO_START_NUMBER    NUMBER,
   PAO_START_SUFFIX    VARCHAR2 (2),
   PAO_END_NUMBER      NUMBER,
   PAO_END_SUFFIX      VARCHAR2 (2),
   PAO_TEXT            VARCHAR2 (90),
   USRN                NUMBER,
   USRN_M_INDICATOR    VARCHAR2 (1),
   AREA_NAME           VARCHAR2 (35),
   addLEVEL            VARCHAR2 (30),
   OFFICIAL_FLAG       VARCHAR2 (1)
);

--The 28 record table Delivery Point Address
CREATE TABLE DEL_PT
(
   RECORD_IDENTIFIER             NUMBER,
   CHANGE_TYPE                   VARCHAR2 (1),
   PRO_ORDER                     NUMBER,
   UPRN                          NUMBER,
   UDPRN                         NUMBER,
   ORGANISATION_NAME             VARCHAR2 (60),
   DEPARTMENT_NAME               VARCHAR2 (60),
   SUB_BUILDING_NAME             VARCHAR2 (30),
   BUILDING_NAME                 VARCHAR2 (50),
   BUILDING_NUMBER               NUMBER,
   DEPENDENT_THOROUGHFARE        VARCHAR2 (80),
   THOROUGHFARE                  VARCHAR2 (80),
   DOU_DEP_LOCALITY              VARCHAR2 (35),
   DEPENDENT_LOCALITY            VARCHAR2 (35),
   POST_TOWN                     VARCHAR2 (30),
   POSTCODE                      VARCHAR2 (8),
   POSTCODE_TYPE                 VARCHAR2 (1),
   DELIVERY_POINT_SUFFIX         VARCHAR2 (10),
   WELSH_DEP_THOROUGHFARE        VARCHAR2 (80),
   WELSH_THOROUGHFARE            VARCHAR2 (80),
   WELSH_DOU_DEP_LOCALITY        VARCHAR2 (35),
   WELSH_DEP_LOCALITY            VARCHAR2 (35),
   WELSH_POST_TOWN               VARCHAR2 (30),
   PO_BOX_NUMBER                 VARCHAR2 (6),
   PROCESS_DATE                  DATE,
   START_DATE                    DATE,
   END_DATE                      DATE,
   LAST_UPDATE_DATE              DATE,
   ENTRY_DATE                    DATE
);

--The 30 record table
CREATE TABLE Successor
(
   RECORD_IDENTIFIER   NUMBER,
   CHANGE_TYPE         VARCHAR2 (1),
   PRO_ORDER           NUMBER,
   UPRN                NUMBER,
   SUCC_KEY            VARCHAR2 (14),
   START_DATE          DATE,
   END_DATE            DATE,
   LAST_UPDATE_DATE    DATE,
   ENTRY_DATE          DATE,
   SUCCESSOR           NUMBER
);

--The 31 record table
CREATE TABLE ORG
(
   RECORD_IDENTIFIER   NUMBER,
   CHANGE_TYPE         VARCHAR2 (1),
   PRO_ORDER           NUMBER,
   UPRN                NUMBER,
   ORG_KEY             VARCHAR2 (14),
   ORGANISATION        VARCHAR2 (100),
   LEGAL_NAME          VARCHAR2 (60),
   START_DATE          DATE,
   END_DATE            DATE,
   LAST_UPDATE_DATE    DATE,
   ENTRY_DATE          DATE
);

--The 32 record table
CREATE TABLE CLASS
(
   RECORD_IDENTIFIER     NUMBER,
   CHANGE_TYPE           VARCHAR2 (1),
   PRO_ORDER             NUMBER,
   UPRN                  NUMBER,
   CLASS_KEY             VARCHAR2 (14),
   CLASSIFICATION_CODE   VARCHAR2 (6),
   CLASS_SCHEME          VARCHAR2 (60),
   SCHEME_VERSION        FLOAT,
   START_DATE            DATE,
   END_DATE              DATE,
   LAST_UPDATE_DATE      DATE,
   ENTRY_DATE            DATE
);

CREATE TABLE header
(
	RECORD_IDENTIFIER	NUMBER,
	CUSTODIAN_NAME		VARCHAR2(40),
	LOCAL_CUSTODIAN_CODE NUMBER,
	PROCESS_DATE 		DATE,
	VOLUME_NUMBER		NUMBER,
	ENTRY_DATE 			DATE,
	TIME_STAMP 			DATE,
	VERSION				VARCHAR2(7),
	FILE_TYPE			VARCHAR2(1)
);

CREATE TABLE metadata
(
	RECORD_IDENTIFIER      	    NUMBER,
	GAZ_NAME					          VARCHAR2(60),
	GAZ_SCOPE					          VARCHAR2(60),
	TER_OF_USE					        VARCHAR2(60),
	LINKED_DATA					        VARCHAR2(100),
	GAZ_OWNER					          VARCHAR2(15),
	NGAZ_FREQ					          VARCHAR2(1),
	CUSTODIAN_NAME				      VARCHAR2(40),
	CUSTODIAN_UPRN				      NUMBER,
	LOCAL_CUSTODIAN_CODE		    NUMBER,
	CO_ORD_SYSTEM				        VARCHAR2(40),
	CO_ORD_UNIT					        VARCHAR2(10),
	META_DATE 					        DATE,
	CLASS_SCHEME				        VARCHAR2(60),
	GAZ_DATE 					          DATE,
	LANGUAGE 					          VARCHAR2(3),
	CHARACTER_SET				        VARCHAR2(5)
);

CREATE TABLE trailer 
(
	RECORD_IDENTIFIER 	  NUMBER,
	NEXT_VOLUME_NUMBER 		NUMBER,
	RECORD_COUNT				  NUMBER,
	ENTRY_DATE 					  DATE,
	TIME_STAMP 					  DATE
);