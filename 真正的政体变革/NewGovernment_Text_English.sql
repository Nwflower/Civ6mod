
INSERT OR
REPLACE
INTO LocalizedText(Tag, Language, Text)
VALUES -- Level 0 Government
       --============================================================================
       ('LOC_GOVERNMENT_BULUO_NAME', 'en_US', 'Tribal'),
       ('LOC_PEDIA_GOVERNMENTS_PAGE_GOVERNMENT_BULUO_CHAPTER_HISTORY_PARA_1', 'en_US',
        'As an initial form of government at the dawn of civilization, tribal organization represents a decentralized social structure situated between "nomadic bands" and "chiefdoms," with blood ties at its core and egalitarianism as a principle, without yet forming centralized power institutions. This form of government, preceding the hierarchical systems of chiefdoms and the centralized theocracy of pharaohs, constitutes a crucial starting point in humanity''s transition from scattered survival groups to organized civilizations, providing the primordial model for the later evolution of complex political systems.'),

       -- Level 0.5 Government
       --============================================================================
       ('LOC_GOVERNMENT_PHARAOH_NAME', 'en_US', 'Sacred Monarchy'),
       ('LOC_GOVT_INHERENT_BONUS_PHARAOH', 'en_US', '+1 to all yields in the [ICON_CAPITAL] Capital.'),
       ('LOC_PEDIA_GOVERNMENTS_PAGE_GOVERNMENT_PHARAOH_CHAPTER_HISTORY_PARA_1', 'en_US',
       'The Sacred Monarchy was a fundamental system of government in ancient civilizations where the monarch embodied the link between the divine and the earthly. Its mechanism of power relied on two pillars: belief in a celestial lineage and the ruler''s role as the principal ritual intermediary with the deities. This duality transformed political obedience into a religious duty, consolidating centralized states around a figure who distributed divine favors in exchange for absolute loyalty. Notable examples include the pharaohs of early dynastic Egypt (c. 3100 BCE), considered incarnations of the god Horus; priest-kings of Sumerian city-states like Uruk and Ur, mediating between the population and the Mesopotamian pantheon; and monarchs of the Xia and Shang dynasties in China, whose divination rituals and ancestor worship legitimized their mandate as "Sons of Heaven." This model laid the theopolitical foundations for the first organized empires.'),

       ('LOC_GOVERNMENT_FENFENG_NAME', 'en_US', 'Fēngjiàn System'),
       ('LOC_GOVT_INHERENT_BONUS_FENFENG', 'en_US', 'Reduces tile purchase cost by 20%.'),
       ('LOC_PEDIA_GOVERNMENTS_PAGE_GOVERNMENT_FENFENG_CHAPTER_HISTORY_PARA_1', 'en_US',
        'As a fundamental system of government in the Classical Era, parallel to consular governments and military confederations, the Feudal System built a pyramidal governance structure "Emperor - Feudal Lords - Officials - Warriors" through "land grants as bonds and hierarchical loyalty as core." This system addressed the challenge of administering vast territories in early empires, and through the dual bonding of blood and contracts, provided a unique boost to military defense and cultural inheritance, representing a crucial form of government in the transition from tribal alliances to centralized power.'),

       -- Level 1.5 Government
       --============================================================================
       -- Centralization of Power
       ('LOC_GOVERNMENT_JUNXUANZHI_NAME', 'en_US', 'Centralized Autocracy'),
       -- Inherent Effect
       ('LOC_GOVT_INHERENT_BONUS_JUNXUANZHI', 'en_US', '+10% non-food yields in the [ICON_CAPITAL] Capital for each city.'),
       -- Accumulated Effect
       ('LOC_GOVT_ACCUMULATE_BONUS_JUNXUANZHI', 'en_US', 'Cities with a Governor gain +10 additional Loyalty.'),
       -- Civilopedia
       ('LOC_PEDIA_GOVERNMENTS_PAGE_GOVERNMENT_JUNXUANZHI_CHAPTER_HISTORY_PARA_1', 'en_US',
        'The earliest traces of this government system date back to the Qin dynasty in China, gradually maturing during the development of feudalism. The First Emperor Qin abolished the feudal system and implemented the commandery and district system, highly centralizing political, military, and economic power in the imperial court, breaking the decentralized pattern of previous feudal lords. It became the central political model to maintain a unified civilization during the feudal era, and its concentrated power structure profoundly influenced the organization of later political regimes in East Asia and other regions.'),

       -- Strengthening of Vassals
       ('LOC_GOVERNMENT_XINGSHENGFENQUAN_NAME', 'en_US', 'Feudal Monarchy'),
       -- Inherent Effect
       ('LOC_GOVT_INHERENT_BONUS_XINGSHENGFENQUAN', 'en_US', 'Cities with a Governor gain +20% [ICON_PRODUCTION] Production when training military units.'),
       -- Accumulated Effect
       ('LOC_GOVT_ACCUMULATE_BONUS_XINGSHENGFENQUAN', 'en_US', '+3% to all yields in other cities per district in the [ICON_CAPITAL] Capital.'),
       -- Civilopedia
       ('LOC_PEDIA_GOVERNMENTS_PAGE_GOVERNMENT_XINGSHENGFENQUAN_CHAPTER_HISTORY_PARA_1', 'en_US',
        'The Strengthened Vassalage system is closely linked to the rise of administrative structures in medieval Europe. Early vassal relations were often informal and personal. Establishing a formal administration allowed lords to systematize these bonds through standardized homage rituals, tribute quotas, and military obligations. This transformation not only consolidated the lord''s authority but also elevated vassalage from a "private pact" to an organized political institution, laying the groundwork for later governance models that combined bureaucracy with feudal ties.'),

       -- Aristocratic Republic
       ('LOC_GOVERNMENT_GUIZUGONGHE_NAME', 'en_US', 'Aristocratic Republic'),
       -- Inherent Effect
       ('LOC_GOVT_INHERENT_BONUS_GUIZUGONGHE', 'en_US', 'Wonders provide +4 [ICON_GOLD] Gold.'),
       -- Accumulated Effect
       ('LOC_GOVT_ACCUMULATE_BONUS_GUIZUGONGHE', 'en_US', 'All units gain +1 [ICON_MOVEMENT] Movement if starting their turn on a water tile.'),
       -- Civilopedia
       ('LOC_PEDIA_GOVERNMENTS_PAGE_GOVERNMENT_GUIZUGONGHE_CHAPTER_HISTORY_PARA_1', 'en_US',
        'First seen in Greek Sparta and the early Roman Republic, it was further consolidated with the rise of guilds. The aristocracy, by joining or incorporating guild power, replaced monarchical autocracy with collective decision-making, jointly exercising political power. This system avoided the pitfalls of absolute monarchy and, through oligarchic governance by the nobility, protected the interests of the ruling class, becoming a key political form between monarchy and democracy, providing an important reference for the institutional design of later city-states and republics.'),

       -- Level 2 Government
       --============================================================================
       -- Original Theocracy
       ('LOC_GOVERNMENT_THEOCRACY_NAME', 'en_US', 'Theocracy'),
       ('LOC_PEDIA_GOVERNMENTS_PAGE_GOVERNMENT_THEOCRACY_CHAPTER_HISTORY_PARA_1', 'en_US',
        'Its earliest traces appeared in the Rashidun Caliphate of the Arabian Peninsula in the 7th century AD, a unique form of government formed after the rise of Islam. This system was based on the teachings of the Quran as the foundation of governance, with the Caliph as both religious and political core, elected by the Muslim community rather than hereditary, combining theocratic authority with republican deliberation. It consolidated the foundations of Islamic propagation and, through collective assembly, prevented excessive concentration of power, becoming a model for early political organization in the Islamic world and profoundly influencing the later development of Islamic political systems.'),
       ('LOC_PEDIA_GOVERNMENTS_PAGE_GOVERNMENT_THEOCRACY_CHAPTER_HISTORY_PARA_2', 'en_US', ''),

       ('LOC_GOVERNMENT_MERCHANT_REPUBLIC_NAME', 'en_US', 'Merchant Republic'),

       -- Original Monarchy
       ('LOC_GOVERNMENT_MONARCHY_NAME', 'en_US', 'Monarchy'),
       ('LOC_PEDIA_GOVERNMENTS_PAGE_GOVERNMENT_MONARCHY_CHAPTER_HISTORY_PARA_1', 'en_US',
        'The origins of this government system trace back to ancient Sumerian city-states, where priests and city rulers were the same entity, exercising political power on behalf of divine authority. In the Middle Ages, this system matured in the Papal States of Europe and the Islamic world: religious doctrines became state law, and religious leaders (Pope, Caliph, etc.) also held secular power. It merged spiritual control with political governance, effectively maintaining social consensus and governmental order in a low-productivity era, but also somewhat hindered secular thought and social change due to the exclusivity of religious authority.'),
       ('LOC_PEDIA_GOVERNMENTS_PAGE_GOVERNMENT_MONARCHY_CHAPTER_HISTORY_PARA_2', 'en_US', ''),

       -- Level 2.5 Government
       --============================================================================
       ('LOC_GOVERNMENT_NW1_NAME', 'en_US', 'Metropolitan Centralized Colonialism'),
       -- Inherent Effect
       ('LOC_GOVT_INHERENT_BONUS_NW1', 'en_US',
        'Newly founded cities gain +4 initial [ICON_CITIZEN] Population. Cities not on the same continent as the Capital [ICON_CAPITAL] gain +15% to all yields but -5 Loyalty.'),
       -- Accumulated Effect
       ('LOC_GOVT_ACCUMULATE_BONUS_NW1', 'en_US',
        'Trade Routes provide +8 [ICON_GOLD] Gold and +1 [ICON_CULTURE] Culture.'),
       ('LOC_PEDIA_GOVERNMENTS_PAGE_GOVERNMENT_NW1_CHAPTER_HISTORY_PARA_1', 'en_US',
        'Its typical form first appeared in the Spanish colonial empire of the 16th century, a centralized government model implemented by the metropolis over overseas territories after the Discovery. The metropolis, through establishing specialized colonial institutions (such as the Spanish Council of the Indies) and directly appointing viceroys, fully centralized the economic (resource extraction, market monopoly), political, and military power of the colonies. This system, serving the interests of the metropolis at the expense of the colonies, not only provided crucial support for European primitive capital accumulation, but also built the basic framework of the modern global colonial system, while colonial contradictions became an important trigger for later national independence movements.'),

       ('LOC_GOVERNMENT_NW2_NAME', 'en_US', 'Liberal Capitalism'),
       -- Inherent Effect
       ('LOC_GOVT_INHERENT_BONUS_NW2', 'en_US',
        '[ICON_GOLD] Gold adjacency bonuses from Commercial Hubs and Harbors also provide [ICON_PRODUCTION] Production.'),
       -- Accumulated Effect
       ('LOC_GOVT_ACCUMULATE_BONUS_NW2', 'en_US',
        'At the start of each turn, gain interest equal to 5% of the Treasury''s [ICON_GOLD] Gold. Markets provide -1 Amenities [ICON_Amenities].'),
       ('LOC_PEDIA_GOVERNMENTS_PAGE_GOVERNMENT_NW2_CHAPTER_HISTORY_PARA_1', 'en_US',
        'It first formed in the United Kingdom after the Industrial Revolution of the 18th century, being the central political-economic form in the initial phase of capitalist development. Guided by Adam Smith''s "invisible hand" theory, this system advocated minimal government intervention in the economy, implementing principles of free trade, inviolability of private property, and free competition. It broke state monopolies and mercantilist trade barriers, greatly stimulating industrial vitality and driving explosive productivity growth, becoming the emblematic governance system in the transition of capitalism from the manufacturing stage to mechanized industry, though its inherent wealth polarization and periodic crises also led to subsequent social changes and institutional adjustments.'),

       ('LOC_GOVERNMENT_NW3_NAME', 'en_US', 'Constitutional Monarchy'),
       -- Inherent Effect
       ('LOC_GOVT_INHERENT_BONUS_NW3', 'en_US', '+1 [ICON_CULTURE] Culture per technology researched.'),
       -- Accumulated Effect
       ('LOC_GOVT_ACCUMULATE_BONUS_NW3', 'en_US', '+1 [ICON_SCIENCE] Science per civics researched. Cities not founded by you have -10% growth rate.'),
       ('LOC_PEDIA_GOVERNMENTS_PAGE_GOVERNMENT_NW3_CHAPTER_HISTORY_PARA_1', 'en_US',
        'It was first stably established in 1689 after the Declaration of Rights in England, a product of compromise and fusion between monarchy and democracy. This system retains the monarch as a state symbol ("reigns but does not rule"), granting central powers such as legislative and executive to institutions like parliament and cabinet, elected or legally established, achieving a balance of power under the principle of "the king is under the law." This system not only perpetuated the symbolic legitimacy of traditional monarchical power but also provided an institutional channel for the bourgeoisie to participate in government, successfully resolving the sharp contradictions between absolute monarchy and social change, becoming an important paradigm for the transition of many countries (such as Japan, Sweden) from feudalism to modern democracy.'),

       -- Level 3 Government
       --============================================================================
       ('LOC_GOVERNMENT_COMMUNISM_NAME', 'en_US', 'Socialism'),
       ('LOC_PEDIA_GOVERNMENTS_PAGE_GOVERNMENT_COMMUNISM_CHAPTER_HISTORY_PARA_1', 'en_US',
       'Its theory dates back to the mid-19th century, with the writings of Marx and Engels. After the October Revolution of 1917 in Russia, the Soviet regime became the first practical example. This system is based on public ownership of the means of production, aims to eliminate exploitation, and applies distribution according to labor (later developing the ideal concept of distribution according to needs). The state is led by a proletarian party representing the people. It broke capitalist monopolies and offered new development paths to backward countries and colonial liberation movements, promoting global discussions on economic equality. Its various practical forms (such as planned economies or market-combined systems) provide multiple references for modern governance.'),

       ('LOC_GOVERNMENT_FASCISM_NAME', 'en_US', 'Fascism'),

       ('LOC_GOVERNMENT_DEMOCRACY_NAME', 'en_US', 'Democracy'),
       ('LOC_PEDIA_GOVERNMENTS_PAGE_GOVERNMENT_DEMOCRACY_CHAPTER_HISTORY_PARA_1', 'en_US',
       'It emerged in mature form after the “Glorious Revolution” of 1688 in England, combining direct democracy with the governance needs of large states. It centers on parliament, whose representatives elected by citizens exercise legislative and oversight powers, while executive power resides in elected governments or cabinets. Its theoretical foundation traces back to the medieval English “Great Council” tradition and the 13th-century Magna Carta, establishing the principle that the king is subject to the law. With the 1689 Bill of Rights, parliament obtained decisive control over the monarchy.'),
       ('LOC_PEDIA_GOVERNMENTS_PAGE_GOVERNMENT_DEMOCRACY_CHAPTER_HISTORY_PARA_2', 'en_US',
       'Representative democracy solved problems arising from population growth that hindered direct democracy, creating a bridge between citizens and government through political parties. It guarantees citizen participation and improves efficiency through specialized representatives. This model was widely adopted: the U.S. developed a presidential republic, Germany adopted a parliamentary republic, and Japan maintains parliamentary representation within a constitutional monarchy.'),

       -- Level 4 Government
       --============================================================================
       ('LOC_GOVERNMENT_CORPORATE_LIBERTARIANISM_NAME', 'en_US', 'Corporate Libertarianism'),
       ('LOC_PEDIA_GOVERNMENTS_PAGE_GOVERNMENT_CORPORATE_LIBERTARIANISM_CHAPTER_HISTORY_PARA_1', 'en_US',
       'This system focuses on capital expansion, incorporating administrative, military, and economic functions into corporate management. The British Parliament''s takeover of India in 1858 marked the early decline of this type of government, but in the 20th century a new form emerged: the “United Citizens” case in the U.S. granted political rights to corporations via donations, restoring capital''s power over government. In civilization history, it represents a special evolution where commercial civilization breaks the constraints of traditional governments.'),

       ('LOC_GOVERNMENT_DIGITAL_DEMOCRACY_NAME', 'en_US', 'Digital Democracy'),
       ('LOC_PEDIA_GOVERNMENTS_PAGE_GOVERNMENT_DIGITAL_DEMOCRACY_CHAPTER_HISTORY_PARA_1', 'en_US',
       'As a technological government of the information age, its theory dates back to the publication of Norbert Wiener''s "Cybernetics" in 1948. It integrates AI algorithms, data monitoring, and administration, achieving dynamic social system balance through precise control: optimizing public services based on citizen data, predicting social risks, and efficiently allocating resources using intelligent systems.'),

       ('LOC_GOVERNMENT_SYNTHETIC_TECHNOCRACY_NAME', 'en_US', 'Communism'),
       ('LOC_PEDIA_GOVERNMENTS_PAGE_GOVERNMENT_SYNTHETIC_TECHNOCRACY_CHAPTER_HISTORY_PARA_1', 'en_US',
       'Communist theory is based on the tension between labor and value. Conceptually, it is more an economic system than a form of government. Marx noted that labor creates value, but workers (“proletariat”) only received minimal wages necessary to survive; all profits went to the owners of the means of production (“bourgeoisie”). Communism arose as a response: the proletariat governs and freely accesses the fruits of their labor. Ideally, this means everyone receives according to their ability and according to their needs, participating democratically in governance. In practice, communist states have struggled to achieve this vision, with many resorting to authoritarian measures. Stalin introduced nationalism and the cult of personality, while other agricultural leaders prioritized peasants. Based on this legacy, countries like North Korea adopted totalitarian rule, often indistinguishable from fascism in societal control.'),
       ('LOC_PEDIA_GOVERNMENTS_PAGE_GOVERNMENT_SYNTHETIC_TECHNOCRACY_CHAPTER_HISTORY_PARA_2', 'en_US',
       'Communism became an attractive choice for many countries seeking to free themselves from European colonialism. While capitalist countries promised integration into a Western-dominated global system, communists opted for self-sufficiency, maintaining political structures aligned with the USSR. Nationalism was also key, as patriotic sentiment helped overthrow colonial regimes. The Cold War arose from this division, with many states attempting intermediate paths suffering extreme dictatorships, like the Khmer Rouge in Cambodia. Today, some communist countries exist nominally, though many have adopted forms of capitalism: Cuba, Vietnam, Laos, and North Korea are current examples.');



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