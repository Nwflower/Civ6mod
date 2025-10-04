INSERT OR
REPLACE
INTO LocalizedText(Tag, Language, Text)
VALUES -- 0级政体
       --============================================================================
       ('LOC_GOVERNMENT_BULUO_NAME', 'zh_Hans_CN',
        '部落'),
       ('LOC_PEDIA_GOVERNMENTS_PAGE_GOVERNMENT_BULUO_CHAPTER_HISTORY_PARA_1', 'zh_Hans_CN',
        '作为文明诞生前夜的初始政体形态，部落是介于 “游群” 与 “酋邦” 之间的分散性社会组织，以血缘联结为核心、平等主义为准则，尚未形成集中化权力机构。这种政体比酋邦的等级制、法老制的神权集权更早出现，是人类从零散生存群体向有组织文明过渡的关键起点，为后续复杂政体的演化提供了原始模板。'),
       -- 0.5级政体
       --============================================================================
       ('LOC_GOVERNMENT_PHARAOH_NAME', 'zh_Hans_CN',
        '法老'),
       ('LOC_GOVT_INHERENT_BONUS_PHARAOH', 'zh_Hans_CN',
        '[ICON_CAPITAL]首都的所有产出+1。'),
       ('LOC_PEDIA_GOVERNMENTS_PAGE_GOVERNMENT_PHARAOH_CHAPTER_HISTORY_PARA_1', 'zh_Hans_CN',
        '埃及君主政体漫长的延续由法老作为核心，其大概含义为“巨屋”。法老们在埃及拥有几乎至高无上的权利，但经过长达千年之后，他们的权利也开始衰退。埃及大祭司们开始和法老分庭抗礼。'),

       ('LOC_GOVERNMENT_FENFENG_NAME', 'zh_Hans_CN',
        '分封'),
       ('LOC_GOVT_INHERENT_BONUS_FENFENG', 'zh_Hans_CN',
        '购买单元格的费用降低20%。'),
       ('LOC_PEDIA_GOVERNMENTS_PAGE_GOVERNMENT_FENFENG_CHAPTER_HISTORY_PARA_1', 'zh_Hans_CN',
        '作为古典时代与合议督政制、军护邦联制并行的核心政体，分封制以 “土地分封为纽带、层级效忠为核心”，构建了 “天子 - 诸侯 - 卿大夫 - 士” 的金字塔式统治架构。这一制度既解决了早期帝国对广阔疆域的治理难题，又通过血缘与契约的双重绑定，为文明的军事防御与文化传承提供了独特动力，是从部落联盟向中央集权过渡的关键政体形态。'),

       -- 1.5级政体
       --============================================================================
       -- 中央集权
       ('LOC_GOVERNMENT_JUNXUANZHI_NAME', 'zh_Hans_CN',
        '中央集权'),
       --传承效果
       ('LOC_GOVT_INHERENT_BONUS_JUNXUANZHI', 'zh_Hans_CN',
        '每有一座城市，[ICON_CAPITAL]首都的非食物产出便+10%。'),
       --固有效果
       ('LOC_GOVT_ACCUMULATE_BONUS_JUNXUANZHI', 'zh_Hans_CN',
        '拥有总督的城市额外+10忠诚度。'),
       --文明百科
       ('LOC_PEDIA_GOVERNMENTS_PAGE_GOVERNMENT_JUNXUANZHI_CHAPTER_HISTORY_PARA_1', 'zh_Hans_CN',
        '这种政体的雏形最早可追溯至中国秦朝，在封建主义发展中逐步成熟。秦始皇废分封、行郡县，将政治、军事、经济权力高度集中于中央朝廷，打破了此前诸侯割据的松散格局。它成为封建时代维系大一统文明的核心政治模式，其权力集中的架构深刻影响了后世东亚及其他地区的政权组织形式。'),

       -- 封臣强化
       ('LOC_GOVERNMENT_XINGSHENGFENQUAN_NAME', 'zh_Hans_CN',
        '封臣强化'),
       --传承效果
       ('LOC_GOVT_INHERENT_BONUS_XINGSHENGFENQUAN', 'zh_Hans_CN',
        '拥有总督的城市，训练军事单位+20% [ICON_PRODUCTION] 生产力。'),
       --固有效果
       ('LOC_GOVT_ACCUMULATE_BONUS_XINGSHENGFENQUAN', 'zh_Hans_CN',
        '[ICON_CAPITAL]首都每有一个区域，其他城市的所有产出便+3%。'),
       --文明百科
       ('LOC_PEDIA_GOVERNMENTS_PAGE_GOVERNMENT_XINGSHENGFENQUAN_CHAPTER_HISTORY_PARA_1', 'zh_Hans_CN',
        '封臣强化与中世纪欧洲行政部门的兴起紧密相关。早期封臣关系松散，而行政部门的建立使得领主能通过规范封臣的效忠仪式、贡赋标准与军事义务，将附庸关系纳入系统管控。这一变革既巩固了领主的统治根基，又让封臣体系从 “私人约定” 升级为有序的政治制度，为后期官僚与附庸结合的治理模式奠定了基础。'),

       -- 贵族共和
       ('LOC_GOVERNMENT_GUIZUGONGHE_NAME', 'zh_Hans_CN',
        '贵族共和'),
       --传承效果
       ('LOC_GOVT_INHERENT_BONUS_GUIZUGONGHE', 'zh_Hans_CN',
        '奇观+4 [ICON_GOLD] 金币。'),
       --固有效果
       ('LOC_GOVT_ACCUMULATE_BONUS_GUIZUGONGHE', 'zh_Hans_CN',
        '所有单位从水域上开始回合时，+1 [ICON_MOVEMENT] 移动力。'),
       --文明百科
       ('LOC_PEDIA_GOVERNMENTS_PAGE_GOVERNMENT_GUIZUGONGHE_CHAPTER_HISTORY_PARA_1', 'zh_Hans_CN',
        '最早可见于古希腊斯巴达与罗马共和国早期，在公会兴起后进一步定型。贵族阶层联合或吸纳公会力量，以集体决策替代君主独断，共同执掌政权。它既规避了君主专制的弊端，又通过贵族寡头的联合统治维护了统治阶层利益，成为介于君主制与民主制之间的关键政治形态，为后世城邦与共和国的制度设计提供了重要参照。'),
       -- 2级政体
       --============================================================================
       -- 原先的神权政体
       ('LOC_GOVERNMENT_THEOCRACY_NAME', 'zh_Hans_CN',
        '神权共和'),
       ('LOC_PEDIA_GOVERNMENTS_PAGE_GOVERNMENT_THEOCRACY_CHAPTER_HISTORY_PARA_1', 'zh_Hans_CN',
        '其最早雏形见于公元 7 世纪阿拉伯半岛的拉希顿哈里发国，是伊斯兰教兴起后形成的独特政体。该政体以《古兰经》教义为治国根本，哈里发作为宗教与政治的双重核心，由穆斯林社群选举产生而非世袭，实现了神权权威与共和合议的结合。它既巩固了伊斯兰教的传播根基，又以集体议事的形式避免了权力过度集中，成为伊斯兰世界早期政权组织的典范，深刻影响了后续伊斯兰政体的发展方向。'),
       ('LOC_PEDIA_GOVERNMENTS_PAGE_GOVERNMENT_THEOCRACY_CHAPTER_HISTORY_PARA_2', 'zh_Hans_CN',
        ''),

       ('LOC_GOVERNMENT_MERCHANT_REPUBLIC_NAME', 'zh_Hans_CN',
        '商人共和国'),

       -- 原先的君主制
       ('LOC_GOVERNMENT_MONARCHY_NAME', 'zh_Hans_CN',
        '政教合一'),
       ('LOC_PEDIA_GOVERNMENTS_PAGE_GOVERNMENT_MONARCHY_CHAPTER_HISTORY_PARA_1', 'zh_Hans_CN',
        '这种政体的萌芽可追溯至古代苏美尔城邦，祭司与城邦统治者身份合一，以神权名义执掌政权。进入中世纪后，该政体在欧洲教皇国与伊斯兰世界走向成熟 —— 宗教教义直接成为国家法律，宗教领袖（教皇、哈里发等）同时掌握世俗统治权。它将精神控制与政治治理融为一体，在生产力低下的时代有效凝聚了社会共识、维系了统治秩序，但也因宗教权威的排他性，在一定程度上阻碍了世俗思想与社会变革的推进。'),
       ('LOC_PEDIA_GOVERNMENTS_PAGE_GOVERNMENT_MONARCHY_CHAPTER_HISTORY_PARA_2', 'zh_Hans_CN',
        ''),

       -- 2.5级政体
       --============================================================================
       ('LOC_GOVERNMENT_NW1_NAME', 'zh_Hans_CN',
        '宗主集权殖民'),
       --传承效果
       ('LOC_GOVT_INHERENT_BONUS_NW1', 'zh_Hans_CN',
        '新建立的城市+4初始 [ICON_CITIZEN] 人口。与[ICON_CAPITAL]首都不在同一大陆的城市，+15%所有产出但-5忠诚度。'),
       --固有效果
       ('LOC_GOVT_ACCUMULATE_BONUS_NW1', 'zh_Hans_CN',
        '贸易路线+8 [ICON_GOLD] 金币、+1 [ICON_CULTURE] 文化值。'),
       ('LOC_PEDIA_GOVERNMENTS_PAGE_GOVERNMENT_NW1_CHAPTER_HISTORY_PARA_1', 'zh_Hans_CN',
        '其典型形态最早出现于 16 世纪的西班牙殖民帝国，是地理大发现后宗主国对海外领地实施的集权统治模式。宗主国通过设立专门殖民机构（如西班牙印度事务委员会）、委派总督直接管辖，将殖民地的经济（资源掠夺、市场垄断）、政治与军事权力全面收归中央。这种政体以殖民地的利益为宗主国服务为核心，既为欧洲资本主义原始积累提供了关键支撑，也构建了近代全球殖民体系的基本框架，同时激化的殖民矛盾成为后续民族独立运动的重要诱因。'),

       ('LOC_GOVERNMENT_NW2_NAME', 'zh_Hans_CN',
        '自由资本主义'),
       --传承效果
       ('LOC_GOVT_INHERENT_BONUS_NW2', 'zh_Hans_CN',
        '商业中心和港口的 [ICON_GOLD] 金币相邻加成也提供 [ICON_PRODUCTION] 生产力。'),
       --固有效果
       ('LOC_GOVT_ACCUMULATE_BONUS_NW2', 'zh_Hans_CN',
        '每个回合开始时，获得等同于国库 [ICON_GOLD] 金币5%的利息。市场-1 [ICON_Amenities] 宜居度。'),
       ('LOC_PEDIA_GOVERNMENTS_PAGE_GOVERNMENT_NW2_CHAPTER_HISTORY_PARA_1', 'zh_Hans_CN',
        '18 世纪工业革命后在英国率先成型，是资本主义发展初期的核心政治经济形态。该政体以亚当・斯密 “看不见的手” 理论为指导，主张政府减少对经济的干预，推行自由贸易、私有财产神圣不可侵犯与自由竞争原则。它打破了重商主义时代的国家垄断与贸易壁垒，极大激发了工业生产活力，推动了生产力的爆发式增长，成为资本主义从工场手工业阶段迈向机器大工业阶段的标志性政体，但其内生的贫富分化与周期性危机也催生了后续的社会变革与制度调整。'),

       ('LOC_GOVERNMENT_NW3_NAME', 'zh_Hans_CN',
        '君主立宪'),
       --传承效果
       ('LOC_GOVT_INHERENT_BONUS_NW3', 'zh_Hans_CN',
        '每个已研究的科技值+1 [ICON_CULTURE] 文化值。'),
       --固有效果
       ('LOC_GOVT_ACCUMULATE_BONUS_NW3', 'zh_Hans_CN',
        '每个已研究的市政+1 [ICON_SCIENCE] 科技值。非您建立的城市-10%发展速率。'),
       ('LOC_PEDIA_GOVERNMENTS_PAGE_GOVERNMENT_NW3_CHAPTER_HISTORY_PARA_1', 'zh_Hans_CN',
        '最早以稳定形态确立于 1689 年英国《权利法案》颁布后，是君主制与民主制妥协融合的产物。该政体保留君主作为国家象征（统而不治），将立法权、行政权等核心权力赋予议会与内阁等民选或法定机构，实现了 “王在法下” 的权力制衡。它既延续了传统王权的合法性象征，又为资产阶级参与政权提供了制度通道，成功化解了君主专制与社会变革的尖锐矛盾，成为近代以来诸多国家（如日本、瑞典）从封建制向现代民主制过渡的重要范式。'),

       --============================================================================
       ('LOC_GOVERNMENT_COMMUNISM_NAME', 'zh_Hans_CN',
        '社会主义'),
       ('LOC_PEDIA_GOVERNMENTS_PAGE_GOVERNMENT_COMMUNISM_CHAPTER_HISTORY_PARA_1', 'zh_Hans_CN',
        '其理论源头可追溯至 19 世纪中叶马克思、恩格斯的著作，1917 年俄国十月革命后建立的苏维埃政权成为首个实践范例。该政体以生产资料公有制为经济基础，主张消灭剥削、实行按劳分配（后期发展出按需分配的理想目标），由无产阶级政党领导国家并代表人民行使权力。它打破了资本主义制度的垄断格局，为后发国家和殖民地解放运动提供了新的发展路径，深刻推动了全球贫富公平议题的讨论，其不同阶段的实践形态（如计划经济、市场经济结合模式）也为现代国家治理提供了多元参照。'),
       ('LOC_GOVERNMENT_FASCISM_NAME', 'zh_Hans_CN',
        '法西斯主义'),
       ('LOC_GOVERNMENT_DEMOCRACY_NAME', 'zh_Hans_CN',
        '代议制'),
       ('LOC_PEDIA_GOVERNMENTS_PAGE_GOVERNMENT_DEMOCRACY_CHAPTER_HISTORY_PARA_1', 'zh_Hans_CN',
        '最早以成熟形态确立于 1688 年英国 "光荣革命" 后，是直接民主与大国治理需求结合的产物。该政体以议会为核心权力载体，由公民选举代表行使立法权与监督权，行政权则归于民选政府或内阁，形成 "代表民意、分权制衡" 的架构。其理论源头可追溯至中世纪英国的 "大会议" 传统，13 世纪《大宪章》确立的 "王在法下" 原则为其奠定基础，但直到 1689 年《权利法案》颁布，才真正实现议会对王权的决定性制约。'),
       ('LOC_PEDIA_GOVERNMENTS_PAGE_GOVERNMENT_DEMOCRACY_CHAPTER_HISTORY_PARA_2', 'zh_Hans_CN',
        '代议制解决了人口膨胀导致的直接民主困境，通过政党政治搭建公民与政权的沟通桥梁，既保障了民众参与权，又通过专业代表提升治理效率。这种模式被广泛效仿：美国形成总统制共和代议制，德国采用议会共和制，日本则在君主立宪框架下保留代议核心，成为现代民主国家的主流政体范式。'),

       -- 4级政体
       --============================================================================
       ('LOC_GOVERNMENT_CORPORATE_LIBERTARIANISM_NAME', 'zh_Hans_CN',
        '巨型企业'),
       ('LOC_PEDIA_GOVERNMENTS_PAGE_GOVERNMENT_CORPORATE_LIBERTARIANISM_CHAPTER_HISTORY_PARA_1', 'zh_Hans_CN',
        '这种政体以资本扩张为核心目标，将行政、军事与经济职能纳入企业管理体系。1858 年英国议会接管印度标志着早期巨型企业政体的衰落，但 20 世纪后又出现新形态 —— 美国 "公民联合案" 裁决赋予企业政治献金权，使资本对政权的影响力重回高峰。在文明发展中，它成为商业文明突破传统政权束缚的特殊演进路径。'),
       ('LOC_GOVERNMENT_DIGITAL_DEMOCRACY_NAME', 'zh_Hans_CN',
        '社会控制论'),
       ('LOC_PEDIA_GOVERNMENTS_PAGE_GOVERNMENT_DIGITAL_DEMOCRACY_CHAPTER_HISTORY_PARA_1', 'zh_Hans_CN',
        '作为信息时代的技术化政体，其理论源头可追溯至 1948 年诺伯特・维纳《控制论》的发表，核心是通过技术手段实现社会系统的动态平衡。该政体将 AI 算法、数据监控与行政体系深度融合，以 "精准调控" 为特征：通过公民行为数据优化公共服务，依托算法预测社会风险，借助智能系统实现资源高效分配。'),
       ('LOC_GOVERNMENT_SYNTHETIC_TECHNOCRACY_NAME', 'zh_Hans_CN',
        '共产主义'),
       ('LOC_PEDIA_GOVERNMENTS_PAGE_GOVERNMENT_SYNTHETIC_TECHNOCRACY_CHAPTER_HISTORY_PARA_1', 'zh_Hans_CN',
        '共产主义理论建立在社会中工作和价值之间的紧张关系之上。在理论上，它更多是一种经济系统，而并非政体。在卡尔·马克思的著作中，他提出了一个问题：工作创造了价值，但工人（“无产阶级”）得到的却是维持他们生活和生存的最低工资。所有利润都归工厂（或农场、公司，或马克思笔下的“生产资料”）拥有者所得。对19世纪末20世纪初的许多人来说，这听起来简直就是巧取豪夺——他们的劳动成果被完全不工作的工厂老板（“资产阶级”）偷走。因此共产主义思想诞生了——“无产阶级专政”，意思是由工作的人进行统治，工人能够自由地获得自己的劳动成果。这与专制的“独裁”完全不同，理想的情况是，“无产阶级”最终意味着每个人、工人将“根据能力给予，根据需要接受”，并民主地参与政府治理（但在主要共产主义国家的历史中几乎很难找到有效民主治理的实例）。在实践中，共产主义国家在努力实现这一愿景。马克思的思想模型以工业生产为基础，那农业社会又应该如何处理呢？共产主义认为宗教是用来让社会底层安于现状的骗局，但那些对自己的信仰有深深依恋的工人们是否又应当抛弃宗教呢？共产主义认为这场斗争是一场跨越国界和种族的斗争，但那些不能接受国际统一的人又该如何呢？为了回答这些问题，马克思的意识形态变得支离破碎。苏联接受了这样一种观点，即一个选定的团体（即共产党）应该牵头实施这些变革（创造“马列主义”传统，就像现在的越南那样）。之后，约瑟夫·斯大林重新引入了民族主义，并将个人崇拜的理念引入到之前的反民族主义意识形态。随着苏联的发展，他们发现自己不得不用愈加严厉的手段来压制反对的声音。而其他领袖则认为，农民应该成为运动的核心，而不是工人。以斯大林的遗产为基础，朝鲜等地的领导人建立了极权统治，而这与他们宣称要反对的法西斯意识形态却几乎并无差别。'),
       ('LOC_PEDIA_GOVERNMENTS_PAGE_GOVERNMENT_SYNTHETIC_TECHNOCRACY_CHAPTER_HISTORY_PARA_1', 'zh_Hans_CN',
        '共产主义成为了许多摆脱欧洲殖民的国家的一个诱人选择。资本主义国家向“第三世界”承诺加入由西方公司主导的国际社会，而共产主义者则选择自食其力，并抵制这种秩序，但付出的代价是需要让国家政治体制与苏联保持一致。但在这些新兴的政体中，民族主义同样很重要，因为正是民族情感推翻了殖民政权。于是冷战诞生了：资本主义和共产主义主导的国际秩序撕裂了任何尝试走中间路线的国家，往往还会培育出完全背离其民主理想的独裁政权——红色高棉便是以共产主义之名大行恐怖之事，这个政权试图逐步将柬埔寨改造为无任何阶级区别的社会，并进行了“大清洗”，大屠杀直到越南军队介入才结束。共产党在许多国家仍然存在，但通常是作为小党派存在，许多名义上的共产主义国家已经接受了某种形式的资本主义（例如越南等）。但在明面上，目前存在的共产主义国家有古巴、越南、老挝等国，而结合了“金日成主义”和极权主义的朝鲜也位列其中。');


DELETE
FROM LocalizedText
WHERE Tag IN (
              'LOC_PEDIA_GOVERNMENTS_PAGE_GOVERNMENT_SYNTHETIC_TECHNOCRACY_CHAPTER_HISTORY_PARA_3',
              'LOC_PEDIA_GOVERNMENTS_PAGE_GOVERNMENT_SYNTHETIC_TECHNOCRACY_CHAPTER_HISTORY_PARA_4',
              'LOC_PEDIA_GOVERNMENTS_PAGE_GOVERNMENT_DIGITAL_DEMOCRACY_CHAPTER_HISTORY_PARA_2',
              'LOC_PEDIA_GOVERNMENTS_PAGE_GOVERNMENT_DIGITAL_DEMOCRACY_CHAPTER_HISTORY_PARA_3',
              'LOC_PEDIA_GOVERNMENTS_PAGE_GOVERNMENT_DIGITAL_DEMOCRACY_CHAPTER_HISTORY_PARA_4',
              'LOC_PEDIA_GOVERNMENTS_PAGE_GOVERNMENT_CORPORATE_LIBERTARIANISM_CHAPTER_HISTORY_PARA_2',
              'LOC_PEDIA_GOVERNMENTS_PAGE_GOVERNMENT_CORPORATE_LIBERTARIANISM_CHAPTER_HISTORY_PARA_3',
              'LOC_PEDIA_GOVERNMENTS_PAGE_GOVERNMENT_DIGITAL_DEMOCRACY_CHAPTER_HISTORY_PARA_4',
              'LOC_PEDIA_GOVERNMENTS_PAGE_GOVERNMENT_COMMUNISM_CHAPTER_HISTORY_PARA_2'
    );