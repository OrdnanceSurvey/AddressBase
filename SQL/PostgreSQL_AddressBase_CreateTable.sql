#-------------------------------------------------------------------------------
# Name:        `AddressBase create table information for PostgreSQL
# Purpose:     `This SQL code is to be used along side the Getting Started Guide
#								to setup the OS AddressBase tables within a database
# Created:     26/10/2015
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
CREATE TABLE addressbase (
UPRN bigint NOT NULL,
OS_ADDRESS_TOID varchar,
UDPRN bigint,
ORGANISATION_NAME varchar,
DEPARTMENT_NAME varchar,
PO_BOX_NUMBER varchar,
SUB_BUILDING_NAME varchar,
BUILDING_NAME varchar,
BUILDING_NUMBER varchar,
DEPENDENT_THOROUGHFARE varchar,
THOROUGHFARE varchar,
POST_TOWN varchar,
DOUBLE_DEPENDENT_LOCALITY varchar,
DEPENDENT_LOCALITY varchar,
POSTCODE varchar,
POSTCODE_TYPE varchar,
X_COORDINATE numeric,
Y_COORDINATE numeric,
LATITUDE numeric,
LONGITUDE numeric,
RPC integer,
COUNTRY varchar,
CHANGE_TYPE varchar,
LA_START_DATE Date,
RM_START_DATE Date,
LAST_UPDATE_DATE Date,
CLASS varchar);