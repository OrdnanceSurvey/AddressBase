#-------------------------------------------------------------------------------
# Name:        `AddressBase Control File information for Oracle
# Purpose:     `This SQL code is to be used along side the Getting Started Guide
#								to setup the OS AddressBase tables within a database
# Created:     `20/07/2015
# Copyright:   `(c) Ordnance Survey 2015
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
--Please note the additional information in the Getting Started Guide before using this file--
--Modifications might be required to implement the below to your requirements --
--------------------------------------------------------------------------------

OPTIONS ( BINDSIZE=20971520, READSIZE=20971520, ROWS=2500, ERRORS=10, SILENT = FEEDBACK )
LOAD DATA
CHARACTERSET UTF8
INFILE 'filelistingLine1.csv'
INFILE 'filelistingLine2.csv'
APPEND
INTO TABLE AddressBase
FIELDS TERMINATED BY ","
OPTIONALLY ENCLOSED BY '"'
TRAILING NULLCOLS
(
UPRN,
OS_ADDRESS_TOID,
UDPRN,
ORGANISATION_NAME,
DEPARTMENT_NAME,
PO_BOX_NUMBER,
SUB_BUILDING_NAME,
BUILDING_NAME,
BUILDING_NUMBER,
DEPENDENT_THOROUGHFARE,
THOROUGHFARE,
POST_TOWN,
DOUBLE_DEPENDENT_LOCALITY,
DEPENDENT_LOCALITY,
POSTCODE,
POSTCODE_TYPE,
X_COORDINATE FLOAT EXTERNAL,
Y_COORDINATE FLOAT EXTERNAL,
LATITUDE FLOAT EXTERNAL,
LONGITUDE FLOAT EXTERNAL,
RPC,
COUNTRY,
CHANGE_TYPE,
LA_START_DATE DATE "YYYY-MM-DD",
RM_START_DATE DATE "YYYY-MM-DD",
LAST_UPDATE_DATE DATE "YYYY-MM-DD",
CLASS,
GEOMETRY COLUMN OBJECT
(
SDO_GTYPE CONSTANT '2001',
SDO_SRID CONSTANT '27700',
SDO_POINT COLUMN OBJECT
(
X ":X_COORDINATE",
Y ":Y_COORDINATE"
)
)
)

