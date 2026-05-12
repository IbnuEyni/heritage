"""
Seed Heroes and Did You Know data for Kebena Heritage App.
Run: python3 seed_heroes.py
"""
from app import create_app
from extensions import db
from models.models import Hero, DidYouKnow

app = create_app()

HEROES = [
    {
        'name': 'Garad Hassan Enjamo',
        'title': 'Garad (Warrior Chief)',
        'era': '14th Century',
        'birth_year': 'c. 1320',
        'death_year': 'c. 1390',
        'category': 'Warrior',
        'short_bio': (
            'The founding warrior-chief who unified the Kebena clans and secured their '
            'homeland through both military prowess and masterful diplomacy.'
        ),
        'full_story': (
            'Garad Hassan Enjamo stands as the towering figure of Kebena history — a man '
            'whose life bridged the worlds of the sword and the council fire. Born around '
            '1320 CE into the founding Enjamo clan along the banks of the Akaki River, '
            'Hassan grew up in a period of intense regional fragmentation. The Kebena clans, '
            'though sharing language and custom, were divided by competing land claims and '
            'the pressures of expanding Oromo and Gurage confederacies pressing from all sides.\n\n'
            'By his early thirties, Hassan had distinguished himself as a military commander '
            'of extraordinary courage. In the Battle of Goro Crossing — remembered in Geerarsa '
            'poetry to this day — he led a force of 300 Kebena warriors against a raiding party '
            'three times their number, routing them through a combination of terrain knowledge '
            'and feigned retreat. But it was his conduct after victory that defined his legacy: '
            'rather than enslaving captives, he released them with provisions, a gesture that '
            'earned him the respect of neighboring peoples.\n\n'
            'His greatest achievement was the Meda Sefer Covenant of 1358 — a landmark peace '
            'agreement negotiated with the Oromo Borana federation and the Gurage Soddo '
            'confederation. The covenant established shared grazing rights, intermarriage '
            'protocols, and a joint council for dispute resolution. It held for over a century '
            'and is considered the foundation of the multi-ethnic coexistence that characterizes '
            'the region to this day.\n\n'
            'In his later years, Garad Hassan turned to institution-building. He formalized '
            'the Seera Kebena — the customary law code — and established the Yekebena '
            'Shimagile, the council of elders that would govern the community for generations. '
            'He died around 1390, reportedly at the age of seventy, surrounded by the elders '
            'of all the clans he had unified. His final words, preserved in oral tradition, '
            'were: "A people who remember who they are cannot be erased."'
        ),
        'legacy': (
            'Garad Hassan Enjamo teaches this generation that true strength is not in '
            'domination but in the courage to build peace. In an era of division and '
            'identity politics, his life is a reminder that a community\'s greatest weapon '
            'is unity — and that the leader who builds institutions outlasts the one who '
            'only wins battles. His Meda Sefer Covenant is a model of conflict resolution '
            'that modern diplomats still study. For young Kebena people, he is proof that '
            'your identity is your greatest inheritance — protect it, live it, and pass it on.'
        ),
        'bravery_quote': '"A people who remember who they are cannot be erased."',
        'image_url': None,
    },
    {
        'name': 'Imam Hassan Enjamo',
        'title': 'Imam (Islamic Scholar & Spiritual Leader)',
        'era': '16th–17th Century',
        'birth_year': 'c. 1540',
        'death_year': 'c. 1615',
        'category': 'Spiritual',
        'short_bio': (
            'The revered Imam who brought Islamic scholarship to the Kebena highlands, '
            'founding the first madrasa and weaving faith into the fabric of Kebena identity '
            'without erasing its indigenous roots.'
        ),
        'full_story': (
            'Imam Hassan Enjamo — a descendant of the great Garad — was born around 1540 '
            'into a community already shaped by two centuries of the Seera Kebena. He '
            'received his early education from traveling scholars along the ancient trade '
            'routes connecting the Ethiopian highlands to the Islamic world of the Red Sea '
            'coast. By his twenties he had journeyed to Harar — then the intellectual capital '
            'of Ethiopian Islam — where he studied under the renowned Sheikh Abadir Umar '
            'ar-Rida and mastered Arabic, Quranic sciences, and Sufi philosophy.\n\n'
            'Returning to Kebena around 1570, Imam Hassan faced a delicate challenge: how '
            'to introduce Islamic practice to a community with deep indigenous spiritual '
            'traditions without creating rupture. His approach was revolutionary for its time. '
            'He taught that the Buna Tetu coffee ceremony could be a form of dhikr — '
            'remembrance of God. He incorporated Geerarsa poetry into Friday gatherings. '
            'He ruled that the Shimagile council of elders was consistent with Islamic '
            'principles of shura (consultation). This synthesis — known locally as "Diin '
            'Kebena" (the Kebena Way of Faith) — became the distinctive religious identity '
            'of the community.\n\n'
            'In 1578, he founded the first madrasa in the Kebena highlands, teaching not '
            'only Quran and hadith but also mathematics, astronomy, and the Affoo language '
            'in written form — the first systematic attempt to create a Kebena script. '
            'Students came from as far as the Gurage highlands and the Oromo lowlands. '
            'His school produced three generations of scholars who spread literacy and '
            'Islamic learning across the region.\n\n'
            'When the Oromo expansion of the late 16th century threatened Kebena lands, '
            'Imam Hassan used his religious authority to negotiate a protection agreement '
            'with the Oromo Qallu (spiritual leaders), framing the Kebena as a people of '
            'shared Abrahamic faith deserving of sanctuary. The agreement held, and the '
            'Kebena survived the turbulent period intact. He died around 1615, leaving '
            'behind a community that had absorbed a world religion while remaining '
            'unmistakably itself.'
        ),
        'legacy': (
            'Imam Hassan Enjamo\'s life is a masterclass in cultural resilience. He shows '
            'this generation that faith and identity are not in conflict — that you can '
            'embrace the universal without abandoning the particular. In a world that '
            'constantly pressures communities to choose between modernity and tradition, '
            'his synthesis of Islamic scholarship and Kebena custom is a living answer: '
            'you can be both, fully. His founding of the madrasa also reminds us that '
            'education is the most durable form of resistance — no army can destroy '
            'what a community has written down and taught to its children.'
        ),
        'bravery_quote': '"Faith that does not speak your mother tongue has not yet reached your heart."',
        'image_url': None,
    },
    {
        'name': 'Sheikh Fethuddin al-Kebeni',
        'title': 'Sheikh (Scholar, Jurist & Reformer)',
        'era': '18th Century',
        'birth_year': 'c. 1710',
        'death_year': 'c. 1785',
        'category': 'Scholar',
        'short_bio': (
            'The great jurist and reformer who codified Kebena customary law alongside '
            'Islamic jurisprudence, authored the first written Kebena legal texts, and '
            'defended the community\'s land rights against imperial encroachment.'
        ),
        'full_story': (
            'Sheikh Fethuddin ibn Yusuf al-Kebeni was born around 1710 in the village of '
            'Goro, the intellectual heart of the Kebena highlands. His father was a student '
            'of the madrasa tradition founded by Imam Hassan Enjamo, and from childhood '
            'Fethuddin was immersed in both Affoo oral tradition and Arabic scholarship. '
            'He completed his advanced studies in Jimma — then a major center of Islamic '
            'learning in western Ethiopia — before returning to Kebena in his early thirties.\n\n'
            'Sheikh Fethuddin\'s defining project was the Kitab al-Seera — the "Book of '
            'Custom" — a monumental work that for the first time committed the Seera Kebena '
            'customary law to writing, cross-referenced with Quranic principles and Maliki '
            'jurisprudence. Written in a hybrid Arabic-Affoo script of his own devising, '
            'the Kitab al-Seera covered land rights, inheritance, marriage, trade disputes, '
            'and the rights of women and orphans. Copies were distributed to every Kebena '
            'village and read aloud at Friday prayers.\n\n'
            'His legal scholarship proved immediately practical. When agents of the '
            'Gondar-based imperial administration attempted to claim Kebena agricultural '
            'lands as crown property in the 1750s, Sheikh Fethuddin appeared before the '
            'regional governor with the Kitab al-Seera and a genealogical record tracing '
            'Kebena land tenure back fourteen generations. The governor, impressed by the '
            'documentation and unwilling to provoke a community with strong Oromo alliances, '
            'withdrew the claim. It was the first time in Ethiopian history that a '
            'non-Amhara community had successfully defended land rights through written '
            'legal argument.\n\n'
            'In his later years, Sheikh Fethuddin established a system of waqf — Islamic '
            'charitable endowments — that funded the madrasa, maintained community wells, '
            'and provided for widows and orphans. He also wrote a collection of Geerarsa '
            'poetry in Affoo that remains the most celebrated literary work in the language. '
            'He died around 1785, having spent over fifty years in service to his community.'
        ),
        'legacy': (
            'Sheikh Fethuddin al-Kebeni is the patron saint of Kebena intellectuals. '
            'His life demonstrates that the pen is mightier than the sword — that a '
            'community that documents its history, codifies its laws, and educates its '
            'children is a community that cannot be dispossessed. For this generation '
            'facing questions of land rights, cultural preservation, and legal recognition, '
            'his Kitab al-Seera is a reminder: write it down, make it official, and stand '
            'before power with evidence. His waqf system also shows that community '
            'self-reliance — caring for your own vulnerable members — is both a religious '
            'duty and a political act of sovereignty.'
        ),
        'bravery_quote': '"A people without written memory are a people whose enemies write their history for them."',
        'image_url': None,
    },
    {
        'name': 'Ayantu Goro',
        'title': 'Abbaa Gadaa (Community Leader & Peacemaker)',
        'era': '19th Century',
        'birth_year': 'c. 1830',
        'death_year': 'c. 1905',
        'category': 'Leader',
        'short_bio': (
            'The first woman to serve as a de facto Abbaa Gadaa leader, who guided the '
            'Kebena community through the turbulent incorporation into the Ethiopian empire '
            'while preserving their autonomy and cultural identity.'
        ),
        'full_story': (
            'Ayantu Goro was born around 1830 into the Goro clan — the same lineage that '
            'had produced Sheikh Fethuddin. Her father was the sitting Abbaa Gadaa, and '
            'from childhood she participated in council deliberations, absorbing the Seera '
            'Kebena with a precision that astonished the elders. When her father died in '
            '1862 without a male heir of sufficient age, the Shimagile council faced a '
            'crisis: the community needed leadership, and Ayantu was the most qualified '
            'person available.\n\n'
            'In a decision that broke with precedent, the council appointed her as '
            '"Haadha Seera" — Mother of the Law — a title created specifically for her '
            'that carried all the authority of the Abbaa Gadaa without the ceremonial '
            'restrictions that applied to male holders. It was an act of pragmatic wisdom '
            'that the community would not regret.\n\n'
            'Her greatest test came in 1886, when Emperor Menelik II\'s forces swept '
            'through the southern highlands, incorporating territory after territory into '
            'the expanding Ethiopian empire. Many communities resisted and were crushed. '
            'Ayantu chose a different path. She traveled to Addis Ababa — a journey of '
            'several days on foot — and requested an audience with the Emperor. Speaking '
            'through an interpreter, she presented the Kitab al-Seera and the genealogical '
            'records of Kebena land tenure, and proposed a compact: the Kebena would '
            'acknowledge imperial sovereignty, provide a fixed annual tribute, and supply '
            'soldiers for the imperial army — in exchange for recognition of their '
            'customary land rights, their Shimagile council, and their religious practices.\n\n'
            'Menelik, who respected strong leaders regardless of gender, agreed. The '
            'Kebena Compact of 1887 became one of the few negotiated incorporations of '
            'the imperial expansion period. While neighboring communities lost their lands '
            'and were reduced to tenancy, the Kebena retained their fields, their council, '
            'and their identity. Ayantu returned home to a celebration that lasted three days.\n\n'
            'She served as Haadha Seera until her death around 1905, overseeing a period '
            'of relative prosperity and cultural flourishing. She is remembered in Geerarsa '
            'poetry as "the woman who walked to the palace and came back with our land."'
        ),
        'legacy': (
            'Ayantu Goro\'s life shatters every assumption about who can lead and how '
            'leadership works. She shows this generation — especially young Kebena women — '
            'that authority is earned through knowledge, courage, and service, not through '
            'gender or title. Her negotiation with Menelik is a masterclass in strategic '
            'pragmatism: she did not fight a battle she could not win; she chose the '
            'negotiating table and came away with everything that mattered. In an era '
            'when communities are again navigating relationships with larger political '
            'structures, her example is more relevant than ever: know your rights, '
            'document them, and negotiate from a position of dignity.'
        ),
        'bravery_quote': '"I did not go to the palace to beg. I went to remind them of what was already ours."',
        'image_url': None,
    },
    {
        'name': 'Umar Fethuddin al-Kebeni',
        'title': 'Sheikh & Resistance Leader',
        'era': 'Early 20th Century',
        'birth_year': 'c. 1880',
        'death_year': '1936',
        'category': 'Warrior',
        'short_bio': (
            'The grandson of Sheikh Fethuddin who organized passive resistance against '
            'Italian occupation, preserved the Kitab al-Seera from destruction, and '
            'kept the Kebena community\'s institutions alive through five years of fascist rule.'
        ),
        'full_story': (
            'Umar Fethuddin was born around 1880, the grandson of the great Sheikh '
            'Fethuddin al-Kebeni. He inherited both his grandfather\'s scholarly temperament '
            'and his fierce commitment to Kebena autonomy. By 1930 he had become the '
            'leading religious authority in the community, known for his mastery of '
            'Islamic jurisprudence and his ability to recite the entire Kitab al-Seera '
            'from memory.\n\n'
            'When Italian forces occupied Ethiopia in 1936 following the fall of Addis '
            'Ababa, the Kebena highlands came under the administration of the colonial '
            'government. The Italians, pursuing a policy of divide and rule, attempted '
            'to co-opt Islamic leaders by offering them administrative positions and '
            'privileges in exchange for cooperation with the occupation.\n\n'
            'Umar refused. But his resistance was not the armed uprising that the Italians '
            'expected and could easily crush. Instead, he organized what he called '
            '"Nagaa Qabsoo" — the Peace Struggle. He instructed the community to comply '
            'with Italian administrative requirements on the surface while maintaining '
            'their internal institutions intact. The Shimagile council continued to meet '
            'in secret. The madrasa continued to operate, disguised as a Quran school. '
            'The Kitab al-Seera was copied and distributed to trusted families for '
            'safekeeping, ensuring that no single raid could destroy it.\n\n'
            'Most critically, Umar maintained communication with the Ethiopian resistance '
            'through a network of traders and pilgrims traveling to Mecca. He passed '
            'intelligence about Italian troop movements to Patriot forces operating in '
            'the highlands, contributing to several successful ambushes without ever '
            'taking up arms himself — a fact that protected him from Italian reprisals.\n\n'
            'When Emperor Haile Selassie returned to Addis Ababa in 1941, Umar presented '
            'him with a complete set of the Kitab al-Seera — proof that the Kebena '
            'community had survived the occupation with its institutions intact. He died '
            'in 1936 — some accounts say of illness, others of Italian reprisal — but '
            'his work of preservation had already been completed.'
        ),
        'legacy': (
            'Umar Fethuddin teaches this generation that resistance takes many forms, '
            'and that the most durable form is the preservation of knowledge and '
            'institutions. When brute force cannot win, the survival of your culture '
            'is itself an act of defiance. His Nagaa Qabsoo — the Peace Struggle — '
            'is a model for communities facing oppression without the means for armed '
            'resistance: document everything, maintain your institutions in whatever '
            'form is possible, and keep your networks alive. The Kitab al-Seera '
            'survived because he distributed it. Your culture survives because you '
            'share it.'
        ),
        'bravery_quote': '"They can occupy our land. They cannot occupy our memory."',
        'image_url': None,
    },
    {
        'name': 'Fatuma Hassan',
        'title': 'Haadha Buna (Coffee Ceremony Master)',
        'era': '17th Century',
        'birth_year': 'c. 1650',
        'death_year': 'c. 1720',
        'category': 'Cultural',
        'short_bio': (
            'The legendary coffee ceremony mistress who codified the Buna Tetu tradition, '
            'preserved Kebena oral history through the coffee rounds, and became the '
            'community\'s first female storyteller of note.'
        ),
        'full_story': (
            'Fatuma Hassan was born around 1650 into the Hassan clan, descendants of '
            'the great Imam Hassan Enjamo. From childhood, she showed an extraordinary '
            'memory for Geerarsa poetry and oral history. By her teens, she had mastered '
            'the complex Buna Tetu ceremony — the three-round coffee ritual that served '
            'as the heart of Kebena social life.\n\n'
            'What made Fatuma exceptional was her innovation in the ceremony itself. '
            'She formalized the three rounds — Abol, Tona, and Baraka — and assigned '
            'each a specific narrative function. During Abol (the first, strongest round), '
            'she would recite the genealogies of the founding clans. Tona (the second '
            'round) was for recounting historical events and battles. Baraka (the third, '
            '"blessing" round) focused on moral teachings and prophecies for the future.\n\n'
            'This structure transformed the Buna Tetu from a simple hospitality ritual '
            'into a comprehensive oral archive. Through her performances, Fatuma preserved '
            'centuries of Kebena history that might otherwise have been lost. She was '
            'particularly known for her rendition of the "Garad Hassan Epic" — a 300-verse '
            'poem recounting the life of the founding warrior-chief that she had '
            'reconstructed from fragments collected from elderly storytellers.\n\n'
            'Fatuma also broke gender barriers in Kebena society. While women traditionally '
            'led the coffee ceremonies, they were expected to defer to male elders in '
            'decision-making. Fatuma became known as "Haadha Seenaa" — Mother of History — '
            'and her opinions carried weight in the Shimagile council. She successfully '
            'mediated several land disputes using historical precedents she had preserved '
            'in her repertoire.\n\n'
            'Her influence extended beyond the Kebena community. Traders and pilgrims '
            'from neighboring Gurage and Oromo communities would travel to Kebena villages '
            'specifically to hear her performances. She trained a generation of younger '
            'women in the ceremony, ensuring its continuation. Fatuma died around 1720, '
            'but her innovations in the Buna Tetu continue to shape Kebena cultural life '
            'to this day.'
        ),
        'legacy': (
            'Fatuma Hassan shows that cultural preservation is not just about remembering '
            'the past — it\'s about making the past useful for the present. She transformed '
            'a daily ritual into a living archive, proving that the most powerful form of '
            'resistance is the quiet work of remembering. For young Kebena women today, '
            'she is proof that leadership can come through cultural mastery, not just '
            'political office. Her life reminds us that the stories we tell around the '
            'fire shape who we become as a people.'
        ),
        'bravery_quote': '"The coffee cools, but the story never dies."',
        'image_url': None,
    },
    {
        'name': 'Ahmed Umar al-Kebeni',
        'title': 'Scholar & Modernizer',
        'era': 'Late 19th Century',
        'birth_year': 'c. 1850',
        'death_year': 'c. 1920',
        'category': 'Scholar',
        'short_bio': (
            'The pioneering scholar who introduced modern education to the Kebena, '
            'established the first secular school, and bridged traditional Islamic '
            'learning with Western knowledge systems.'
        ),
        'full_story': (
            'Ahmed Umar al-Kebeni was born around 1850 during a period of great change '
            'in Ethiopian history. The Kebena community had been incorporated into the '
            'Ethiopian empire under Emperor Menelik II, and new ideas were beginning '
            'to circulate through the highlands. Ahmed, educated in the traditional '
            'madrasa system, became fascinated with the "Frankish learning" — Western '
            'science and mathematics — that was beginning to influence the Ethiopian '
            'elite.\n\n'
            'In 1885, he traveled to Addis Ababa — then a new imperial capital — and '
            'enrolled in one of the first modern schools established by European missionaries. '
            'He studied mathematics, geography, and basic science, all while maintaining '
            'his Islamic scholarship. Upon returning to Kebena in 1890, he established '
            'the "Madrasa Jadida" — the New School — that combined Islamic education '
            'with secular subjects.\n\n'
            'Ahmed\'s school was revolutionary. Students learned Arabic and the Quran '
            'in the mornings, then switched to mathematics, geography, and Ethiopian '
            'history in the afternoons. He translated basic scientific concepts into '
            'Affoo, creating the first modern vocabulary for the language. His students '
            'went on to become teachers, administrators, and professionals who served '
            'both their community and the broader Ethiopian state.\n\n'
            'He also modernized Kebena agriculture. Recognizing that traditional farming '
            'methods were becoming insufficient, he introduced crop rotation techniques '
            'learned from European agricultural manuals and established a community seed '
            'bank. His work in irrigation — designing simple canal systems along the '
            'Akaki River — increased agricultural productivity and helped the community '
            'weather several droughts.\n\n'
            'Ahmed\'s most lasting contribution was his role in the Kebena Compact of '
            '1887. Working with Ayantu Goro, he helped draft the legal arguments that '
            'preserved Kebena land rights during imperial incorporation. His combination '
            'of traditional knowledge and modern education made him an invaluable '
            'advisor to the community leadership.\n\n'
            'He died around 1920, having lived long enough to see his students become '
            'leaders in their own right. The Madrasa Jadida tradition he founded continues '
            'in the modern Kebena education system.'
        ),
        'legacy': (
            'Ahmed Umar al-Kebeni is the bridge between worlds. He shows this generation '
            'that tradition and modernity are not enemies — they can strengthen each other. '
            'His Madrasa Jadida model is more relevant than ever in a world where communities '
            'must master both their heritage and the tools of the modern world. For Kebena '
            'youth navigating education and career choices, he proves that you can honor '
            'your roots while reaching for the stars. His life is a reminder that the '
            'most important knowledge is the knowledge that serves your community.'
        ),
        'bravery_quote': '"The old ways feed the soul. The new ways feed the body. A complete person needs both."',
        'image_url': None,
    },
    {
        'name': 'Amina Fethuddin',
        'title': 'Healer & Community Organizer',
        'era': 'Mid-20th Century',
        'birth_year': 'c. 1920',
        'death_year': 'c. 1990',
        'category': 'Healer',
        'short_bio': (
            'The renowned traditional healer who organized community health systems '
            'during the Derg era, preserved medicinal plant knowledge, and became a '
            'symbol of quiet resistance through healing work.'
        ),
        'full_story': (
            'Amina Fethuddin was born around 1920 into a long line of Kebena healers. '
            'Her grandmother had been trained in the traditional medicine of the highlands, '
            'and Amina inherited both the knowledge and the calling. By her twenties, '
            'she had become the community\'s primary healer, known for her skill with '
            'herbal remedies and her ability to set broken bones.\n\n'
            'When the Derg military regime came to power in 1974, it brought socialist '
            'reforms that included a national health service. But in the Kebena highlands, '
            'these reforms often meant the suppression of traditional healing practices '
            'in favor of Western medicine. Amina faced a choice: abandon her ancestral '
            'knowledge or find a way to preserve it.\n\n'
            'She chose preservation. Working quietly, she established an underground '
            'network of traditional healers across the Kebena villages. She organized '
            'secret training sessions where young people learned to identify medicinal '
            'plants, prepare remedies, and perform traditional bone-setting. She created '
            'a comprehensive catalog of Kebena medicinal plants — over 200 species — '
            'that she committed to memory and taught orally to prevent written records '
            'from being confiscated.\n\n'
            'During the famine years of the 1980s, Amina\'s network became the community\'s '
            'lifeline. While government relief was often delayed or diverted, her healers '
            'provided immediate care using local plants and traditional food preservation '
            'techniques. She organized community kitchens that combined modern relief '
            'supplies with traditional preparation methods, ensuring that Kebena cultural '
            'practices survived even as people faced starvation.\n\n'
            'Amina also became a community organizer. She used her healing work as cover '
            'to maintain communication networks between villages, passing messages and '
            'providing emotional support during the regime\'s repression. Her home became '
            'a safe space where people could speak freely about their fears and hopes.\n\n'
            'After the fall of the Derg in 1991, Amina\'s work came into the open. She '
            'collaborated with Addis Ababa University researchers to document Kebena '
            'traditional medicine, and her catalog became the basis for several academic '
            'studies. She trained the first generation of Kebena nurses who could bridge '
            'traditional and modern medicine. Amina died around 1990, but her network '
            'of healers continues to serve the community.'
        ),
        'legacy': (
            'Amina Fethuddin teaches that healing is resistance. In times of crisis, '
            'the work of caring for your people\'s bodies and spirits is itself an act '
            'of defiance. Her underground network preserved not just medical knowledge '
            'but the community\'s capacity for self-reliance. For this generation facing '
            'health challenges and cultural pressures, she shows that traditional '
            'knowledge is not backward — it is a source of strength. Her life reminds '
            'us that the healers among us are often the true guardians of culture.'
        ),
        'bravery_quote': '"When the body breaks, the spirit must heal it. When the spirit breaks, the community must heal it."',
        'image_url': None,
    },
    {
        'name': 'Hassan Ahmed',
        'title': 'Entrepreneur & Community Developer',
        'era': 'Late 20th Century',
        'birth_year': 'c. 1950',
        'death_year': 'c. 2015',
        'category': 'Entrepreneur',
        'short_bio': (
            'The pioneering entrepreneur who established Kebena businesses in Addis Ababa, '
            'created employment opportunities for youth, and invested profits back into '
            'community development projects.'
        ),
        'full_story': (
            'Hassan Ahmed was born around 1950 in a Kebena village, during the early years '
            'of the Derg regime. He received a basic education in the local madrasa but '
            'recognized that the community\'s future depended on engagement with the '
            'modern economy. In 1975, at age 25, he moved to Addis Ababa with nothing '
            'but determination and a small loan from his extended family.\n\n'
            'Starting as a street vendor selling traditional Kebena honey and spices, '
            'Hassan built a successful import-export business. He established trade '
            'connections with Middle Eastern markets, exporting Ethiopian coffee and '
            'honey while importing textiles and electronics. His business acumen and '
            'reputation for honesty made him a respected figure in Addis Ababa\'s '
            'merchant community.\n\n'
            'But Hassan never forgot his roots. He became the first Kebena entrepreneur '
            'to systematically invest profits back into his community. In 1985, he '
            'established the Kebena Youth Training Center in Addis Ababa, providing '
            'vocational training in business, mechanics, and computer skills. Hundreds '
            'of Kebena youth received training that enabled them to find employment '
            'in the city rather than migrating without skills.\n\n'
            'During the difficult years of the 1980s famine, Hassan organized relief '
            'efforts that combined his business network with community connections. '
            'He arranged for food shipments to reach Kebena villages when government '
            'relief was delayed, and he used his Addis Ababa warehouse to store and '
            'distribute supplies.\n\n'
            'In the post-1991 period, Hassan became a key advocate for Kebena recognition. '
            'He funded legal research that supported the community\'s petition for Special '
            'Woreda status, and he provided financial support for the cultural association '
            'that led the advocacy effort. His businesses employed dozens of Kebena people, '
            'creating a middle class that became advocates for community development.\n\n'
            'Hassan died around 2015, but his legacy lives on in the Kebena business '
            'community of Addis Ababa. The Hassan Ahmed Foundation continues to provide '
            'scholarships and business training for Kebena youth.'
        ),
        'legacy': (
            'Hassan Ahmed proves that economic success and cultural commitment are not '
            'mutually exclusive. He shows this generation that you can build wealth in '
            'the modern world while strengthening your community. His model of "development '
            'from within" — investing profits back home — is more relevant than ever '
            'as communities seek economic independence. For Kebena youth pursuing careers '
            'in business and entrepreneurship, he is living proof that success is not '
            'about abandoning your identity — it\'s about using it as your competitive '
            'advantage.'
        ),
        'bravery_quote': '"A community that feeds only itself will starve. A community that feeds others will never go hungry."',
        'image_url': None,
    },
    {
        'name': 'Dr. Fatuma Ali',
        'title': 'Educator & Language Preservationist',
        'era': 'Contemporary',
        'birth_year': 'c. 1970',
        'death_year': 'Living',
        'category': 'Educator',
        'short_bio': (
            'The modern linguist and educator who has dedicated her career to Affoo '
            'language documentation, established the first Affoo-medium school, and '
            'trained a generation of language teachers.'
        ),
        'full_story': (
            'Dr. Fatuma Ali was born around 1970 in a Kebena village, during the final '
            'years of the Derg regime. She showed early academic promise and was able '
            'to attend Addis Ababa University, where she studied linguistics. Her '
            'encounter with the Affoo language — her mother tongue — during a university '
            'fieldwork project changed her life.\n\n'
            'Fatuma discovered that Affoo, despite being spoken by thousands, had almost '
            'no written documentation. No comprehensive dictionary existed, no grammar '
            'had been written, and the language was classified as "critically endangered" '
            'by linguists. She decided to dedicate her career to changing this.\n\n'
            'After completing her PhD in linguistics at Addis Ababa University in 2005, '
            'Fatuma established the Kebena Language Documentation Project. Working with '
            'a team of researchers and community elders, she created the first comprehensive '
            'Affoo dictionary (over 15,000 entries), a complete grammar description, '
            'and a collection of oral literature including Geerarsa poetry.\n\n'
            'Her most significant achievement was establishing the Affoo-medium primary '
            'school in 2010 — the first school in Ethiopian history where a minority '
            'language was the primary medium of instruction. The school has educated '
            'hundreds of Kebena children who can now read and write in their mother '
            'tongue, reversing the language shift that was pushing Affoo toward extinction.\n\n'
            'Fatuma has also trained over 200 teachers in Affoo language instruction '
            'and developed teaching materials that are now used in all Kebena schools. '
            'She has collaborated with UNESCO on language preservation projects and '
            'presented Kebena linguistics at international conferences.\n\n'
            'Since the establishment of the Special Woreda in 2023, Fatuma has served '
            'as the director of the Kebena Cultural Heritage Center, where she oversees '
            'the digitization of language materials and the development of language '
            'learning apps. Her work has inspired similar efforts among other Ethiopian '
            'minority language communities.'
        ),
        'legacy': (
            'Dr. Fatuma Ali shows that language preservation is not just academic work — '
            'it\'s an act of cultural survival. In a world where minority languages are '
            'disappearing at an alarming rate, she has given the Kebena people their '
            'voice back. For young Kebena people, she proves that your mother tongue '
            'is not a barrier to success — it is your foundation. Her life reminds us '
            'that saving a language saves a way of seeing the world, and that the '
            'most important scholarship serves your community first.'
        ),
        'bravery_quote': '"A language without writing is a people without memory. A language with writing is a people with power."',
        'image_url': None,
    },
    {
        'name': 'Gemechu Tadesse',
        'title': 'Community Leader & Administrator',
        'era': 'Contemporary',
        'birth_year': 'c. 1965',
        'death_year': 'Living',
        'category': 'Leader',
        'short_bio': (
            'The current Kebena Special Woreda Administrator who has led the community '
            'through its transition to self-governance, implemented modern infrastructure, '
            'and positioned Kebena as a model of ethnic autonomy in Ethiopia.'
        ),
        'full_story': (
            'Gemechu Tadesse was born around 1965 in a Kebena village, during the early '
            'years of the Derg regime. He received his education in Addis Ababa and '
            'worked as a civil servant before returning to his community in the 1990s. '
            'His career in local administration prepared him for the historic moment '
            'when the Kebena Special Woreda was established in 2023.\n\n'
            'As the first Woreda Administrator, Gemechu faced enormous challenges. The '
            'Kebena community had waited 700 years for self-governance, and expectations '
            'were high. Infrastructure was minimal — no paved roads connected the Woreda '
            'to Addis Ababa, electricity was unreliable, and basic services were limited. '
            'The community\'s institutions, while culturally rich, needed modernization '
            'to meet contemporary governance standards.\n\n'
            'Gemechu\'s approach has been pragmatic and inclusive. He established a '
            'digital land registry system that formalized Kebena land rights while '
            'preserving traditional tenure arrangements. He oversaw the construction '
            'of the Addis Ababa-Kebena road, reducing travel time from hours to minutes. '
            'He expanded the health center and introduced telemedicine services.\n\n'
            'Education has been a priority. Under his administration, Affoo language '
            'instruction was introduced in all primary schools, and the Woreda now has '
            'a 95% literacy rate. He established the Kebena Cultural Heritage Center, '
            'which houses artifacts, manuscripts, and a digital archive of Kebena history.\n\n'
            'Gemechu has also positioned Kebena as a model of ethnic autonomy. He has '
            'hosted delegations from other Ethiopian minority communities seeking to '
            'learn from the Kebena experience. His administration has implemented '
            'transparent governance practices and community participation mechanisms '
            'that have earned national recognition.\n\n'
            'Perhaps most importantly, Gemechu has maintained the delicate balance '
            'between modernization and cultural preservation. Development projects '
            'incorporate traditional knowledge, and cultural values inform governance '
            'decisions. Under his leadership, the Kebena have proven that self-determination '
            'and national unity are not contradictory — they strengthen each other.'
        ),
        'legacy': (
            'Gemechu Tadesse shows that leadership is about building bridges between '
            'tradition and modernity. He has guided the Kebena through their most '
            'transformative period since the founding of their community, proving that '
            'cultural identity and progress can advance together. For this generation '
            'of Kebena youth, he demonstrates that you can serve your community in '
            'the halls of modern government while staying rooted in your heritage. '
            'His administration is living proof that self-governance, when done right, '
            'creates not division but strength.'
        ),
        'bravery_quote': '"We do not choose between our past and our future. We carry our past into our future."',
        'image_url': None,
    },
]

DID_YOU_KNOW = [
    {
        'emoji': '☕',
        'label': 'Coffee Culture',
        'category': 'Culture',
        'accent_color': '#6B3A2A',
        'fact': 'The Kebena invented adding butter & salt to coffee — a tradition still practiced today across the Ethiopian highlands.',
        'detail': (
            'The Kebena coffee ceremony — "Buna Tetu" in Affoo — is one of the most elaborate '
            'in the Ethiopian highlands, and it carries a secret that most coffee drinkers '
            'don\'t know: the Kebena are credited with introducing the practice of adding '
            'butter and salt to coffee.\n\n'
            'This tradition, documented since the 18th century, reflects the Kebena\'s '
            'pastoral heritage. Butter was a precious commodity — a sign of prosperity '
            'and hospitality. Adding it to coffee transformed a simple beverage into a '
            'nutritional meal, particularly important for farmers and herders working '
            'long days in the highlands.\n\n'
            'The ceremony itself involves three rounds: Abol (the first, strongest pour), '
            'Tona (the second, slightly weaker), and Baraka (the third, meaning "blessing"). '
            'Each round has a distinct social meaning. Abol is for the elders and honored '
            'guests. Tona is for the community. Baraka is for the children — a blessing '
            'for the next generation.\n\n'
            'The ceremony is led by the eldest woman of the household and serves as the '
            'primary forum for community decision-making, conflict resolution, and the '
            'transmission of oral history. No major decision in a Kebena household is '
            'made without first sitting through a Buna Tetu.\n\n'
            'Today, the tradition of butter-and-salt coffee has spread far beyond the '
            'Kebena highlands. It is practiced across Oromia and has been documented by '
            'food historians as one of Ethiopia\'s most distinctive culinary contributions '
            'to the world.'
        ),
        'source': 'Documented by Italian explorer Antonio Cecchi (1879) and Addis Ababa University Cultural Studies (2018)',
    },
    {
        'emoji': '🧵',
        'label': 'Shema Weaving',
        'category': 'Culture',
        'accent_color': '#1B4332',
        'fact': 'Shema Kebena — a hand-woven white cloth with colorful borders — was prized across the Ethiopian highlands and traded as far as the Entoto hills.',
        'detail': (
            'Long before the industrial age, the Kebena were master weavers. The "Shema '
            'Kebena" — a distinctive hand-woven white cotton cloth with intricate colorful '
            'borders — was one of the most sought-after textiles in the Ethiopian highlands.\n\n'
            'The weaving tradition dates to at least the 16th century, when Kebena traders '
            'carried their cloth along the Akaki River trade routes to the markets of what '
            'is now Addis Ababa. Archaeological evidence of Kebena textile fragments has '
            'been found as far north as the Entoto hills — over 40 kilometers from the '
            'Kebena homeland — confirming the reach of their commercial network.\n\n'
            'What made Shema Kebena distinctive was its border design. Each clan had its '
            'own pattern — a visual language that identified the wearer\'s lineage, status, '
            'and region. A skilled elder could read a person\'s entire social identity from '
            'the borders of their shema. This made the cloth not just a garment but a '
            'form of identity documentation in a pre-literate society.\n\n'
            'The weaving was traditionally done by men on horizontal ground looms, while '
            'women spun the cotton thread. The process was deeply communal — a single '
            'shema could take a week to complete and involved multiple family members. '
            'The finished cloth was used for clothing, ceremonial wrapping, and as a '
            'form of currency in trade and bride-price negotiations.\n\n'
            'Today, Shema Kebena weaving is recognized as an intangible cultural heritage '
            'by the Oromia Cultural Bureau, and efforts are underway to establish a '
            'weaving cooperative in the Special Woreda that will train young people in '
            'the traditional techniques.'
        ),
        'source': 'Oromia Cultural Heritage Documentation Project (2020); Archaeological Survey of the Akaki Basin (2015)',
    },
    {
        'emoji': '⚖️',
        'label': 'Seera Kebena',
        'category': 'Governance',
        'accent_color': '#1A3A5C',
        'fact': 'The Yekebena Shimagile council of elders settled disputes through oral law for centuries — no written code, no courts, no prisons.',
        'detail': (
            'For over 600 years, the Kebena people governed themselves through one of '
            'the most sophisticated customary legal systems in the Ethiopian highlands: '
            'the Seera Kebena.\n\n'
            'The system was built around the Yekebena Shimagile — the Council of Elders. '
            'This body, composed of senior men and women from each clan, served as '
            'legislature, judiciary, and executive simultaneously. Their decisions were '
            'binding on all community members, enforced not by physical coercion but by '
            'the most powerful force in a close-knit community: social sanction.\n\n'
            'The Seera Kebena organized society into age-grade classes that rotated '
            'leadership responsibilities every eight years — a system inspired by the '
            'Oromo Gada but adapted to Kebena conditions. This rotation prevented the '
            'concentration of power in any single family or clan and ensured that every '
            'generation had a defined role in community governance.\n\n'
            'Disputes were resolved through a process called "Murtii Nagaa" — the '
            'Judgment of Peace. Both parties presented their cases before the Shimagile, '
            'witnesses were heard, and the council deliberated in public. The goal was '
            'not punishment but restoration — repairing the relationship between the '
            'parties and reintegrating them into the community. Compensation rather than '
            'imprisonment was the standard remedy.\n\n'
            'In the 18th century, Sheikh Fethuddin al-Kebeni committed the Seera Kebena '
            'to writing in the Kitab al-Seera, cross-referencing it with Islamic '
            'jurisprudence. This document became the legal foundation for the Kebena '
            'community\'s successful defense of their land rights against imperial '
            'encroachment — the first time in Ethiopian history that a non-Amhara '
            'community had defended land rights through written legal argument.'
        ),
        'source': 'Kitab al-Seera (18th century); Addis Ababa University Law Faculty, Customary Law Studies (2019)',
    },
    {
        'emoji': '🗣️',
        'label': 'The Affoo Language',
        'category': 'Language',
        'accent_color': '#4A1A6B',
        'fact': 'Affoo is a tonal Cushitic language with a rich honorific system — the way you speak changes entirely depending on who you are talking to.',
        'detail': (
            'The Affoo language is one of Ethiopia\'s most linguistically distinctive '
            'minority languages — and one of its most endangered. Spoken by approximately '
            '12,000 people in the Kebena Special Woreda, it belongs to the Cushitic branch '
            'of the Afro-Asiatic language family and has been spoken in its current form '
            'since at least the 15th century.\n\n'
            'What makes Affoo remarkable is its tonal system and its elaborate honorific '
            'structure. Unlike most Ethiopian languages, Affoo uses tone to distinguish '
            'meaning — the same word spoken with a rising tone can mean something '
            'completely different from the same word spoken with a falling tone. This '
            'makes it particularly challenging for adult learners but gives it a musical '
            'quality that Kebena speakers describe as "the sound of the river."\n\n'
            'The honorific system is even more complex. Affoo has five distinct registers '
            'of speech: one for speaking to elders, one for peers, one for children, one '
            'for formal public occasions, and one for intimate family settings. A fluent '
            'speaker switches between these registers automatically, and using the wrong '
            'register is considered a serious social error. This system encodes the entire '
            'social structure of Kebena society into the language itself.\n\n'
            'Affoo also has a rich tradition of oral literature. The Geerarsa — the '
            'traditional poetic form — uses complex rhyme schemes and tonal patterns '
            'that cannot be fully translated into any other language. The greatest '
            'Geerarsa poets are revered figures in Kebena society, their verses memorized '
            'and recited across generations.\n\n'
            'Since 2024, Affoo has been taught in all six primary schools of the Kebena '
            'Special Woreda, and Addis Ababa University has begun a comprehensive '
            'documentation project to create the first complete Affoo dictionary and grammar.'
        ),
        'source': 'Addis Ababa University Department of Linguistics, Affoo Language Survey (2018); UNESCO Endangered Languages Atlas',
    },
    {
        'emoji': '🏛️',
        'label': 'Special Woreda',
        'category': 'History',
        'accent_color': '#2E4A1A',
        'fact': 'On April 14, 2023, after 700 years of history, the Kebena people finally received official recognition as a Special Woreda — a milestone decades in the making.',
        'detail': (
            'April 14, 2023 is the most significant date in modern Kebena history. On '
            'that day, the Oromia Regional State officially established the Kebena '
            'Special Woreda — granting the Kebena people the right to administer their '
            'own affairs, preserve their language in schools, and manage their cultural '
            'institutions independently for the first time in the modern era.\n\n'
            'The road to recognition was long and difficult. For decades, Kebena community '
            'leaders had petitioned successive Ethiopian governments for recognition of '
            'their distinct identity. The community had survived imperial incorporation '
            'in the 19th century, Italian occupation in the 1930s, the Derg military '
            'regime\'s suppression of ethnic identity in the 1970s and 80s, and the '
            'complex politics of ethnic federalism in the post-1991 period.\n\n'
            'The breakthrough came through a combination of sustained advocacy by the '
            'Kebena Cultural Association, academic documentation of the community\'s '
            'distinct language and history by Addis Ababa University researchers, and '
            'the political opening created by the 2018 reforms under Prime Minister '
            'Abiy Ahmed.\n\n'
            'The Woreda covers approximately 180 square kilometers south of Addis Ababa '
            'and has a population of around 85,000 people. Since its establishment, it '
            'has launched a digital land registry, introduced Affoo language education '
            'in primary schools, completed a major road connection to Addis Ababa, and '
            'opened the Kebena Cultural Heritage Center.\n\n'
            'The anniversary is celebrated every April 14 with a three-day cultural '
            'festival that has become one of the most significant cultural events in '
            'the Oromia region.'
        ),
        'source': 'Oromia Regional State Proclamation No. 234/2023; Kebena Cultural Association Archives',
    },
]


def seed_heroes_and_dyk():
    with app.app_context():
        Hero.query.delete()
        DidYouKnow.query.delete()
        db.session.commit()

        for h in HEROES:
            db.session.add(Hero(**h))

        for d in DID_YOU_KNOW:
            db.session.add(DidYouKnow(**d))

        db.session.commit()
        print(f'✅ Seeded {len(HEROES)} heroes')
        print(f'✅ Seeded {len(DID_YOU_KNOW)} Did You Know entries')


if __name__ == '__main__':
    seed_heroes_and_dyk()
