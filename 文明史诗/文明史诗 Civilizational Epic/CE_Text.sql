 INSERT OR
REPLACE INTO LocalizedText ( Tag, Language, Text )
 VALUES
     -- =============================================================
     -- Civilizations
     -- =============================================================
     -- 文美
     ( 'LOC_TRAIT_LEADER_ANTIQUES_AND_PARKS_DESCRIPTION', 'zh_Hans_CN',
       '首次建成保护区时，[ICON_CAPITAL] 首都获得一个免费的自然学家。拥有国家公园的城市单元格+1魅力值。神秘主义市政后，未改良惊艳单元格+1 [ICON_SCIENCE] 科技值、+1 [ICON_GOLD] 金币。无视前置市政要求，可以在相邻保护区的单元格上栽种树林。' ),
     ( 'LOC_ABILITY_NW_CANNOT_PLANT_FOREST_BUT_ADJACENT_PRESERVE_DESCRIPTION', 'zh_Hans_CN',
       '可以在相邻保护区的单元格上栽种树林。' ),
     -- 武美
     ( 'LOC_TRAIT_LEADER_ROOSEVELT_COROLLARY_ROUGH_RIDER_DESCRIPTION', 'zh_Hans_CN',
       '[ICON_CAPITAL] 首都所在大陆上的单位从市政广场及其建筑获得+1 [ICON_Strength] 战斗力；[ICON_CAPITAL] 首都所在大陆以外的单位从外交区及其建筑获得+1 [ICON_Strength] 战斗力。市政广场及外交区各提供+1 [ICON_TradeRoute] 贸易路线容量。如与城邦之间存在 [ICON_TradeRoute] 贸易路线，派往此处的1位 [ICON_Envoy] 使者将视为2位。人文主义市政后，额外获得一个通配符槽位。军事学后解锁特色单位“莽骑兵”。' ),
     ( 'LOC_PROMOTION_COMBAT_HOME_CONTINENT_DESCRIPTION', 'zh_Hans_CN',
       '+{Property} 来自罗斯福推论（同大陆）。' ),
     ( 'LOC_ROOSEVELT_COMBAT_BONUS_FOREIGN_CONTINENT', 'zh_Hans_CN',
       '+{Property} 来自罗斯福推论（异大陆）。' ),
     ( 'LOC_ABILITY_ROOSEVELT_COMBAT_BONUS_HOME_CONTINENT_DESCRIPTION', 'zh_Hans_CN',
       '[ICON_CAPITAL] 首都所在大陆上的单位从每个市政广场及其建筑获得+1 [ICON_Strength] 战斗力；[ICON_CAPITAL] 首都所在大陆以外的单位从每个外交区及其建筑获得+1 [ICON_Strength] 战斗力。' ),
     -- 林肯
     ( 'LOC_TRAIT_LEADER_LINCOLN_EXPANSION_DESCRIPTION', 'zh_Hans_CN',
       '相邻工业区的种植园额外提供+2 [ICON_Amenities] 宜居度、+1住房，否则-2忠诚度。建造工业区、水渠时+100% [ICON_Production] 生产力。建造工业区和其建筑后获得1个免费近战单位，免费单位的生成或维护不需要资源。若城市拥有工业区，则为其训练的近战单位提供+3 [ICON_Strength] 战斗力。' ),

     -- 阿拉伯
     ( 'LOC_TRAIT_CIVILIZATION_LAST_PROPHET_NAME', 'zh_Hans_CN',
       '一千零一夜' ),
     ( 'LOC_TRAIT_CIVILIZATION_LAST_PROPHET_DESCRIPTION', 'zh_Hans_CN',
       '创建宗教后+1 [ICON_TRADEROUTE] 贸易路线容量，并获得一个 [ICON_GreatWriter] 大作家。[ICON_GreatWork_Writing] 著作类巨作提供等同于其 [ICON_CULTURE] 文化值产出的 [ICON_FAITH] 信仰值。每座信奉阿拉伯宗教的外国城市+1 [ICON_Science] 科技值。' ),
     -- 萨拉丁（维齐尔）
     ( 'LOC_TRAIT_LEADER_RIGHTEOUSNESS_OF_FAITH_DESCRIPTION', 'zh_Hans_CN',
       '在信仰阿拉伯的宗教的城市，所有玩家都可以免费购买宗教祭祀建筑。拥有祭祀建筑的阿拉伯城市每回合产出的 [ICON_Science] 科技值、 [ICON_Faith] 信仰值、[ICON_Culture] 文化值+7%。解锁“法典”市政后每回合获得+1  [ICON_GreatProphet] 预言家点数。' ),


     -- 澳大利亚
     ( 'LOC_TRAIT_LEADER_CITADEL_CIVILIZATION_EXPANSION2_DESCRIPTION', 'zh_Hans_CN',
       '满足前置科技或市政要求时，您的所有城市将可以生产所有相邻过您任意市中心的特色单位。生产其他文明的特色单位时+20% [ICON_PRODUCTION] 生产力。' ),
     ( 'LOC_TRAIT_CIVILIZATION_LAND_DOWN_UNDER_DESCRIPTION', 'zh_Hans_CN',
       '为所有海岸城市+3[ICON_Housing]住房、+8% [ICON_PRODUCTION] 生产力。牧场可触发文化炸弹。迷人的圣地、学院、商业中心和剧院广场获得大量相邻加成。' ),

     ( 'LOC_ABILITY_UNIT_GIVE_AUSTRALIA_VALID_BUILD_NAME', 'zh_Hans_CN',
       '文明的大本营' ),
     ( 'LOC_ABILITY_UNIT_GIVE_AUSTRALIA_VALID_BUILD_DESCRIPTION', 'zh_Hans_CN',
       '为所在城市玩家解锁生产该单位的能力。' ),

     -- 阿兹特克
     ( 'LOC_TRAIT_LEADER_GIFTS_FOR_TLATOANI_DESCRIPTION', 'zh_Hans_CN',
       '其领土中的奢侈品资源为额外2座城市提供1点 [ICON_Amenities] 宜居度。已改良的每种陆地奢侈品为陆地单位进攻时提供+1 [ICON_Strength] 战斗力，至多通过这种方式获得+4 [ICON_Strength] 战斗力。' ),
     ( 'LOC_ABILITY_NW_AZTK_DESCRIPTION', 'zh_Hans_CN',
       '从已改良的每种陆地奢侈品获得+1 [ICON_Strength] 战斗力，至多通过这种方式获得+4 [ICON_Strength] 战斗力。' ),
     ( 'LOC_MODIFIER_ABILITY_NW_AZTK_ADD_COMBAT', 'zh_Hans_CN',
       '+{Property} [ICON_Strength] 战斗力来自已改良的奢侈品。' ),
     ( 'LOC_BUILDING_TLACHTLI_XP1_DESCRIPTION', 'zh_Hans_CN',
       '阿兹特克特色建筑。提供2点 [ICON_Amenities] 宜居度、+3 [ICON_Culture] 文化值、+2 [ICON_Faith] 信仰值，并提供2点 [ICON_GreatGeneral] 大将军点数。城市新训练的建造者可以建造一个额外的改良设施。采用“保护地球”市政后，提供的 [ICON_TOURISM] 旅游业绩+1。' ),

     -- 汉谟拉比
     ( 'LOC_TRAIT_LEADER_HAMMURABI_NAME', 'zh_Hans_CN',
       '汉谟拉比法典' ),
     ( 'LOC_TRAIT_LEADER_HAMMURABI_XP1_DESCRIPTION', 'zh_Hans_CN',
       '游戏开始时解锁法典市政。' ),
     ( 'LOC_TRAIT_CIVILIZATION_BABYLON_NAME', 'zh_Hans_CN',
       '两河流域' ),
     ( 'LOC_TRAIT_CIVILIZATION_BABYLON_DESCRIPTION', 'zh_Hans_CN',
       '若拥有政治哲学市政，则毗邻淡水的单元格+1 [ICON_PRODUCTION] 生产力。每拥有一个相邻河流的市中心，[ICON_TechBoosted] 尤里卡就会额外提供科技1%的总 [ICON_SCIENCE] 科技值。' ),

     -- 巴西
     ( 'LOC_TRAIT_CIVILIZATION_AMAZON_DESCRIPTION', 'zh_Hans_CN',
       '雨林单元格为学院、商业中心、圣地、工业区和剧院广场提供标准相邻加成，并为相邻的单元格提供+1魅力（而非通常的-1）。解锁“帝国初期”市政后，雨林+1 [ICON_PRODUCTION] 生产力。' ),

     -- 拜占庭
     ( 'LOC_TRAIT_LEADER_BASIL_NAME', 'zh_Hans_CN',
       '生于紫室' ),
     ( 'LOC_TRAIT_LEADER_BASIL_DESCRIPTION', 'zh_Hans_CN',
       '击杀敌方文明或城邦的单位时，拜占庭的宗教将传播到附近的城市。对所信仰宗教与拜占庭相同的城市发起进攻时，轻重骑兵将输出全额伤害。解锁"王权神授"市政后获得特色单位"甲胄骑兵"。' ),
     ( 'LOC_ABILITY_BYZANTIUM_COMBAT_UNITS_DESCRIPTION', 'zh_Hans_CN',
       '主要文明的单位被击杀后，拜占庭的宗教将传播到附近的城市（生于紫室）' ),

     ( 'LOC_TRAIT_LEADER_THEODORA_DESCRIPTION', 'zh_Hans_CN',
       '圣地每相邻一个区域+1 [ICON_CULTURE] 文化值。相邻圣地的农场+1 [ICON_FAITH] 信仰和+1 [ICON_CULTURE] 文化值，不会从多个圣地处获得该加成。' ),
     ( 'LOC_MODIFIER_TRAIT_LEADER_THEODORA_HOLY_CULTURE', 'zh_Hans_CN',
       '+{1_Num} [ICON_CULTURE] 文化值来自相邻区域' ),

     ( 'LOC_TRAIT_CIVILIZATION_BYZANTIUM_NAME', 'zh_Hans_CN',
       '世界渴望之城' ),
     ( 'LOC_TRAIT_CIVILIZATION_BYZANTIUM_DESCRIPTION', 'zh_Hans_CN',
       '建造首都已建成的区域时+35% [ICON_PRODUCTION] 生产力。每回合从区域获得的伟人点数+100%。' ),

     -- 加拿大
     ( 'LOC_TRAIT_LEADER_LAST_BEST_WEST_DESCRIPTION', 'zh_Hans_CN',
       '如果满足前置市政要求，可以在冻土及丘陵、雪地及丘陵上修建农场改良设施。购买这些地形的单元格费用降低50%。这些地形上的矿山和伐木场提供的 [ICON_PRODUCTION] 生产力+2、营地和农场提供的 [ICON_FOOD] 食物+2。战略资源积累速度+100%。首都+1 [ICON_FOOD] 食物。' ),
     ( 'LOC_TRAIT_LEADER_LAST_BEST_WEST_DESCRIPTION', 'zh_Hans_CN',
       '如果满足前置市政要求，可以在冻土及丘陵、雪地及丘陵上修建农场改良设施。购买这些地形的单元格费用降低50%。这些地形上的矿山和伐木场提供的 [ICON_PRODUCTION] 生产力+2、营地和农场提供的 [ICON_FOOD] 食物+2。战略资源积累速度+100%。首都+1 [ICON_FOOD] 食物。' ),

     -- 中国
     ( 'LOC_TRAIT_CIVILIZATION_DYNASTIC_CYCLE_EXPANSION2_DESCRIPTION', 'zh_Hans_CN',
       '[ICON_TechBoosted] 尤里卡和 [ICON_CivicBoosted] 鼓舞提供48%的科技与市政，而非40%。通过科技或市政进入新时代后获得所处时代的一项随机[ICON_TechBoosted] 尤里卡和 [ICON_CivicBoosted] 鼓舞（如可用）。' ),
     -- 文秦
     ( 'LOC_TRAIT_LEADER_FIRST_EMPEROR_NAME', 'zh_Hans_CN',
       '千古一帝' ),
     ( 'LOC_TRAIT_LEADER_FIRST_EMPEROR_EXPANSION2_DESCRIPTION', 'zh_Hans_CN',
       '建造远古和古典奇观时，可消耗建造者次数来加速奇观原始建造进程的18%。建成奇观时获得50 [ICON_GOLD] 金币（联机速度下）。建造者会获得1个额外次数。解锁“砌砖”科技的同时也解锁“运河”。' ),
     -- 永乐
     ( 'LOC_TRAIT_LEADER_YONGLE_XP_DESCRIPTION', 'zh_Hans_CN',
       '所有城市在运行里甲项目期间，将获得等同于每回合 [ICON_PRODUCTION] 生产力70%的 [ICON_FOOD] 食物；或者100%的 [ICON_FAITH] 信仰值；或者150%的 [ICON_GOLD] 金币。至少拥有7人口的城市，每位公民提供+0.6 [ICON_GOLD] 金币、+0.4 [ICON_SCIENCE] 科技值、+0.2 [ICON_CULTURE] 文化值。' ),
     -- 武则天
     ( 'LOC_TRAIT_LEADER_WU_ZETIAN_DESCRIPTION', 'zh_Hans_CN',
       '进攻性间谍的行动效果提升1级。进攻性间谍任务成功时，获得目标城市该回合[ICON_Culture] 文化值、 [ICON_SCIENCE] 科技值和 [ICON_Faith] 信仰值的50%。解锁“防御战术”后获得1个额外的间谍容量。解锁“行政部门”后获得1名免费间谍（和1个额外的间谍容量），并可以使用[ICON_Faith] 信仰值购买间谍。' ),
     -- 武秦
     ( 'LOC_TRAIT_LEADER_QIN_ALT_NAME', 'zh_Hans_CN',
       '山河秦制' ),
     ( 'LOC_TRAIT_LEADER_QIN_ALT_DESCRIPTION', 'zh_Hans_CN',
       '可晋升的近战攻击单位在击败敌方单位后有几率将其俘获为军事工程师。单位进攻时+1 [ICON_Strength] 战斗力，若解锁“防御战术”市政，则提升至+2 [ICON_Strength] 战斗力。' ),
     -- 忽中
     ( 'LOC_TRAIT_LEADER_KUBLAI_DESCRIPTION', 'zh_Hans_CN',
       '首都拥有总督时，获得一个经济政策槽位、+1 [ICON_TradeRoute] 贸易路线容量。首次在另一个文明的城市中建立 [ICON_TradingPost] 贸易站时随机获得一项 [ICON_TechBoosted] 尤里卡和 [ICON_CivicBoosted] 鼓舞。为国际贸易路线+1 [ICON_FOOD] 粮食、国内贸易路线+2 [ICON_GOLD] 金币。' ),

     -- 克里
     ( 'LOC_LEADER_POUNDMAKER_ABILITY_DESCRIPTION', 'zh_Hans_CN',
       '所有同盟类型均可形成共享视野。输入的国外 [ICON_TradeRoute] 贸易路线目的地城市中的每座营地或牧场可为庞德梅克提供+1 [ICON_Gold] 金币。解锁“政治哲学”市政后，输出的[ICON_TradeRoute] 贸易路线目的地城市中的每座营地或牧场可为庞德梅克提供+1 [ICON_Food] 食物。' ),
     ( 'LOC_TRAIT_CIVILIZATION_CREE_TRADE_GAIN_TILES_DESCRIPTION', 'zh_Hans_CN',
       '+1 [ICON_TradeRoute] 贸易路线容量，拥有制陶术科技后获得1个免费商人。商人首次进入克里城市3个单元格内的无主单元格后，这些单元格将划入克里领土中。' ),

     -- 埃及
     ( 'LOC_TRAIT_CIVILIZATION_ITERU_NAME', 'zh_Hans_CN',
       '泛滥季节' ),
     ( 'LOC_TRAIT_CIVILIZATION_ITERU_EXPANSION2_DESCRIPTION', 'zh_Hans_CN',
       '在江河旁建造奇观时+15% [ICON_Production] 生产力。不会受到洪水的损害。' ),
     -- 克利欧佩特拉（埃及）
     ( 'LOC_TRAIT_LEADER_MEDITERRANEAN_EXPANSION2_DESCRIPTION', 'zh_Hans_CN',
       '相邻河流的区域、市中心和奇观+1 [ICON_SCIENCE] 科技值。您通往其他文明的 [ICON_TradeRoute] 贸易路线为埃及+4 [ICON_Gold] 金币。其他文明通往埃及的 [ICON_TradeRoute] 贸易路线能为其+2 [ICON_Food] 食物、为埃及+2 [ICON_Gold] 金币。与盟友进行贸易可获得双倍同盟点数。' ),
     -- 拉美西斯二世
     ( 'LOC_TRAIT_LEADER_RAMSES_DESCRIPTION', 'zh_Hans_CN',
       '相邻河流的区域、市中心和奇观+1 [ICON_PRODUCTION] 生产力。建筑或奇观建成时，获得等同于其花费25%的 [ICON_CULTURE] 文化值。' ),
     -- 克利欧佩特拉（托勒密）
     ( 'LOC_TRAIT_LEADER_CLEOPATRA_ALT_DESCRIPTION', 'zh_Hans_CN',
       '相邻河流的区域、市中心和奇观+3 [ICON_GOLD] 金币。沿泛滥平原的资源+1 [ICON_CULTURE] 文化值、+1 [ICON_FOOD] 食物。已拥有的泛滥平原为相邻单元格提供+1魅力（而非通常的-1）。' ),

     -- 英国
     ( 'LOC_TRAIT_CIVILIZATION_INDUSTRIAL_REVOLUTION_DESCRIPTION', 'zh_Hans_CN',
       '封建主义市政后，在地图上显示 [ICON_RESOURCE_COAL] 煤资源。军事工程师+2建造次数。需要消耗电力的建筑在拥有电力供给时的相应产出+4。每回合从改良设施收集的战略资源+100%。' ),
     -- 皇家海军船坞
     ( 'LOC_DISTRICT_ROYAL_NAVY_DOCKYARD_EXPANSION2_DESCRIPTION', 'zh_Hans_CN',
       '英国特色区域，取代港口。该区域内的建筑使战略资源储备+5（联机速度下）。修建在非首都大陆上时+2 [ICON_Gold] 金币，并为城市每回合提供+4忠诚度。[NEWLINE][NEWLINE]取消从该单元格上下船的 [ICON_Movement] 移动力消耗。必须修建在无礁石地貌的邻陆海岸或湖泊单元格上。' ),

     -- 帝英
     ( 'LOC_TRAIT_CIVILIZATION_PAX_BRITANNICA_EXPANSION2_DESCRIPTION', 'zh_Hans_CN',
       '在每个大陆定居下首座城市时免费获得1个近战单位与1条 [ICON_TradeRoute] 贸易路线容量（也包括 [ICON_Capital] 首都）。在建造“皇家海军船坞”后，获得可生产的最强海军单位。军事学后解锁特色单位“红衫军”。' ),
     -- 爱英
     ( 'LOC_TRAIT_LEADER_ELEANOR_LOYALTY_DESCRIPTION', 'zh_Hans_CN',
       '建成剧院广场时也建成古罗马剧场。[ICON_GreatWork_Writing]著作、[ICON_GreatWork_Landscape]艺术巨作和[ICON_GreatWork_Music]音乐+3 [ICON_Science] 科技值。每个巨作对9个单元格内的外国城市施加3点忠诚度压力。因埃莉诺的忠诚度压力而叛乱的城市将直接加入埃莉诺的文明。' ),
     -- 蒸英
     ( 'LOC_TRAIT_LEADER_VICTORIA_ALT_DESCRIPTION', 'zh_Hans_CN',
       '建造工业区时+35% [ICON_PRODUCTION] 生产力。拥有工业区的城市+8% [ICON_PRODUCTION] 生产力，该加成在解锁工业化后并拥有电力供给时翻倍。所有可见的战略资源+1 [ICON_PRODUCTION] 生产力，解锁“批量生产”后额外+1 [ICON_PRODUCTION] 生产力。' ),
     -- 商英
     ( 'LOC_TRAIT_LEADER_ELIZABETH_DESCRIPTION', 'zh_Hans_CN',
       '每次招募 [ICON_GreatAdmiral] 海军统帅后+1 [ICON_TradeRoute] 贸易路线容量，通过这种方式至多+4 [ICON_TradeRoute] 贸易路线容量。通往任意城邦的 [ICON_TradeRoute] 贸易路线从起源城市中的每个特色区域+3 [ICON_GOLD] 金币。掠夺海上 [ICON_TradeRoute] 贸易路线的收益+100%。' ),


     -- 埃塞
     ( 'LOC_TRAIT_LEADER_MENELIK_DESCRIPTION', 'zh_Hans_CN',
       '建在丘陵上的城市，城市获得等同于所产生 [ICON_FAITH] 信仰值7%的 [ICON_SCIENCE] 科技值和 [ICON_CULTURE] 文化值。单位在丘陵上时+3 [ICON_STRENGTH] 战斗力。平民单位忽略来自丘陵的 [ICON_MOVEMENT] 移动力减益。' ),
     ( 'LOC_TRAIT_CIVILIZATION_ETHIOPIA_DESCRIPTION', 'zh_Hans_CN',
       '埃塞俄比亚的国际 [ICON_TradeRoute] 贸易路线起点处每拥有一种资源，其提供的 [ICON_Faith] 信仰值便+0.5。改良后的资源+1 [ICON_Faith] 信仰值。可用 [ICON_Faith] 信仰值购买考古博物馆和考古学家。' ),
     ( 'LOC_UNIT_ETHIOPIAN_OROMO_CAVALRY_EXPANSION2_DESCRIPTION', 'zh_Hans_CN',
       '埃塞俄比亚特色中世纪轻骑兵单位。替代追猎者，战斗力更强、视野更广。在丘陵中移动时无 [ICON_Movement] 移动力减益。' ),

     -- 法国
     ( 'LOC_TRAIT_CIVILIZATION_WONDER_TOURISM_DESCRIPTION', 'zh_Hans_CN',
       '为中世纪及之后的奇观+25% [ICON_Production] 生产力。所有奇观提供的基础产出、[ICON_Housing] 住房、 [ICON_Amenities] 宜居度、伟人点数和 [ICON_Tourism] 旅游业绩+100%。' ),
     -- 黑法
     ( 'LOC_TRAIT_LEADER_FLYING_SQUADRON_DESCRIPTION', 'zh_Hans_CN',
       '行政部门市政后，对其他文明的外交能见度提高一级。建成古典时代及之后的奇观时提供一个免费间谍。' ),
     -- 爱法
     ( 'LOC_TRAIT_LEADER_ELEANOR_FRANCE_LOYALTY_TEAM_PVP_DESCRIPTION', 'zh_Hans_CN',
       '建成剧院广场时也建成古罗马剧场。[ICON_GreatWork_Writing]著作、[ICON_GreatWork_Landscape]艺术巨作和[ICON_GreatWork_Music]音乐+3 [ICON_Science] 科技值。每个巨作对9个单元格内的外国城市施加3点忠诚度压力。因埃莉诺的忠诚度压力而叛乱的城市将直接加入埃莉诺的文明。' ),
     -- 金法
     ( 'LOC_TRAIT_LEADER_MAGNIFICENCES_NAME', 'zh_Hans_CN',
       '向着星辰与深渊' ),
     ( 'LOC_TRAIT_LEADER_MAGNIFICENCES_DESCRIPTION', 'zh_Hans_CN',
       '拥有帝国初期市政后解锁剧院广场。剧院广场从奢侈品单元格获得大量相邻加成。可在拥有剧院广场区域的任意城市中开展“宫廷盛会”项目。' ),
     ( 'LOC_TRAIT_LEADER_MAGNIFICENCES_THEATER', 'zh_Hans_CN',
       '+{1_Num} [ICON_CULTURE]文化值来自相邻的奢侈品单元格。' ),

     -- 高卢
     ( 'LOC_TRAIT_CIVILIZATION_GAUL_DESCRIPTION', 'zh_Hans_CN',
       '矿山为所有区域提供少量相邻加成、对无主领土施放文化炸弹，若拥解锁“封建主义”市政则+1 [ICON_CULTURE] 文化值。但特色区域无法建在市中心旁、与其他区域相邻时不会获得少量相邻加成。' ),

     -- 格鲁吉亚
     ( 'LOC_TRAIT_LEADER_RELIGION_CITY_STATES_DESCRIPTION', 'zh_Hans_CN',
       '战斗胜利后，获得等同于被击杀单位战斗力50%的 [ICON_FAITH] 信仰值（联机速度下）。如与城邦信仰相同的主流宗教，则派遣至其处的每名 [ICON_ENVOY] 使者将视为2名。游戏开始便激活“采矿术”科技。' ),
     ( 'LOC_TRAIT_CIVILIZATION_GOLDEN_AGE_QUESTS_DESCRIPTION', 'zh_Hans_CN',
       '在黄金或英雄时代初期设置着力点时，除原有加成外还将获得提高时代得分的普通时代加成。建造防御性建筑时+50% [ICON_Production] 生产力。' ),

     -- 德国
     ( 'LOC_TRAIT_CIVILIZATION_IMPERIAL_FREE_CITIES_NAME', 'zh_Hans_CN',
       '汉萨同盟' ),
     ( 'LOC_TRAIT_CIVILIZATION_IMPERIAL_FREE_CITIES_DESCRIPTION', 'zh_Hans_CN',
       '每座城市都能建造比平常多一个区域（无视 [ICON_Citizen] 人口数量限制）。' ),
     ( 'LOC_DISTRICT_HANSA_EXPANSION2_DESCRIPTION', 'zh_Hans_CN',
       '德国特色区域，替代工业区，建造费用更低。[NEWLINE]每个相邻的商业中心区域提供+2 [ICON_Production] 生产力。所有相邻资源（而非仅战略资源）为其提供+1 [ICON_Production] 生产力加成。' ),
     -- 文德
     ( 'LOC_TRAIT_LEADER_LUDWIG_DESCRIPTION', 'zh_Hans_CN',
       '拥有世界奇观的城市+1 [ICON_Amenities] 宜居度。6个单元格内尚无世界奇观的城市建造世界奇观时+25% [ICON_PRODUCTION] 生产力。' ),
     -- 武德
     ( 'LOC_TRAIT_LEADER_HOLY_ROMAN_EMPEROR_DESCRIPTION', 'zh_Hans_CN',
       '额外的军事政策槽位。单位在 [ICON_Capital] 首都5个单元格内作战时，每距离 [ICON_Capital] 首都1个单元格便+1 [ICON_Strength] 战斗力。' ),
     ( 'LOC_MODIFIER_TRAIT_LEADER_HOLY_ROMAN_EMPEROR_ADJUST_COMBAT_STRENGTH', 'zh_Hans_CN',
       '+{1_Num} 来自距离其首都的距离。' ),

     -- 大哥伦比亚
     ( 'LOC_TRAIT_CIVILIZATION_EJERCITO_PATRIOTA_DESCRIPTION', 'zh_Hans_CN',
       '平民单位在友好领土内开始回合时+1 [ICON_MOVEMENT] 移动力。升级单位不会结束其回合。' ),

     -- 希腊
     ( 'LOC_TRAIT_CIVILIZATION_PLATOS_REPUBLIC_DESCRIPTION', 'zh_Hans_CN',
       '解锁“帝国初期”获得一个额外的通用槽位。游戏开始时获得3个随机 [ICON_CivicBoosted] 鼓舞。' ),
     ( 'LOC_DISTRICT_ACROPOLIS_EXPANSION2_DESCRIPTION', 'zh_Hans_CN',
       '希腊特色区域，替代剧院广场，建造费用更低。建成后奖励1名 [ICON_Envoy] 使者。[NEWLINE]每个相邻市中心、区域为其提供1点 [ICON_Culture] 文化值加成。每个相邻奇观、娱乐中心及水上乐园为其提供2点 [ICON_Culture] 文化值加成。只能建在丘陵上。' ),

     -- 伯里克利
     ( 'LOC_TRAIT_LEADER_SURROUNDED_BY_GLORY_DESCRIPTION', 'zh_Hans_CN',
       '作为宗主国时，每个下辖的城邦使您的 [ICON_Culture] 文化值和 [ICON_Tourism] 旅游业绩+7%。卫城从每个相邻区域+1 [ICON_PRODUCTION] 生产力。' ),
     ( 'LOC_DISTRICT_ACROPOLIS_ADD_PRODUCTION', 'zh_Hans_CN',
       '+{1_Num} [ICON_PRODUCTION] 生产力来自相邻区域。' ),
     -- 戈尔戈
     ( 'LOC_TRAIT_LEADER_THERMOPYLAE_DESCRIPTION', 'zh_Hans_CN',
       '战斗胜利可获得等同于被击败单位 [ICON_Strength] 战斗力35%的 [ICON_Culture] 文化值（联机速度下）。若解锁“政治哲学”文化，则+1 [ICON_Strength] 战斗力，若解锁“人文主义”文化，则再+1 [ICON_Strength] 战斗力。' ),

     -- 匈牙利
     ( 'LOC_BUILDING_THERMAL_BATH_DESCRIPTION', 'zh_Hans_CN',
       '匈牙利特色建筑，解锁于人文主义。+2点 [ICON_Amenities] 宜居度与+2点 [ICON_PRODUCTION] 生产力，可扩展到6个单元格内的每个市中心。城市仅能应用1次此类加成，因此市中心6个单元格以内相同的此建筑不会再额外提供加成。此城中若包含至少1处地热裂缝，则该城市的 [ICON_TOURISM] 旅游业绩+3，同时 [ICON_AMENITIES] 宜居度额外+2。[NEWLINE][NEWLINE]不能建造在已拥有动物园的娱乐中心区域中。' ),
     ( 'LOC_TRAIT_CIVILIZATION_PEARL_DANUBE_DESCRIPTION', 'zh_Hans_CN',
       '在市中心河对岸修建区域与建筑时+50% [ICON_PRODUCTION] 生产力。' ),

     -- 印加
     ( 'LOC_TRAIT_LEADER_PACHACUTI_QHAPAQ_NAN_DESCRIPTION', 'zh_Hans_CN',
       '起始城市中的每座山脉单元格为国内 [ICON_TradeRoute] 贸易路线提供+1 [ICON_Food] 食物。侦查单位可以使用自身的高 [ICON_Movement] 移动力护送平民单位。“法典”市政后可获得一个侦察兵，并解锁印加路网改良设施。' ),

     -- 印度
     ( 'LOC_TRAIT_CIVILIZATION_DHARMA_EXPANSION2_DESCRIPTION', 'zh_Hans_CN',
       '从城市中的每个宗教（其须拥有至少1个信徒）获得信徒信仰加成。城市从每个宗教（须有至少1个信徒）获得1点 [ICON_Amenities] 宜居度。传教士的传播次数+2。来自 [ICON_TradeRoute] 贸易路线的宗教压力+100%。' ),
     ( 'LOC_IMPROVEMENT_STEPWELL_EXPANSION2_DESCRIPTION', 'zh_Hans_CN',
       '解锁建造者建造印度特色改良设施梯井的能力。[NEWLINE][NEWLINE]提供1点 [ICON_Food] 食物并+0.5 [ICON_Housing] 住房。建成时对相邻中立单元格释放文化炸弹。如果靠近圣地区域，+1 [ICON_PRODUCTION] 生产力、+3 [ICON_FAITH] 信仰值。如果靠近农场，+1 [ICON_Food] 食物。干旱时防止 [ICON_Food] 食物损失，不能建在另一个梯井旁。若拥有"王权神授"文化，则相邻圣地时额外+1 [ICON_FAITH] 信仰。若拥有"归正会"文化，则相邻圣地时额外+1 [ICON_FAITH] 信仰值。不能建造在丘陵上。' ),
     ( 'LOC_TRAIT_LEADER_SATYAGRAHA_DESCRIPTION', 'zh_Hans_CN',
       '所遇到的文明已创建了宗教且不在战争状态，均会+5信仰值 [ICON_Faith] 。与甘地交战的文明额外获得40%的厌战情绪，建造者+1 [ICON_Movement] 移动力。' ),
     ( 'LOC_TRAIT_LEADER_ARTHASHASTRA_DESCRIPTION', 'zh_Hans_CN',
       '国境内军事单位+1 [ICON_Movement] 移动力、+1 [ICON_Strength] 战斗力，解锁军事训练市政后可宣布领土扩张战争。' ),

     -- 印尼
     ( 'LOC_TRAIT_LEADER_EXALTED_GODDESS_DESCRIPTION', 'zh_Hans_CN',
       '沿海城市建造圣地时+80% [ICON_PRODUCTION] 生产力。相邻圣地的港口的相邻加成也提供 [ICON_FAITH] 信仰值。可以使用 [ICON_FAITH] 信仰值购买港口建筑。宗教单位上船下船时无移动力消耗。与海岸或湖泊单元格相邻的市中心+2 [ICON_FAITH] 信仰值。' ),
     ( 'LOC_TRAIT_CIVILIZATION_INDONESIA_NUSANTARA_DESCRIPTION', 'zh_Hans_CN',
       '海岸和湖泊单元格可为圣地、学院、工业区和剧院广场提供标准相邻加成。如与海岸或湖泊单元格相邻，娱乐中心+1 [ICON_AMENITIES] 宜居度。' ),

     -- 日本
     ( 'LOC_TRAIT_CIVILIZATION_ADJACENT_DISTRICTS_DESCRIPTION', 'zh_Hans_CN',
       '区域与区域相邻时额外获得少量相邻加成。' ),
     -- 北条
     ( 'LOC_TRAIT_LEADER_DIVINE_WIND_EXPANSION2_DESCRIPTION', 'zh_Hans_CN',
       '相邻海岸的陆地单位和海岸上的海军单位+2 [ICON_Strength] 战斗力。[NEWLINE]如果首都相邻海岸，则所有城市建造港口时+80% [ICON_PRODUCTION] 生产力。[NEWLINE]如果首都不相邻海岸，则所有城市建造圣地和商业中心时+55% [ICON_PRODUCTION] 生产力。' ),
     ( 'LOC_ABILITY_NW_JP_UNIT_SETTLE_NAME', 'zh_Hans_CN',
       '+1 [ICON_MOVEMENT] 移动力、无视地形地貌的移动力减益。' ),
     -- 德川
     ( 'LOC_TRAIT_LEADER_TOKUGAWA_XP_DESCRIPTION', 'zh_Hans_CN',
       '国际 [ICON_TradeRoute] 贸易路线的产出和旅游业绩-25%；目的地城市中每有一个特色区域，国内 [ICON_TradeRoute] 贸易路线便提供+0.7 [ICON_Culture] 文化值、+0.7 [ICON_Science] 科技值和+1.2 [ICON_Gold] 金币。在日本首都6单元格内的城市为100%忠诚；研究完“飞行”后，每有一个区域则+1 [ICON_Tourism] 旅游业绩。' ),

     -- 高棉
     ( 'LOC_TRAIT_LEADER_MONASTERIES_KING_DESCRIPTION', 'zh_Hans_CN',
       '圣地+1 [ICON_HOUSING] 住房、+1 [ICON_FOOD] 食物、并释放一次文化炸弹、从河流获得大量相邻加成。建造水渠时+50% [ICON_PRODUCTION] 生产力。' ),

     -- 刚果
     ( 'LOC_TRAIT_CIVILIZATION_NKISI_DESCRIPTION', 'zh_Hans_CN',
       '获得额外100% [ICON_GreatArtist] 大艺术家点数，每个大艺术家提供一个随机的鼓舞。政治哲学市政后， [ICON_GreatWork_Relic] 遗物、[ICON_GreatWork_Artifact] 文物以及 [ICON_GreatWork_Sculpture] 雕塑艺术巨作额外+2 [ICON_Food] 食物、+2 [ICON_Production] 生产力、+1 [ICON_Faith] 信仰值和+4 [ICON_Gold] 金币。宫殿有5个巨作槽位。每解锁一个二级政体获得1个 [ICON_GreatWork_Relic] 遗物。' ),
     ( 'LOC_DISTRICT_MBANZA_DESCRIPTION', 'zh_Hans_CN',
       '刚果特色区域，代替社区，解锁更早且建造费用更低。无视魅力值，固定提供+5 [ICON_Housing] 住房、+3 [ICON_Food] 食物和+1 [ICON_Gold] 金币。[NEWLINE][NEWLINE]只能建在雨林或树林里。' ),

     ( 'LOC_TRAIT_LEADER_RELIGIOUS_CONVERT_NAME', 'zh_Hans_CN',
       '受洗国王' ),
     ( 'LOC_TRAIT_LEADER_RELIGIOUS_CONVERT_DESCRIPTION', 'zh_Hans_CN',
       '对圣地及其建筑+25% [ICON_Production] 生产力。首次建造神社和寺庙时分别获得一个遗物。允许城市使用 [ICON_Production] 生产力建造宗教单位，生产宗教单位时+100% [ICON_Production] 生产力。' ),
     ( 'LOC_TRAIT_LEADER_NZINGA_MBANDE_NAME', 'zh_Hans_CN',
       '马坦巴的战略家' ),
     ( 'LOC_TRAIT_LEADER_NZINGA_MBANDE_DESCRIPTION', 'zh_Hans_CN',
       '距离任意 [ICON_Capital] 首都7个单元格范围内的城市+1 [ICON_AMENITIES] 宜居度，且每回合提供+1 [ICON_Gold] 金币。与盟友或下辖城邦的 [ICON_TradeRoute] 贸易路线为双方城市提供+2 [ICON_GOLD] 金币和+2 [ICON_CULTURE] 文化。' ),

     -- 朝鲜
     ( 'LOC_TRAIT_LEADER_HWARANG_DESCRIPTION', 'zh_Hans_CN',
       '就职 [ICON_Governor] 总督的每有一次升级，城市便额外提供+6% [ICON_Culture] 文化值、+5% [ICON_Gold] 金币、+4% [ICON_Science] 科技值、+3% [ICON_Faith] 信仰值、+2% [ICON_Production] 生产力和+1% [ICON_Food] 食物。' ),
     ( 'LOC_TRAIT_LEADER_SEJONG_DESCRIPTION', 'zh_Hans_CN',
       '解锁新时代的首项科技时，获得1.2倍于每回合 [ICON_SCIENCE] 科技值收益的 [ICON_CULTURE] 文化值、1.2倍于每回合 [ICON_SCIENCE] 科技值收益的 [ICON_GOLD] 金币。' ),

     -- 马其顿
     ( 'LOC_TRAIT_LEADER_TO_WORLDS_END_DESCRIPTION', 'zh_Hans_CN',
       '城市不会产生厌战情绪。此玩家占领拥有世界奇观的城市时，所有军事单位的体力值将完全恢复。首次建成皇家学堂后，[ICON_Capital]首都获得亚历山大大帝。' ),
     ( 'LOC_LEADER_NW_ALEXANDER_DESCRIPTION', 'zh_Hans_CN',
       '亚历山大特色大将军单位。为2个单元格范围内的古典时代、中世纪和文艺复兴时期的单位+5 [ICON_Strength] 战斗力、+1 [ICON_Movement] 移动力，不会和完全相同的效果同时生效。可在城邦进行隐退，为玩家永久提供该城邦的宗主国加成效果。' ),
     ( 'LOC_GREAT_PERSON_INDIVIDUAL_ALEXANDER_ACTION_TEXT', 'zh_Hans_CN',
       '永久提供该城邦的宗主国加成效果。' ),
     ( 'LOC_LEADER_NW_ALEXANDER_NAME', 'zh_Hans_CN',
       '亚历山大大帝' ),

     -- 马里
     ( 'LOC_TRAIT_CIVILIZATION_MALI_GOLD_DESERT_DESCRIPTION', 'zh_Hans_CN',
       '初始便获得2点 [ICON_Faith] 信仰值。每个相邻沙漠或者沙漠丘陵为市中心提供+1 [ICON_FOOD] 食物。沙漠单元格+2 [ICON_GOLD] 金币。' ),
     ( 'LOC_TRAIT_LEADER_SAHEL_MERCHANTS_DESCRIPTION', 'zh_Hans_CN',
       '国际 [ICON_TradeRoute] 贸易路线提供+2 [ICON_FAITH] 信仰。文明进入黄金时代后可获得+1 [ICON_TradeRoute] 贸易路线容量。' ),
     ( 'LOC_TRAIT_LEADER_SUNDIATA_KEITA_DESCRIPTION', 'zh_Hans_CN',
       '招募伟人所花费的 [ICON_GOLD] 金币-18%，马里所建城市的市场获得2个 [ICON_GreatWork_WRITING] 著作巨作槽位。[ICON_GreatWork_WRITING] 著作巨作+8 [ICON_GOLD] 黄金、+2 [ICON_PRODUCTION] 生产力。' ),

     -- 毛利
     ( 'LOC_TRAIT_LEADER_KUPES_VOYAGE_DESCRIPTION', 'zh_Hans_CN',
       '建立首座城市时免费获得一名建造者。宫殿获得+3 [ICON_HOUSING] 住房与+1 [ICON_AMENITIES] 宜居度。' ),
     ( 'LOC_TRAIT_CIVILIZATION_MAORI_MANA_DESCRIPTION', 'zh_Hans_CN',
       '游戏初始便解锁“航海术”与“造船术”科技。水运单位+1 [ICON_Movement] 移动力。对外贸易市政后，未改良的树林与雨林提供 +1 [ICON_PRODUCTION] 生产力，重商主义市政后额外提供+1 [ICON_PRODUCTION] 生产力，保护地球市政后额外+2 [ICON_PRODUCTION] 生产力。渔船 +1 [ICON_Gold] 金币，并对相邻单元格释放文化炸弹。无法收获资源。无法获得 [ICON_GreatWriter] 大作家。' ),


     -- 马普切
     ( 'LOC_TRAIT_LEADER_LAUTARO_ABILITY_DESCRIPTION_ALT', 'zh_Hans_CN',
       '与自由城市或处在 [ICON_Glory_Golden_Age] 黄金/英雄时代中的文明作战时+3 [ICON_Strength] 战斗力。在敌方城市边界中击杀敌方单位后，将使此城损失20点忠诚度。单位相邻山脉开始回合时+1 [ICON_Movement]移动力。' ),
     ( 'LOC_TRAIT_CIVILIZATION_MAPUCHE_TOQUI_NAME','zh_Hans_CN',
       '图卡佩尔精神' ),
     ( 'LOC_TRAIT_CIVILIZATION_MAPUCHE_TOQUI_DESCRIPTION','zh_Hans_CN',
       '拥有 [ICON_Governor] 总督的城市+1魅力值，+7% [ICON_Culture] 文化值和+7% [ICON_Production] 生产力，在这些城市训练的军事单位获得+50%战斗经验，该加成在非马普切建立的城市中翻倍。在敌方城市边界内击败敌方单位会使该城市失去20忠诚度。[ICON_Governor] 总督对9格内的所有城市施加+4忠诚度。' ),

     -- 玛雅
     ( 'LOC_TRAIT_LEADER_MUTAL_DESCRIPTION', 'zh_Hans_CN',
       '[ICON_Capital] 首都6个单元格范围内的非首都城市所有产出+5%、单位+2 [ICON_Strength] 战斗力。' ),

     -- 蒙古
     ( 'LOC_TRAIT_CIVILIZATION_MONGOLIAN_ORTOO_DESCRIPTION', 'zh_Hans_CN',
       '单位从草原、草原（丘陵）单元格开始回合时+1 [ICON_MOVEMENT] 移动力。创建 [ICON_TradeRoute] 贸易路线后，目的地城市中将立即出现1座 [ICON_TradingPost] 贸易站。' ),

     ( 'LOC_TRAIT_LEADER_GENGHIS_KHAN_ABILITY_DESCRIPTION', 'zh_Hans_CN',
       '建造斡耳朵后获得1个免费轻骑兵单位。' ),

     ( 'LOC_UNIT_MONGOLIAN_KESHIG_DESCRIPTION', 'zh_Hans_CN',
       '中世纪蒙古特色远程骑兵单位，替代弩手。可利用自身的高 [ICON_Movement] 移动力护送平民和支援单位。' ),
     ( 'LOC_BUILDING_ORDU_DESCRIPTION', 'zh_Hans_CN',
       '蒙古特色建筑。其所在城市生产的骑兵单位无需维护费。其所在城市生产的所有骑兵类和攻城类单位+25%战斗经验值。无法建造在已拥有兵营的军营区域中。[NEWLINE]若解锁 [ICON_RESOURCE_HORSES] 马资源，每回合产出2点资源 [ICON_RESOURCE_HORSES] 马。' ),
     ( 'LOC_NW_MONGOLIA_ABILITY_GRASS_MOVEMENT_DESCRIPTION', 'zh_Hans_CN',
       '从草原、草原（丘陵）单元格开始回合时+1 [ICON_MOVEMENT] 移动力。' ),

     -- 荷兰
     ( 'LOC_TRAIT_RADIO_ORANJE_DESCRIPTION', 'zh_Hans_CN',
       '市政广场建筑额外提供等同于宫殿的基础产出。向城邦派遣的第一名 [ICON_ENVOY] 使者视为2名。' ),
     ( 'LOC_TRAIT_CIVILIZATION_GROTE_RIVIEREN_NAME', 'zh_Hans_CN',
       '海上马车夫' ),
     ( 'LOC_TRAIT_CIVILIZATION_GROTE_RIVIEREN_EXPANSION2_DESCRIPTION', 'zh_Hans_CN',
       '学院、剧院广场和工业区从河流获得大量相邻加成。建造港口区域时+100% [ICON_Production] 生产力，建成后可对相邻单元格施放文化炸弹。商人处于水域上时+1 [ICON_GreatMerchant] 大商人点数。' ),
     -- 挪威
     (  'LOC_TRAIT_CIVILIZATION_EARLY_OCEAN_NAVIGATION_NAME','zh_Hans_CN',
       '从海至巅' ),
     ( 'LOC_TRAIT_CIVILIZATION_EARLY_OCEAN_NAVIGATION_DESCRIPTION','zh_Hans_CN',
       '在研究造船术后，单位获得进入海洋单元格的能力。沿海城市+1 [ICON_Faith] 信仰值、+1 [ICON_Production] 生产力。帝国初期市政后，相邻海岸的惊艳单元格+1 [ICON_Food] 食物、+1 [ICON_Culture] 文化值。' ),
     ( 'LOC_TRAIT_LEADER_THUNDERBOLT_EXPANSION2_DESCRIPTION','zh_Hans_CN',
       '海军近战单位能在中立领土单元格回复并能发动海岸突袭。掠夺或海岸扫荡改良设施时除原有产出外还将获得 [ICON_SCIENCE] 科技值。航海术解锁特色单位维京长船。' ),
     (  'LOC_TRAIT_LEADER_HARALD_ALT_XP_DESCRIPTION','zh_Hans_CN',
       '所有单位-1 [ICON_GOLD] 金币维护花费。建造商业中心和港口时+25% [ICON_Production] 生产力。帝国初期市政后获得1个 [ICON_ENVOY] 使者。' ),
     (  'LOC_UNIT_NORWEGIAN_BERSERKER_DESCRIPTION','zh_Hans_CN',
       '挪威中世纪特色单位。基础 [ICON_Movement] 移动力为3，如果该单位从敌人领土开始回合，则 [ICON_Movement] 移动力为4，在水中时 +1[ICON_Movement] 移动力。攻击时+3 [ICON_Strength] 战斗力，防御时-2 [ICON_Strength] 战斗力。可以使用 [ICON_Faith] 信仰值购买。购买时花费-15%。' ),

     -- 努比亚
     ( 'LOC_TRAIT_LEADER_KANDAKE_OF_MEROE_NAME', 'zh_Hans_CN',
       '麦罗埃复兴' ),
     ( 'LOC_TRAIT_LEADER_KANDAKE_OF_MEROE_DESCRIPTION', 'zh_Hans_CN',
       '没有专业化区域的城市建造区域时+100% [ICON_Production] 生产力。' ),
     ( 'LOC_TRAIT_CIVILIZATION_TA_SETI_DESCRIPTION', 'zh_Hans_CN',
       '相邻河流的单位进攻时+2 [ICON_Strength] 战斗力，跨过河流攻击单位时不会受到 [ICON_Strength] 战斗力和 [ICON_MOVEMENT] 移动力减益。如果区域相邻河流，则可以使用 [ICON_FAITH] 信仰值购买其中的建筑。' ),
     ( 'LOC_IMPROVEMENT_PYRAMID_DESCRIPTION', 'zh_Hans_CN',
       '砌砖科技解锁建造者建造努比亚特色改良设施努比亚金字塔的能力。+2 [ICON_Faith] 信仰值、+1 [ICON_Food] 食物。与市中心相邻时 +1 [ICON_Food] 食物。与其他提供相邻加成的区域相邻时+2对应产出。[NEWLINE][NEWLINE]可以建造在沙漠、草原、平原及其丘陵或在泛滥平原上。不能建造在另一个努比亚金字塔旁。' ),

     ( 'LOC_ABILITY_TA_SETI_RIVER_COMBAT_DESCRIPTION', 'zh_Hans_CN',
       '相邻河流时+3 [ICON_Strength] 战斗力，跨过河流攻击单位时不会受到减益' ),
     ( 'LOC_MODFEAT_ABILITY_TA_SETI_RIVER_COMBAT_COMBAT', 'zh_Hans_CN',
       '+{1_Num} [ICON_Strength] 战斗力来自相邻河流（塔赛提）。' ),

     -- 奥斯曼
     ( 'LOC_TRAIT_LEADER_SULEIMAN_GOVERNOR_NAME', 'zh_Hans_CN',
       '辉煌时代' ),
     ( 'LOC_TRAIT_LEADER_SULEIMAN_GOVERNOR_DESCRIPTION', 'zh_Hans_CN',
       '拥有军事与外交能力的专属特色总督。研究完“火药”科技后获得特色单位“苏丹亲兵”，政治哲学市政后获得1个 [Icon_Governor] 总督头衔。' ),
     ( 'LOC_TRAIT_LEADER_SULEIMAN_ALT_NAME', 'zh_Hans_CN',
       '艺匠之师' ),
     ( 'LOC_TRAIT_LEADER_SULEIMAN_ALT_DESCRIPTION', 'zh_Hans_CN',
       '处于 [ICON_GLORY_GOLDEN_AGE] 黄金时代或英雄时代时，+7% [Icon_Science] 科技值和 [Icon_CUlture] 文化值。未处于 [ICON_GLORY_GOLDEN_AGE] 黄金时代或英雄时代时，获得一个额外的通配符政策槽位，并和同样未处于 [ICON_GLORY_GOLDEN_AGE] 黄金时代或英雄时代的文明作战将+2 [ICON_Strength] 战斗力。' ),

     -- 波斯
     ( 'LOC_TRAIT_CIVILIZATION_SATRAPIES_DESCRIPTION', 'zh_Hans_CN',
       '货币科技后，[ICON_TradeRoute] 贸易路线容量+1。国内 [ICON_TradeRoute] 贸易路线+2 [ICON_Gold] 金币，+1 [ICON_Culture] 文化值。本国领土中的道路提升一个等级。' ),
     ( 'LOC_TRAIT_LEADER_FALL_BABYLON_EXPANSION2_DESCRIPTION', 'zh_Hans_CN',
       '对主要文明宣布突袭战争后的7回合内+1 [ICON_Movement] 移动力。拥有驻扎单位的占领城市每回合的忠诚度+5。宣布突袭战争的 [ICON_STAT_GRIEVANCE] 不满和好战性与正式战争相同。如果处于战争状态，+1 [ICON_TradeRoute] 贸易路线容量。' ),
     ( 'LOC_TRAIT_LEADER_NADER_SHAH_DESCRIPTION', 'zh_Hans_CN',
       '攻击生命值全满的单位时+3 [ICON_Strength] 战斗力。“封建主义”市政后，国内 [ICON_TradeRoute] 贸易路线+2 [Icon_Faith] 信仰值和 +3 [Icon_Gold] 金币。' ),

     -- 腓尼基
     ( 'LOC_TRAIT_LEADER_FOUNDER_CARTHAGE_DESCRIPTION', 'zh_Hans_CN',
       '海岸城市建立之初便拥有一个免费的 [ICON_TradingPost] 贸易站。市政广场及其每个建筑+1 [ICON_TradeRoute] 贸易路线容量。在拥有市政广场的城市中建造区域时+50% [ICON_Production] 生产力。' ),
     ( 'LOC_TRAIT_CIVILIZATION_MEDITERRANEAN_COLONIES_DESCRIPTION', 'zh_Hans_CN',
       '游戏开始便激活“写作”科技 [ICON_TechBoosted] 尤里卡。本方建立的与 [ICON_Capital] 首都在同一大陆的海岸城市永久忠诚。开拓者上船后，[ICON_Movement] 移动力与视野范围各+1。开拓者总是无视上下船的 [ICON_Movement] 移动力减益。' ),
     ( 'LOC_DISTRICT_COTHON_DESCRIPTION', 'zh_Hans_CN',
       '腓尼基特色区域，取代港口，建造成本更低。为此城生产海军单位与开拓者+20% [ICON_PRODUCTION] 生产力。在该城范围内，所有受损海军单位每回合可额外恢复30点生命值。[NEWLINE][NEWLINE]取消从该单元格上下船的 [ICON_Movement] 移动力消耗。必须修建在无礁石地貌的邻陆海岸或湖泊单元格上。' ),

     -- 波兰
     ( 'LOC_BUILDING_SUKIENNICE_EXPANSION1_DESCRIPTION', 'zh_Hans_CN',
       '波兰特色建筑，建造费用更低。从此城开始的国际 [ICON_TradeRoute] 贸易路线+2 [ICON_Production] 生产力；国内 [ICON_TradeRoute] 贸易路线+4 [ICON_Gold] 金币。如此城尚未建有灯塔，则+1 [ICON_TradeRoute] 贸易路线容量。' ),

     -- 葡萄牙
     ( 'LOC_TRAIT_LEADER_JOAO_III_DESCRIPTION', 'zh_Hans_CN',
       '所有单位+1视野。与文明相遇后便+2 [ICON_TradeRoute] 贸易路线容量。开放所有城邦的边界。为商人单位+50% [ICON_Production] 生产力。' ),
     ( 'LOC_TRAIT_CIVILIZATION_PORTUGAL_DESCRIPTION', 'zh_Hans_CN',
       '国际 [ICON_TradeRoute] 贸易路线必须起源于海岸城市，并只能通往处于海岸上或拥有港口的城市，但除 [ICON_Gold] 金币以外所有产出+50%。商人单位在水域中的行动范围+100%，且解锁之后可立即在水域中行动。' ),

     -- 罗马
     ( 'LOC_TRAIT_LEADER_TRAJANS_COLUMN_DESCRIPTION', 'zh_Hans_CN',
       '若解锁“对外贸易”市政，每个城市赠送一个市中心建筑。' ),
     ( 'LOC_TRAIT_LEADER_CAESAR_DESCRIPTION', 'zh_Hans_CN',
       '如已拥有法典市政，则建立或占领城市时将获得一个免费的近战单位。占领城市时还会获得150 [ICON_GOLD] 金币（联机速度下）。' ),
     ( 'LOC_DISTRICT_BATH_EXPANSION2_ALT_DESCRIPTION', 'zh_Hans_CN', '罗马特色区域，取代水渠，建造费用更低，解锁于游戏和娱乐。[NEWLINE][NEWLINE]从相邻河流、湖泊、绿洲或山脉引水，为该城市提供淡水资源。尚未拥有淡水资源的城市最多获得6个 [ICON_Housing] 住房。已有淡水资源的城市则+2 [ICON_Housing] 住房。若与地热裂缝相邻，提供+1 [ICON_Amenities] 宜居度。在任何情况下，浴场都能额外提供+2 [ICON_Housing] 住房和+1 [ICON_Amenities] 宜居度。干旱时可防止 [ICON_Food] 食物损失。必须修建在与市中心相邻的单元格中。军事工程师可消耗1次使用次数来完成浴场45%的修建进度。' ),

     -- 俄罗斯
     ( 'LOC_TRAIT_CIVILIZATION_MOTHER_RUSSIA_EXPANSION2_DESCRIPTION', 'zh_Hans_CN',
       '所建城市获得5块额外领土。冻土及其丘陵+1 [ICON_Production] 生产力。拥有拉夫拉修道院的城市，冻土+1 [ICON_Faith] 信仰值。与俄罗斯交战的文明单位如处于俄罗斯领土中，遭遇暴风雪时受到的伤害+100%。' ),
     ( 'LOC_DISTRICT_LAVRA_DESCRIPTION', 'zh_Hans_CN',
       '俄罗斯特色区域，代替圣地，建造费用更低。[NEWLINE][NEWLINE]拥有祭祀建筑后每回合提供+1 [ICON_GreatMusician] 大音乐家点数。此城市每消耗一位伟人，城市边界则扩张1单元格。' ),

     -- 苏格兰
     ( 'LOC_TRAIT_LEADER_BANNOCKBURN_DESCRIPTION', 'zh_Hans_CN',
       '单位在任意 [ICON_CAPITAL] 首都3个单元格范围内时，+2 [ICON_Strength] 战斗力。' ),
     ( 'LOC_TRAIT_CIVILIZATION_SCOTTISH_ENLIGHTENMENT_DESCRIPTION', 'zh_Hans_CN',
       '每3位 [ICON_CITIZEN] 公民消耗1 [ICON_AMENITIES] 宜居度，而非通常的2位。快乐的城市+3% [ICON_SCIENCE] 科技值和 [ICON_PRODUCTION] 生产力。欣喜若狂的城市，上述加成翻倍。' ),
     ( 'LOC_IMPROVEMENT_GOLF_COURSE_XP2_DESCRIPTION', 'zh_Hans_CN',
       '解锁建造者建造苏格兰特色改良设施高尔夫球场的能力。[NEWLINE][NEWLINE]+1 [ICON_AMENITIES] 宜居度、+3 [ICON_GOLD] 金币。如与市中心区域相邻，则+1 [ICON_CULTURE] 文化值；如与娱乐设施区域相邻，则+1 [ICON_CULTURE] 文化值。解锁更多市政和科技后可获得更多 [ICON_TOURISM] 旅游业绩和 [ICON_HOUSING] 住房。无法建在沙漠或沙漠丘陵地貌上。每座城市仅限建造一座。拥有高尔夫球场的单元格无法切换。+1魅力。' ),
     ( 'LOC_MODIFIER_TRAIT_LEADER_BANNOCKBURN_COMBAT', 'zh_Hans_CN',
       '+{1_Num} [ICON_Strength] 战斗力来自附近的首都。' ),

     -- 斯基泰
     ( 'LOC_TRAIT_CIVILIZATION_EXTRA_LIGHT_CAVALRY_DESCRIPTION', 'zh_Hans_CN',
       '可用 [ICON_FAITH] 信仰值购买轻骑兵或萨卡弓骑手，且花费减少15%。' ),

     -- 西班牙
     ( 'LOC_TRAIT_CIVILIZATION_TREASURE_FLEET_EXPANSION2_DESCRIPTION', 'zh_Hans_CN',
       '+1 [ICON_TradeRoute] 贸易路线容量。 [ICON_TradeRoute] 洲际贸易路线获得 +5 [ICON_Gold] 金币、+3 [ICON_Faith] 信仰值、+1 [ICON_PRODUCTION] 生产力。可以用 [ICON_Faith] 信仰购买商人。在非原始首都所在大陆上建立或征服城市时，该城市获得一个免费的建造者。人文主义后可构建舰队，重商主义可构建无敌舰队。' ),

     -- 苏美尔
     ( 'LOC_TRAIT_LEADER_ADVENTURES_ENKIDU_EXPANSION2_DESCRIPTION', 'zh_Hans_CN',
       '进攻时，单位从每个有效同盟处+1 [ICON_Strength] 战斗力。' ),
     ( 'LOC_TRAIT_CIVILIZATION_FIRST_CIVILIZATION_DESCRIPTION', 'zh_Hans_CN',
       '当您占领一个蛮族哨站时，您会获得部落村庄奖励，以及 [ICON_Gold] 金币，初始便获得30 [ICON_Gold] 金币。初始便获得1个 [ICON_ENVOY] 使者，每回合获得1点影响力。' ),
     ( 'LOC_MODIFIER_TRAIT_LEADER_BANNOCKBURN_COMBAT', 'zh_Hans_CN',
       '+{1_Num} [ICON_Strength] 战斗力来自同盟（恩奇都奇遇）。' ),


     -- 瑞典
     ( 'LOC_TRAIT_LEADER_KRISTINA_AUTO_THEME_DESCRIPTION', 'zh_Hans_CN',
       '全部槽位填满时，建筑和奇观可自动获得主题。可在市政广场中建造女王图书馆。' ),
     ( 'LOC_TRAIT_CIVILIZATION_NOBEL_PRIZE_DESCRIPTION', 'zh_Hans_CN',
       '建造学院、工业区及其建筑时+35% [ICON_PRODUCTION] 生产力。 [ICON_GreatScientist] 大科学家和 [ICON_GreatEngineer] 大工程师点数+50%。瑞典招募伟人时可获得10点 [ICON_Favor] 外交支持（联机速度下）。如瑞典在游戏中，进入工业时代后将增添3项特色世界议会竞赛。' ),
     ( 'LOC_BUILDING_QUEENS_BIBLIOTHEQUE_DESCRIPTION', 'zh_Hans_CN',
       '瑞典特色建筑。该建筑可以放置2个 [ICON_GreatWork_WRITING] 著作、3个 [ICON_GreatWork_Landscape] 艺术巨作。' ),

     -- 越南
     ( 'LOC_TRAIT_LEADER_TRIEU_DESCRIPTION', 'zh_Hans_CN',
       '在雨林、沼泽或树林单元格中战斗的单位+2 [ICON_Strength] 战斗力。单位无视这些地貌的 [ICON_Movement] 移动力减益。' ),


     -- 祖鲁
     ( 'LOC_DISTRICT_IKANDA_DESCRIPTION', 'zh_Hans_CN',
       '祖鲁特色区域，替代军营。提供 +1 [ICON_Housing] 住房。满足市政或科技先决条件后即可创建军团和军队。建成时提供一个枪兵。伊坎达中的建筑+1 [ICON_SCIENCE] 科技值。城市中的兵营额外+1 [ICON_CULTURE] 文化值，马厩+1 [ICON_SCIENCE] 科技值。可加快军团和军队的创建速度。' );
