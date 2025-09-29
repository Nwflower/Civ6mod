INSERT OR
REPLACE
INTO LocalizedText
    (Tag, Language, Text)
VALUES -- 直到世界尽头
       ('LOC_TRAIT_LEADER_TO_WORLDS_END_DESCRIPTION', 'zh_Hans_CN',
        '城市不会产生厌战情绪。为军营建筑+40% [ICON_PRODUCTION] 生产力。移动力未耗尽的单位，在下个回合开始时，+1[ICON_MOVEMENT]移动力。'),
       -- 希腊文化融合
       ('LOC_TRAIT_LEADER_HELLENISTIC_FUSION_DESCRIPTION', 'zh_Hans_CN',
        '区域+1 [ICON_FOOD] 食物，军营额外+1 [ICON_FOOD] 食物。拥有军营区域的城市建造区域及建筑时+10% [ICON_PRODUCTION] 生产力。政体内的一个军事卡槽变为通配符卡槽。'),
       ('LOC_BUILDING_BASILIKOI_PAIDES_EXPANSION2_DESCRIPTION', 'zh_Hans_CN',
        '马其顿特色建筑。该城中训练的陆地近战、远程单位和伙友骑兵+25战斗经验值。非平民单位在此城中创建时，获得等同于单位花费25%的 [ICON_SCIENCE] 科技值，拥有民族主义后额外提供15%的 [ICON_CULTURE] 文化值。军事学和民族主义分别为生产的单位+1 [ICON_Strength] 战斗力。[NEWLINE][NEWLINE]无法建造在已拥有马厩的军营区域中。'),

       ('LOC_TRAIT_LEADER_HELLENISTIC_FUSION_EXPANSION1_DESCRIPTION', 'zh_Hans_CN',
        '{LOC_TRAIT_LEADER_HELLENISTIC_FUSION_DESCRIPTION}'),
       ('LOC_AB_MODIFIER_MQD_JUNSIXUE_NAME', 'zh_Hans_CN',
        '军事学提供+1 [ICON_Strength] 战斗力。'),
       ('LOC_AB_MODIFIER_MQD_MZ_NAME', 'zh_Hans_CN',
        '民族主义提供+1 [ICON_Strength] 战斗力。'),
       ('LOC_MODIFIER_AB_MODIFIER_MQD_JUNSIXUE_1', 'zh_Hans_CN',
        '+1 [ICON_Strength] 战斗力来自已研究的市政或科技。');