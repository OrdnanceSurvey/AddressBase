SELECT
l.uprn,
l.sao_text, l.sao_start_number, l.sao_start_suffix, l.sao_end_number, l.sao_end_suffix,
l.pao_text, l.pao_start_number, l.pao_start_suffix, l.pao_end_number, l.pao_end_suffix,
s.street_description,
s.locality_name,
b.postcode_locator,
/*
Concatenate a single GEOGRAPHIC address line label
This code takes into account all possible combinations os pao/sao numbers and suffixes
*/
case
when o.organisation != ‘’ then o.organisation||’, ‘ else ‘’ end
--Secondary Addressable Information--------------------------------------------------------------------------------------
||case when l.sao_text != ‘’ then l.sao_text||’, ‘ else ‘’ end
--case statement for different combinations of the sao start numbers (e.g. if no sao start suffix)
||case
when l.sao_start_number is not null and l.sao_start_suffix = ‘’ and l.sao_end_number is null
then l.sao_start_number::varchar(4)||’, ‘
when l.sao_start_number is null then ‘’ else l.sao_start_number::varchar(4)||’’ end
--case statement for different combinations of the sao start suffixes (e.g. if no sao end number)
||case
when l.sao_start_suffix != ‘’ and l.sao_end_number is null then l.sao_start_suffix||’, ‘
when l.sao_start_suffix != ‘’ and l.sao_end_number is not null then l.sao_start_suffix else ‘’ end
--Add a ‘-’ between the start and end of the secondary address (e.g. only when sao start and sao end)
||case
when l.sao_end_suffix != ‘’ and l.sao_end_number is not null then ‘-’
when l.sao_start_number is not null and l.sao_end_number is not null then ‘-’ else ‘’ end
--case statement for different combinations of the sao end numbers and sao end suffixes
||case
when l.sao_end_number is not null and l.sao_end_suffix = ‘’ then l.sao_end_number::varchar(4)||’, ‘
when l.sao_end_number is null then ‘’ else l.sao_end_number::varchar(4) end
--pao end suffix
||case when l.sao_end_suffix != ‘’ then l.sao_end_suffix||’, ‘ else ‘’ end
--Primary Addressable
Information----------------------------------------------------------------------------------------------------------
||case when l.pao_text != ‘’ then l.pao_text||’, ‘ else ‘’ end

--case statement for different combinations of the pao start numbers (e.g. if no pao start suffix)
||case

when l.pao_start_number is not null and l.pao_start_suffix = ‘’ and l.pao_end_number is null then l.pao_start_number::varchar(4)||’, ‘
when l.pao_start_number is null then ‘’ else l.pao_start_number::varchar(4)||’’ end
--case statement for different combinations of the pao start suffixes (e.g. if no pao end number)
||case

when l.pao_start_suffix != ‘’ and l.pao_end_number is null then l.pao_start_suffix||’, ‘ when l.pao_start_suffix != ‘’ and l.pao_end_number is not null then l.pao_start_suffix else ‘’ end
--Add a ‘-’ between the start and end of the primary address (e.g. only when pao start and pao end)
||case

when l.pao_end_suffix != ‘’ and l.pao_end_number is not null then ‘-’

when l.pao_start_number is not null and l.pao_end_number is not null then ‘-’ else ‘’ end
--case statement for different combinations of the pao end numbers and pao end suffixes
||case

when l.pao_end_number is not null and l.pao_end_suffix = ‘’ then l.pao_end_number::varchar(4)||’, ‘ when l.pao_end_number is null then ‘’
else l.pao_end_number::varchar(4) end
--pao end suffix
||case when l.pao_end_suffix != ‘’ then l.pao_end_suffix||’, ‘ else ‘’ end

--Street Information-----------------------------------------------------------------------------------------------------------
||case when s.street_description != ‘’ then s.street_description||’, ‘ else ‘’ end

--Locality------------------------------------------------------------------------------------------------------------------------
||case when s.locality_name != ‘’ then s.locality_name||’, ‘ else ‘’ end

--Town--------------------------------------------------------------------------------------------------------------------------
||case when s.town_name != ‘’ then s.town_name||’, ‘ else ‘’ end
--Postcode---------------------------------------------------------------------------------------------------------------------
||case when b.postcode_locator != ‘’ then b.postcode_locator else ‘’ end
AS geo_single_address_label FROM
abp_blpu AS b, abp_street_descriptor AS s,
abp_lpi AS l full outer join abp_organisation AS o on (l.uprn = o.uprn) WHERE b.uprn = l.uprn
AND l.usrn = s.usrn
AND l.language = s.language;

