#-------------------------------------------------------------------------------
# Name:        `AddressBase Plus and AdressBase Plus Islands Indexes for Oracle
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
--The tablespace information below needs to be updated appropriately for your use.
--------------------------------------------------------------------------------

CREATE INDEX AB_Plus_UPRN_IDX ON AB_Plus(UPRN);
Drop INDEX AB_Plus_IXS;
CREATE INDEX AB_Plus_IXS on AB_Plus(GEOMETRY)
INDEXTYPE IS MDSYS.SPATIAL_INDEX
PARAMETERS ( 'LAYER_GTYPE=POINT, tablespace=<tablespace name>' );

