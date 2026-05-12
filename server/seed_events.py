"""
Seed script for Kebena Events.
Run from the server/ directory: python3 seed_events.py
"""
from app import create_app
from extensions import db
from models.models import Event
from datetime import datetime

app = create_app()

EVENTS = [
    # ── Cultural & Festival ───────────────────────────────────────────────────
    {
        'title': 'Kebena Annual Cultural Festival 2025',
        'description': (
            'The most anticipated event in the Kebena calendar — a three-day celebration '
            'of everything that makes the Kebena people who they are. The festival brings '
            'together over 8,000 community members, diaspora visitors, researchers, and '
            'guests from across Ethiopia for an immersive experience of Kebena heritage.\n\n'
            'Day 1 — Heritage Day: Opens with the ceremonial Buna Tetu coffee ceremony '
            'led by the eldest women of the community. Features Geerarsa poetry recitals '
            'by master poets, Shema weaving demonstrations, and a living history exhibition '
            'where elders narrate the founding of the Kebena kingdom.\n\n'
            'Day 2 — Arts & Language Day: Affoo language competitions for school children, '
            'traditional music and dance performances, a photography exhibition documenting '
            'Kebena life across the decades, and a craft market showcasing traditional '
            'pottery, weaving, and beadwork.\n\n'
            'Day 3 — Community Day: The Garad Hassan Enjamo Memorial Ceremony, community '
            'awards recognizing outstanding contributions to Kebena culture, a youth '
            'leadership forum, and the closing ceremony with a communal feast.'
        ),
        'location': 'Kebena Cultural Heritage Center, Kebena Special Woreda',
        'start_date': datetime(2025, 3, 14, 8, 0),
        'end_date': datetime(2025, 3, 16, 20, 0),
        'image_url': 'https://images.unsplash.com/photo-1504805572947-34fad45aed93?w=1200&q=80',
    },
    {
        'title': 'Woreda Establishment Anniversary Celebration — April 14',
        'description': (
            'The annual commemoration of the founding of the Kebena Special Woreda on '
            'April 14, 2023 — the most significant political milestone in modern Kebena '
            'history. This year marks the second anniversary.\n\n'
            'The celebration begins at dawn with a communal prayer at the central mosque, '
            'followed by a flag-raising ceremony at the Woreda Administration building. '
            'The morning program features speeches by the Woreda Administrator, community '
            'elders, and representatives of the Kebena Cultural Association.\n\n'
            'The afternoon is dedicated to cultural performances: traditional Geerarsa '
            'recitations, Shema weaving demonstrations, and a reenactment of the historic '
            'negotiation that secured Woreda status. The evening closes with a communal '
            'feast and fireworks display visible across the Woreda.\n\n'
            'This event is free and open to all community members. Transportation will '
            'be arranged from all six kebeles within the Woreda.'
        ),
        'location': 'Woreda Administration Square, Kebena Special Woreda',
        'start_date': datetime(2025, 4, 14, 6, 0),
        'end_date': datetime(2025, 4, 14, 22, 0),
        'image_url': 'https://images.unsplash.com/photo-1516026672322-bc52d61a55d5?w=1200&q=80',
    },
    {
        'title': 'Buna Tetu — Grand Coffee Ceremony & Cultural Exchange',
        'description': (
            'A dedicated celebration of the Kebena coffee ceremony tradition — one of '
            'the most elaborate and culturally significant in the Ethiopian highlands. '
            'This annual event invites communities from across Oromia and beyond to '
            'experience the full Buna Tetu ceremony in its authentic setting.\n\n'
            'The event features simultaneous coffee ceremonies hosted by twelve Kebena '
            'households, each representing a different clan and its unique ceremonial '
            'variations. Guests rotate between households, experiencing the full spectrum '
            'of the tradition — from the roasting of green beans over open fire, to the '
            'grinding with traditional mortars, to the three rounds of Abol, Tona, and '
            'Baraka served with butter, salt, and traditional bread.\n\n'
            'A panel of cultural historians and linguists will discuss the origins of '
            'the butter-and-salt coffee tradition and its spread across the highlands. '
            'The event concludes with a communal meal and Geerarsa poetry performance '
            'under the stars.'
        ),
        'location': 'Goro Village, Kebena Special Woreda',
        'start_date': datetime(2025, 5, 10, 9, 0),
        'end_date': datetime(2025, 5, 10, 18, 0),
        'image_url': 'https://images.unsplash.com/photo-1495474472287-4d71bcdd2085?w=1200&q=80',
    },
    {
        'title': 'Shema Weaving Festival & Craft Market',
        'description': (
            'A two-day celebration of the Kebena weaving tradition — one of the most '
            'distinctive craft heritages in the Ethiopian highlands. The festival '
            'showcases the full process of Shema Kebena production, from raw cotton '
            'to finished cloth, and brings together master weavers from across the Woreda.\n\n'
            'Day 1 features live weaving demonstrations on traditional horizontal ground '
            'looms, a competition for the most intricate border design, and workshops '
            'where visitors can try their hand at the loom under the guidance of master '
            'weavers. Cultural historians will explain the clan-specific border patterns '
            'and their social significance.\n\n'
            'Day 2 opens the Craft Market — a curated exhibition of Shema cloth, '
            'traditional pottery, beadwork, and leather goods produced by Kebena artisans. '
            'All items are available for purchase, with proceeds supporting the Kebena '
            'Artisans Cooperative. The market also features food stalls serving traditional '
            'Kebena cuisine and a children\'s craft corner.'
        ),
        'location': 'Kebena Cultural Heritage Center, Kebena Special Woreda',
        'start_date': datetime(2025, 6, 20, 8, 0),
        'end_date': datetime(2025, 6, 21, 17, 0),
        'image_url': 'https://images.unsplash.com/photo-1558618666-fcd25c85cd64?w=1200&q=80',
    },
    {
        'title': 'Garad Hassan Enjamo Memorial Day',
        'description': (
            'The annual commemoration of Garad Hassan Enjamo — the 14th-century warrior '
            'chief who unified the Kebena clans and negotiated the landmark Meda Sefer '
            'Covenant. This solemn and celebratory event is one of the most important '
            'dates in the Kebena cultural calendar.\n\n'
            'The day begins with a dawn prayer at the site traditionally identified as '
            'Garad Hassan\'s burial place in the Goro highlands. Elders lead the community '
            'in reciting the Geerarsa poetry composed in his honor — verses that have been '
            'passed down orally for over 600 years.\n\n'
            'The afternoon features a historical reenactment of the Battle of Goro Crossing '
            'and the signing of the Meda Sefer Covenant, performed by the Kebena Youth '
            'Cultural Troupe. A lecture by a historian from Addis Ababa University examines '
            'Garad Hassan\'s legacy in the context of modern conflict resolution.\n\n'
            'The evening closes with a communal feast and the lighting of memorial fires '
            'on the hilltops surrounding the Woreda — a tradition said to date back to '
            'the night of his death.'
        ),
        'location': 'Goro Highlands & Kebena Cultural Heritage Center',
        'start_date': datetime(2025, 9, 5, 6, 0),
        'end_date': datetime(2025, 9, 5, 21, 0),
        'image_url': 'https://images.unsplash.com/photo-1531123897727-8f129e1688ce?w=1200&q=80',
    },
]


def seed_events():
    with app.app_context():
        Event.query.delete()
        db.session.commit()

        for e in EVENTS:
            db.session.add(Event(**e))

        db.session.commit()
        print(f'✅ Seeded {len(EVENTS)} events (Batch 1: Cultural & Festival)')


if __name__ == '__main__':
    seed_events()
