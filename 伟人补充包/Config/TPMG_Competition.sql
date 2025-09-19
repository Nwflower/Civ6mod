-- Team_PVP_More_GreatPeople
-- Author: Nwflower
-- DateCreated: 2025-6-12 14:19:14
--------------------------------------------------------------

-- 删除所有除了岳飞以外的全部新增伟人
DELETE FROM GreatPersonIndividuals WHERE GreatPersonIndividualType IN
(SELECT GreatPersonIndividualType FROM NW_GreatPersonClass) AND GreatPersonIndividualType IS NOT 'GREAT_PERSON_INDIVIDUAL_NW_GENERAL_MEDIEVAL_2';