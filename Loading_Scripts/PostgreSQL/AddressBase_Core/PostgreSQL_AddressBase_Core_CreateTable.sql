#-------------------------------------------------------------------------------
# Name:        `AddressBase Core create table information for PostgreSQL
# Purpose:     `This SQL code is to be used along side the Getting Started Guide
#								to setup the OS AddressBase tables within a database
# Created:     28/05/2020
# Copyright:   `(c) Ordnance Survey 2020
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
CREATE TABLE addressbase_core(
uprn bigint NOT NULL,
parent_uprn bigint,
udprn bigint,
usrn bigint,
toid varchar,
classification_code varchar,
easting numeric,
northing numeric,
latitude numeric,
longitude numeric,
rpc bigint,
last_update_date Date,
single_line_address varchar,
po_box varchar,
organisation varchar,
sub_building varchar,
building_name varchar,
building_number varchar,
street_name varchar,
locality varchar,
town_name varchar,
post_town varchar,
island varchar,
postcode varchar,
delivery_point_suffix varchar,
gss_code varchar,
change_code varchar);