INSERT OR
REPLACE
INTO LocalizedText
    (Tag, Language, Text)
VALUES -- FE
       ('LOC_NW_DTMS_NATUREWONDER_REBALANCE_NAME', 'zh_Hans_CN',
        '[COLOR:ChatMessage_Team]枯木逢春[ENDCOLOR] 自然奇观逢春'),
       ('LOC_NW_DTMS_NATUREWONDER_REBALANCE_DESCRIPTION', 'zh_Hans_CN',
        '以罗赖马山为标准，增强一些较为落后的自然奇观。'),
       ('LOC_NW_DTMS_WONDER_REBALANCE_NAME', 'zh_Hans_CN',
        '[COLOR:ChatMessage_Team]枯木逢春[ENDCOLOR] 人造奇观逢春'),
       ('LOC_NW_DTMS_WONDER_REBALANCE_DESCRIPTION', 'zh_Hans_CN',
        '以金字塔为标准，增强一些较为落后的人造奇观。'),

       -- 瑞典
--        ('LOC_TRAIT_CIVILIZATION_NOBEL_PRIZE_DESCRIPTION', 'zh_Hans_CN',
--         '招募伟人时可获得10点 [ICON_Favor] 外交支持（联机速度下）。图书馆获得两个[ICON_GreatWork_Writing]著作槽位，并在戏剧与诗歌市政后+1 [ICON_GreatWriter] 大作家、+1 [ICON_GreatArtist] 大艺术家和+1 [ICON_GreatMusician] 大音乐家点数。建造学院及其建筑时+70% [ICON_PRODUCTION] 生产力。如瑞典在游戏中，进入工业时代后将增添3项特色世界议会竞赛。'),

       -- 朝鲜
--        ('LOC_TRAIT_LEADER_HWARANG_DESCRIPTION', 'zh_Hans_CN',
--         '[ICON_Governor] 总督在城市中就职后，每次升级（包括首次升级）都将提供+3% [ICON_Culture] 文化值和+2% [ICON_Science] 科技值。政治哲学市政后，拥有 [ICON_Governor] 总督的城市额外+1 [ICON_Culture] 文化值和+1 [ICON_Science] 科技值。'),

       -- 伯里克利
--        ('LOC_TRAIT_LEADER_SURROUNDED_BY_GLORY_DESCRIPTION', 'zh_Hans_CN',
--         '每回合的 [ICON_Culture] 文化值+5%。作为宗主国时，每个下辖的城邦使您的 [ICON_Culture] 文化值和 [ICON_Tourism] 旅游业绩+5%。卫城从每个相邻区域+1 [ICON_PRODUCTION] 生产力。'),
--        ('LOC_DISTRICT_ACROPOLIS_ADD_PRODUCTION', 'zh_Hans_CN',
--         '+{1_Num} [ICON_PRODUCTION] 生产力来自相邻区域。'),

       -- 印尼
       ('LOC_TRAIT_LEADER_EXALTED_GODDESS_DESCRIPTION', 'zh_Hans_CN',
        '可用 [ICON_FAITH] 信仰值购买海军单位。沿海城市建造圣地时+75% [ICON_PRODUCTION] 生产力。拥有圣地的城市使用 [ICON_FAITH] 信仰值购买海军单位-10%花费。宗教单位上船下船时无移动力消耗。与海岸或湖泊单元格相邻的市中心+2 [ICON_FAITH] 信仰值。'),
       -- 毛利
       -- ('LOC_TRAIT_LEADER_KUPES_VOYAGE_DESCRIPTION', 'zh_Hans_CN',
       -- 宫殿+3 [ICON_HOUSING] 住房与+1 [ICON_AMENITIES] 宜居度。建立首座城市前每回合+3 [ICON_Science] 科技值、+7 [ICON_Gold] 金币值与+1 [ICON_Culture] 文化值。'),
       -- 努比亚
--        ('LOC_IMPROVEMENT_PYRAMID_DESCRIPTION', 'zh_Hans_CN',
--         '砌砖解锁建造者建造努比亚特色改良设施努比亚金字塔的能力。建在沙漠、沙漠丘陵，草原，平原，丘陵或泛滥平原上。+2 [ICON_Faith] 信仰值， +1 [ICON_Food] 食物。+0.5 [ICON_Housing] 住房。可从相邻区域获得额外产出。如与市中心相邻+1 [ICON_Food] 食物。如与其他任意提供相邻加成的区域相邻，对应产出+2。相邻娱乐中心时为城市+1 [ICON_Amenities] 宜居度，每个城市至多从努比亚金字塔+2 [ICON_Amenities] 宜居度。不能与另一个金字塔相邻。'),
       -- 刚果

--        ('LOC_TRAIT_LEADER_RELIGIOUS_CONVERT_DESCRIPTION', 'zh_Hans_CN',
--         '无法建造圣地区、获得大预言家，或创建宗教。获得刚果信仰的主流宗教的所有信仰加成。每次完成一个姆班赞或剧院广场区时获得一位（城市主流宗教的）使徒。招募首个伟人，或者首次采用更高一级的政体后获得1个 [ICON_GreatWork_Relic] 遗物。所有近战单位在防御远程攻击时+3 [ICON_Strength] 战斗力。'),
--        ('LOC_TRAIT_LEADER_NZINGA_MBANDE_DESCRIPTION', 'zh_Hans_CN',
--         '[ICON_Capital] 首都和与 [ICON_Capital] 首都处于同一大陆的城市+5%除 [ICON_FOOD] 食物外的产出，并且城市发展速率+5%'),

       -- 匈牙利
       ('LOC_BUILDING_THERMAL_BATH_DESCRIPTION', 'zh_Hans_CN',
        '匈牙利特色建筑，解锁于动员。+2点 [ICON_Amenities] 宜居度与+2点 [ICON_PRODUCTION] 生产力，可扩展到6个单元格内的每个市中心。城市仅能应用1次此类加成，因此市中心6个单元格以内相同的此建筑不会再额外提供加成。此城中若包含至少1处地热裂缝，则该城市的 [ICON_TOURISM] 旅游业绩+3，同时 [ICON_AMENITIES] 宜居度额外+2。[NEWLINE][NEWLINE]不能建造在已拥有动物园的娱乐中心区域中。'),
       ('LOC_TRAIT_CIVILIZATION_PEARL_DANUBE_DESCRIPTION', 'zh_Hans_CN',
        '在市中心河对岸修建区域与建筑时+50% [ICON_PRODUCTION] 生产力。建立 [ICON_Capital] 首都前开拓者无视河流的移动力减益。'),

       -- 文德
       ('LOC_TRAIT_LEADER_LUDWIG_DESCRIPTION', 'zh_Hans_CN',
        '已建成的奇观提供+3 [ICON_CULTURE] 文化值。市中心和每个已建成的专业化区域为该城的奇观+4% [ICON_PRODUCTION] 生产力，最多+16%。'),
       -- 日本
       -- 北条
       ('LOC_TRAIT_LEADER_DIVINE_WIND_EXPANSION2_DESCRIPTION', 'zh_Hans_CN',
        '相邻海岸的陆地单位和海岸上的海军单位+2 [ICON_Strength] 战斗力。[NEWLINE]如果首都相邻海岸，则所有城市建造港口时+80% [ICON_PRODUCTION] 生产力。[NEWLINE]如果首都不相邻海岸，则所有城市建造圣地和商业中心时+55% [ICON_PRODUCTION] 生产力。'),
       ('LOC_TRAIT_CIVILIZATION_ADJACENT_DISTRICTS_DESCRIPTION', 'zh_Hans_CN',
        '除了商业中心、港口，区域与区域相邻时额外获得少量相邻加成。首个开拓者的首次移动+1 [ICON_MOVEMENT] 移动力、无视地形地貌的移动力减益。'),
       ('LOC_ABILITY_NW_JP_UNIT_SETTLE_NAME', 'zh_Hans_CN',
        '+1 [ICON_MOVEMENT] 移动力、无视地形地貌的移动力减益。'),

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
        '[ICON_CAPITAL] 首都所在大陆上的单位从市政广场及其建筑获得+1 [ICON_Strength] 战斗力；[ICON_CAPITAL] 首都所在大陆以外的单位从外交区及其建筑获得+1 [ICON_Strength] 战斗力。建成市政广场和外交区后，+1 [ICON_TradeRoute] 贸易路线容量。如与城邦之间存在 [ICON_TradeRoute] 贸易路线，派往此处的1位 [ICON_Envoy] 使者将视为2位。人文主义市政后，额外获得一个通配符槽位。军事学后获得特色单位“莽骑兵”。'),

       ('LOC_PROMOTION_COMBAT_HOME_CONTINENT_DESCRIPTION', 'zh_Hans_CN',
        '+{Property} 来着罗斯福推论（同大陆）。'),
       ('LOC_ROOSEVELT_COMBAT_BONUS_FOREIGN_CONTINENT', 'zh_Hans_CN',
        '+{Property} 来着罗斯福推论（异大陆）。'),
       ('LOC_ABILITY_ROOSEVELT_COMBAT_BONUS_HOME_CONTINENT_DESCRIPTION', 'zh_Hans_CN',
        '[ICON_CAPITAL] 首都所在大陆上的单位从每个市政广场及其建筑获得+1 [ICON_Strength] 战斗力；[ICON_CAPITAL] 首都所在大陆以外的单位从每个外交区及其建筑获得+1 [ICON_Strength] 战斗力。'),
       -- 苏格兰
       ('LOC_TRAIT_CIVILIZATION_SCOTTISH_ENLIGHTENMENT_DESCRIPTION', 'zh_Hans_CN',
        '每3位 [ICON_CITIZEN] 公民消耗1 [ICON_AMENITIES] 宜居度，而非通常的2位。快乐的城市+5% [ICON_SCIENCE] 科技值和 [ICON_PRODUCTION] 生产力。欣喜若狂的城市，上述加成翻倍。'),
       ('LOC_IMPROVEMENT_GOLF_COURSE_XP2_DESCRIPTION', 'zh_Hans_CN',
        '解锁建造者建造苏格兰特色改良设施高尔夫球场的能力。[NEWLINE][NEWLINE]+1 [ICON_AMENITIES] 宜居度、+3 [ICON_GOLD] 金币。如与市中心区域相邻，则+1 [ICON_CULTURE] 文化值；如与娱乐设施区域相邻，则+1 [ICON_CULTURE] 文化值。解锁更多市政和科技后可获得更多 [ICON_TOURISM] 旅游业绩和 [ICON_HOUSING] 住房。无法建在沙漠或沙漠丘陵地貌上。每座城市仅限建造一座。拥有高尔夫球场的单元格无法切换。+1魅力。'),

       -- 埃莉诺
       -- 爱英
       ('LOC_TRAIT_LEADER_ELEANOR_LOYALTY_DESCRIPTION', 'zh_Hans_CN',
        '[ICON_GreatWork_Writing]著作、[ICON_GreatWork_Religious]宗教、[ICON_GreatWork_Portrait]肖像、[ICON_GreatWork_Landscape]风景、[ICON_GreatWork_Sculpture]雕塑和[ICON_GreatWork_Music]音乐+3 [ICON_Science] 科技值。巨作对9个单元格内的外国城市施加3点忠诚度压力。因埃莉诺的忠诚度压力而叛乱的城市将直接加入埃莉诺的文明。建造剧院广场及其建筑时+25% [ICON_PRODUCTION] 生产力。若解锁“戏剧与诗歌”市政，则获得一名免费的 [ICON_GreatWriter] 大作家。'),
       -- 爱法
       ('LOC_TRAIT_LEADER_ELEANOR_FRANCE_LOYALTY_TEAM_PVP_DESCRIPTION', 'zh_Hans_CN',
        '[ICON_GreatWork_Writing]著作、[ICON_GreatWork_Religious]宗教、[ICON_GreatWork_Portrait]肖像、[ICON_GreatWork_Landscape]风景、[ICON_GreatWork_Sculpture]雕塑和[ICON_GreatWork_Music]音乐+3 [ICON_Science] 科技值。巨作对9个单元格内的外国城市施加3点忠诚度压力。因埃莉诺的忠诚度压力而叛乱的城市将直接加入埃莉诺的文明。建造剧院广场及其建筑时+25% [ICON_PRODUCTION] 生产力。若解锁“戏剧与诗歌”市政，则获得一名免费的 [ICON_GreatWriter] 大作家、两项随机 [ICON_CivicBoosted] 鼓舞。'),
       --金法
       ('LOC_TRAIT_LEADER_MAGNIFICENCES_DESCRIPTION', 'zh_Hans_CN',
        '拥有写作和法典后解锁剧院广场。剧院广场从奢侈品单元格获得标准相邻加成，戏剧与诗歌市政后翻倍。可在拥有剧院广场区域的任意城市中开展“宫廷盛会”项目。建造剧院广场及其建筑时+45% [ICON_PRODUCTION] 生产力。'),
       ('LOC_TRAIT_LEADER_MAGNIFICENCES_THEATER', 'zh_Hans_CN',
        '+{1_Num} [ICON_CULTURE]文化值来自相邻的奢侈品单元格。');

