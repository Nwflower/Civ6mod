INSERT OR
REPLACE
INTO LocalizedText
    (Tag, Language, Text)
VALUES -- 文德
       ('LOC_TRAIT_LEADER_LUDWIG_DESCRIPTION', 'zh_Hans_CN',
        '已建成的奇观提供+3 [ICON_CULTURE] 文化值。市中心和每个已建成的专业化区域为该城的奇观+4% [ICON_PRODUCTION] 生产力，最多+16%。'),
       -- 埃塞
       ('LOC_TRAIT_LEADER_MENELIK_DESCRIPTION', 'zh_Hans_CN',
        '建在丘陵上的城市，城市获得等同于所产生 [ICON_FAITH] 信仰值7%的 [ICON_SCIENCE] 科技值和3% [ICON_CULTURE] 文化值。轻骑兵+1视野。位于丘陵之上的军事单位额外+3 [ICON_STRENGTH] 战斗力，平民单位+1视野+1 [ICON_MOVEMENT] 移动力。若还没建立城市，开拓者在丘陵地貌时不遭受移动力减益。'),
       ('LOC_UNIT_ETHIOPIAN_OROMO_CAVALRY_EXPANSION2_DESCRIPTION', 'zh_Hans_CN',
        '埃塞俄比亚特色中世纪轻骑兵单位。替代追猎者，战斗力更强。在丘陵中移动时无 [ICON_Movement] 移动力减益。'),
       --格鲁吉亚
       ('LOC_TRAIT_CIVILIZATION_GOLDEN_AGE_QUESTS_DESCRIPTION', 'zh_Hans_CN',
        '在黄金或英雄时代初期设置着力点时，除原有加成外还将获得提高时代得分的普通时代加成。建造防御性建筑时+50[ICON_Production] 生产力。若解锁防御战术市政，每个城市赠送一个市中心建筑。'),
       -- 阿拉伯
       ('LOC_TRAIT_CIVILIZATION_LAST_PROPHET_DESCRIPTION', 'zh_Hans_CN',
        '阿拉伯的圣城提供+1 [ICON_TRADEROUTE] 贸易路线容量，且圣城训练的宗教单位具有一次额外的传教次数。以阿拉伯圣城为终点的 [ICON_TRADEROUTE] 国际贸易路线为起源城市+2 [ICON_GOLD] 金币，为阿拉伯+2 [ICON_FAITH] 信仰值。当倒数第二个 [ICON_GreatProphet] 预言家被招募后（如果您尚未获得 [ICON_GreatProphet] 大预言家），自动获得最后一个大预言家。每座信奉阿拉伯宗教的外国城市+1 [ICON_Science] 科技值。'),
       ('LOC_BUILDING_NW_ALBERT_HOLY_CITY_NAME', 'zh_Hans_CN',
        '麦加朝圣'),

       -- 文美
       ('LOC_TRAIT_LEADER_ANTIQUES_AND_PARKS_DESCRIPTION', 'zh_Hans_CN',
        '首次建成保护区时，[ICON_CAPITAL] 首都获得一个免费的自然学家。拥有国家公园的城市单元格+1魅力值。神秘主义市政后，惊艳单元格+1 [ICON_SCIENCE] 科技值，相邻保护区的未改良惊艳单元格+1 [ICON_PRODUCTION] 生产力。无视前置市政要求，可以在相邻保护区的单元格上栽种树林。'),
       ('LOC_ABILITY_NW_CANNOT_PLANT_FOREST_BUT_ADJACENT_PRESERVE_DESCRIPTION', 'zh_Hans_CN',
        '可以在相邻保护区的单元格上栽种树林。'),

       -- 武美
       ('LOC_TRAIT_LEADER_ROOSEVELT_COROLLARY_ROUGH_RIDER_DESCRIPTION', 'zh_Hans_CN',
        '[ICON_CAPITAL] 首都所在大陆上的单位从市政广场及其建筑获得+1 [ICON_Strength] 战斗力；[ICON_CAPITAL] 首都所在大陆以外的单位从外交区及其建筑获得+1 [ICON_Strength] 战斗力。建成市政广场和外交区后，+1 [ICON_TradeRoute] 贸易路线容量。如与城邦之间存在 [ICON_TradeRoute] 贸易路线，派往此处的1位 [ICON_Envoy] 使者将视为2位。人文主义市政后，额外获得一个通配符槽位。膛线后获得特色单位“莽骑兵”。'),

       ('LOC_PROMOTION_COMBAT_HOME_CONTINENT_DESCRIPTION', 'zh_Hans_CN',
        '+{Property} 来着罗斯福推论（同大陆）。'),
       ('LOC_ROOSEVELT_COMBAT_BONUS_FOREIGN_CONTINENT', 'zh_Hans_CN',
        '+{Property} 来着罗斯福推论（异大陆）。'),
       ('LOC_ABILITY_ROOSEVELT_COMBAT_BONUS_HOME_CONTINENT_DESCRIPTION', 'zh_Hans_CN',
        '[ICON_CAPITAL] 首都所在大陆上的单位从每个市政广场及其建筑获得+1 [ICON_Strength] 战斗力；[ICON_CAPITAL] 首都所在大陆以外的单位从每个外交区及其建筑获得+1 [ICON_Strength] 战斗力。'),
       -- 苏格兰
       ('LOC_TRAIT_CIVILIZATION_SCOTTISH_ENLIGHTENMENT_DESCRIPTION', 'zh_Hans_CN',
        '每3位 [ICON_CITIZEN] 公民消耗1 [ICON_AMENITIES] 宜居度，而非通常的2位。快乐的城市+5% [ICON_SCIENCE] 科技值和 [ICON_PRODUCTION] 生产力。欣喜若狂的城市，上述加成翻倍。'),
       -- 埃莉诺
       ('LOC_TRAIT_LEADER_ELEANOR_LOYALTY_DESCRIPTION', 'zh_Hans_CN',
        '[ICON_GreatWork_Writing]著作、[ICON_GreatWork_Religious]宗教、[ICON_GreatWork_Portrait]肖像、[ICON_GreatWork_Landscape]风景、[ICON_GreatWork_Sculpture]雕塑和[ICON_GreatWork_Music]音乐+3 [ICON_Science] 科技值。巨作对9个单元格内的外国城市施加3点忠诚度压力。因埃莉诺的忠诚度压力而叛乱的城市将直接加入埃莉诺的文明。建造剧院广场建筑时+25% [ICON_PRODUCTION] 生产力。若解锁“戏剧与诗歌”市政，则获得一名免费的 [ICON_GreatWriter] 大作家。'),
       ('LOC_TRAIT_LEADER_ELEANOR_FRANCE_LOYALTY_TEAM_PVP_DESCRIPTION', 'zh_Hans_CN',
        '[ICON_GreatWork_Writing]著作、[ICON_GreatWork_Religious]宗教、[ICON_GreatWork_Portrait]肖像、[ICON_GreatWork_Landscape]风景、[ICON_GreatWork_Sculpture]雕塑和[ICON_GreatWork_Music]音乐+3 [ICON_Science] 科技值。巨作对9个单元格内的外国城市施加3点忠诚度压力。因埃莉诺的忠诚度压力而叛乱的城市将直接加入埃莉诺的文明。建造剧院广场及其建筑时+25% [ICON_PRODUCTION] 生产力。若解锁“戏剧与诗歌”市政，则获得一名免费的 [ICON_GreatWriter] 大作家。招募伟人时随机获得两项 [ICON_CivicBoosted] 鼓舞。'),
       --金法
       ('LOC_TRAIT_LEADER_MAGNIFICENCES_DESCRIPTION', 'zh_Hans_CN',
        '拥有写作和法典后解锁剧院广场。剧院广场从奢侈品获得大量相邻加成。可在拥有剧院广场区域的任意城市中开展“宫廷盛会”项目。建造剧院广场及其建筑时+45% [ICON_PRODUCTION] 生产力。'),
       ('LOC_TRAIT_LEADER_MAGNIFICENCES_THEATER', 'zh_Hans_CN',
        '+{1_Num} [ICON_CULTURE]文化值来自相邻的奢侈品单元格。');
