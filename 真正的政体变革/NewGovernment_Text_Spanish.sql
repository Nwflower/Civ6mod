INSERT OR
REPLACE
INTO LocalizedText(Tag, Language, Text)
VALUES -- Nivel 0 de Gobierno
       --============================================================================
       ('LOC_GOVERNMENT_BULUO_NAME', 'es_ES', 'Tribal'),
       ('LOC_PEDIA_GOVERNMENTS_PAGE_GOVERNMENT_BULUO_CHAPTER_HISTORY_PARA_1', 'es_ES',
        'Como forma de gobierno inicial en los albores de la civilización, la organización tribal representa una estructura social descentralizada situada entre las "bandas nómadas" y los "cacicazgos", con vínculos de sangre como núcleo y el igualitarismo como principio, sin haber formado aún instituciones de poder centralizadas. Esta forma de gobierno, que precede a los sistemas jerárquicos de los cacicazgos y a la teocracia centralizada de los faraones, constituye un punto de partida crucial en la transición de la humanidad desde grupos de supervivencia dispersos hacia civilizaciones organizadas, proporcionando el modelo primigenio para la evolución posterior de sistemas políticos complejos.'),

       -- Nivel 0.5 de Gobierno
       --============================================================================
       ('LOC_GOVERNMENT_PHARAOH_NAME', 'es_ES', 'Realeza sagrada'),
       ('LOC_GOVT_INHERENT_BONUS_PHARAOH', 'es_ES', '+1 a todos los rendimientos en la Capital [ICON_CAPITAL].'),
       ('LOC_PEDIA_GOVERNMENTS_PAGE_GOVERNMENT_PHARAOH_CHAPTER_HISTORY_PARA_1', 'es_ES',
       'La Realeza Sagrada fue un sistema de gobierno fundamental en las civilizaciones antiguas donde el monarca encarnaba el vínculo entre lo divino y lo terrenal. Su mecanismo de poder se basaba en dos pilares: la creencia en un linaje de origen celestial y la función del soberano como principal intermediario ritual con las deidades. Esta dualidad transformaba la obediencia política en un deber religioso, consolidando estados centralizados alrededor de una figura que distribuía favores divinos a cambio de lealtad absoluta. Algunos ejemplos emblemáticos incluyen a los faraones del Egipto dinástico temprano (3100 a.C.), considerados encarnaciones del dios Horus; los reyes-sacerdotes de las ciudades-estado sumerias como Uruk y Ur, que mediaban entre la población y el panteón mesopotámico; y los monarcas de la China Xia y Shang, cuyos rituales de adivinación y culto a los ancestros legitimaban su mandato como "Hijos del Cielo". Este modelo sentó las bases teopolíticas de los primeros imperios organizados.'),
       
       ('LOC_GOVERNMENT_FENFENG_NAME', 'es_ES', 'Sistema Fēngjiàn'),
       ('LOC_GOVT_INHERENT_BONUS_FENFENG', 'es_ES', 'Reduce en un 20% el coste de compra de casillas.'),
       ('LOC_PEDIA_GOVERNMENTS_PAGE_GOVERNMENT_FENFENG_CHAPTER_HISTORY_PARA_1', 'es_ES',
        'Como sistema de gobierno fundamental de la Era Clásica, paralelo a los sistemas de gobierno consular y confederaciones militares, el Sistema Feudal construyó una estructura piramidal de gobierno "Emperador - Señores Feudales - Oficiales - Guerreros" mediante "concesiones de tierras como vínculo y lealtad jerárquica como núcleo". Este sistema resolvió el desafío de administrar vastos territorios en los primeros imperios y, a través de la doble vinculación de la sangre y los contratos, proporcionó un impulso único para la defensa militar y la herencia cultural, representando una forma de gobierno crucial en la transición de las alianzas tribales hacia la centralización del poder.'),

       -- Nivel 1.5 de Gobierno
       --============================================================================
       -- Centralización del Poder
       ('LOC_GOVERNMENT_JUNXUANZHI_NAME', 'es_ES', 'Autocracia Centralizada'),
       -- Efecto Heredado
       ('LOC_GOVT_INHERENT_BONUS_JUNXUANZHI', 'es_ES', '+10% a los rendimientos no alimenticios de la Capital [ICON_CAPITAL] por cada ciudad.'),
       -- Efecto Inherente
       ('LOC_GOVT_ACCUMULATE_BONUS_JUNXUANZHI', 'es_ES', 'Las ciudades con un Gobernador obtienen +10 de Lealtad adicional.'),
       -- Civilopedia
       ('LOC_PEDIA_GOVERNMENTS_PAGE_GOVERNMENT_JUNXUANZHI_CHAPTER_HISTORY_PARA_1', 'es_ES',
        'Los primeros vestigios de este sistema de gobierno se remontan a la dinastía Qin en China, madurando gradualmente durante el desarrollo del feudalismo. El Primer Emperador Qin abolió el sistema feudal e implementó el sistema de comanderías y distritos, centralizando altamente el poder político, militar y económico en la corte imperial, rompiendo el patrón descentralizado de señores feudales anteriores. Se convirtió en el modelo político central para mantener la civilización unificada durante la era feudal, y su estructura de poder concentrado influyó profundamente en la organización de regímenes políticos posteriores en Asia Oriental y otras regiones.'),

       -- Fortalecimiento de Vasallos
       ('LOC_GOVERNMENT_XINGSHENGFENQUAN_NAME', 'es_ES', 'Monarquía Feudal'),
       -- Efecto Heredado
       ('LOC_GOVT_INHERENT_BONUS_XINGSHENGFENQUAN', 'es_ES', 'Las ciudades con un Gobernador ganan +20% de Producción [ICON_PRODUCTION] al entrenar unidades militares.'),
       -- Efecto Inherente
       ('LOC_GOVT_ACCUMULATE_BONUS_XINGSHENGFENQUAN', 'es_ES', '+3% a todos los rendimientos en otras ciudades por cada distrito en la Capital [ICON_CAPITAL].'),
       -- Civilopedia
       ('LOC_PEDIA_GOVERNMENTS_PAGE_GOVERNMENT_XINGSHENGFENQUAN_CHAPTER_HISTORY_PARA_1', 'es_ES',
        'El sistema de Vasallaje Fortalecido está estrechamente relacionado con el surgimiento de estructuras administrativas en la Europa medieval. Las primeras relaciones de vasallaje eran a menudo informales y personales. El establecimiento de una administración formal permitió a los señores sistematizar estos vínculos mediante la estandarización de los rituales de homenaje, las cuotas tributarias y las obligaciones militares. Esta transformación no solo consolidó la autoridad del señor, sino que también elevó el vasallaje de un "pacto privado" a una institución política ordenada, sentando las bases para modelos de gobierno posteriores que combinaban la burocracia con los lazos feudales.'),

       -- República Aristocrática
       ('LOC_GOVERNMENT_GUIZUGONGHE_NAME', 'es_ES', 'República Aristocrática'),
       -- Efecto Heredado
       ('LOC_GOVT_INHERENT_BONUS_GUIZUGONGHE', 'es_ES',
        'Las Maravillas otorgan +4 de Oro [ICON_GOLD].'),
       -- Efecto Inherente
       ('LOC_GOVT_ACCUMULATE_BONUS_GUIZUGONGHE', 'es_ES',
        'Todas las unidades obtienen +1 de Movimiento [ICON_MOVEMENT] si comienzan su turno en una casilla de agua.'),
       -- Civilopedia
       ('LOC_PEDIA_GOVERNMENTS_PAGE_GOVERNMENT_GUIZUGONGHE_CHAPTER_HISTORY_PARA_1', 'es_ES',
        'Visible por primera vez en la Esparta griega y la temprana República Romana, se consolidó aún más con el auge de los gremios. La aristocracia, uniéndose o incorporando el poder de los gremios, reemplazó la autocracia monárquica con la toma de decisiones colectiva, ejerciendo conjuntamente el poder político. Este sistema evitó los inconvenientes del absolutismo monárquico y, a través del gobierno oligárquico conjunto de la nobleza, protegió los intereses de la clase dominante, convirtiéndose en una forma política clave entre la monarquía y la democracia, proporcionando un importante referente para el diseño institucional de ciudades-estado y repúblicas posteriores.'),

       -- Nivel 2 de Gobierno
       --============================================================================
       -- Teocracia original
       ('LOC_GOVERNMENT_THEOCRACY_NAME', 'es_ES', 'Teocrácia'),
       ('LOC_PEDIA_GOVERNMENTS_PAGE_GOVERNMENT_THEOCRACY_CHAPTER_HISTORY_PARA_1', 'es_ES',
        'Sus primeros vestigios aparecieron en el Califato Rashidun de la Península Arábiga en el siglo VII d.C., una forma de gobierno única formada tras el surgimiento del Islam. Este sistema se basaba en las enseñanzas del Corán como fundamento de gobierno, con el Califa como doble núcleo religioso y político, elegido por la comunidad musulmana en lugar de ser hereditario, combinando la autoridad teocrática con la deliberación republicana. Consolidó los cimientos de la propagación islámica y, mediante la forma de asamblea colectiva, evitó una concentración excesiva de poder, convirtiéndose en un modelo para la organización política temprana del mundo islámico e influyendo profundamente en el desarrollo posterior de los sistemas políticos islámicos.'),
       ('LOC_PEDIA_GOVERNMENTS_PAGE_GOVERNMENT_THEOCRACY_CHAPTER_HISTORY_PARA_2', 'es_ES',
        ''),

       ('LOC_GOVERNMENT_MERCHANT_REPUBLIC_NAME', 'es_ES', 'República Mercantil'),

       -- Monarquía original
       ('LOC_GOVERNMENT_MONARCHY_NAME', 'es_ES', 'Monarquia'),
       ('LOC_PEDIA_GOVERNMENTS_PAGE_GOVERNMENT_MONARCHY_CHAPTER_HISTORY_PARA_1', 'es_ES',
        'Los brotes de este sistema de gobierno se remontan a las antiguas ciudades-estado sumerias, donde los sacerdotes y los gobernantes de la ciudad eran la misma entidad, ejerciendo el poder político en nombre de la autoridad divina. Al entrar en la Edad Media, este sistema maduró en los Estados Papales de Europa y el mundo islámico: las doctrinas religiosas se convirtieron directamente en ley estatal, y los líderes religiosos (Papa, Califa, etc.) también ostentaban el poder secular. Fusionó el control espiritual con la gobernanza política, cohesionando efectivamente el consenso social y manteniendo el orden de gobierno en una era de baja productividad, pero también obstaculizó en cierta medida el pensamiento secular y el cambio social debido a la naturaleza exclusivista de la autoridad religiosa.'),
       ('LOC_PEDIA_GOVERNMENTS_PAGE_GOVERNMENT_MONARCHY_CHAPTER_HISTORY_PARA_2', 'es_ES',
        ''),

       -- Nivel 2.5 de Gobierno
       --============================================================================
       ('LOC_GOVERNMENT_NW1_NAME', 'es_ES', 'Colonialismo Centralizado Metropolitano'),
       -- Efecto Heredado
       ('LOC_GOVT_INHERENT_BONUS_NW1', 'es_ES',
        'Las ciudades recién fundadas obtienen +4 de Población [ICON_CITIZEN] inicial. Las ciudades que no estén en el mismo continente que la Capital [ICON_CAPITAL] obtienen +15% a todos los rendimientos pero -5 de Lealtad.'),
       -- Efecto Inherente
       ('LOC_GOVT_ACCUMULATE_BONUS_NW1', 'es_ES',
        'Las Rutas Comerciales otorgan +8 de Oro [ICON_GOLD] y +1 de Cultura [ICON_CULTURE].'),
       ('LOC_PEDIA_GOVERNMENTS_PAGE_GOVERNMENT_NW1_CHAPTER_HISTORY_PARA_1', 'es_ES',
        'Su forma típica apareció por primera vez en el Imperio colonial español del siglo XVI, un modelo de gobierno centralizado implementado por la metrópoli sobre territorios de ultramar tras el Descubrimiento. La metrópoli, mediante el establecimiento de instituciones coloniales especializadas (como el Consejo de Indias español) y el nombramiento directo de virreyes, centralizó completamente el poder económico (saqueo de recursos, monopolio de mercados), político y militar de las colonias. Este sistema, que servía a los intereses de la metrópoli a expensas de las colonias, no sólo proporcionó un apoyo crucial para la acumulación primitiva de capital europeo, sino que también construyó el marco básico del sistema colonial global moderno, mientras que las contradicciones coloniales agravadas se convirtieron en un importante detonante de los posteriores movimientos de independencia nacional.'),

       ('LOC_GOVERNMENT_NW2_NAME', 'es_ES',
        'Capitalismo Liberal'),
       -- Efecto Heredado
       ('LOC_GOVT_INHERENT_BONUS_NW2', 'es_ES',
        'Las bonificaciones por adyacencia de Oro [ICON_GOLD] de los Centros Comerciales y Puertos también proporcionan Producción [ICON_PRODUCTION].'),
       -- Efecto Inherente
       ('LOC_GOVT_ACCUMULATE_BONUS_NW2', 'es_ES',
        'Al comienzo de cada turno, obtienes intereses equivalentes al 5% del Oro [ICON_GOLD] del Tesoro. Los Mercados otorgan -1 Servicios [ICON_Amenities].'),
       ('LOC_PEDIA_GOVERNMENTS_PAGE_GOVERNMENT_NW2_CHAPTER_HISTORY_PARA_1', 'es_ES',
        'Se conformó primero en el Reino Unido tras la Revolución Industrial del siglo XVIII, siendo la forma político-económica central en la fase inicial de desarrollo capitalista. Este sistema, guiado por la teoría de la "mano invisible" de Adam Smith, abogaba por una menor intervención gubernamental en la economía, implementando principios de libre comercio, inviolabilidad de la propiedad privada y libre competencia. Rompió los monopolios estatales y las barreras comerciales de la era mercantilista, estimulando enormemente la vitalidad industrial y impulsando un crecimiento explosivo de la productividad, convirtiéndose en el sistema de gobierno emblemático de la transición del capitalismo desde la etapa manufacturera hacia la industria mecanizada, aunque su inherente polarización de la riqueza y las crisis periódicas también generaron posteriores cambios sociales y ajustes institucionales.'),

       ('LOC_GOVERNMENT_NW3_NAME', 'es_ES',
        'Monarquía Constitucional'),
       -- Efecto Heredado
       ('LOC_GOVT_INHERENT_BONUS_NW3', 'es_ES',
        '+1 de Cultura por cada tecnología investigada [ICON_CULTURE].'),
       -- Efecto Inherente
       ('LOC_GOVT_ACCUMULATE_BONUS_NW3', 'es_ES',
        '+1 de Ciencia [ICON_SCIENCE] por cada civismo investigado. Las ciudades no fundadas por ti tienen -10% de tasa de crecimiento.'),
       ('LOC_PEDIA_GOVERNMENTS_PAGE_GOVERNMENT_NW3_CHAPTER_HISTORY_PARA_1', 'es_ES',
        'Se estableció por primera vez de forma estable en 1689 tras la promulgación de la Declaración de Derechos en Inglaterra, producto del compromiso y fusión entre la monarquía y la democracia. Este sistema conserva al monarca como símbolo del estado ("reina pero no gobierna"), otorgando poderes centrales como el legislativo y el ejecutivo a instituciones como el parlamento y el gabinete, electas o establecidas por ley, logrando un equilibrio de poder bajo el principio de "el rey está bajo la ley". Este sistema no sólo perpetuó el símbolo de legitimidad del poder monárquico tradicional, sino que también proporcionó un canal institucional para que la burguesía participara en el gobierno, resolviendo con éxito las agudas contradicciones entre el absolutismo monárquico y el cambio social, convirtiéndose en un importante paradigma para la transición de muchos países (como Japón, Suecia) desde el sistema feudal hacia la democracia moderna.'),

       -- Nivel 3 de Gobierno
       --============================================================================
       ('LOC_GOVERNMENT_COMMUNISM_NAME', 'es_ES',
       'Socialismo'),
       ('LOC_PEDIA_GOVERNMENTS_PAGE_GOVERNMENT_COMMUNISM_CHAPTER_HISTORY_PARA_1', 'es_ES',
       'Su teoría se remonta a mediados del siglo XIX, con los escritos de Marx y Engels. Tras la Revolución de Octubre de 1917 en Rusia, el régimen soviético se convirtió en el primer ejemplo práctico. Este sistema se basa en la propiedad pública de los medios de producción, busca eliminar la explotación y aplicar la distribución según el trabajo (desarrollándose posteriormente la idea ideal de distribución según las necesidades). El estado es dirigido por un partido proletario que representa al pueblo. Rompió los monopolios del capitalismo y ofreció nuevas vías de desarrollo a países atrasados y movimientos de liberación colonial, promoviendo discusiones globales sobre la igualdad económica. Sus diversas formas prácticas (como la economía planificada o combinada con mercado) ofrecen referencias múltiples para la gobernanza moderna.'),
       ('LOC_GOVERNMENT_FASCISM_NAME', 'es_ES',
       'Fascismo'),
       ('LOC_GOVERNMENT_DEMOCRACY_NAME', 'es_ES',
       'Democracia'),
       ('LOC_PEDIA_GOVERNMENTS_PAGE_GOVERNMENT_DEMOCRACY_CHAPTER_HISTORY_PARA_1', 'es_ES',
       'Surgió en forma madura tras la “Revolución Gloriosa” de 1688 en Inglaterra, combinando democracia directa con necesidades de gobernanza de grandes estados. Se centra en el parlamento, cuyos representantes elegidos por los ciudadanos ejercen el poder legislativo y de supervisión, mientras que el ejecutivo recae en gobiernos o gabinetes electos. Su fundamento teórico se remonta a la tradición medieval inglesa del “Gran Consejo” y a la Carta Magna del siglo XIII, estableciendo el principio de que el rey está sujeto a la ley. Con la aprobación de la Declaración de Derechos en 1689, el parlamento obtuvo un control decisivo sobre la monarquía.'),
       ('LOC_PEDIA_GOVERNMENTS_PAGE_GOVERNMENT_DEMOCRACY_CHAPTER_HISTORY_PARA_2', 'es_ES',
       'La democracia representativa resolvió problemas derivados del crecimiento poblacional que dificultaban la democracia directa, creando un puente entre ciudadanos y gobierno mediante partidos políticos. Garantiza participación ciudadana y mejora la eficiencia mediante representantes especializados. Este modelo fue ampliamente adoptado: EE. UU. desarrolló la república presidencial, Alemania adoptó la república parlamentaria, y Japón mantiene la representación parlamentaria dentro de una monarquía constitucional.'),

       -- Nivel 4 de Gobierno
       --============================================================================
       ('LOC_GOVERNMENT_CORPORATE_LIBERTARIANISM_NAME', 'es_ES',
       'Libertarismo Corporativo'),
       ('LOC_PEDIA_GOVERNMENTS_PAGE_GOVERNMENT_CORPORATE_LIBERTARIANISM_CHAPTER_HISTORY_PARA_1', 'es_ES',
       'Este sistema se centra en la expansión del capital, incorporando funciones administrativas, militares y económicas dentro de la gestión empresarial. La toma de control del Parlamento británico sobre India en 1858 marcó el declive temprano de este tipo de gobierno, pero en el siglo XX surgió una nueva forma: la decisión del caso "United Citizens" en EE. UU. otorgó derechos políticos a las corporaciones mediante donaciones, devolviendo el poder del capital sobre el gobierno. En la historia de la civilización, representa una evolución especial donde la civilización comercial rompe las restricciones de los gobiernos tradicionales.'),
       ('LOC_GOVERNMENT_DIGITAL_DEMOCRACY_NAME', 'es_ES',
       'Democracia Digital'),
       ('LOC_PEDIA_GOVERNMENTS_PAGE_GOVERNMENT_DIGITAL_DEMOCRACY_CHAPTER_HISTORY_PARA_1', 'es_ES',
       'Como gobierno tecnológico de la era de la información, su teoría se remonta a la publicación de "Cibernética" de Norbert Wiener en 1948. Se caracteriza por integrar algoritmos de IA, monitoreo de datos y administración, logrando un equilibrio dinámico del sistema social mediante control preciso: optimizando servicios públicos a partir de datos de ciudadanos, prediciendo riesgos sociales y distribuyendo recursos eficientemente con sistemas inteligentes.'),
       ('LOC_GOVERNMENT_SYNTHETIC_TECHNOCRACY_NAME', 'es_ES',
       'Comunismo'),
       ('LOC_PEDIA_GOVERNMENTS_PAGE_GOVERNMENT_SYNTHETIC_TECHNOCRACY_CHAPTER_HISTORY_PARA_1', 'es_ES',
       'La teoría comunista se basa en la tensión entre trabajo y valor. Conceptualmente es más un sistema económico que un gobierno. Marx señaló que el trabajo crea valor, pero los trabajadores ("proletariado") recibían solo el salario mínimo necesario para sobrevivir; todas las ganancias iban al dueño de los medios de producción ("burguesía"). El comunismo surge como respuesta: el proletariado gobierna y accede libremente a los frutos de su trabajo. Idealmente, significa que cada persona recibe según sus capacidades y según sus necesidades, participando democráticamente en el gobierno. En la práctica, los estados comunistas han luchado por lograr esta visión, con muchos recurriendo a medidas autoritarias. Stalin introdujo el nacionalismo y el culto a la personalidad, y otros líderes agrícolas privilegiaron al campesinado. Basándose en este legado, países como Corea del Norte adoptaron un gobierno totalitario, a menudo indistinguible del fascismo en su control sobre la sociedad.'),
       ('LOC_PEDIA_GOVERNMENTS_PAGE_GOVERNMENT_SYNTHETIC_TECHNOCRACY_CHAPTER_HISTORY_PARA_2', 'es_ES',
       'El comunismo se convirtió en una opción atractiva para muchos países que buscaban liberarse del colonialismo europeo. Mientras los países capitalistas prometían integración en un sistema global dominado por Occidente, los comunistas optaron por la autosuficiencia, manteniendo estructuras políticas alineadas con la URSS. El nacionalismo también fue clave en estos países, ya que los sentimientos patrióticos ayudaron a derrocar regímenes coloniales. La Guerra Fría surgió de esta división, con muchos estados intentando rutas intermedias sufriendo dictaduras extremas, como los Jemeres Rojos en Camboya. Hoy, algunos países comunistas existen nominalmente, aunque muchos han adoptado formas de capitalismo: Cuba, Vietnam, Laos y Corea del Norte son ejemplos actuales.');


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