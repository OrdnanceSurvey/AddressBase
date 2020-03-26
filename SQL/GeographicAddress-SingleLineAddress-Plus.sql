SELECT
uprn,
sao_text, sao_start_number, sao_start_suffix, sao_end_number, sao_end_suffix,
pao_text, pao_start_number, pao_start_suffix, pao_end_number, pao_end_suffix,
street_description,
locality,
town_name,
postcode_locator,
/*
Concatenate a single GEOGRAPHIC address line label
This code takes into account all possible combinations os pao/sao numbers and suffixes
*/
case
when la_organisation != '' then la_organisation||', '  else '' end
--Secondary Addressable Information--------------------------------------------------------------------------------------
||case when sao_text != '' then sao_text||', '  else '' end
--case statement for different combinations of the sao start numbers (e.g. if no sao start suffix)
||case
when sao_start_number is not null and sao_start_suffix = '' and sao_end_number is null
then sao_start_number::varchar(4)||', '
when sao_start_number is null then '' else sao_start_number::varchar(4)||'' end
--case statement for different combinations of the sao start suffixes (e.g. if no sao end number)
||case
when sao_start_suffix != '' and sao_end_number is null then sao_start_suffix||', '
when sao_start_suffix != '' and sao_end_number is not null then sao_start_suffix else '' end
--Add a '-' between the start and end of the secondary address (e.g. only when sao start and sao end)
||case
when sao_end_suffix != '' and sao_end_number is not null then '-'
when sao_start_number is not null and sao_end_number is not null then '-' else '' end
--case statement for different combinations of the sao end numbers and sao end suffixes
||case
when sao_end_number is not null and sao_end_suffix = '' then sao_end_number::varchar(4)||', '
when sao_end_number is null then '' else sao_end_number::varchar(4) end
--pao end suffix
||case when sao_end_suffix != '' then sao_end_suffix||', ' else '' end
--Primary Addressable Information----------------------------------------------------------------------------------------------------------
||case when pao_text != '' then pao_text||', ' else '' end

--case statement for different combinations of the pao start numbers (e.g. if no pao start suffix)
||case

when pao_start_number is not null and pao_start_suffix = '' and pao_end_number is null then pao_start_number::varchar(4)||' '
when pao_start_number is null then '' else pao_start_number::varchar(4)||'' end
--case statement for different combinations of the pao start suffixes (e.g. if no pao end number)
||case

when pao_start_suffix != '' and pao_end_number is null then pao_start_suffix||', ' when pao_start_suffix != '' and pao_end_number is not null then pao_start_suffix else '' end
--Add a '-' between the start and end of the primary address (e.g. only when pao start and pao end)
||case

when pao_end_suffix != '' and pao_end_number is not null then '-'

when pao_start_number is not null and pao_end_number is not null then '-' else '' end
--case statement for different combinations of the pao end numbers and pao end suffixes
||case

when pao_end_number is not null and pao_end_suffix = '' then pao_end_number::varchar(4)||', ' when pao_end_number is null then ''
else pao_end_number::varchar(4) end
--pao end suffix
||case when pao_end_suffix != '' then pao_end_suffix||', ' else '' end

--Street Information-----------------------------------------------------------------------------------------------------------
||case when street_description != '' then street_description||', ' else '' end

--Locality------------------------------------------------------------------------------------------------------------------------
||case when locality != '' then locality||', ' else '' end

--Town--------------------------------------------------------------------------------------------------------------------------
||case when town_name != '' then town_name||', ' else '' end
--Postcode---------------------------------------------------------------------------------------------------------------------
||case when postcode_locator != '' then postcode_locator else '' end
AS geo_single_address_label FROM
addressbaseplus.addressbaseplus;
