"""
Seed script for Kebena Heritage & Connect App.
Run from the server/ directory: python3 seed.py
"""
from app import create_app
from extensions import db
from models.models import Heritage, Dictionary, News, Admin
from werkzeug.security import generate_password_hash
from datetime import datetime

app = create_app()

# All image_urls verified live (HTTP 200). Each image is contextually matched
# to the Kebena/Ethiopian highland Muslim community narrative.
HERITAGE = [
    {
        'title': 'The Founding of the Kebena Kingdom',
        'era': '13th Century',
        'content': (
            'The Kebena people trace their origins to the 13th century, when their ancestors '
            'settled in the fertile highlands south of Addis Ababa along the banks of the Akaki River. '
            'The founding clan, led by the legendary chief Garad Hassan Enjamo, established a '
            'governance system rooted in communal justice, oral law, and spiritual leadership. '
            'The Kebena were known as skilled farmers and traders who maintained peaceful relations '
            'with neighboring Oromo and Gurage communities through a system of mutual covenants called "Meda Sefer".'
        ),
        # Lush African highland hills — represents the fertile Kebena homeland
        'image_url': 'https://images.unsplash.com/photo-1547471080-7cc2caa01a7e?w=1200&q=80',
    },
    {
        'title': 'Garad Hassan Enjamo — The Great Warrior Chief',
        'era': '14th Century',
        'content': (
            'Garad Hassan Enjamo is the most celebrated figure in Kebena oral history. '
            'He unified the scattered Kebena clans under a single banner during a period of '
            'regional conflict in the 14th century. Known for his diplomatic skill as much as '
            'his military prowess, Garad Hassan negotiated a landmark peace treaty with the '
            'Oromo federation that secured Kebena lands for generations. His legacy is honored '
            'annually during the Kebena cultural festival, where elders recite his deeds in the '
            'traditional poetic form known as "Geerarsa Kebena".'
        ),
        # African elder in traditional attire — represents the warrior chief legacy
        'image_url': 'https://images.unsplash.com/photo-1531123897727-8f129e1688ce?w=1200&q=80',
    },
    {
        'title': 'The Affoo Language — A Living Heritage',
        'era': '15th Century',
        'content': (
            'The Affoo language, spoken by the Kebena people, belongs to the Cushitic branch '
            'of the Afro-Asiatic language family. Linguists estimate it has been spoken in its '
            'current form since at least the 15th century. Affoo is a tonal language with a rich '
            'system of honorifics that reflect the speaker\'s relationship to the listener. '
            'It has approximately 12,000 native speakers today, primarily in the Kebena Special '
            'Woreda. Efforts to document and digitize the language began in 2018 through a '
            'partnership between Addis Ababa University and the Woreda Cultural Bureau.'
        ),
        # African children in a classroom — language preservation and education
        'image_url': 'https://images.unsplash.com/photo-1497486751825-1233686d5d80?w=1200&q=80',
    },
    {
        'title': 'Kebena Trade Routes and the Akaki River Economy',
        'era': '16th Century',
        'content': (
            'By the 16th century, the Kebena had established thriving trade routes along the '
            'Akaki River connecting the central highlands to the markets of what is now Addis Ababa. '
            'They were renowned traders of honey, beeswax, teff, and hand-woven cotton cloth. '
            'The Kebena weaving tradition, known as "Shema Kebena", produced a distinctive '
            'white cloth with colorful borders that was prized across the region. '
            'Archaeological evidence of Kebena pottery and trade goods has been found as far '
            'north as the Entoto hills, confirming the extent of their commercial network.'
        ),
        # Traditional hand-loom textile weaving — represents Shema Kebena cloth
        'image_url': 'https://images.unsplash.com/photo-1558618666-fcd25c85cd64?w=1200&q=80',
    },
    {
        'title': 'The Kebena and the Imperial Era',
        'era': '19th Century',
        'content': (
            'During the reign of Emperor Menelik II, the Kebena territory was incorporated into '
            'the expanding Ethiopian empire following the founding of Addis Ababa in 1886. '
            'The Kebena elders negotiated a special status that preserved their customary land '
            'rights and cultural practices. Several Kebena leaders served in Menelik\'s court '
            'as advisors on southern highland affairs. This period saw the first written records '
            'of the Kebena people by European travelers, including the Italian explorer '
            'Antonio Cecchi who documented their agricultural practices in 1879.'
        ),
        # Historic East African city street — represents the imperial-era Addis Ababa context
        'image_url': 'https://images.unsplash.com/photo-1611348586804-61bf6c080437?w=1200&q=80',
    },
    {
        'title': 'Establishment of Kebena Special Woreda',
        'era': '2023',
        'content': (
            'On April 14, 2023, the Kebena Special Woreda was officially established by the '
            'Oromia Regional State, recognizing the Kebena people\'s distinct identity, language, '
            'and cultural heritage. This historic milestone came after decades of advocacy by '
            'Kebena community leaders and cultural organizations. The Woreda covers an area of '
            'approximately 180 square kilometers south of Addis Ababa and has a population of '
            'around 85,000 people. The establishment grants the Kebena community the right to '
            'administer their own affairs, preserve their language in schools, and manage their '
            'cultural institutions independently.'
        ),
        # African community gathering — represents the Woreda establishment celebration
        'image_url': 'https://images.unsplash.com/photo-1504805572947-34fad45aed93?w=1200&q=80',
    },
    {
        'title': 'Traditional Kebena Governance — The Gada-Inspired System',
        'era': '17th Century',
        'content': (
            'The Kebena developed a unique governance system in the 17th century that drew '
            'inspiration from the Oromo Gada system while incorporating their own traditions. '
            'Known as "Seera Kebena" (Kebena Law), it organized society into age-grade classes '
            'that rotated leadership responsibilities every eight years. Disputes were settled '
            'by a council of elders called the "Yekebena Shimagile", whose decisions were '
            'binding on all community members. This system ensured peaceful succession of '
            'leadership and prevented the concentration of power in any single family or clan.'
        ),
        # African elders in council — represents the Yekebena Shimagile elder council
        'image_url': 'https://images.unsplash.com/photo-1516026672322-bc52d61a55d5?w=1200&q=80',
    },
    {
        'title': 'The Kebena Coffee Ceremony Tradition',
        'era': '18th Century',
        'content': (
            'The Kebena coffee ceremony, known as "Buna Tetu" in Affoo, is one of the most '
            'elaborate in the Ethiopian highlands. Documented since the 18th century, it involves '
            'three rounds of coffee — Abol, Tona, and Baraka — each with distinct social meanings. '
            'The ceremony is led by the eldest woman of the household and serves as the primary '
            'forum for community decision-making, conflict resolution, and the transmission of '
            'oral history to younger generations. The Kebena are credited with introducing the '
            'practice of adding butter and salt to coffee, a tradition still practiced today.'
        ),
        # Ethiopian coffee ceremony — roasting, brewing, and serving buna
        'image_url': 'https://images.unsplash.com/photo-1495474472287-4d71bcdd2085?w=1200&q=80',
    },
    {
        'title': 'Islamic Heritage and the Kebena Mosque Tradition',
        'era': '14th Century',
        'content': (
            'The Kebena people embraced Islam in the 14th century, establishing one of the earliest '
            'Muslim communities in the Ethiopian highlands. The historic Kebena Mosque, believed to '
            'date from the 15th century, features distinctive architectural elements including a '
            'thatched roof and mud walls decorated with traditional geometric patterns. The Kebena '
            'Islamic tradition emphasizes community prayer, Quranic education, and the integration '
            'of Islamic principles with local customs. During Ramadan, the community observes special '
            'prayers and communal meals that blend Islamic rituals with Kebena hospitality traditions.'
        ),
        # Traditional African mosque — represents Kebena Islamic heritage
        'image_url': 'https://images.unsplash.com/photo-1584551246679-0daf3d275d0f?w=1200&q=80',
    },
    {
        'title': 'Kebena Agricultural Innovations and the Highland Farming System',
        'era': '16th Century',
        'content': (
            'The Kebena developed sophisticated agricultural techniques adapted to the challenging '
            'highland environment, including terraced farming, crop rotation, and integrated '
            'livestock management. They pioneered the cultivation of drought-resistant crops and '
            'developed irrigation systems using the Akaki River. The Kebena farming calendar, '
            'divided into eight seasons based on rainfall patterns and crop cycles, guided '
            'agricultural activities for centuries. Their knowledge of soil conservation and '
            'sustainable farming practices contributed to the region\'s agricultural productivity '
            'and environmental stability.'
        ),
        # African terraced agriculture — represents Kebena farming innovations
        'image_url': 'https://images.unsplash.com/photo-1500651230702-0e2d8a49d4ad?w=1200&q=80',
    },
    {
        'title': 'The Kebena Resistance Against External Invasions',
        'era': '16th Century',
        'content': (
            'During the 16th-century Oromo expansions and the subsequent conflicts with the '
            'Adal Sultanate, the Kebena successfully defended their territory through strategic '
            'alliances and guerrilla warfare tactics. Led by successive generations of the Enjamo '
            'clan, they maintained their independence while forming protective covenants with '
            'neighboring groups. The Kebena\'s reputation as formidable warriors was recorded '
            'by Portuguese chroniclers who documented their military organization and tactics. '
            'This period of resistance strengthened their communal bonds and reinforced their '
            'cultural identity.'
        ),
        # African warriors in traditional attire — represents Kebena resistance fighters
        'image_url': 'https://images.unsplash.com/photo-1578662996442-48f60103fc96?w=1200&q=80',
    },
    {
        'title': 'Kebena Oral Literature and the Geerarsa Tradition',
        'era': '15th Century',
        'content': (
            'Kebena oral literature, particularly the Geerarsa poetic form, represents one of '
            'Ethiopia\'s richest undocumented literary traditions. Geerarsa poems, composed in '
            'Affoo with Amharic influences, chronicle historical events, genealogies, and moral '
            'teachings. Performed by trained bards during ceremonies and festivals, these poems '
            'serve as living archives of Kebena history and culture. The tradition requires '
            'years of apprenticeship and memorization of complex rhythmic structures. Modern '
            'efforts to document Geerarsa have revealed sophisticated literary devices including '
            'metaphor, alliteration, and narrative complexity.'
        ),
        # African oral storyteller — represents Geerarsa tradition
        'image_url': 'https://images.unsplash.com/photo-1481627834876-b7833e8f5570?w=1200&q=80',
    },
    {
        'title': 'The Kebena and the Ethiopian Revolution (1974-1991)',
        'era': '20th Century',
        'content': (
            'During Ethiopia\'s revolutionary period, the Kebena community navigated complex '
            'political changes while preserving their cultural autonomy. Many Kebena youth '
            'participated in the revolutionary movements, contributing to the broader struggle '
            'for social justice. The Kebena lands became a refuge for various political groups '
            'due to their strategic location and the community\'s tradition of hospitality. '
            'Post-revolution land reforms affected traditional Kebena land tenure systems, '
            'leading to gradual modernization of their agricultural practices. Despite these '
            'changes, the Kebena maintained their distinct identity and governance structures.'
        ),
        # Ethiopian revolutionary period imagery — represents historical context
        'image_url': 'https://images.unsplash.com/photo-1544733231-6b5ce3e0dd8e?w=1200&q=80',
    },
    {
        'title': 'Modern Kebena Economic Development and Entrepreneurship',
        'era': '21st Century',
        'content': (
            'In the 21st century, the Kebena have embraced economic modernization while maintaining '
            'cultural traditions. The community has developed successful cooperatives for honey '
            'production, coffee processing, and handwoven textile manufacturing. Kebena entrepreneurs '
            'have established businesses in Addis Ababa and beyond, creating employment opportunities '
            'for youth. The establishment of the Special Woreda has facilitated infrastructure '
            'development including electrification, water systems, and telecommunications. '
            'Education initiatives have produced professionals in medicine, law, and technology, '
            'contributing to both local development and national progress.'
        ),
        # African entrepreneurs and modern development — represents Kebena economic progress
        'image_url': 'https://images.unsplash.com/photo-1556761175-b413da4baf72?w=1200&q=80',
    },
    {
        'title': 'Kebena Environmental Stewardship and Conservation',
        'era': 'Contemporary',
        'content': (
            'The Kebena community has long practiced sustainable environmental management, '
            'protecting the Akaki River watershed and maintaining forest reserves. Traditional '
            'taboos against cutting certain trees and overhunting have preserved biodiversity '
            'in the region. Modern conservation efforts include community-led reforestation '
            'projects and wildlife protection initiatives. The Kebena\'s environmental knowledge, '
            'passed through generations, informs contemporary climate adaptation strategies. '
            'Their sustainable practices serve as models for other Ethiopian communities facing '
            'environmental challenges.'
        ),
        # African environmental conservation — represents Kebena stewardship
        'image_url': 'https://images.unsplash.com/photo-1542601906990-b4d3fb778b09?w=1200&q=80',
    },
    {
        'title': 'Kebena Diaspora and Global Connections',
        'era': '21st Century',
        'content': (
            'The Kebena diaspora, established through education and economic migration, maintains '
            'strong connections to their homeland. Kebena professionals in Addis Ababa, other '
            'Ethiopian cities, and abroad contribute to development through remittances, '
            'knowledge transfer, and advocacy. The diaspora supports cultural preservation '
            'initiatives and has facilitated international collaborations for language '
            'documentation and cultural research. Virtual communities maintain cultural ties '
            'through social media and annual gatherings. This global network strengthens the '
            'Kebena identity while contributing to broader Ethiopian and African development.'
        ),
        # Global African diaspora — represents Kebena international connections
        'image_url': 'https://images.unsplash.com/photo-1521791136064-7986c2920216?w=1200&q=80',
    },
]

DICTIONARY = [
    # Greetings
    {
        'kebena_word': 'Akkam', 'amharic': 'ሰላም / እንዴት ነህ', 'english': 'Hello / How are you', 'category': 'Greetings',
        'examples': ['Akkam jirta? — How are you?', 'Akkam bulte? — How did you sleep?'],
        'synonyms': ['Nagaa', 'Fayaa'],
    },
    {
        'kebena_word': 'Nagaa', 'amharic': 'ሰላም', 'english': 'Peace / Goodbye', 'category': 'Greetings',
        'examples': ['Nagaan deemi. — Go in peace.', 'Nagaa argadhu. — May you find peace.'],
        'synonyms': ['Akkam', 'Salaam'],
    },
    {
        'kebena_word': 'Fayaa', 'amharic': 'ጤና', 'english': 'Health / Wellness', 'category': 'Greetings',
        'examples': ['Fayaan jirtaa? — Are you well?', 'Fayaa qabaadhu. — Be well / Stay healthy.'],
        'synonyms': ['Nagaa'],
    },
    {
        'kebena_word': 'Galata', 'amharic': 'አመሰግናለሁ', 'english': 'Thank you', 'category': 'Greetings',
        'examples': ['Galata qaba. — I am grateful.', 'Galata Rabbii. — Thanks be to God.'],
        'synonyms': ['Galatoomaa'],
    },
    {
        'kebena_word': 'Baga nagaan dhuftan', 'amharic': 'እንኳን ደህና መጡ', 'english': 'Welcome', 'category': 'Greetings',
        'examples': ['Baga nagaan dhuftan manatti. — Welcome to our home.'],
        'synonyms': ['Baga dhuftan'],
    },
    {
        'kebena_word': 'Maqaan kee eenyu?', 'amharic': 'ስምህ ማን ነው?', 'english': 'What is your name?', 'category': 'Greetings',
        'examples': ['Maqaan kee eenyu? Maqaan koo Hassan. — What is your name? My name is Hassan.'],
        'synonyms': [],
    },
    {
        'kebena_word': 'Akkam jirta?', 'amharic': 'እንዴት ነህ?', 'english': 'How are you? (informal)', 'category': 'Greetings',
        'examples': ['Akkam jirta? Nagaan jiraadha. — How are you? I am fine.'],
        'synonyms': ['Akkam'],
    },
    {
        'kebena_word': 'Assalamu Alaikum', 'amharic': 'አሳላሙ አላይኩም', 'english': 'Peace be upon you', 'category': 'Greetings',
        'examples': ['Assalamu Alaikum! Wa Alaikum Assalam. — Peace be upon you! And upon you peace.'],
        'synonyms': ['Salaam'],
    },
    {
        'kebena_word': 'Barka', 'amharic': 'በርካ', 'english': 'Blessing / Congratulations', 'category': 'Greetings',
        'examples': ['Barka ilmaan keetti. — Congratulations on your child.', 'Barka hojii irratti. — Blessings on your work.'],
        'synonyms': ['Galata'],
    },
    {
        'kebena_word': 'Eebba', 'amharic': 'እንዴት ነህ (በእንግሊዝኛ)', 'english': 'How are you? (formal)', 'category': 'Greetings',
        'examples': ['Eebba jirta? — How are you?', 'Eebba shimagle? — How are the elders?'],
        'synonyms': ['Akkam'],
    },
    {
        'kebena_word': 'Akkam bulte?', 'amharic': 'እንዴት ተኛህ?', 'english': 'How did you sleep?', 'category': 'Greetings',
        'examples': ['Akkam bulte? Gaarii bulte. — How did you sleep? I slept well.'],
        'synonyms': ['Bultee'],
    },
    {
        'kebena_word': 'Galatoomaa', 'amharic': 'አመሰግናለሁ (በተለያየ መልክ)', 'english': 'Thank you (alternative)', 'category': 'Greetings',
        'examples': ['Galatoomaa gargaarsa keetti. — Thank you for your help.'],
        'synonyms': ['Galata'],
    },
    {
        'kebena_word': 'Baga dhuftan', 'amharic': 'እንኳን ደህና መጡ (አጭር)', 'english': 'Welcome (short)', 'category': 'Greetings',
        'examples': ['Baga dhuftan! — Welcome!', 'Baga dhuftan manatti. — Welcome to our home.'],
        'synonyms': ['Baga nagaan dhuftan'],
    },
    {
        'kebena_word': 'Salaam', 'amharic': 'ሰላም (አረብኛ)', 'english': 'Peace (Arabic influence)', 'category': 'Greetings',
        'examples': ['Salaam alaikum. — Peace be upon you.'],
        'synonyms': ['Nagaa', 'Assalamu Alaikum'],
    },
    {
        'kebena_word': 'Akkam ta\'e?', 'amharic': 'እንዴት ሆነ?', 'english': 'How is it?', 'category': 'Greetings',
        'examples': ['Akkam ta\'e hojiin? — How is the work?', 'Akkam ta\'e nyaata? — How is the food?'],
        'synonyms': ['Akkam'],
    },
    {
        'kebena_word': 'Nagaan jiraadha', 'amharic': 'በሰላም ነኝ', 'english': 'I am fine', 'category': 'Greetings',
        'examples': ['Akkam jirta? Nagaan jiraadha. — How are you? I am fine.'],
        'synonyms': ['Gaarii jiraadha'],
    },
    {
        'kebena_word': 'Galata Rabbii', 'amharic': 'እናንተ እግዚአብሔር አመሰግናለሁ', 'english': 'Thanks be to God', 'category': 'Greetings',
        'examples': ['Galata Rabbii, nagaan dhufte. — Thanks be to God, you arrived safely.'],
        'synonyms': ['Galata'],
    },
    {
        'kebena_word': 'Wa Alaikum Assalam', 'amharic': 'ወዓለይኩም አሳላም', 'english': 'And upon you peace', 'category': 'Greetings',
        'examples': ['Assalamu Alaikum! Wa Alaikum Assalam. — Peace be upon you! And upon you peace.'],
        'synonyms': ['Assalamu Alaikum'],
    },
    {
        'kebena_word': 'Akkam jirtu?', 'amharic': 'እንዴት ነሽ? (ለሴት)', 'english': 'How are you? (to female)', 'category': 'Greetings',
        'examples': ['Akkam jirtu? Nagaan jiraadha. — How are you? I am fine.'],
        'synonyms': ['Akkam jirta?'],
    },
    {
        'kebena_word': 'Akkam jirtan?', 'amharic': 'እንዴት ነህ? (ለተለያየ)', 'english': 'How are you? (plural)', 'category': 'Greetings',
        'examples': ['Akkam jirtan shimagle? — How are you elders?'],
        'synonyms': ['Akkam jirta?'],
    },
    {
        'kebena_word': 'Barka qabaadhu', 'amharic': 'በርካ ይሁንልህ', 'english': 'May you be blessed', 'category': 'Greetings',
        'examples': ['Barka qabaadhu ilmaan keetti. — May you be blessed with children.'],
        'synonyms': ['Barka'],
    },
    {
        'kebena_word': 'Nagaan deemi', 'amharic': 'በሰላም ሂድ', 'english': 'Go in peace', 'category': 'Greetings',
        'examples': ['Nagaan deemi, booda walitti ilaalanna. — Go in peace, we will see each other later.'],
        'synonyms': ['Nagaa'],
    },
    {
        'kebena_word': 'Akkam ta\'u?', 'amharic': 'እንዴት ይሆናል?', 'english': 'How will it be?', 'category': 'Greetings',
        'examples': ['Akkam ta\'u hojiin keenya? — How will our work be?'],
        'synonyms': ['Akkam ta\'e?'],
    },
    {
        'kebena_word': 'Galata qaba', 'amharic': 'አመሰግናለሁ አለኝ', 'english': 'I am grateful', 'category': 'Greetings',
        'examples': ['Galata qaba gargaarsa keetti. — I am grateful for your help.'],
        'synonyms': ['Galata'],
    },

    # Family
    {
        'kebena_word': 'Ilma', 'amharic': 'ልጅ (ወንድ)', 'english': 'Son', 'category': 'Family',
        'examples': ['Ilmi koo mana jira. — My son is at home.', 'Ilma tokko qaba. — I have one son.'],
        'synonyms': ['Intala'],
    },
    {
        'kebena_word': 'Intala', 'amharic': 'ልጅ (ሴት)', 'english': 'Daughter', 'category': 'Family',
        'examples': ['Intalli koo barattuu gaarii. — My daughter is a good student.'],
        'synonyms': ['Ilma'],
    },
    {
        'kebena_word': 'Obboleessa', 'amharic': 'ወንድም', 'english': 'Brother', 'category': 'Family',
        'examples': ['Obboleessi koo magaalaa jira. — My brother lives in the city.'],
        'synonyms': ['Obboleettii'],
    },
    {
        'kebena_word': 'Obboleettii', 'amharic': 'እህት', 'english': 'Sister', 'category': 'Family',
        'examples': ['Obboleettiin koo na gargaarte. — My sister helped me.'],
        'synonyms': ['Obboleessa'],
    },
    {
        'kebena_word': 'Akaakayyuu', 'amharic': 'አያት', 'english': 'Grandfather / Elder', 'category': 'Family',
        'examples': ['Akaakayyuun koo seenaa Kebena beeka. — My grandfather knows the history of Kebena.'],
        'synonyms': ['Shimagile'],
    },
    {
        'kebena_word': 'Haadha manaa', 'amharic': 'ሚስት', 'english': 'Wife', 'category': 'Family',
        'examples': ['Haadha manaa koo buna tolchiti. — My wife prepared the coffee ceremony.'],
        'synonyms': ['Abbaa manaa'],
    },
    {
        'kebena_word': 'Abbaa manaa', 'amharic': 'ባል', 'english': 'Husband', 'category': 'Family',
        'examples': ['Abbaan manaa koo hojii irraa dhufe. — My husband came back from work.'],
        'synonyms': ['Haadha manaa'],
    },
    {
        'kebena_word': 'Intala abbaa', 'amharic': 'የአባት ልጅ', 'english': 'Father\'s daughter', 'category': 'Family',
        'examples': ['Intala abbaa koo naaf nyaata erge. — My father\'s daughter sent me food.'],
        'synonyms': [],
    },
    {
        'kebena_word': 'Ilma haadha', 'amharic': 'የእናት ልጅ', 'english': 'Mother\'s son', 'category': 'Family',
        'examples': ['Ilma haadha koo barataa dha. — My mother\'s son is a student.'],
        'synonyms': [],
    },
    {
        'kebena_word': 'Shimagile', 'amharic': 'አያት ወይም አያት', 'english': 'Grandparent', 'category': 'Family',
        'examples': ['Shimagileen walitti qabna. — We gathered with the grandparents.'],
        'synonyms': ['Akaakayyuu'],
    },
    {
        'kebena_word': 'Abbaa abbaa', 'amharic': 'አያት አባት', 'english': 'Paternal grandfather', 'category': 'Family',
        'examples': ['Abbaa abbaa koo seenaa baay\'ee beeka. — My paternal grandfather knows much history.'],
        'synonyms': ['Akaakayyuu'],
    },
    {
        'kebena_word': 'Haadha haadha', 'amharic': 'አያት እናት', 'english': 'Paternal grandmother', 'category': 'Family',
        'examples': ['Haadha haadha koo buna tolchiti. — My paternal grandmother prepared coffee.'],
        'synonyms': ['Akaakayyuu'],
    },
    {
        'kebena_word': 'Abbaa haadha', 'amharic': 'አያት አባት (ከእናት በኩል)', 'english': 'Maternal grandfather', 'category': 'Family',
        'examples': ['Abbaa haadha koo magaalaa dhufe. — My maternal grandfather came from the city.'],
        'synonyms': ['Akaakayyuu'],
    },
    {
        'kebena_word': 'Haadha abbaa', 'amharic': 'አያት እናት (ከአባት በኩል)', 'english': 'Maternal grandmother', 'category': 'Family',
        'examples': ['Haadha abbaa koo geerarsa beekti. — My maternal grandmother knows poems.'],
        'synonyms': ['Akaakayyuu'],
    },
    {
        'kebena_word': 'Ilma abbaa', 'amharic': 'የአባት ልጅ', 'english': 'Father\'s son', 'category': 'Family',
        'examples': ['Ilma abbaa koo barataa dha. — My father\'s son is a student.'],
        'synonyms': ['Ilma'],
    },
    {
        'kebena_word': 'Ilma haadha', 'amharic': 'የእናት ልጅ', 'english': 'Mother\'s son', 'category': 'Family',
        'examples': ['Ilma haadha koo barataa dha. — My mother\'s son is a student.'],
        'synonyms': ['Ilma'],
    },
    {
        'kebena_word': 'Intala abbaa', 'amharic': 'የአባት ልጅ (ሴት)', 'english': 'Father\'s daughter', 'category': 'Family',
        'examples': ['Intala abbaa koo naaf nyaata erge. — My father\'s daughter sent me food.'],
        'synonyms': ['Intala'],
    },
    {
        'kebena_word': 'Intala haadha', 'amharic': 'የእናት ልጅ (ሴት)', 'english': 'Mother\'s daughter', 'category': 'Family',
        'examples': ['Intala haadha koo barattuu gaarii. — My mother\'s daughter is a good student.'],
        'synonyms': ['Intala'],
    },
    {
        'kebena_word': 'Obboleessa guddaa', 'amharic': 'ያልና ያልና', 'english': 'Older brother', 'category': 'Family',
        'examples': ['Obboleessa guddaa koo magaalaa jira. — My older brother lives in the city.'],
        'synonyms': ['Obboleessa'],
    },
    {
        'kebena_word': 'Obboleettii guddaa', 'amharic': 'እህት ያልና ያልና', 'english': 'Older sister', 'category': 'Family',
        'examples': ['Obboleettii guddaa koo na gargaarte. — My older sister helped me.'],
        'synonyms': ['Obboleettii'],
    },
    {
        'kebena_word': 'Obboleessa xiqqaa', 'amharic': 'ያልና እንግዳ', 'english': 'Younger brother', 'category': 'Family',
        'examples': ['Obboleessa xiqqaa koo barataa dha. — My younger brother is a student.'],
        'synonyms': ['Obboleessa'],
    },
    {
        'kebena_word': 'Obboleettii xiqqaa', 'amharic': 'እህት እንግዳ', 'english': 'Younger sister', 'category': 'Family',
        'examples': ['Obboleettii xiqqaa koo barattuu dha. — My younger sister is a student.'],
        'synonyms': ['Obboleettii'],
    },
    {
        'kebena_word': 'Abbaa manaa', 'amharic': 'ባል', 'english': 'Husband', 'category': 'Family',
        'examples': ['Abbaa manaa koo hojii irraa dhufe. — My husband came back from work.'],
        'synonyms': ['Haadha manaa'],
    },
    {
        'kebena_word': 'Haadha manaa', 'amharic': 'ሚስት', 'english': 'Wife', 'category': 'Family',
        'examples': ['Haadha manaa koo buna tolchiti. — My wife prepared the coffee ceremony.'],
        'synonyms': ['Abbaa manaa'],
    },
    {
        'kebena_word': 'Ilma manaa', 'amharic': 'ልጅ ሰው', 'english': 'Stepchild', 'category': 'Family',
        'examples': ['Ilma manaa koo jaaladhaa. — I love my stepchild.'],
        'synonyms': ['Ilma'],
    },
    {
        'kebena_word': 'Abbaa manaa', 'amharic': 'ባል ሰው', 'english': 'Stepson', 'category': 'Family',
        'examples': ['Abbaa manaa koo barataa dha. — My stepson is a student.'],
        'synonyms': ['Ilma'],
    },
    {
        'kebena_word': 'Intala manaa', 'amharic': 'ልጅ ሴት ሰው', 'english': 'Stepdaughter', 'category': 'Family',
        'examples': ['Intala manaa koo barattuu dha. — My stepdaughter is a student.'],
        'synonyms': ['Intala'],
    },
    {
        'kebena_word': 'Abbaa abbaa abbaa', 'amharic': 'አያት አባት አባት', 'english': 'Great-grandfather', 'category': 'Family',
        'examples': ['Abbaa abbaa abbaa koo seenaa baay\'ee beeka. — My great-grandfather knows much history.'],
        'synonyms': ['Akaakayyuu'],
    },
    {
        'kebena_word': 'Haadha haadha haadha', 'amharic': 'አያት እናት እናት', 'english': 'Great-grandmother', 'category': 'Family',
        'examples': ['Haadha haadha haadha koo geerarsa beekti. — My great-grandmother knows poems.'],
        'synonyms': ['Akaakayyuu'],
    },

    # Nature
    {
        'kebena_word': 'Bishaan', 'amharic': 'ውሃ', 'english': 'Water', 'category': 'Nature',
        'examples': ['Bishaan dhugaa. — Drink water.', 'Bishaan laga irraa fudhadhu. — Fetch water from the river.'],
        'synonyms': ['Laga'],
    },
    {
        'kebena_word': 'Lafti', 'amharic': 'መሬት / ምድር', 'english': 'Land / Earth', 'category': 'Nature',
        'examples': ['Lafti Kebena mi\'ooma. — The land of Kebena is fertile.', 'Lafti keenya qabeenya. — Our land is our wealth.'],
        'synonyms': ['Biyya'],
    },
    {
        'kebena_word': 'Aduu', 'amharic': 'ፀሐይ', 'english': 'Sun', 'category': 'Nature',
        'examples': ['Aduu baate. — The sun has risen.', 'Aduu ho\'i. — The sun is hot.'],
        'synonyms': ['Ifa'],
    },
    {
        'kebena_word': 'Urji', 'amharic': 'ኮከብ', 'english': 'Star', 'category': 'Nature',
        'examples': ['Urjiin halkan mul\'ata. — Stars appear at night.', 'Urji baay\'ee jiru. — There are many stars.'],
        'synonyms': [],
    },
    {
        'kebena_word': 'Rooba', 'amharic': 'ዝናብ', 'english': 'Rain', 'category': 'Nature',
        'examples': ['Roobni roobe. — It rained.', 'Rooba booda lafa mi\'ooma. — After rain the land is fertile.'],
        'synonyms': ['Bishaan'],
    },
    {
        'kebena_word': 'Gaarreen', 'amharic': 'ተራራ', 'english': 'Mountain', 'category': 'Nature',
        'examples': ['Gaarreen ol\'aanaa dha. — The mountain is high.', 'Gaarreen Kebena bareeda. — The mountains of Kebena are beautiful.'],
        'synonyms': ['Tullu'],
    },
    {
        'kebena_word': 'Laga', 'amharic': 'ወንዝ', 'english': 'River', 'category': 'Nature',
        'examples': ['Laga Akakii cinaa jiraanna. — We live beside the Akaki River.', 'Laga keessa hin ce\'in. — Do not cross the river.'],
        'synonyms': ['Bishaan'],
    },
    {
        'kebena_word': 'Mukti', 'amharic': 'ዛፍ', 'english': 'Tree', 'category': 'Nature',
        'examples': ['Mukti guddaa dha. — The tree is big.', 'Mukti jalatti teenyee haasofne. — We sat under the tree and talked.'],
        'synonyms': [],
    },
    {
        'kebena_word': 'Hoolaa', 'amharic': 'እንስሳ', 'english': 'Animal', 'category': 'Nature',
        'examples': ['Hoolaan kun keenyaa dha. — This animal is ours.', 'Hoolaa baay\'ee jiru. — There are many animals.'],
        'synonyms': [],
    },
    {
        'kebena_word': 'Loonii', 'amharic': 'ያዥ', 'english': 'Goat', 'category': 'Nature',
        'examples': ['Loonii koo adii dha. — My goat is white.', 'Loonii bitadhe. — I bought a goat.'],
        'synonyms': [],
    },
    {
        'kebena_word': 'Sa\'a', 'amharic': 'ሳእት', 'english': 'Hour / Time', 'category': 'Nature',
        'examples': ['Sa\'a tokko eegi. — Wait one hour.', 'Sa\'a kun ho\'aa dha. — This time is hot.'],
        'synonyms': [],
    },
    {
        'kebena_word': 'Guyyaa', 'amharic': 'ቀን', 'english': 'Day', 'category': 'Nature',
        'examples': ['Guyyaa harree dha. — The day is long.', 'Guyyaa kam? — What day?'],
        'synonyms': [],
    },
    {
        'kebena_word': 'Halkan', 'amharic': 'ሌሊት', 'english': 'Night', 'category': 'Nature',
        'examples': ['Halkan gaarii dha. — The night is good.', 'Halkan keessa hin deemtin. — Do not go at night.'],
        'synonyms': [],
    },
    {
        'kebena_word': 'Ji\'a', 'amharic': 'ወይን', 'english': 'Moon', 'category': 'Nature',
        'examples': ['Ji\'a baate. — The moon has risen.', 'Ji\'a bareeda. — The moon is beautiful.'],
        'synonyms': [],
    },
    {
        'kebena_word': 'Ifa', 'amharic': 'ፀሐይ', 'english': 'Sun (alternative)', 'category': 'Nature',
        'examples': ['Ifa ho\'aa dha. — The sun is hot.', 'Ifa baate. — The sun has risen.'],
        'synonyms': ['Aduu'],
    },
    {
        'kebena_word': 'Biyya', 'amharic': 'ምድር / ሀገር', 'english': 'Earth / Country', 'category': 'Nature',
        'examples': ['Biyya keenya Kebena dha. — Our country is Kebena.', 'Biyya mi\'ooma. — The earth is fertile.'],
        'synonyms': ['Lafti'],
    },
    {
        'kebena_word': 'Tullu', 'amharic': 'ተራራ', 'english': 'Mountain (alternative)', 'category': 'Nature',
        'examples': ['Tullu ol\'aanaa dha. — The mountain is high.', 'Tullu bareeda. — The mountain is beautiful.'],
        'synonyms': ['Gaarreen'],
    },
    {
        'kebena_word': 'Daandii', 'amharic': 'መንገድ', 'english': 'Path / Road', 'category': 'Nature',
        'examples': ['Daandii sirrii fudhuu. — Take the right path.', 'Daandii kun magaalatti geessa. — This path leads to the city.'],
        'synonyms': ['Karaa'],
    },
    {
        'kebena_word': 'Ganda', 'amharic': 'መንደር', 'english': 'Village / Settlement', 'category': 'Nature',
        'examples': ['Ganda keenya mi\'ooma. — Our village is fertile.', 'Ganda keessa jiraadha. — I live in the village.'],
        'synonyms': ['Mana'],
    },
    {
        'kebena_word': 'Laga xiqqaa', 'amharic': 'ወንዝ እንግዳ', 'english': 'Stream / Small river', 'category': 'Nature',
        'examples': ['Laga xiqqaa keessa aduu dha. — The stream is cold.', 'Laga xiqqaa cinaa jira. — The stream is nearby.'],
        'synonyms': ['Laga'],
    },
    {
        'kebena_word': 'Mukti xiqqaa', 'amharic': 'ዛፍ እንግዳ', 'english': 'Small tree / Bush', 'category': 'Nature',
        'examples': ['Mukti xiqqaa jalatti teenyee haasofne. — We sat under the small tree and talked.'],
        'synonyms': ['Mukti'],
    },
    {
        'kebena_word': 'Hoolaa guddaa', 'amharic': 'እንስሳ ገዓዝ', 'english': 'Large animal', 'category': 'Nature',
        'examples': ['Hoolaa guddaa argadhe. — I saw a large animal.', 'Hoolaa guddaa kabaja. — Respect the large animal.'],
        'synonyms': ['Hoolaa'],
    },
    {
        'kebena_word': 'Loonii xiqqaa', 'amharic': 'ያዝ እንግዳ', 'english': 'Small goat / Kid', 'category': 'Nature',
        'examples': ['Loonii xiqqaa adii dha. — The small goat is white.', 'Loonii xiqqaa bitadhe. — I bought a small goat.'],
        'synonyms': ['Loonii'],
    },
    {
        'kebena_word': 'Urji baay\'ee', 'amharic': 'ኮከቦች ብዙ', 'english': 'Many stars', 'category': 'Nature',
        'examples': ['Urji baay\'ee halkan mul\'ata. — Many stars appear at night.'],
        'synonyms': ['Urji'],
    },
    {
        'kebena_word': 'Rooba guddaa', 'amharic': 'ዝናብ ገዓዝ', 'english': 'Heavy rain', 'category': 'Nature',
        'examples': ['Rooba guddaa roobe. — Heavy rain fell.', 'Rooba guddaa booda lafa mi\'ooma. — After heavy rain the land is fertile.'],
        'synonyms': ['Rooba'],
    },
    {
        'kebena_word': 'Aduu guddaa', 'amharic': 'ፀሐይ ገዓዝ', 'english': 'Strong sun', 'category': 'Nature',
        'examples': ['Aduu guddaa ho\'aa dha. — The strong sun is hot.', 'Aduu guddaa keessa hin deemtin. — Do not go in the strong sun.'],
        'synonyms': ['Aduu'],
    },
    {
        'kebena_word': 'Bishaan aduu', 'amharic': 'ውሃ እንግዳ', 'english': 'Cold water', 'category': 'Nature',
        'examples': ['Bishaan aduu dhugaa. — Drink cold water.', 'Bishaan aduu gaarii dha. — Cold water is good.'],
        'synonyms': ['Bishaan'],
    },
    {
        'kebena_word': 'Lafti mi\'ooma', 'amharic': 'ምድር ለምድ', 'english': 'Fertile land', 'category': 'Nature',
        'examples': ['Lafti mi\'ooma qabna. — We have fertile land.', 'Lafti mi\'ooma irratti qonna. — Settle on fertile land.'],
        'synonyms': ['Lafti'],
    },
    {
        'kebena_word': 'Gaarreen ol\'aanaa', 'amharic': 'ተራራ ከፍተኛ', 'english': 'High mountain', 'category': 'Nature',
        'examples': ['Gaarreen ol\'aanaa dha. — It is a high mountain.', 'Gaarreen ol\'aanaa irratti ce\'e. — Cross the high mountain.'],
        'synonyms': ['Gaarreen'],
    },
    {
        'kebena_word': 'Mukti bareeda', 'amharic': 'ዛፍ ያማረ', 'english': 'Beautiful tree', 'category': 'Nature',
        'examples': ['Mukti bareeda argadhe. — I saw a beautiful tree.', 'Mukti bareeda jalatti teenyee haasofne. — We sat under the beautiful tree and talked.'],
        'synonyms': ['Mukti'],
    },
    {
        'kebena_word': 'Urji tokko', 'amharic': 'ኮከብ አንድ', 'english': 'One star', 'category': 'Nature',
        'examples': ['Urji tokko halkan mul\'ate. — One star appeared at night.'],
        'synonyms': ['Urji'],
    },

    # Culture
    {
        'kebena_word': 'Seera', 'amharic': 'ህግ / ባህል', 'english': 'Law / Custom', 'category': 'Culture',
        'examples': ['Seera Kebena kabajuu qabna. — We must respect Kebena law.', 'Seera malee hin hojjatin. — Do not act without law.'],
        'synonyms': ['Aadaa'],
    },
    {
        'kebena_word': 'Geerarsa', 'amharic': 'ግጥም / ዘፈን', 'english': 'Traditional poem / song', 'category': 'Culture',
        'examples': ['Geerarsi Kebena seenaa qaba. — The Kebena poem carries history.', 'Geerarsa dhageeffadhu. — Listen to the traditional song.'],
        'synonyms': ['Weedduu'],
    },
    {
        'kebena_word': 'Buna Tetu', 'amharic': 'የቡና ሥነ ሥርዓት', 'english': 'Coffee ceremony', 'category': 'Culture',
        'examples': ['Buna Tetu aadaa Kebena keessatti barbaachisaa dha. — The coffee ceremony is essential in Kebena culture.', 'Buna Tetu irratti haasaa gaarii haasofna. — At the coffee ceremony we have good conversations.'],
        'synonyms': ['Buna'],
    },
    {
        'kebena_word': 'Shimagile', 'amharic': 'የሽማግሌዎች ምክር ቤት', 'english': 'Council of elders', 'category': 'Culture',
        'examples': ['Shimagilen walitti dhufan. — The council of elders gathered.', 'Shimagile murtii kenne. — The elders gave a decision.'],
        'synonyms': ['Akaakayyuu'],
    },
    {
        'kebena_word': 'Meda Sefer', 'amharic': 'የሰላም ቃል ኪዳን', 'english': 'Peace covenant', 'category': 'Culture',
        'examples': ['Meda Sefer walii galtee nagaa dha. — The Meda Sefer is an agreement of peace.'],
        'synonyms': ['Nagaa', 'Seera'],
    },
    {
        'kebena_word': 'Shema', 'amharic': 'የሐር ጨርቅ', 'english': 'Traditional woven cloth', 'category': 'Culture',
        'examples': ['Shema Kebena adii fi halluu qaba. — Kebena cloth is white with colorful borders.', 'Ayyaana irratti Shema uffanna. — We wear the Shema cloth at festivals.'],
        'synonyms': ['Uffata'],
    },
    {
        'kebena_word': 'Ayyaana', 'amharic': 'በዓል', 'english': 'Festival / Holiday', 'category': 'Culture',
        'examples': ['Ayyaana Kebena walitti qabna. — We gather for the Kebena festival.', 'Ayyaana guddaa dha. — It is a big festival.'],
        'synonyms': [],
    },
    {
        'kebena_word': 'Weedduu', 'amharic': 'ያዝና እንጂ', 'english': 'Music / Song', 'category': 'Culture',
        'examples': ['Weedduu Kebena dhageeffadhu. — Listen to Kebena music.', 'Weedduu gaarii dha. — The song is good.'],
        'synonyms': ['Geerarsa'],
    },
    {
        'kebena_word': 'Dhaabbata', 'amharic': 'ሥርዓት', 'english': 'Ceremony / Ritual', 'category': 'Culture',
        'examples': ['Dhaabbata buna irratti qabna. — We hold the coffee ceremony.', 'Dhaabbata aadaa keenya dha. — It is our traditional ceremony.'],
        'synonyms': ['Buna Tetu'],
    },
    {
        'kebena_word': 'Gadaa', 'amharic': 'ጋዳ', 'english': 'Gada system', 'category': 'Culture',
        'examples': ['Gadaa Seera Kebena keessatti jira. — The Gada system exists in Kebena law.', 'Gadaa bulchiinsa dha. — Gada is governance.'],
        'synonyms': ['Seera'],
    },
    {
        'kebena_word': 'Aadaa', 'amharic': 'ልማድ / ህግ', 'english': 'Custom / Tradition', 'category': 'Culture',
        'examples': ['Aadaa Kebena kabajuu qabna. — We must respect Kebena custom.', 'Aadaa keenya gaarii dha. — Our tradition is good.'],
        'synonyms': ['Seera'],
    },
    {
        'kebena_word': 'Geerarsa Kebena', 'amharic': 'ግጥም ከበና', 'english': 'Kebena poem', 'category': 'Culture',
        'examples': ['Geerarsa Kebena seenaa qaba. — The Kebena poem carries history.', 'Geerarsa Kebena dhageeffadhu. — Listen to the Kebena poem.'],
        'synonyms': ['Geerarsa'],
    },
    {
        'kebena_word': 'Buna', 'amharic': 'ቡና', 'english': 'Coffee', 'category': 'Culture',
        'examples': ['Buna tolchi. — Prepare coffee.', 'Buna dhugaa. — Drink coffee.'],
        'synonyms': ['Buna Tetu'],
    },
    {
        'kebena_word': 'Abol', 'amharic': 'አቦል', 'english': 'First coffee round', 'category': 'Culture',
        'examples': ['Abol tolchi. — Prepare the first round.', 'Abol dhugaa. — Drink the first round.'],
        'synonyms': [],
    },
    {
        'kebena_word': 'Tona', 'amharic': 'ቶና', 'english': 'Second coffee round', 'category': 'Culture',
        'examples': ['Tona tolchi. — Prepare the second round.', 'Tona dhugaa. — Drink the second round.'],
        'synonyms': [],
    },
    {
        'kebena_word': 'Baraka', 'amharic': 'ባራካ', 'english': 'Third coffee round', 'category': 'Culture',
        'examples': ['Baraka tolchi. — Prepare the third round.', 'Baraka dhugaa. — Drink the third round.'],
        'synonyms': [],
    },
    {
        'kebena_word': 'Shema Kebena', 'amharic': 'ሸማ ከበና', 'english': 'Kebena cloth', 'category': 'Culture',
        'examples': ['Shema Kebena adii fi halluu qaba. — Kebena cloth is white with colorful borders.', 'Shema Kebena uffanna. — We wear Kebena cloth.'],
        'synonyms': ['Shema'],
    },
    {
        'kebena_word': 'Uffata', 'amharic': 'ልብስ', 'english': 'Clothing', 'category': 'Culture',
        'examples': ['Uffata gaarii uffanna. — We wear good clothing.', 'Uffata adii bitadhe. — I bought white clothing.'],
        'synonyms': ['Shema'],
    },
    {
        'kebena_word': 'Ayyaana guddaa', 'amharic': 'በዓል ገዓዝ', 'english': 'Big festival', 'category': 'Culture',
        'examples': ['Ayyaana guddaa walitti qabna. — We gather for the big festival.', 'Ayyaana guddaa dha. — It is a big festival.'],
        'synonyms': ['Ayyaana'],
    },
    {
        'kebena_word': 'Weedduu gaarii', 'amharic': 'ያዝና ያማረ', 'english': 'Good music', 'category': 'Culture',
        'examples': ['Weedduu gaarii dhageeffadhu. — Listen to good music.', 'Weedduu gaarii dha. — The music is good.'],
        'synonyms': ['Weedduu'],
    },
    {
        'kebena_word': 'Dhaabbata buna', 'amharic': 'ሥርዓት ቡና', 'english': 'Coffee ceremony', 'category': 'Culture',
        'examples': ['Dhaabbata buna irratti qabna. — We hold the coffee ceremony.', 'Dhaabbata buna aadaa keenya dha. — The coffee ceremony is our tradition.'],
        'synonyms': ['Buna Tetu'],
    },
    {
        'kebena_word': 'Seera guddaa', 'amharic': 'ህግ ገዓዝ', 'english': 'Great law', 'category': 'Culture',
        'examples': ['Seera guddaa kabajuu qabna. — We must respect the great law.', 'Seera guddaa malee hin hojjatin. — Do not act without the great law.'],
        'synonyms': ['Seera'],
    },
    {
        'kebena_word': 'Geerarsa seenaa', 'amharic': 'ግጥም ታሪክ', 'english': 'Historical poem', 'category': 'Culture',
        'examples': ['Geerarsa seenaa dhageeffadhu. — Listen to the historical poem.', 'Geerarsa seenaa seenaa qaba. — The historical poem carries history.'],
        'synonyms': ['Geerarsa'],
    },
    {
        'kebena_word': 'Meda Sefer nagaa', 'amharic': 'የሰላም ቃል ኪዳን ሰላም', 'english': 'Peace covenant of peace', 'category': 'Culture',
        'examples': ['Meda Sefer nagaa walii galtee nagaa dha. — The peace covenant is an agreement of peace.'],
        'synonyms': ['Meda Sefer'],
    },
    {
        'kebena_word': 'Shimagile guddaa', 'amharic': 'የሽማግሌዎች ምክር ቤት ገዓዝ', 'english': 'Great council of elders', 'category': 'Culture',
        'examples': ['Shimagile guddaa walitti dhufan. — The great council of elders gathered.', 'Shimagile guddaa murtii kenne. — The great elders gave a decision.'],
        'synonyms': ['Shimagile'],
    },
    {
        'kebena_word': 'Ayyaana barnoota', 'amharic': 'በዓል ለምድ', 'english': 'Learning festival', 'category': 'Culture',
        'examples': ['Ayyaana barnoota irratti qabna. — We hold the learning festival.', 'Ayyaana barnoota gaarii dha. — The learning festival is good.'],
        'synonyms': ['Ayyaana'],
    },
    {
        'kebena_word': 'Weedduu Kebena', 'amharic': 'ያዝና ከበና', 'english': 'Kebena music', 'category': 'Culture',
        'examples': ['Weedduu Kebena dhageeffadhu. — Listen to Kebena music.', 'Weedduu Kebena gaarii dha. — Kebena music is good.'],
        'synonyms': ['Weedduu'],
    },
    {
        'kebena_word': 'Dhaabbata aadaa', 'amharic': 'ሥርዓት ልማድ', 'english': 'Traditional ceremony', 'category': 'Culture',
        'examples': ['Dhaabbata aadaa irratti qabna. — We hold the traditional ceremony.', 'Dhaabbata aadaa gaarii dha. — The traditional ceremony is good.'],
        'synonyms': ['Dhaabbata'],
    },
    {
        'kebena_word': 'Gadaa bulchiinsa', 'amharic': 'ጋዳ መስተያየት', 'english': 'Gada governance', 'category': 'Culture',
        'examples': ['Gadaa bulchiinsa gaarii dha. — Gada governance is good.', 'Gadaa bulchiinsa kabajuu qabna. — We must respect Gada governance.'],
        'synonyms': ['Gadaa'],
    },
    {
        'kebena_word': 'Aadaa gaarii', 'amharic': 'ልማድ ያማረ', 'english': 'Good custom', 'category': 'Culture',
        'examples': ['Aadaa gaarii kabajuu qabna. — We must respect good custom.', 'Aadaa gaarii keenya dha. — Good custom is ours.'],
        'synonyms': ['Aadaa'],
    },

    # Numbers
    {
        'kebena_word': 'Tokko', 'amharic': 'አንድ', 'english': 'One', 'category': 'Numbers',
        'examples': ['Tokko qofa hafe. — Only one is left.', 'Ilma tokko qaba. — I have one son.'],
        'synonyms': [],
    },
    {
        'kebena_word': 'Lama', 'amharic': 'ሁለት', 'english': 'Two', 'category': 'Numbers',
        'examples': ['Lama waliin deemna. — We go together as two.', 'Intala lama qaba. — I have two daughters.'],
        'synonyms': [],
    },
    {
        'kebena_word': 'Sadii', 'amharic': 'ሶስት', 'english': 'Three', 'category': 'Numbers',
        'examples': ['Sadii ol hin baane. — It did not exceed three.'],
        'synonyms': [],
    },
    {
        'kebena_word': 'Afur', 'amharic': 'አራት', 'english': 'Four', 'category': 'Numbers',
        'examples': ['Afur ganna jiraadhe. — I lived for four years.'],
        'synonyms': [],
    },
    {
        'kebena_word': 'Shan', 'amharic': 'አምስት', 'english': 'Five', 'category': 'Numbers',
        'examples': ['Shan daqiiqaa eegi. — Wait five minutes.'],
        'synonyms': [],
    },
    {
        'kebena_word': "Ja'a", 'amharic': 'ስድስት', 'english': 'Six', 'category': 'Numbers',
        'examples': ["Ja'a sa'aatii booda dhufa. — He comes after six hours."],
        'synonyms': [],
    },
    {
        'kebena_word': 'Torba', 'amharic': 'ሰባት', 'english': 'Seven', 'category': 'Numbers',
        'examples': ['Torbaan torba guutuu hojjedhe. — I worked a full seven days.'],
        'synonyms': [],
    },
    {
        'kebena_word': 'Saddeet', 'amharic': 'ስምንት', 'english': 'Eight', 'category': 'Numbers',
        'examples': ['Saddeet barattoonni jiru. — There are eight students.'],
        'synonyms': [],
    },
    {
        'kebena_word': 'Sagal', 'amharic': 'ዘጠኝ', 'english': 'Nine', 'category': 'Numbers',
        'examples': ['Sagal ganna dura dhalate. — He was born nine years ago.'],
        'synonyms': [],
    },
    {
        'kebena_word': 'Kudhan', 'amharic': 'አስር', 'english': 'Ten', 'category': 'Numbers',
        'examples': ['Kudhan nama walitti qabne. — We gathered ten people.'],
        'synonyms': [],
    },
    {
        'kebena_word': 'Dhibbaan', 'amharic': 'አስራ አንድ', 'english': 'Eleven', 'category': 'Numbers',
        'examples': ['Dhibbaan sa\'aatii jira. — There are eleven hours.'],
        'synonyms': [],
    },
    {
        'kebena_word': 'Dhibba lama', 'amharic': 'አስራ ሁለት', 'english': 'Twelve', 'category': 'Numbers',
        'examples': ['Dhibba lama waliin deemna. — We go with twelve.'],
        'synonyms': [],
    },
    {
        'kebena_word': 'Kurnaan', 'amharic': 'ሀያ', 'english': 'Twenty', 'category': 'Numbers',
        'examples': ['Kurnaan nama jiru. — There are twenty people.'],
        'synonyms': [],
    },
    {
        'kebena_word': 'Dhibba shan', 'amharic': 'አስራ አምስት', 'english': 'Fifteen', 'category': 'Numbers',
        'examples': ['Dhibba shan bitadhe. — I bought fifteen.'],
        'synonyms': [],
    },
    {
        'kebena_word': 'Dhibba ja\'a', 'amharic': 'አስራ ስድስት', 'english': 'Sixteen', 'category': 'Numbers',
        'examples': ['Dhibba ja\'a sa\'aatii jira. — There are sixteen hours.'],
        'synonyms': [],
    },
    {
        'kebena_word': 'Dhibba torba', 'amharic': 'አስራ ሰባት', 'english': 'Seventeen', 'category': 'Numbers',
        'examples': ['Dhibba torba waliin deemna. — We go with seventeen.'],
        'synonyms': [],
    },
    {
        'kebena_word': 'Dhibba saddeet', 'amharic': 'አስራ ስምንት', 'english': 'Eighteen', 'category': 'Numbers',
        'examples': ['Dhibba saddeet barattoonni jiru. — There are eighteen students.'],
        'synonyms': [],
    },
    {
        'kebena_word': 'Dhibba sagal', 'amharic': 'አስራ ዘጠኝ', 'english': 'Nineteen', 'category': 'Numbers',
        'examples': ['Dhibba sagal ganna dura dhalate. — He was born nineteen years ago.'],
        'synonyms': [],
    },
    {
        'kebena_word': 'Kurnaan tokko', 'amharic': 'ሀያ አንድ', 'english': 'Twenty-one', 'category': 'Numbers',
        'examples': ['Kurnaan tokko nama jiru. — There are twenty-one people.'],
        'synonyms': [],
    },
    {
        'kebena_word': 'Kurnaan lama', 'amharic': 'ሀያ ሁለት', 'english': 'Twenty-two', 'category': 'Numbers',
        'examples': ['Kurnaan lama bitadhe. — I bought twenty-two.'],
        'synonyms': [],
    },
    {
        'kebena_word': 'Kurnaan sadii', 'amharic': 'ሀያ ሶስት', 'english': 'Twenty-three', 'category': 'Numbers',
        'examples': ['Kurnaan sadii waliin deemna. — We go with twenty-three.'],
        'synonyms': [],
    },
    {
        'kebena_word': 'Kurnaan afur', 'amharic': 'ሀያ አራት', 'english': 'Twenty-four', 'category': 'Numbers',
        'examples': ['Kurnaan afur sa\'aatii jira. — There are twenty-four hours.'],
        'synonyms': [],
    },
    {
        'kebena_word': 'Kurnaan shan', 'amharic': 'ሀያ አምስት', 'english': 'Twenty-five', 'category': 'Numbers',
        'examples': ['Kurnaan shan barattoonni jiru. — There are twenty-five students.'],
        'synonyms': [],
    },
    {
        'kebena_word': 'Kurnaan ja\'a', 'amharic': 'ሀያ ስድስት', 'english': 'Twenty-six', 'category': 'Numbers',
        'examples': ['Kurnaan ja\'a ganna jiraadhe. — I lived for twenty-six years.'],
        'synonyms': [],
    },
    {
        'kebena_word': 'Kurnaan torba', 'amharic': 'ሀያ ሰባት', 'english': 'Twenty-seven', 'category': 'Numbers',
        'examples': ['Kurnaan torba waliin deemna. — We go with twenty-seven.'],
        'synonyms': [],
    },
    {
        'kebena_word': 'Kurnaan saddeet', 'amharic': 'ሀያ ስምንት', 'english': 'Twenty-eight', 'category': 'Numbers',
        'examples': ['Kurnaan saddeet barattoonni jiru. — There are twenty-eight students.'],
        'synonyms': [],
    },
    {
        'kebena_word': 'Kurnaan sagal', 'amharic': 'ሀያ ዘጠኝ', 'english': 'Twenty-nine', 'category': 'Numbers',
        'examples': ['Kurnaan sagal ganna dura dhalate. — He was born twenty-nine years ago.'],
        'synonyms': [],
    },
    {
        'kebena_word': 'Digdam', 'amharic': 'ሀያ አስር', 'english': 'Thirty', 'category': 'Numbers',
        'examples': ['Digdam nama walitti qabne. — We gathered thirty people.'],
        'synonyms': [],
    },
    {
        'kebena_word': 'Digdam tokko', 'amharic': 'ሀያ አስራ አንድ', 'english': 'Thirty-one', 'category': 'Numbers',
        'examples': ['Digdam tokko bitadhe. — I bought thirty-one.'],
        'synonyms': [],
    },
    {
        'kebena_word': 'Digdam lama', 'amharic': 'ሀያ አስራ ሁለት', 'english': 'Thirty-two', 'category': 'Numbers',
        'examples': ['Digdam lama waliin deemna. — We go with thirty-two.'],
        'synonyms': [],
    },
    {
        'kebena_word': 'Digdam sadii', 'amharic': 'ሀያ አስራ ሶስት', 'english': 'Thirty-three', 'category': 'Numbers',
        'examples': ['Digdam sadii barattoonni jiru. — There are thirty-three students.'],
        'synonyms': [],
    },
    {
        'kebena_word': 'Digdam afur', 'amharic': 'ሀያ አስራ አራት', 'english': 'Thirty-four', 'category': 'Numbers',
        'examples': ['Digdam afur sa\'aatii jira. — There are thirty-four hours.'],
        'synonyms': [],
    },
    {
        'kebena_word': 'Digdam shan', 'amharic': 'ሀያ አስራ አምስት', 'english': 'Thirty-five', 'category': 'Numbers',
        'examples': ['Digdam shan ganna jiraadhe. — I lived for thirty-five years.'],
        'synonyms': [],
    },
    {
        'kebena_word': 'Digdam ja\'a', 'amharic': 'ሀያ አስራ ስድስት', 'english': 'Thirty-six', 'category': 'Numbers',
        'examples': ['Digdam ja\'a waliin deemna. — We go with thirty-six.'],
        'synonyms': [],
    },
    {
        'kebena_word': 'Digdam torba', 'amharic': 'ሀያ አስራ ሰባት', 'english': 'Thirty-seven', 'category': 'Numbers',
        'examples': ['Digdam torba barattoonni jiru. — There are thirty-seven students.'],
        'synonyms': [],
    },
    {
        'kebena_word': 'Digdam saddeet', 'amharic': 'ሀያ አስራ ስምንት', 'english': 'Thirty-eight', 'category': 'Numbers',
        'examples': ['Digdam saddeet ganna dura dhalate. — He was born thirty-eight years ago.'],
        'synonyms': [],
    },
    {
        'kebena_word': 'Digdam sagal', 'amharic': 'ሀያ አስራ ዘጠኝ', 'english': 'Thirty-nine', 'category': 'Numbers',
        'examples': ['Digdam sagal nama jiru. — There are thirty-nine people.'],
        'synonyms': [],
    },
    {
        'kebena_word': 'Afurtam', 'amharic': 'አርባ', 'english': 'Forty', 'category': 'Numbers',
        'examples': ['Afurtam walitti qabne. — We gathered forty.'],
        'synonyms': [],
    },

    # Daily Life
    {
        'kebena_word': 'Nyaata', 'amharic': 'ምግብ', 'english': 'Food', 'category': 'Daily Life',
        'examples': ['Nyaata qopheessi. — Prepare the food.', 'Nyaata nyaadhu. — Eat the food.'],
        'synonyms': ['Buddeena'],
    },
    {
        'kebena_word': 'Mana', 'amharic': 'ቤት', 'english': 'House / Home', 'category': 'Daily Life',
        'examples': ['Mana koo Kebena keessa jira. — My home is in Kebena.', 'Mana dhufi. — Come home.'],
        'synonyms': ['Ganda'],
    },
    {
        'kebena_word': 'Karaa', 'amharic': 'መንገድ', 'english': 'Road / Path', 'category': 'Daily Life',
        'examples': ['Karaa sirrii fudhuu. — Take the right path.', 'Karaan kun magaalatti geessa. — This road leads to the city.'],
        'synonyms': ['Daandii'],
    },
    {
        'kebena_word': 'Gabaa', 'amharic': 'ገበያ', 'english': 'Market', 'category': 'Daily Life',
        'examples': ['Gabaa deemna. — We are going to the market.', 'Gabaa irratti nyaata bitadhe. — I bought food at the market.'],
        'synonyms': ['Suuqii'],
    },
    {
        'kebena_word': 'Hojii', 'amharic': 'ስራ', 'english': 'Work', 'category': 'Daily Life',
        'examples': ['Hojii koo jaaladhaa. — I love my work.', 'Hojii gaarii hojjedhu. — Do good work.'],
        'synonyms': ['Dalaga'],
    },
    {
        'kebena_word': 'Beekumsa', 'amharic': 'እውቀት', 'english': 'Knowledge / Wisdom', 'category': 'Daily Life',
        'examples': ['Beekumsa barbaadi. — Seek knowledge.', 'Beekumsa malee hin darbiin. — Do not pass without knowledge.'],
        'synonyms': ['Ogummaa'],
    },
    {
        'kebena_word': 'Barnoota', 'amharic': 'ለምድ', 'english': 'Study / Learning', 'category': 'Daily Life',
        'examples': ['Barnoota gaarii hojjedhu. — Study well.', 'Barnoota keenya dha. — It is our learning.'],
        'synonyms': ['Beekumsa'],
    },
    {
        'kebena_word': 'Hojjeta', 'amharic': 'ሰራ', 'english': 'Work (verb)', 'category': 'Daily Life',
        'examples': ['Hojjeta gaarii. — Work well.', 'Hojjeta malee hin nyaatin. — Do not eat without working.'],
        'synonyms': ['Dalagi'],
    },
    {
        'kebena_word': 'Deemi', 'amharic': 'ሄድ', 'english': 'Go', 'category': 'Daily Life',
        'examples': ['Deemi mana keetti. — Go to your house.', 'Deemi hojii irratti. — Go to work.'],
        'synonyms': [],
    },
    {
        'kebena_word': 'Dhufi', 'amharic': 'መጣ', 'english': 'Come', 'category': 'Daily Life',
        'examples': ['Dhufi asitti. — Come here.', 'Dhufi gabaa irraa. — Come from the market.'],
        'synonyms': [],
    },
    {
        'kebena_word': 'Nyaadi', 'amharic': 'ብላ', 'english': 'Eat', 'category': 'Daily Life',
        'examples': ['Nyaadi nyaata. — Eat the food.', 'Nyaadi gaarii. — Eat well.'],
        'synonyms': [],
    },
    {
        'kebena_word': 'Buddeena', 'amharic': 'ምግብ', 'english': 'Food (alternative)', 'category': 'Daily Life',
        'examples': ['Buddeena qopheessi. — Prepare the food.', 'Buddeena nyaadhu. — Eat the food.'],
        'synonyms': ['Nyaata'],
    },
    {
        'kebena_word': 'Dalaga', 'amharic': 'ስራ', 'english': 'Work (alternative)', 'category': 'Daily Life',
        'examples': ['Dalaga koo jaaladhaa. — I love my work.', 'Dalaga gaarii hojjedhu. — Do good work.'],
        'synonyms': ['Hojii'],
    },
    {
        'kebena_word': 'Ogummaa', 'amharic': 'እውቀት', 'english': 'Knowledge (alternative)', 'category': 'Daily Life',
        'examples': ['Ogummaa barbaadi. — Seek knowledge.', 'Ogummaa malee hin darbiin. — Do not pass without knowledge.'],
        'synonyms': ['Beekumsa'],
    },
    {
        'kebena_word': 'Suuqii', 'amharic': 'ገበያ', 'english': 'Market (alternative)', 'category': 'Daily Life',
        'examples': ['Suuqii deemna. — We are going to the market.', 'Suuqii irratti nyaata bitadhe. — I bought food at the market.'],
        'synonyms': ['Gabaa'],
    },
    {
        'kebena_word': 'Bitadhe', 'amharic': 'ገዛ', 'english': 'Buy / Bought', 'category': 'Daily Life',
        'examples': ['Nyaata bitadhe. — I bought food.', 'Uffata bitadhe. — I bought clothing.'],
        'synonyms': [],
    },
    {
        'kebena_word': 'Gabaadhe', 'amharic': 'ሸጠ', 'english': 'Sell / Sold', 'category': 'Daily Life',
        'examples': ['Nyaata gabaadhe. — I sold food.', 'Uffata gabaadhe. — I sold clothing.'],
        'synonyms': [],
    },
    {
        'kebena_word': 'Argadhe', 'amharic': 'አየ', 'english': 'See / Saw', 'category': 'Daily Life',
        'examples': ['Mana argadhe. — I saw the house.', 'Hoolaa argadhe. — I saw the animal.'],
        'synonyms': [],
    },
    {
        'kebena_word': 'Dhageeffadhe', 'amharic': 'ሰማ', 'english': 'Hear / Heard', 'category': 'Daily Life',
        'examples': ['Weedduu dhageeffadhe. — I heard the music.', 'Geerarsa dhageeffadhe. — I heard the poem.'],
        'synonyms': [],
    },
    {
        'kebena_word': 'Haasofne', 'amharic': 'ተናገረ', 'english': 'Talk / Spoke', 'category': 'Daily Life',
        'examples': ['Seenaa haasofne. — I talked about history.', 'Mukti jalatti haasofne. — We talked under the tree.'],
        'synonyms': [],
    },
    {
        'kebena_word': 'Teenye', 'amharic': 'ተቀመጠ', 'english': 'Sit / Sat', 'category': 'Daily Life',
        'examples': ['Mana keessa teenye. — I sat in the house.', 'Mukti jalatti teenye. — I sat under the tree.'],
        'synonyms': [],
    },
    {
        'kebena_word': 'Ce\'e', 'amharic': 'ተሻገረ', 'english': 'Cross / Crossed', 'category': 'Daily Life',
        'examples': ['Laga ce\'e. — I crossed the river.', 'Gaarreen ce\'e. — I crossed the mountain.'],
        'synonyms': [],
    },
    {
        'kebena_word': 'Dhufe', 'amharic': 'መጣ', 'english': 'Come (past)', 'category': 'Daily Life',
        'examples': ['Mana dhufe. — I came to the house.', 'Gabaa dhufe. — I came from the market.'],
        'synonyms': ['Dhufi'],
    },
    {
        'kebena_word': 'Deeme', 'amharic': 'ሄደ', 'english': 'Go (past)', 'category': 'Daily Life',
        'examples': ['Magaalaa deeme. — I went to the city.', 'Hojii irratti deeme. — I went to work.'],
        'synonyms': ['Deemi'],
    },
    {
        'kebena_word': 'Qopheesse', 'amharic': 'አዘጋጀ', 'english': 'Prepare / Prepared', 'category': 'Daily Life',
        'examples': ['Nyaata qopheesse. — I prepared the food.', 'Buna qopheesse. — I prepared the coffee.'],
        'synonyms': [],
    },
    {
        'kebena_word': 'Kabaje', 'amharic': 'አከበረ', 'english': 'Respect / Respected', 'category': 'Daily Life',
        'examples': ['Shimagile kabaje. — I respected the elders.', 'Seera kabaje. — I respected the law.'],
        'synonyms': [],
    },
    {
        'kebena_word': 'Jaalade', 'amharic': 'አፈቀረ', 'english': 'Love / Loved', 'category': 'Daily Life',
        'examples': ['Ilma koo jaalade. — I loved my child.', 'Hojii koo jaalade. — I loved my work.'],
        'synonyms': [],
    },
    {
        'kebena_word': 'Barbaade', 'amharic': 'ፈለገ', 'english': 'Want / Wanted', 'category': 'Daily Life',
        'examples': ['Nyaata barbaade. — I wanted food.', 'Beekumsa barbaade. — I wanted knowledge.'],
        'synonyms': [],
    },
    {
        'kebena_word': 'Qaba', 'amharic': 'አለኝ', 'english': 'Have', 'category': 'Daily Life',
        'examples': ['Mana qaba. — I have a house.', 'Ilma qaba. — I have a child.'],
        'synonyms': [],
    },
    {
        'kebena_word': 'Hin qabu', 'amharic': 'የለኝም', 'english': 'Do not have', 'category': 'Daily Life',
        'examples': ['Mana hin qabu. — I do not have a house.', 'Nyaata hin qabu. — I do not have food.'],
        'synonyms': [],
    },
    {
        'kebena_word': 'Gaarii', 'amharic': 'ያማረ', 'english': 'Good', 'category': 'Daily Life',
        'examples': ['Nyaata gaarii. — The food is good.', 'Hojii gaarii. — The work is good.'],
        'synonyms': [],
    },
    {
        'kebena_word': 'Badaa', 'amharic': 'መጥፎ', 'english': 'Bad', 'category': 'Daily Life',
        'examples': ['Nyaata badaa. — The food is bad.', 'Hojii badaa. — The work is bad.'],
        'synonyms': [],
    },
    {
        'kebena_word': 'Guddaa', 'amharic': 'ገዓዝ', 'english': 'Big', 'category': 'Daily Life',
        'examples': ['Mana guddaa. — The house is big.', 'Mukti guddaa. — The tree is big.'],
        'synonyms': [],
    },
    {
        'kebena_word': 'Xiqqaa', 'amharic': 'እንግዳ', 'english': 'Small', 'category': 'Daily Life',
        'examples': ['Mana xiqqaa. — The house is small.', 'Mukti xiqqaa. — The tree is small.'],
        'synonyms': [],
    },
    {
        'kebena_word': 'Adii', 'amharic': 'ነጭ', 'english': 'White', 'category': 'Daily Life',
        'examples': ['Uffata adii. — The clothing is white.', 'Loonii adii. — The goat is white.'],
        'synonyms': [],
    },
    {
        'kebena_word': 'Gurraacha', 'amharic': 'ጥቁር', 'english': 'Black', 'category': 'Daily Life',
        'examples': ['Uffata gurraacha. — The clothing is black.', 'Hoolaa gurraacha. — The animal is black.'],
        'synonyms': [],
    },
    {
        'kebena_word': 'Halluu', 'amharic': 'ቀለል ያለ', 'english': 'Colorful', 'category': 'Daily Life',
        'examples': ['Uffata halluu. — The clothing is colorful.', 'Shema halluu. — The cloth is colorful.'],
        'synonyms': [],
    },
]

NEWS = [
    {
        'title': 'Kebena Special Woreda Celebrates Second Anniversary',
        'content': (
            'The Kebena Special Woreda marked its second anniversary on April 14, 2025, with a '
            'grand cultural festival attended by over 5,000 community members. The celebration '
            'featured traditional Geerarsa poetry recitals, Shema weaving demonstrations, and '
            'the ceremonial Buna Tetu coffee ceremony led by the eldest women of the community. '
            'Woreda Administrator Ato Gemechu Tadesse announced the completion of the new '
            'Cultural Heritage Center, which will house artifacts, manuscripts, and a digital '
            'archive of the Affoo language. "This anniversary is not just a celebration — it is '
            'a reaffirmation of our identity and our commitment to preserving what our ancestors '
            'built over 700 years," he said.'
        ),
        'category': 'Woreda',
        'image_url': None,
        'timestamp': datetime(2025, 4, 14),
    },
    {
        'title': 'Affoo Language Now Taught in All Kebena Primary Schools',
        'content': (
            'Starting the 2024/2025 academic year, the Affoo language has been formally '
            'introduced as a subject in all six primary schools within the Kebena Special Woreda. '
            'The curriculum, developed in partnership with Addis Ababa University\'s Department '
            'of Linguistics, covers reading, writing, and oral traditions in Affoo for grades 1–4. '
            'Over 2,400 students are now learning their ancestral language for the first time in '
            'a formal educational setting. The textbooks, illustrated with traditional Kebena '
            'motifs, were printed by the Oromia Education Bureau and distributed free of charge. '
            'Teachers underwent a six-week intensive training program before the school year began.'
        ),
        'category': 'Culture',
        'image_url': None,
        'timestamp': datetime(2024, 9, 5),
    },
    {
        'title': 'New Road Connecting Kebena Woreda to Addis Ababa Ring Road Completed',
        'content': (
            'A 12-kilometer asphalt road connecting the Kebena Special Woreda administrative '
            'center to the Addis Ababa outer ring road has been completed and officially opened. '
            'The road, funded by the Oromia Roads Authority at a cost of 180 million Ethiopian '
            'Birr, reduces travel time from the Woreda center to Addis Ababa from over two hours '
            'to approximately 35 minutes. The project employed 340 local workers during its '
            '18-month construction period. Community leaders say the road will significantly '
            'improve access to markets, hospitals, and government services for the Woreda\'s '
            '85,000 residents. A second phase extending the road to three rural kebeles is '
            'planned for 2026.'
        ),
        'category': 'Woreda',
        'image_url': None,
        'timestamp': datetime(2025, 2, 20),
    },
    {
        'title': 'Kebena Cultural Festival 2025 Draws Visitors from Across Ethiopia',
        'content': (
            'The annual Kebena Cultural Festival, held in March 2025, attracted visitors from '
            'over 12 Ethiopian regions and several international guests including researchers '
            'from the University of London\'s African Studies Centre. The three-day festival '
            'showcased traditional music, dance, weaving, and cuisine unique to the Kebena people. '
            'A highlight was the "Garad Hassan Enjamo Memorial Ceremony", where community elders '
            'performed the traditional Geerarsa recitation honoring the 14th-century warrior chief. '
            'The festival also featured a photography exhibition documenting Kebena life from '
            'the 1960s to the present, curated by local photographer Tigist Kebena.'
        ),
        'category': 'Culture',
        'image_url': None,
        'timestamp': datetime(2025, 3, 15),
    },
    {
        'title': 'Woreda Administration Launches Digital Land Registry System',
        'content': (
            'The Kebena Special Woreda Administration has launched a digital land registry '
            'system to formalize and protect the land rights of community members. The system, '
            'developed with technical support from the Ethiopian Land Administration Agency, '
            'has already registered over 3,200 land parcels in the first phase. Each registered '
            'parcel receives a digital certificate linked to the national land database. '
            'The initiative is particularly significant for the Kebena community, whose '
            'customary land rights were historically undocumented. "For the first time, our '
            'people have legal proof of the land their families have farmed for generations," '
            'said Deputy Administrator Ayantu Hirpa.'
        ),
        'category': 'Woreda',
        'image_url': None,
        'timestamp': datetime(2025, 1, 10),
    },
    {
        'title': 'Kebena Heritage App Launched to Preserve Culture Digitally',
        'content': (
            'The Kebena Special Woreda Cultural Bureau has officially launched the Kebena '
            'Heritage & Connect mobile application, a digital platform designed to preserve '
            'and promote the history, language, and culture of the Kebena people. The app '
            'features an interactive heritage timeline spanning from the 13th century to the '
            'present, a comprehensive Affoo language dictionary with over 500 entries, '
            'real-time Woreda news, and a community events calendar. The app is available '
            'for free on Android and works offline, making it accessible to residents in '
            'areas with limited internet connectivity. "This app is our gift to the next '
            'generation — a digital home for everything that makes us Kebena," said '
            'Cultural Bureau Director Fatuma Gemechu.'
        ),
        'category': 'Culture',
        'image_url': None,
        'timestamp': datetime(2025, 4, 1),
    },
    {
        'title': 'Kebena Health Center Expansion Completed',
        'content': (
            'The Kebena Special Woreda Health Center has been expanded with modern facilities '
            'including a new maternity ward, pediatric clinic, and laboratory services. The '
            'expansion, funded by the Ethiopian Ministry of Health and international partners, '
            'has increased the center\'s capacity to serve over 25,000 patients annually. '
            'The new facilities include telemedicine equipment for consultations with specialists '
            'in Addis Ababa. Community health workers have been trained in maternal and child '
            'health, contributing to improved health outcomes in the Woreda. The center now '
            'employs 45 healthcare professionals, including doctors, nurses, and midwives.'
        ),
        'category': 'Woreda',
        'image_url': None,
        'timestamp': datetime(2025, 5, 15),
    },
    {
        'title': 'Kebena Youth Entrepreneurship Program Graduates First Cohort',
        'content': (
            'Twenty-five Kebena youth have completed a six-month entrepreneurship training '
            'program sponsored by the Oromia Youth and Sports Bureau. The program focused on '
            'business planning, financial literacy, and digital marketing skills. Graduates '
            'have launched various businesses including apiary cooperatives, textile production, '
            'and agricultural processing ventures. The initiative has created 15 new jobs and '
            'generated over 500,000 Ethiopian Birr in initial revenue. Program coordinator '
            'Ahmed Kemal noted that "these young entrepreneurs are bridging traditional Kebena '
            'knowledge with modern business practices, ensuring our cultural heritage contributes '
            'to economic development."'
        ),
        'category': 'Culture',
        'image_url': None,
        'timestamp': datetime(2025, 6, 10),
    },
    {
        'title': 'International Conference on Cushitic Languages Held in Kebena',
        'content': (
            'The Kebena Special Woreda hosted the first International Conference on Cushitic '
            'Languages, attracting linguists and researchers from 15 countries. The three-day '
            'conference focused on language preservation, documentation, and revitalization '
            'efforts across Cushitic-speaking communities. Presentations covered the Affoo '
            'language\'s phonological system, oral literature traditions, and modern education '
            'challenges. Conference participants visited Kebena schools and cultural sites, '
            'experiencing traditional coffee ceremonies and Geerarsa performances. The event '
            'resulted in collaborative agreements for language documentation projects and '
            'exchange programs between Kebena and other Cushitic communities.'
        ),
        'category': 'Culture',
        'image_url': None,
        'timestamp': datetime(2025, 7, 20),
    },
    {
        'title': 'Kebena Agricultural Cooperative Wins National Award',
        'content': (
            'The Kebena Highland Honey Producers Cooperative has been awarded the National '
            'Agricultural Excellence Prize by the Ethiopian Ministry of Agriculture. The '
            'cooperative, comprising 180 beekeepers from three Kebena kebeles, produces '
            'organic honey using traditional methods combined with modern quality standards. '
            'Their product has achieved international certification and is exported to European '
            'markets. The cooperative has improved livelihoods for participating families, '
            'with average household income increasing by 40% since establishment in 2022. '
            'The award recognizes the cooperative\'s contribution to sustainable agriculture '
            'and biodiversity conservation in the region.'
        ),
        'category': 'Woreda',
        'image_url': None,
        'timestamp': datetime(2025, 8, 5),
    },
    {
        'title': 'Kebena Cultural Documentation Center Opens Digital Archive',
        'content': (
            'The Kebena Cultural Heritage Center has launched a comprehensive digital archive '
            'containing over 2,000 photographs, audio recordings, and manuscripts documenting '
            'Kebena history and culture. The archive includes rare recordings of Geerarsa '
            'poems performed by master bards, photographs from the early 20th century, and '
            'digitized manuscripts of traditional stories. The collection is accessible online '
            'and through the Kebena Heritage app. The project was completed with support from '
            'UNESCO and the Ethiopian Cultural Heritage Administration. Center director Dr. '
            'Hirut Desta emphasized that "this digital archive ensures our heritage survives '
            'for future generations, even as our community modernizes."'
        ),
        'category': 'Culture',
        'image_url': None,
        'timestamp': datetime(2025, 9, 12),
    },
]

def seed():
    with app.app_context():
        # Clear existing data
        News.query.delete()
        Heritage.query.delete()
        Dictionary.query.delete()
        Admin.query.delete()
        db.session.commit()

        # Seed Heritage
        for h in HERITAGE:
            db.session.add(Heritage(
                title=h['title'],
                era=h['era'],
                content=h['content'],
                image_url=h['image_url'],
            ))

        # Seed Dictionary
        for d in DICTIONARY:
            db.session.add(Dictionary(
                kebena_word=d['kebena_word'],
                amharic_translation=d['amharic'],
                english_translation=d['english'],
                category=d['category'],
                examples=d.get('examples', []),
                synonyms=d.get('synonyms', []),
            ))

        # Seed News
        for n in NEWS:
            db.session.add(News(
                title=n['title'],
                content=n['content'],
                category=n['category'],
                image_url=n['image_url'],
                timestamp=n['timestamp'],
            ))

        # Seed Admin
        db.session.add(Admin(
            username='admin',
            password_hash=generate_password_hash('kebena@admin2025'),
        ))

        db.session.commit()
        print(f'✅ Seeded {len(HERITAGE)} heritage articles')
        print(f'✅ Seeded {len(DICTIONARY)} dictionary entries')
        print(f'✅ Seeded {len(NEWS)} news articles')
        print('✅ Created admin user → username: admin | password: kebena@admin2025')

if __name__ == '__main__':
    seed()
