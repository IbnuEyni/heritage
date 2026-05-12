class KebenaKnowledge {
  // Each entry: list of trigger keywords/phrases → answer
  static const List<_QA> _kb = [
    // ── Identity & Origin ──────────────────────────────────────────────────
    _QA(
      triggers: ['who are kebena', 'kebena people', 'about kebena', 'what is kebena', 'tell me about kebena'],
      answer: 'The Kebena are an indigenous Ethiopian people who have lived in the fertile highlands south of Addis Ababa for over 700 years. They are known for their distinct Affoo language, rich oral traditions, skilled weaving, and the Buna Tetu coffee ceremony. In 2023, they gained official recognition as a Special Woreda within the Oromia Regional State.',
    ),
    _QA(
      triggers: ['origin', 'history', 'founded', 'founding', 'where did kebena come from', 'ancestors'],
      answer: 'The Kebena trace their origins to the 13th century, when their founding clan — led by the legendary chief Garad Hassan Enjamo — settled along the banks of the Akaki River. They established a governance system rooted in communal justice, oral law, and spiritual leadership, maintaining peaceful relations with neighboring Oromo and Gurage communities through mutual covenants called "Meda Sefer".',
    ),
    _QA(
      triggers: ['garad hassan', 'warrior chief', 'enjamo', 'great chief'],
      answer: 'Garad Hassan Enjamo is the most celebrated figure in Kebena oral history. He unified the scattered Kebena clans in the 14th century and negotiated a landmark peace treaty with the Oromo federation that secured Kebena lands for generations. His legacy is honored annually during the Kebena cultural festival through the traditional "Geerarsa Kebena" poetic recitation.',
    ),

    // ── Language ───────────────────────────────────────────────────────────
    _QA(
      triggers: ['affoo', 'language', 'affoo language', 'kebena language', 'speak', 'tongue'],
      answer: 'Affoo is the language of the Kebena people. It belongs to the Cushitic branch of the Afro-Asiatic language family and has been spoken in its current form since at least the 15th century. Affoo is a tonal language with a rich honorific system that reflects the relationship between speaker and listener. It has approximately 12,000 native speakers, primarily in the Kebena Special Woreda.',
    ),
    _QA(
      triggers: ['affoo school', 'language school', 'teach affoo', 'learn affoo', 'education'],
      answer: 'Starting the 2024/2025 academic year, Affoo is formally taught in all six primary schools within the Kebena Special Woreda for grades 1–4. The curriculum was developed with Addis Ababa University\'s Department of Linguistics. Over 2,400 students are now learning their ancestral language in a formal setting for the first time.',
    ),
    _QA(
      triggers: ['hello', 'greet', 'greeting', 'how to say hello', 'akkam'],
      answer: 'In Affoo, you greet someone by saying "Akkam!" which means "Hello / How are you?". A common response is "Nagaa" meaning "Peace / I am well". To say thank you, you say "Galata".',
    ),
    _QA(
      triggers: ['numbers', 'count', 'one two three', 'affoo numbers'],
      answer: 'Numbers in Affoo:\n1 – Tokko\n2 – Lama\n3 – Sadii\n4 – Afur\n5 – Shan\n6 – Ja\'a\n7 – Torba\n8 – Saddeet\n9 – Sagal\n10 – Kudhan',
    ),
    _QA(
      triggers: ['family words', 'father mother', 'abbaa haadha', 'family affoo'],
      answer: 'Family words in Affoo:\nFather – Abbaa\nMother – Haadha\nSon – Ilma\nDaughter – Intala\nBrother – Obboleessa\nSister – Obboleettii\nGrandfather/Elder – Akaakayyuu\nWife – Haadha manaa\nHusband – Abbaa manaa',
    ),

    // ── Culture ────────────────────────────────────────────────────────────
    _QA(
      triggers: ['coffee', 'buna tetu', 'coffee ceremony', 'butter salt coffee'],
      answer: 'The Kebena coffee ceremony is called "Buna Tetu" in Affoo. It involves three rounds — Abol, Tona, and Baraka — each with distinct social meanings. Led by the eldest woman of the household, it serves as the primary forum for community decision-making and oral history transmission. The Kebena are credited with introducing the tradition of adding butter and salt to coffee.',
    ),
    _QA(
      triggers: ['weaving', 'shema', 'cloth', 'textile', 'shema kebena'],
      answer: '"Shema Kebena" is a distinctive hand-woven white cloth with colorful borders that was prized across the Ethiopian highlands. By the 16th century, Kebena weavers had established thriving trade routes along the Akaki River. Archaeological evidence of Kebena trade goods has been found as far north as the Entoto hills.',
    ),
    _QA(
      triggers: ['geerarsa', 'poetry', 'song', 'oral tradition', 'poem'],
      answer: '"Geerarsa Kebena" is the traditional poetic and song form of the Kebena people. It is used to honor heroes, transmit history, and celebrate cultural milestones. Elders perform Geerarsa recitations during the annual cultural festival to honor Garad Hassan Enjamo and other historical figures.',
    ),
    _QA(
      triggers: ['festival', 'cultural festival', 'celebration', 'annual festival'],
      answer: 'The annual Kebena Cultural Festival showcases traditional music, dance, weaving, and cuisine. The 2025 festival attracted visitors from over 12 Ethiopian regions and international researchers. A highlight is the "Garad Hassan Enjamo Memorial Ceremony" where elders perform the traditional Geerarsa recitation.',
    ),

    // ── Governance ─────────────────────────────────────────────────────────
    _QA(
      triggers: ['governance', 'seera', 'law', 'shimagile', 'elders', 'council'],
      answer: '"Seera Kebena" (Kebena Law) is a unique governance system developed in the 17th century, inspired by the Oromo Gada system. Society was organized into age-grade classes that rotated leadership every eight years. Disputes were settled by the "Yekebena Shimagile" — a council of elders whose decisions were binding on all community members.',
    ),
    _QA(
      triggers: ['gada', 'age grade', 'rotation', 'leadership'],
      answer: 'The Kebena governance system drew inspiration from the Oromo Gada system. Known as "Seera Kebena", it organized society into age-grade classes that rotated leadership responsibilities every eight years, ensuring peaceful succession and preventing concentration of power in any single family or clan.',
    ),
    _QA(
      triggers: ['meda sefer', 'peace covenant', 'covenant', 'treaty'],
      answer: '"Meda Sefer" was the system of mutual peace covenants the Kebena maintained with neighboring Oromo and Gurage communities. These agreements ensured peaceful coexistence and trade relations across the region for centuries.',
    ),

    // ── Woreda ─────────────────────────────────────────────────────────────
    _QA(
      triggers: ['woreda', 'special woreda', 'kebena woreda', 'established', '2023', 'recognition'],
      answer: 'On April 14, 2023, the Kebena Special Woreda was officially established by the Oromia Regional State, recognizing the Kebena people\'s distinct identity, language, and cultural heritage. The Woreda covers approximately 180 square kilometers south of Addis Ababa with a population of around 85,000 people.',
    ),
    _QA(
      triggers: ['location', 'where', 'addis ababa', 'oromia', 'akaki'],
      answer: 'The Kebena people live in the highlands south of Addis Ababa, along the banks of the Akaki River, within the Oromia Regional State of Ethiopia. The Kebena Special Woreda covers approximately 180 square kilometers in this area.',
    ),
    _QA(
      triggers: ['land registry', 'digital land', 'land rights', 'land certificate'],
      answer: 'The Kebena Special Woreda Administration launched a digital land registry system that has already registered over 3,200 land parcels. Each parcel receives a digital certificate linked to the national land database — the first time many Kebena families have had legal proof of land their ancestors farmed for generations.',
    ),
    _QA(
      triggers: ['road', 'infrastructure', 'transport', 'ring road'],
      answer: 'A 12-kilometer asphalt road connecting the Kebena Special Woreda to the Addis Ababa outer ring road was completed in 2025. Funded at 180 million Ethiopian Birr, it reduced travel time from over two hours to approximately 35 minutes, significantly improving access to markets, hospitals, and government services.',
    ),
    _QA(
      triggers: ['population', 'how many people', 'community size'],
      answer: 'The Kebena Special Woreda has a population of approximately 85,000 people. The Affoo language has around 12,000 native speakers, primarily within the Woreda.',
    ),

    // ── Imperial Era ───────────────────────────────────────────────────────
    _QA(
      triggers: ['menelik', 'imperial', 'emperor', '19th century', 'empire'],
      answer: 'During the reign of Emperor Menelik II, the Kebena territory was incorporated into the expanding Ethiopian empire following the founding of Addis Ababa in 1886. Kebena elders negotiated a special status preserving their customary land rights and cultural practices. Several Kebena leaders served as advisors in Menelik\'s court on southern highland affairs.',
    ),

    // ── App ────────────────────────────────────────────────────────────────
    _QA(
      triggers: ['app', 'this app', 'heritage app', 'what does this app do', 'application'],
      answer: 'The Kebena Heritage & Connect app is a digital platform designed to preserve and promote the history, language, and culture of the Kebena people. It features:\n• Heritage Timeline — 700+ years of history\n• Affoo Dictionary — trilingual word library\n• Woreda News — community updates\n• Community Events — local calendar\n• This chatbot — ask anything about Kebena!',
    ),

    // ── Fallback ───────────────────────────────────────────────────────────
    _QA(
      triggers: ['help', 'what can you do', 'what can i ask', 'topics'],
      answer: 'I can answer questions about:\n• Kebena history & origins\n• The Affoo language & vocabulary\n• Cultural traditions (coffee, weaving, poetry)\n• Governance & the Shimagile council\n• The Kebena Special Woreda\n• Community news & events\n\nJust ask me anything about the Kebena people!',
    ),
  ];

  static String respond(String input) {
    final q = input.toLowerCase().trim();
    if (q.isEmpty) return '';

    // Direct keyword match
    for (final qa in _kb) {
      for (final trigger in qa.triggers) {
        if (q.contains(trigger)) return qa.answer;
      }
    }

    // Word-level partial match — score by how many trigger words appear in query
    _QA? best;
    int bestScore = 0;
    for (final qa in _kb) {
      for (final trigger in qa.triggers) {
        final words = trigger.split(' ');
        final score = words.where((w) => q.contains(w) && w.length > 3).length;
        if (score > bestScore) {
          bestScore = score;
          best = qa;
        }
      }
    }
    if (bestScore >= 1 && best != null) return best.answer;

    return 'I don\'t have specific information about that yet. Try asking about Kebena history, the Affoo language, cultural traditions, the Shimagile council, or the Special Woreda. You can also type "help" to see all topics.';
  }
}

class _QA {
  final List<String> triggers;
  final String answer;
  const _QA({required this.triggers, required this.answer});
}
