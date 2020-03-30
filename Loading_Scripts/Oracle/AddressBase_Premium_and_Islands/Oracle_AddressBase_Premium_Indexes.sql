#-------------------------------------------------------------------------------
# Name:        `AddressBase Premium Indexes for Oracle
# Purpose:     `This SQL code is to be used along side the Getting Started Guide
#				to setup the OS AddressBase Premium tables within a database
# Created:     `18/12/2014
# Copyright:   `(c) Ordnance Survey 2014
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

-------------------------------------------------------------------------------------
-- Please note all instances of <TablespaceName> need to be updated with the relevant
--information for the user before running these scripts.
-------------------------------------------------------------------------------------

--BLPU Indexes
DROP INDEX Abp_blpu_MIPRINX_PK;
DROP INDEX Abp_blpu_UPRN_IDX;
CREATE UNIQUE INDEX Abp_blpu_MIPRINX_PK ON Abp_blpu (MI_PRINX);
CREATE INDEX Abp_blpu_UPRN_IDX ON Abp_blpu (UPRN);
Drop INDEX Abp_blpu_IXS;
CREATE INDEX Abp_blpu_IXS on Abp_blpu(GEOMETRY)
INDEXTYPE IS MDSYS.SPATIAL_INDEX
PARAMETERS ( ' INITIAL =8M , NEXT =8M , PCTINCREASE = 0,
LAYER_GTYPE=MULTIPOINT, tablespace=<tablespace name>' );

-- APP X REF Indexes
DROP INDEX Abp_crossref_XRef_IDX;
CREATE INDEX Abp_crossref_XRef_IDX ON Abp_crossref (UPRN);

-- Classification Indexes
DROP INDEX Abp_classification_UPRN_IDX;
CREATE INDEX Abp_classification_UPRN_IDX ON ABPrem_CLASSIFICATION (UPRN);

-- Organisation Indexes
DROP INDEX Abp_Organisation_UPRN_IDX;
CREATE INDEX Abp_Organisation_UPRN_IDX ON Abp_ORGANISATION(UPRN);

-- Delivery Point Address Indexes
DROP INDEX Abp_DP_PC_IDX;
DROP INDEX Abp_DP_UPRN_IDX;
CREATE INDEX Abp_DP_PC_IDX ON Abp_delivery_point (POSTCODE);
CREATE INDEX Abp_DP_UPRN_IDX ON Abp_delivery_point (UPRN);

--LPI Indexes
DROP INDEX Abp_LPI_UPRN_IDX;
DROP INDEX Abp_LPI_USRN_IDX;
CREATE INDEX Abp_LPI_UPRN_IDX ON Abp_LPI (UPRN);
CREATE INDEX Abp_LPI_USRN_IDX ON Abp_LPI (USRN);

--Street Indexes
DROP INDEX Abp_street_USRN_IDX;
DROP INDEX Abp_street_MIPRINX_PK;
CREATE INDEX Abp_street_USRN_IDX ON Abp_street(USRN);
CREATE UNIQUE INDEX Abp_street_MIPRINX_PK ON Abp_street(MI_PRINX);

--StreetDescriptor Indexes
DROP INDEX Abp_street_descriptor_USRN_IDX;
CREATE INDEX Abp_street_descriptor_USRN_IDX ON Abp_street_descriptor (USRN);