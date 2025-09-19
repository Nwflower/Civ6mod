INSERT OR
REPLACE
INTO LocalizedText(Language, Tag, Text)
VALUES -- 吸血鬼
       ('zh_Hans_CN', 'LOC_GOVERNOR_PROMOTION_SANGUINE_PACT_1_DESCRIPTION', '[ICON_Capital] 首都将出现1个吸血鬼单位。发起贸易路线后，目的地立即出现一座贸易站。'),
       ('zh_Hans_CN', 'LOC_GOVERNOR_PROMOTION_SANGUINE_PACT_2_DESCRIPTION',
        '在中世纪解锁。[ICON_Capital] 首都将出现1个吸血鬼单位，允许吸血鬼建造吸血鬼城堡（帝国中最多可建造3座）。'),
       ('zh_Hans_CN', 'LOC_GOVERNOR_PROMOTION_SANGUINE_PACT_3_DESCRIPTION',
        '在文艺复兴时代解锁。[ICON_Capital] 首都将出现1个吸血鬼单位。将吸血鬼城堡建造上限提升至4座。您的吸血鬼现在能恐吓相邻的敌方单位，使其 [ICON_Strength] 战斗力-5。进行掠夺将消耗吸血鬼1点 [ICON_Movement] 移动力。'),
       ('zh_Hans_CN', 'LOC_GOVERNOR_PROMOTION_SANGUINE_PACT_4_DESCRIPTION',
        '在工业时代解锁。[ICON_Capital] 首都将出现1个吸血鬼单位。将吸血鬼城堡建造上限提升至5座。您吸血鬼城堡1单元格范围中的单位现在能瞬移至帝国其中一座吸血鬼城堡附近的任意单元格。'),
       -- 虚空
       ('zh_Hans_CN', 'LOC_GOVERNOR_PROMOTION_VOIDSINGERS_1_DESCRIPTION', '允许建造“纪念碑”的强力替代品：“旧神方尖碑”。发起贸易路线后，目的地立即出现一座贸易站。'),
       ('zh_Hans_CN', 'LOC_GOVERNOR_PROMOTION_VOIDSINGERS_3_DESCRIPTION',
        '在文艺复兴时代解锁。 +1通配符政策槽位。解锁单位“邪教徒”。此单位可用 [ICON_Faith] 信仰值购买，可消耗次数来降低外国城市的忠诚度，并生成 [ICON_GreatWork_Relic] 虚空遗物。'),
       ('zh_Hans_CN', 'LOC_GOVERNOR_PROMOTION_VOIDSINGERS_4_DESCRIPTION',
        '在工业时代解锁。所有城市+10% [ICON_Faith] 信仰值。虚空之音遍及四方（每被解锁一次效果都可以叠加）：所有文明魅力为惊艳的单元格将产出1点 [ICON_Faith] 信仰。解锁“黑暗召唤”。此城市项目在进行时可提供大量 [ICON_Faith] 信仰值，完成后可提升邪教徒造成的忠诚度损失。'),
       ('zh_Hans_CN', 'LOC_BUILDING_OLD_GOD_OBELISK_DESCRIPTION',
        '虚空吟唱者专属，替代纪念碑。若位于首都巨作槽位（可放置任意类型的巨作），使此城市每回合+1忠诚度。如城市已拥有最高忠诚度，则额外+1 [ICON_Culture] 文化值。城市中每个专业化区域+1 [ICON_Faith] 信仰值产出。'),

       --夜莺
       ('zh_Hans_CN', 'LOC_GOVERNOR_PROMOTION_OWLS_OF_MINERVA_1_DESCRIPTION',
        '获得3个 [ICON_Envoy] 使者。+1经济政策槽位。通往城邦的每条 [ICON_TradeRoute] 贸易路线将为此处提供2名 [ICON_Envoy] 使者。发起贸易路线后，目的地立即出现一座贸易站。'),
       ('zh_Hans_CN', 'LOC_GOVERNOR_PROMOTION_OWLS_OF_MINERVA_3_DESCRIPTION',
        '在文艺复兴时代解锁。+1通配符政策槽位。每回合您将获得等同于国库5%的 [ICON_Gold] 金币收入。+2间谍容量。您的间谍处于本方城市的领土中时，城市每回合+4忠诚度、+1 [ICON_Amenities] 宜居度。'),
       ('zh_Hans_CN', 'LOC_GOVERNOR_PROMOTION_OWLS_OF_MINERVA_4_DESCRIPTION',
        '在工业时代解锁。攻击性间谍任务成功后，您还将获得目标城市在此回合获得的 [ICON_Science] 科技值、[ICON_Culture] 文化值、[ICON_Gold] 金币和 [ICON_Faith] 信仰值。通往其他文明的贸易路线+2 [ICON_Production] 生产力，通往城邦的贸易路线+2 [ICON_Faith] 信仰'),
       ('zh_Hans_CN', 'LOC_BUILDING_GILDED_VAULT_DESCRIPTION',
        '弥涅耳瓦夜鹰专属，替代银行。这个商业中心将提供等同于其 [ICON_Gold] 金币相邻加成的 [ICON_CULTURE] 文化值。若此城市至少拥有两个专业化区域，则+1 [ICON_TradeRoute] 贸易路线容量。'),

       -- 黄金
       ('zh_Hans_CN', 'LOC_GOVERNOR_PROMOTION_HERMETIC_ORDER_1_DESCRIPTION', '每回合获得1点大科学家、大工程师点数。发起贸易路线后，目的地立即出现一座贸易站。'),
       ('zh_Hans_CN', 'LOC_GOVERNOR_PROMOTION_HERMETIC_ORDER_2_DESCRIPTION',
        '在中世纪解锁。允许建造“大学”的强力替代品：“炼金术会所”。每回合再获得3点大科学家、大工程师点数。'),
       ('zh_Hans_CN', 'LOC_GOVERNOR_PROMOTION_HERMETIC_ORDER_3_DESCRIPTION',
        '在文艺复兴时代解锁。每获得一名 [ICON_GreatPerson] 伟人，地脉便获得等同于此 [ICON_GreatPerson] 伟人区域类型的+1产出。[ICON_GreatAdmiral] 海军统帅和 [ICON_GreatGeneral] 大将军获得+1 [ICON_Science] 科技值。城市中的区域额外产出1点伟人点数。'),
       ('zh_Hans_CN', 'LOC_GOVERNOR_PROMOTION_HERMETIC_ORDER_4_DESCRIPTION',
        '在工业时代解锁。解锁“秘术研究”。此城市项目在进行时将提供 [ICON_GOLD] 金币。完成时，其将根据城市中的地脉数量提供 [ICON_GreatPerson] 伟人点数和 [ICON_SCIENCE] 科技值。'),

       ('zh_Hans_CN', 'TRAIT_LEADER_MAJOR_CIV_ADD_20',
        '青山一道同风雨'),
       ('zh_Hans_CN', 'LOC_LEADER_TRAIT_NALANDA_DESCRIPTION',
        '您的建造者现在可以建造大寺改良设施。[NEWLINE][NEWLINE]+2 [ICON_SCIENCE] 科技值、+1 [Icon_Housing] 住房。每与1座圣地区域相邻，则+1 [ICON_Faith] 信仰值；每与1座学院区域相邻，则+1 [ICON_Science] 科技值。研究完“科学理论”之后，每与1座学院相邻则额外+1 [Icon_Science] 科技值。玩家建成大寺时将随机获得一项科技，通过这种方式，至多获得三项科技。必须建在平坦地貌上，不能与其他大寺相邻。'),
        ('zh_Hans_CN', 'LOC_IMPROVEMENT_MAHAVIHARA_DESCRIPTION','解锁建造者建造大寺的能力。[NEWLINE][NEWLINE]+2 [ICON_SCIENCE] 科技值、+1 [Icon_Housing] 住房。每与1座圣地区域相邻，则+1 [ICON_Faith] 信仰值；每与1座学院区域相邻，则+1 [ICON_Science] 科技值。研究完“科学理论”之后，每与1座学院相邻则额外+1 [Icon_Science] 科技值。玩家建成大寺时将随机获得一项科技，通过这种方式，至多获得三项科技。必须建在平坦地貌上，不能与其他大寺相邻。'),
        ('zh_Hans_CN',	'LOC_GAME_REALISM_DESCRIPTION',
		'设置自然灾害强度。在0（频率最低、强度最弱）到8（频率最高、强度最高）之间进行选择。注意：如灾难等级大于3，严重的火山喷发可能会对2个格位外的单元格造成破坏。'		);
REPLACE INTO LocalizedText(Language, Tag, Text)
VALUES ('zh_Hans_CN', 'LOC_MOD_PVESAB_DES', '  ·每次触发随机解锁多个结社 结社总督可以提前解锁[NEWLINE]
·地脉变多 可以修建矿山 可以移除和覆盖但是提供的加成会消失[NEWLINE]
·直接显示地脉 所有文明都可以享受地脉加成[NEWLINE]
·解锁黄金黎明 每回合送1点科学家、商人、作家伟人点数[NEWLINE]
·黄金黎明二级总督 每回合再送5点科学家、商人、作家伟人点数[NEWLINE]
·黄金黎明特殊项目所需要的生产力略微减少[NEWLINE]
·解锁夜莺送3个使者 贸易路线提供的使者为2[NEWLINE]
·吸血鬼移速为3 为近战单位可以升级[NEWLINE]
·吸血鬼主动攻击结算后可吸取受到伤害1/4的血量[NEWLINE]
·吸血鬼城堡上限+1 提供4点住房 二级总督解锁[NEWLINE]
·虚空3级: 多一个通配槽[NEWLINE]
·虚空4级: 虚空之音遍及四方（每被解锁一次效果都可以叠加）：所有文明魅力为惊艳的单元格将产出1点 [ICON_Faith] 信仰[NEWLINE]
·夜莺最高等级的效果翻倍 国库利息为5% 镀金宝库提供4点生产力');