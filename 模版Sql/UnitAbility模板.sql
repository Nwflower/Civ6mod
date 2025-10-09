--	FILE: %ModName%_UnitAbility.sql
--  VERSION: 1
--  Author: Nwflower
--  Spicial Thanks: Uni
--	Copyright (c) 2025.
--	All rights reserved.
--  DateCreated: 2025-10-8 22:34:02
--======================================================================
--  作者： 千川白浪
--  特别鸣谢： 优妮
--======================================================================

-- 定义一个新的单位能力
INSERT INTO Types (Type, Kind)
VALUES ('ABILITY_UNIT_NW_EXAMPLE', 'KIND_ABILITY');

-- 定义一个新的单位集合
INSERT INTO Tags (Tag, Vocabulary)
VALUES ('CLASS_UNIT_NW_EXAMPLE', 'ABILITY_CLASS');

-- 将单位能力和单位集合相关联
INSERT INTO TypeTags (Type, Tag)
VALUES ('UNIT_NW_EXAMPLE', 'CLASS_UNIT_NW_EXAMPLE'),
       ('ABILITY_UNIT_NW_EXAMPLE', 'CLASS_UNIT_NW_EXAMPLE');

INSERT INTO UnitAbilities (UnitAbilityType, Name, Description, Inactive)
VALUES ('ABILITY_UNIT_NW_EXAMPLE',
        'LOC_UNIT_NW_EXAMPLE_NAME',
        'LOC_UNIT_NW_EXAMPLE_DESCRIPTION',
        0 -- 该单位能力是否默认隐藏。为1时需要使用Modifier授予
       );

-- 已经定义好了授予的Modifier可以直接修改使用
-- INSERT INTO TraitModifiers (TraitType, ModifierId)
-- VALUES ('TRAIT_GRANT_UA_EXAMPLE', 'MODFEAT_GRANT_ABILITY_UNIT_NW_EXAMPLE');
INSERT INTO Modifiers (ModifierId, ModifierType, RunOnce, Permanent, NewOnly, OwnerRequirementSetId,
                       SubjectRequirementSetId)
VALUES ('MODFEAT_GRANT_ABILITY_UNIT_NW_EXAMPLE', 'MODIFIER_PLAYER_UNITS_GRANT_ABILITY', 0, 0, 0, NULL, NULL);
INSERT INTO ModifierArguments (ModifierId, Name, Value)
VALUES ('MODFEAT_GRANT_ABILITY_UNIT_NW_EXAMPLE', 'AbilityType', 'ABILITY_UNIT_NW_EXAMPLE');

-- H佬辅助工具内不包含的加力信息生成
-- INSERT INTO ModifierStrings (ModifierId, Context, Text)
-- VALUES ('MODFEAT_ABILITY_UNIT_NW_EXAMPLE_ADD_COMBAT', 'Preview', 'LOC_MODFEAT_ABILITY_UNIT_NW_EXAMPLE_ADD_COMBAT');
-- 常见加力信息示例：
-- +{1_Num} [ICON_Strength] 战斗力来自XXX。
-- +{Property} [ICON_Strength] 战斗力来自XXX。
-- [COLOR:Red]-{1_Num} [ICON_Strength] 战斗力来自XXX[ENDCOLOR]。
-- [COLOR:Red]-{Property} [ICON_Strength] 战斗力来自XXX[ENDCOLOR]。


-- 官方MODIFIER合集
INSERT INTO UnitAbilityModifiers (UnitAbilityType, ModifierId)
SELECT 'ABILITY_UNIT_NW_EXAMPLE', ModifierId
FROM UnitPromotionModifiers
WHERE UnitPromotionType IN
      (
       'PROMOTION_RANGER', -- 游骑兵：无视树林和雨林的移动力减益。
       'PROMOTION_ALPINE', -- 高山：无视丘陵的移动力减益。
       'PROMOTION_SENTRY', -- 哨兵：视野能穿过森林和丛林。
       'PROMOTION_GUERRILLA', -- 游击队：攻击后可移动。
       'PROMOTION_SPYGLASS', -- 望远镜：+1 视野范围。
       'PROMOTION_AMBUSH', -- 埋伏：在所有情况下 + 20 战斗力。
       'PROMOTION_CAMOUFLAGE', -- 伪装：只有相邻敌军单位才能发现该单位。
       'PROMOTION_BATTLECRY', -- 战嚎：与近战和远程单位战斗时 + 7 战斗力。
       'PROMOTION_TORTOISE', -- 龟形盾：防御远程攻击时 + 10 战斗力。
       'PROMOTION_COMMANDO', -- 突击队：+1 移动力。可攀登悬崖。
       'PROMOTION_AMPHIBIOUS', -- 水陆两栖：从海洋或河流进行攻击时，免除战斗力和移动力减益。
       'PROMOTION_ZWEIHANDER', -- 双手剑：与抗骑兵单位战斗时 + 7 战斗力。
       'PROMOTION_URBAN_WARFARE', -- 城镇战：当在区域内攻击时 + 10 战斗力。
       'PROMOTION_ELITE_GUARD', -- 精英卫队：如果移动力允许，每回合 + 1 额外攻击。可在攻击后移动。
       'PROMOTION_VOLLEY', -- 齐射：与陆地单位战斗时 + 5远程攻击力。
       'PROMOTION_GARRISON', -- 驻军：占领一个区域或一个提供防御力的改良设施时 + 10战斗力。
       'PROMOTION_ARROW_STORM', -- 风暴之箭：与陆地和海军单位战斗时 + 7远程攻击力。
       'PROMOTION_INCENDIARIES', -- 燃烧弹：攻击区域防御时 + 7远程攻击力。
       'PROMOTION_SUPPRESSION', -- 压制：学会区域控制。
       'PROMOTION_EMPLACEMENT', -- 炮台：防御城市攻击时 + 10战斗力。
       'PROMOTION_EXPERT_MARKSMAN', -- 神枪手：如果单位没有移动，每回合 + 1 额外攻击。
       'PROMOTION_GRAPE_SHOT', -- 霰弹：与陆地单位战斗时 + 7战斗力。
       'PROMOTION_CREW_WEAPONS', -- 重武器：防御时 + 7战斗力。
       'PROMOTION_SHRAPNEL', -- 榴霰弹：与陆地单位战斗时 + 10战斗力。
       'PROMOTION_SHELLS', -- 炮弹：攻击区域防御时 + 10战斗力。
       'PROMOTION_ADVANCED_RANGEFINDING', -- 先进测距：与海军单位战斗时 + 10战斗力。
       'PROMOTION_EXPERT_CREW', -- 专家组：移动后可攻击。
       'PROMOTION_FORWARD_OBSERVERS', -- 前方观察员：+1 射程。
       'PROMOTION_ECHELON', -- 梯队：与骑兵单位战斗时 + 5战斗力。
       'PROMOTION_THRUST', -- 突袭：与近战单位战斗时 + 5战斗力。
       'PROMOTION_SQUARE', -- 方阵：双倍支援加成。
       'PROMOTION_SCHILTRON', -- 长矛阵：防御近战系单位攻击时 + 10战斗力。
       'PROMOTION_REDEPLOY', -- 重新部署：+1移动力。
       'PROMOTION_CHOKE_POINTS', -- 咽喉要道：在树林、丛林、丘陵或沼泽防御时 + 7战斗力。
       'PROMOTION_HOLD_THE_LINE', -- 压阵：与骑兵战斗时，如有与不同类型战斗单位相邻 + 10战斗力。
       'PROMOTION_CAPARISON', -- 马衣：与抗骑兵单位战斗时 + 5战斗力。
       'PROMOTION_COURSERS', -- 追猎者：攻击远程和攻城单位时 + 5战斗力。
       'PROMOTION_DEPREDATION', -- 掠夺：掠夺只消耗 1 个移动力。
       'PROMOTION_DOUBLE_ENVELOPMENT', -- 两翼包围：两倍夹击加成。
       'PROMOTION_SPIKING_THE_GUNS', -- 火药失效：与攻城单位战斗时 + 7战斗力。
       'PROMOTION_PURSUIT', -- 追击：+1移动力。
       'PROMOTION_ESCORT_MOBILITY', -- 护卫队机动性：编队单位全部获得陪护单位移动力。
       'PROMOTION_CHARGE', -- 冲锋：与驻扎的单位战斗时 + 10战斗力。
       'PROMOTION_BARDING', -- 战马铠甲：防御远程攻击时 + 7战斗力。
       'PROMOTION_MARAUDING', -- 抢劫：在区域内战斗时，+7战斗力。
       'PROMOTION_ROUT', -- 击溃：与受损单位战斗时 + 5战斗力。
       'PROMOTION_ARMOR_PIERCING', -- 穿透护甲：与其他重骑兵单位战斗时 + 7战斗力。
       'PROMOTION_REACTIVE_ARMOR', -- 反应装甲：防御重骑兵和抗骑兵单位攻击时 + 7战斗力。
       'PROMOTION_BREAKTHROUGH', -- 突破：如果移动力允许，每回合 + 1 额外攻击。
       'PROMOTION_DOGFIGHTING', -- 空中缠斗：与战斗机系单位战斗时 + 7战斗力。
       'PROMOTION_COCKPIT_ARMOR', -- 座舱护甲：防御防空攻击时 + 7战斗力。
       'PROMOTION_INTERCEPTOR', -- 拦截机：与轰炸机单位战斗时 + 7战斗力。
       'PROMOTION_STRAFE', -- 扫射：与非骑兵单位战斗时 + 17战斗力。
       'PROMOTION_GROUND_CREWS', -- 地勤人员：巡逻或部署时可恢复。
       'PROMOTION_TANK_BUSTER', -- 坦克克星：与骑兵单位战斗时 + 17战斗力。
       'PROMOTION_DROP_TANKS', -- 副油箱：+2 射程。
       'PROMOTION_BOX_FORMATION', -- 方阵形式：防御战斗机系单位时 + 7战斗力。
       'PROMOTION_EVASIVE_MANEUVERS', -- 机动规避：防御防空攻击时 + 7战斗力。
       'PROMOTION_TORPEDO_BOMBER', -- 鱼雷轰炸机：与海军单位战斗时 + 17战斗力。
       'PROMOTION_CLOSE_AIR_SUPPORT', -- 近距空中支援：与陆地单位战斗时 + 12战斗力。
       'PROMOTION_TACTICAL_MAINTENANCE', -- 战术维护：攻击后可恢复。
       'PROMOTION_LONG_RANGE', -- 远程：+2 射程。
       'PROMOTION_SUPERFORTRESS', -- 超级堡垒：空中掠夺没有最低生命值要求。
       'PROMOTION_EMBOLON', -- 楔形阵：与海军单位战斗时 + 7战斗力。
       'PROMOTION_HELMSMAN', -- 舵手：+1移动力。
       'PROMOTION_REINFORCED_HULL', -- 加固船壳：防御远程攻击时 + 10战斗力。
       'PROMOTION_RUTTER', -- 航线海图：+1 视野范围。
       'PROMOTION_AUXILIARY_SHIPS', -- 辅助船：可在友军领土之外恢复。
       'PROMOTION_CONVOY', -- 护航队：位于一个编队内时 + 10战斗力。
       'PROMOTION_CREEPING_ATTACK', -- 匍匐攻击：与海军袭击者单位战斗时 + 14战斗力。
       'PROMOTION_LINE_OF_BATTLE', -- 战斗队形：与海军单位战斗时 + 7战斗力。
       'PROMOTION_BOMBARDMENT', -- 轰炸：攻击区域防御时 + 7战斗力。
       'PROMOTION_PREPARATORY_FIRE', -- 火力准备：与陆地单位战斗时 + 7战斗力。
       'PROMOTION_ROLLING_BARRAGE', -- 徐进弹：攻击区域防御时 + 10战斗力。
       'PROMOTION_SUPPLY_FLEET', -- 船舰补给：在友军领土之外恢复。
       'PROMOTION_PROXIMITY_FUSES', -- 近爆引管：防御空中攻击时 + 7战斗力。
       'PROMOTION_COINCIDENCE_RANGEFINDING', -- 测距一致：+1 射程。
       'PROMOTION_FLIGHT_DECK', -- 飞行甲板：+1 额外飞机槽位。
       'PROMOTION_HANGAR_DECK', -- 机库甲板：+1 额外飞机槽位。
       'PROMOTION_FOLDING_WINGS', -- 折翼：+1 额外飞机槽位。
       'PROMOTION_SCOUT_PLANES', -- 侦察飞机：+1 视野范围。
       'PROMOTION_ADVANCED_ENGINES', -- 先进发动机：+1移动力。
       'PROMOTION_DECK_CREWS', -- 甲板专员：在攻击后可恢复。
       'PROMOTION_SUPER_CARRIER', -- 超级航空母舰：在友军领土之外恢复。
       'PROMOTION_LOOT', -- 掠夺：海岸扫荡获得的 金币 + 50。
       'PROMOTION_BOARDING', -- 登船：从海军胜利中获得 金币。
       'PROMOTION_SWIFT_KEEL', -- 龙骨改良：+1移动力。
       'PROMOTION_HOMING_TORPEDOES', -- 自导鱼雷：与海军单位战斗时 + 10战斗力。
       'PROMOTION_OBSERVATION', -- 观察：+1 视野范围。
       'PROMOTION_SILENT_RUNNING', -- 无声运行：攻击后可移动。
       'PROMOTION_WOLFPACK', -- 狼群战术：每回合 + 1 额外攻击。
       'PROMOTION_ORATOR', -- 演说者：可额外传教 2 次。
       'PROMOTION_PROSELYTIZER', -- 劝导者：宗教传播将消除目标城市中其他宗教 75 的现有压力。
       'PROMOTION_TRANSLATOR', -- 翻译员：在其他文明的城市，宗教传播增强三倍。
       'PROMOTION_PILGRIM', -- 朝圣者：首次移动靠近一个自然奇观时，获得 3 次额外传播。
       'PROMOTION_INDULGENCE_VENDOR', -- 赎罪卷小贩：如果该单位首次让一座城市信奉您的宗教，您会获得 100 金币。
       'PROMOTION_HEATHEN_CONVERSION', -- 异教徒信仰转变：使用传教次数，能让附近所有蛮族信奉您的宗教。
       'PROMOTION_DEBATER', -- 辩论者：在神学战争中 + 20 宗教战斗力。
       'PROMOTION_MARTYR', -- 殉道者：如果该使徒在神学战斗中死了，会产生一个遗物。
       'PROMOTION_CHAPLAIN', -- 牧师：使徒和医疗兵一样，为附近 1 个单元格以内的单位提供额外恢复。
       'PROMOTION_MONK_SHADOW_STRIKE', -- 无影拳：两倍夹击加成。
       'PROMOTION_MONK_TWILIGHT_VEIL', -- 迷魂幕：只有相邻的敌方单位才能发现该单位。
       'PROMOTION_MONK_EXPLODING_PALMS', -- 穿心掌：在所有情况下 + 10战斗力。
       'PROMOTION_MONK_DISCIPLES', -- 弟子：此单位会在击败敌方单位后将其宗教传播到附近的城市中。
       'PROMOTION_MONK_SWEEPING_WIND', -- 风舞拳：如果移动力允许，每回合 + 1 额外攻击。
       'PROMOTION_MONK_DANCING_CRANE', -- 白鹤拳：+1移动力。
       'PROMOTION_MONK_COBRA_STRIKE', -- 蛇形拳：在所有情况下 + 15战斗力。
       'PROMOTION_SPY_TECHNOLOGIST', -- 技术专家：2 级窃取科技能力，有更高机率成功窃取科技。
       'PROMOTION_SPY_CAT_BURGLAR', -- 飞贼：2 级盗取能力，有更高机率成功盗取巨作。
       'PROMOTION_SPY_DEMOLITIONS', -- 爆破兵：2 级破坏生产能力，有更高机率成功破坏生产。
       'PROMOTION_SPY_CON_ARTIST', -- 骗子：2 级诈骗能力，有更高机率成功抽取资金。
       'PROMOTION_SPY_GUERILLA_LEADER', -- 游击队领袖：等级达到 2 级或以上，可招募游击队员。
       'PROMOTION_SPY_ROCKET_SCIENTIST', -- 火箭专家：2 级破坏火箭研究能力，有更高机率成功破坏火箭研究。
       'PROMOTION_SPY_SEDUCTION', -- 诱惑：2 级反间谍能力，有更高机率成功反间谍。
       'PROMOTION_SPY_DISGUISE', -- 掩饰：部署在敌人城市无需消耗时间。
       'PROMOTION_SPY_LINGUIST', -- 语言学家：完成所有任务的时间减少 25。
       'PROMOTION_SPY_QUARTERMASTER', -- 军需官：如果该间谍在自己的领土上，您所有间谍的等级 + 1。
       'PROMOTION_SPY_ACE_DRIVER', -- 王牌驾驶员：如果在执行任务时被捕，有更高机率逃脱（+4 等级）。
       'PROMOTION_SPY_SMEAR_CAMPAIGN', -- 恶意抹黑：2 级捏造丑闻能力，有更高机率成功捏造丑闻。
       'PROMOTION_SPY_COVERT_ACTION', -- 隐秘行动：2 级煽动骚乱能力，有更高机率成功煽动骚乱。
       'PROMOTION_SPY_LICENSE_TO_KILL', -- 杀戮执照：2 级陷害总督能力，有更高机率成功陷害总督。
       'PROMOTION_ALBUM_COVER_ART', -- 专辑封面：在奇观单元格中的表演效果提升 1 个等级。
       'PROMOTION_ARENA_ROCK', -- 舞台摇滚：娱乐设施区域单元格中的表演效果提升 2 个等级。
       'PROMOTION_GLAM_ROCK', -- 华丽摇滚：剧院广场区域单元格中的表演效果提升 2 个等级。
       'PROMOTION_GOES_TO', -- 音量爆表：10 个单元格内的文明获得本场音乐会 50 的 旅游业绩。
       'PROMOTION_INDIE', -- 独立摇滚：举办音乐会将导致城市失去 40 点忠诚度。
       'PROMOTION_MUSIC_FESTIVAL', -- 音乐节：国家公园和自然奇观中的表演效果提升 1 个等级，预计将获得 1000 点 旅游业绩。
       'PROMOTION_POP', -- 流行巨星：获得等同于产生 旅游业绩额度 25 的 金币。
       'PROMOTION_REGGAE_ROCK', -- 雷鬼音乐：水上乐园区域单元格中的表演效果提升 2 个等级。
       'PROMOTION_RELIGIOUS_ROCK', -- 宗教摇滚：举办音乐会将使此城市皈依文明创立的宗教。
       'PROMOTION_ROADIES', -- 乐队管家：+4移动力。
       'PROMOTION_SPACE_ROCK', -- 太空摇滚：在宇航中心和学院中的表演效果提升 1 个等级，+500 旅游业绩（如学院拥有大学，则 + 1000 旅游业绩）。
       'PROMOTION_SURF_ROCK', -- 冲浪摇滚：在海滨度假区和港口中的表演效果提升 1 个等级，+500 旅游业绩（如港口拥有造船厂，则 + 1000 旅游业绩）。
       'PROMOTION_SPY_SATCHEL_CHARGES', -- 爆炸装置：2 级破坏堤坝能力，有更高几率成功破坏堤坝。
       'PROMOTION_SPY_SURVEILLANCE', -- 监视：进行反间谍时效果将覆盖所有城市区域（1 格位内的区域将 + 1 等级）。
       'PROMOTION_SPY_POLYGRAPH', -- 测谎仪：如果该间谍处于本国领土中，境内敌方间谍的行动等级 - 1。
       'PROMOTION_GDR_AA_DEFENSE', -- 无人机防空： 对空防御力增至 130 点。
       'PROMOTION_GDR_SIEGE_LASER', -- 粒子束攻城巨炮：对城市和军营进行远程攻击的效率为 100，+30远程攻击力。
       'PROMOTION_GDR_BONUS_MOVEMENT', -- 增强机动：+3移动力。可进行 1 次跳跃，跨过山脉地貌。
       'PROMOTION_GDR_ARMOR_UPGRADE', -- 强力装甲：防御陆地与海军单位的攻击时 + 10战斗力。
       'PROMOTION_NIHANG_FLANKED_BONUS', -- 弯剑：遭夹击时 + 7战斗力。
       'PROMOTION_NIHANG_FAITH_FOR_VICTORIES', -- 三叉戟：击杀敌方单位后，获得等同于该单位基础战斗力 50 的 信仰值（标准速度下）。
       'PROMOTION_NIHANG_MOVEMENT_BONUS', -- 铁头战靴：+1移动力。
       'PROMOTION_NIHANG_NO_WOUNDED_PENALTY', -- 锁子甲：受伤不减战斗力。
       'PROMOTION_NIHANG_SUZERAIN_COMBAT_BONUS' -- 铁护腕：作为拉合尔的宗主国时 + 10战斗力。
);
