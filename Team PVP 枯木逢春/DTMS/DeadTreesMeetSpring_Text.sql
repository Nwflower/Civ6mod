INSERT OR
REPLACE
INTO LocalizedText
    (Tag, Language, Text)
VALUES -- FE
       ('LOC_NW_DTMS_CAC_REBALANCE_NAME', 'zh_Hans_CN',
        '[COLOR:ChatMessage_Team]枯木逢春[ENDCOLOR] 炼金杯额外配置'),
       ('LOC_NW_DTMS_CAC_REBALANCE_DESCRIPTION', 'zh_Hans_CN',
        '外交部（市政二级建筑）[NEWLINE]---------------[NEWLINE]重做效果：[NEWLINE]{LOC_CAC_BUILDING_GOV_CITYSTATES_EXPANSION2_DESCRIPTION}'),
       ('LOC_CAC_BUILDING_GOV_CITYSTATES_EXPANSION2_DESCRIPTION', 'zh_Hans_CN',
        '作为国际贸易路线的目的地，为起源城市+2 [ICON_Gold] 金币。+1 [ICON_tradeRoute] 贸易路线容量。同盟等级更快提高（每回合+1[COLOR:ResCultureLabelCS]同盟点数[ENDCOLOR]）。敌方间谍以己方城市为目标时，其效力降低一级。[NEWLINE]奖励1个 [Icon_Governor] 总督头衔。'),


        -- 玛雅
--        ('LOC_TRAIT_LEADER_MUTAL_DESCRIPTION', 'zh_Hans_CN',
--         '[ICON_Capital] 首都6单元格范围内的非首都城市所有产出+5%。其他非首都城市的所有产出-10%。[ICON_Capital] 首都6单元格范围内的单位+2 [ICON_Strength] 战斗力。如果当前回合数恰能被2整除，则[ICON_Capital] 首都6单元格范围内的城市生产军事单位时+7% [ICON_Production] 生产力；反之，[ICON_Capital] 首都6单元格范围内的城市生产建造者时+14% [ICON_Production] 生产力。'),

        -- 印加
       ('LOC_TRAIT_LEADER_PACHACUTI_QHAPAQ_NAN_DESCRIPTION', 'zh_Hans_CN',
        '起始城市中的每座山脉单元格为国内 [ICON_TradeRoute] 贸易路线提供+1 [ICON_Food] 食物。侦查单位可以使用自身的高 [ICON_Movement] 移动力护送平民单位。“对外贸易”市政后可获得一个侦察兵，并解锁印加路网改良设施。'),

        -- 祖鲁
       ('LOC_DISTRICT_IKANDA_DESCRIPTION', 'zh_Hans_CN',
        '祖鲁特色区域，替代军营。提供 +1 [ICON_Housing] 住房。满足市政或科技先决条件后即可创建军团和军队。建成时提供一个枪兵。伊坎达中的建筑+1 [ICON_SCIENCE] 科技值。城市中的兵营额外+1 [ICON_CULTURE] 文化值，马厩+1 [ICON_SCIENCE] 科技值。可加快军团和军队的创建速度。'),

       -- 马其顿
       ('LOC_TRAIT_LEADER_TO_WORLDS_END_DESCRIPTION', 'zh_Hans_CN',
        '城市不会产生厌战情绪。此玩家占领拥有世界奇观的城市时，所有军事单位的体力值将完全恢复。首次建成皇家学堂后，[ICON_Capital]首都获得亚历山大大帝。每回合获得的基础同盟点数+50%。'),
       ('LOC_LEADER_NW_ALEXANDER_DESCRIPTION', 'zh_Hans_CN',
        '亚历山大特色大将军单位。为2个单元格范围内的古典时代、中世纪和文艺复兴时期的单位+5 [ICON_Strength] 战斗力、+1 [ICON_Movement] 移动力，不会和完全相同的效果同时生效。可在城邦进行隐退，为玩家永久提供该城邦的宗主国加成效果。'),
       ('LOC_GREAT_PERSON_INDIVIDUAL_ALEXANDER_ACTION_TEXT', 'zh_Hans_CN',
        '永久提供该城邦的宗主国加成效果。'),
       ('LOC_LEADER_NW_ALEXANDER_NAME', 'zh_Hans_CN',
        '亚历山大大帝'),

       -- 阿兹特克
       ('LOC_TRAIT_LEADER_GIFTS_FOR_TLATOANI_DESCRIPTION', 'zh_Hans_CN',
        '其领土中的奢侈品资源为额外2座城市提供1点 [ICON_Amenities] 宜居度。阿兹特克的军队在进攻时+3 [ICON_Strength] 战斗力，在拥有迷人魅力的单元格上防御时+1 [ICON_Strength] 战斗力，进攻魅力值不足迷人的单元格上的单位时额外+1 [ICON_Strength] 战斗力。'),
       ('LOC_ABILITY_NW_AZTK_DESCRIPTION', 'zh_Hans_CN',
        '在拥有迷人魅力的单元格上防御时+1 [ICON_Strength] 战斗力，进攻魅力值不足迷人的单元格上的单位时额外+1 [ICON_Strength] 战斗力。'),
       ('LOC_MODIFIER_ABILITY_NW_AZTK_ADD_COMBAT', 'zh_Hans_CN',
        '+{Property} [ICON_Strength] 战斗力来自单元格魅力值。'),
       ('LOC_BUILDING_TLACHTLI_XP1_DESCRIPTION', 'zh_Hans_CN',
        '阿兹特克特色建筑。提供2点 [ICON_Amenities] 宜居度、+3 [ICON_Culture] 文化值、+2 [ICON_Faith] 信仰值，并提供2点 [ICON_GreatGeneral] 大将军点数。城市新训练的建造者可以建造一个额外的改良设施。采用“保护地球”市政后，提供的 [ICON_TOURISM] 旅游业绩+1。'),

       -- 瑞典
       ('LOC_TRAIT_LEADER_KRISTINA_AUTO_THEME_DESCRIPTION', 'zh_Hans_CN',
        '全部槽位填满时，拥有3个或以上巨作槽位的建筑和2个或以上巨作槽位的奇观可自动获得主题。图书馆拥有2个 [ICON_GreatWork_Writing] 著作类巨作槽位。大学额外提供+1 [ICON_GreatWriter] 大作家点数、+1 [ICON_GreatArtist] 大艺术家点数和+1 [ICON_GreatMusician] 大音乐家点数。可在市政广场中建造女王图书馆。'),
       ('LOC_TRAIT_CIVILIZATION_NOBEL_PRIZE_DESCRIPTION', 'zh_Hans_CN',
        '瑞典招募伟人时可获得10点 [ICON_Favor] 外交支持（联机速度下）。学院建筑提供的 [ICON_PRODUCTION] 生产力等于其固定产出50%的基础 [ICON_SCIENCE] 科技值、工作坊+2 [ICON_SCIENCE] 科技值，并在建造工业、学院区域和建筑时+35% [ICON_PRODUCTION] 生产力。如瑞典在游戏中，进入工业时代后将增添3项特色世界议会竞赛。'),
       ('LOC_BUILDING_QUEENS_BIBLIOTHEQUE_DESCRIPTION', 'zh_Hans_CN',
        '瑞典特色建筑。该建筑可以放置2个 [ICON_GreatWork_WRITING] 著作、3个 [ICON_GreatWork_Landscape] 艺术巨作。'),

       -- 大哥伦比亚
       ('LOC_TRAIT_CIVILIZATION_EJERCITO_PATRIOTA_DESCRIPTION', 'zh_Hans_CN',
        '在总指挥2个单元格范围内开始回合时，建造者和其他的总指挥单位+1 [ICON_MOVEMENT] 移动力。升级单位不会结束其回合。'),
       ('LOC_ABILITY_UNIT_COMANDANTE_GENERAL_DESCRIPTION', 'zh_Hans_CN',
        '2个单元格内的总指挥和建造者开始回合时+1 [ICON_MOVEMENT] 移动力。升级单位不会结束其回合。'),

       -- 朝鲜
       ('LOC_TRAIT_LEADER_HWARANG_DESCRIPTION', 'zh_Hans_CN',
        '城市从就职 [ICON_Governor] 总督的每次升级（包括首次升级）中获得+3% [ICON_Culture] 文化值、+3% [ICON_Gold] 金币、+2% [ICON_Science] 科技值、+2% [ICON_Faith] 信仰值、+1% [ICON_Production] 生产力和+1% [ICON_Food] 食物。'),

       -- 文秦
       ('LOC_TRAIT_LEADER_QIN_NAME', 'zh_Hans_CN',
        '千古一帝'),

       -- 武秦
       ('LOC_TRAIT_LEADER_QIN_ALT_NAME', 'zh_Hans_CN',
        '山河秦制'),
       ('LOC_TRAIT_LEADER_QIN_ALT_DESCRIPTION', 'zh_Hans_CN',
        '可晋升的近战攻击单位在击败敌方单位后有几率将其俘获为军事工程师。除非拥有军事工程学科技，否则军事工程师的使用次数-1。所有近战攻击单位+1 [ICON_Strength] 战斗力，若解锁“防御战术”市政，则提升至+2 [ICON_Strength] 战斗力。'),

       -- 伯里克利
       ('LOC_TRAIT_LEADER_SURROUNDED_BY_GLORY_DESCRIPTION', 'zh_Hans_CN',
        '每回合的 [ICON_Culture] 文化值+6%。作为宗主国时，每个下辖的城邦使您的 [ICON_Culture] 文化值和 [ICON_Tourism] 旅游业绩+4%。卫城从每个相邻区域+1 [ICON_PRODUCTION] 生产力。'),
       ('LOC_DISTRICT_ACROPOLIS_ADD_PRODUCTION', 'zh_Hans_CN',
        '+{1_Num} [ICON_PRODUCTION] 生产力来自相邻区域。'),

       -- 印尼
       ('LOC_TRAIT_LEADER_EXALTED_GODDESS_DESCRIPTION', 'zh_Hans_CN',
        '沿海城市建造圣地时+80% [ICON_PRODUCTION] 生产力。相邻圣地的港口的相邻加成也提供 [ICON_FAITH] 信仰值。可以-15%的花费用 [ICON_FAITH] 信仰值购买海军单位。宗教单位上船下船时无移动力消耗。与海岸或湖泊单元格相邻的市中心+2 [ICON_FAITH] 信仰值。'),
       ('LOC_TRAIT_CIVILIZATION_INDONESIA_NUSANTARA_DESCRIPTION', 'zh_Hans_CN',
        '海岸和湖泊单元格可为圣地提供标准相邻加成，为学院、工业区和剧院广场提供少量相邻加成。如与海岸或湖泊单元格相邻，娱乐中心+1 [ICON_AMENITIES] 宜居度。'),

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
        '首次建成保护区时，[ICON_CAPITAL] 首都获得一个免费的自然学家。拥有国家公园的城市单元格+1魅力值。神秘主义市政后，未改良惊艳单元格+1 [ICON_SCIENCE] 科技值，相邻山脉则额外+1 [ICON_PRODUCTION] 生产力。无视前置市政要求，可以在相邻保护区的单元格上栽种树林。'),
       ('LOC_ABILITY_NW_CANNOT_PLANT_FOREST_BUT_ADJACENT_PRESERVE_DESCRIPTION', 'zh_Hans_CN',
        '可以在相邻保护区的单元格上栽种树林。'),

       -- 武美
       ('LOC_TRAIT_LEADER_ROOSEVELT_COROLLARY_ROUGH_RIDER_DESCRIPTION', 'zh_Hans_CN',
        '[ICON_CAPITAL] 首都所在大陆上的单位从市政广场及其建筑获得+1 [ICON_Strength] 战斗力；[ICON_CAPITAL] 首都所在大陆以外的单位从外交区及其建筑获得+1 [ICON_Strength] 战斗力。市政广场及外交区各提供+1 [ICON_TradeRoute] 贸易路线容量。如与城邦之间存在 [ICON_TradeRoute] 贸易路线，派往此处的1位 [ICON_Envoy] 使者将视为2位。人文主义市政后，额外获得一个通配符槽位。军事学后解锁特色单位“莽骑兵”。'),

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
        '拥有帝国初期市政后解锁剧院广场。剧院广场从奢侈品单元格获得标准相邻加成，戏剧与诗歌市政后翻倍。可在拥有剧院广场区域的任意城市中开展“宫廷盛会”项目。建造剧院广场及其建筑时+45% [ICON_PRODUCTION] 生产力。'),
       ('LOC_TRAIT_LEADER_MAGNIFICENCES_THEATER', 'zh_Hans_CN',
        '+{1_Num} [ICON_CULTURE]文化值来自相邻的奢侈品单元格。');


-----------------------------------------------------------------------  魔女环境下伟人修改  -----------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS TeamPVPGPN
(
    Tag  TEXT NOT NULL PRIMARY KEY,
    Text TEXT
);
INSERT OR
REPLACE INTO TeamPVPGPN(Tag, Text)
VALUES ('LOC_GREAT_PERSON_INDIVIDUAL_JOHANN_SEBASTIAN_BACH_NAME', '千川白浪'),
       ('LOC_PEDIA_GREATPEOPLE_PAGE_GREAT_PERSON_INDIVIDUAL_JOHANN_SEBASTIAN_BACH_CHAPTER_HISTORY_PARA_1', '金牌成就'),
       ('LOC_PEDIA_GREATPEOPLE_PAGE_GREAT_PERSON_INDIVIDUAL_JOHANN_SEBASTIAN_BACH_CHAPTER_HISTORY_PARA_2',
        '作为炼金系列模组的官方主创Modder，创作了众多魔女环境下的好评如潮的模组。他在未来又能创作出哪些模组？让我们拭目以待。'),
       ('LOC_PEDIA_GREATPEOPLE_PAGE_GREAT_PERSON_INDIVIDUAL_JOHANN_SEBASTIAN_BACH_CHAPTER_HISTORY_PARA_3', ''),
       ('LOC_GREATWORK_BACH_1_NAME', '世界歧路'),
       ('LOC_GREATWORK_BACH_2_NAME', '枯木逢春');

INSERT OR
REPLACE INTO LocalizedText(Tag, Language, Text)
SELECT Tag,
       'zh_Hans_CN',
       Text
FROM TeamPVPGPN
WHERE EXISTS (SELECT 1
              FROM LocalizedText
              WHERE Tag = 'LOC_GREAT_PERSON_INDIVIDUAL_IMHOTEPI_NAME'
                AND Text = '号码菌');


