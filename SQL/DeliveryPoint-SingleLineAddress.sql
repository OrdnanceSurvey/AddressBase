SELECT
uprn,
(
 CASE WHEN department_name IS NOT NULL THEN department_name || ', ' ELSE '' END
 || CASE WHEN organisation_name IS NOT NULL THEN organisation_name || ', ' ELSE '' END
 || CASE WHEN sub_building_name IS NOT NULL THEN sub_building_name || ', ' ELSE '' END
 || CASE WHEN building_name IS NOT NULL THEN building_name || ', ' ELSE '' END
 || CASE WHEN building_number IS NOT NULL THEN building_number || ' ' ELSE '' END
 || CASE WHEN po_box_number IS NOT NULL THEN 'PO BOX ' || po_box_number || ', ' ELSE '' END
 || CASE WHEN dep_thoroughfare IS NOT NULL THEN dep_thoroughfare || ', ' ELSE '' END
 || CASE WHEN thoroughfare IS NOT NULL THEN thoroughfare || ', ' ELSE '' END
 || CASE WHEN dou_dep_locality IS NOT NULL THEN dou_dep_locality || ', ' ELSE '' END
 || CASE WHEN dep_locality IS NOT NULL THEN dep_locality || ', ' ELSE '' END
 || CASE WHEN post_town IS NOT NULL THEN post_town || ', ' ELSE '' END
 || postcode
) AS dpa_single_address_label
FROM addressbase_premium.delivery_point;