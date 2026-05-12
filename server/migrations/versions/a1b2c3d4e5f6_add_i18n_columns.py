"""add amharic and oromo translation columns to all content tables

Revision ID: a1b2c3d4e5f6
Revises: c8e2dca51e1c
Create Date: 2026-05-12 00:00:00.000000
"""
from alembic import op
import sqlalchemy as sa

revision = 'a1b2c3d4e5f6'
down_revision = 'c8e2dca51e1c'
branch_labels = None
depends_on = None


def upgrade():
    # ── Heritage ──────────────────────────────────────────────────────────────
    with op.batch_alter_table('heritage_table') as batch_op:
        batch_op.add_column(sa.Column('title_am',   sa.String(200)))
        batch_op.add_column(sa.Column('title_om',   sa.String(200)))
        batch_op.add_column(sa.Column('content_am', sa.Text()))
        batch_op.add_column(sa.Column('content_om', sa.Text()))
        batch_op.add_column(sa.Column('era_am',     sa.String(100)))
        batch_op.add_column(sa.Column('era_om',     sa.String(100)))

    # ── Dictionary ────────────────────────────────────────────────────────────
    with op.batch_alter_table('dictionary_table') as batch_op:
        batch_op.add_column(sa.Column('oromo_translation', sa.String(200)))
        batch_op.add_column(sa.Column('examples_am',       sa.JSON()))
        batch_op.add_column(sa.Column('examples_om',       sa.JSON()))

    # ── News ──────────────────────────────────────────────────────────────────
    with op.batch_alter_table('news_table') as batch_op:
        batch_op.add_column(sa.Column('title_am',   sa.String(200)))
        batch_op.add_column(sa.Column('title_om',   sa.String(200)))
        batch_op.add_column(sa.Column('content_am', sa.Text()))
        batch_op.add_column(sa.Column('content_om', sa.Text()))

    # ── Events ────────────────────────────────────────────────────────────────
    with op.batch_alter_table('events_table') as batch_op:
        batch_op.add_column(sa.Column('title_am',       sa.String(200)))
        batch_op.add_column(sa.Column('title_om',       sa.String(200)))
        batch_op.add_column(sa.Column('description_am', sa.Text()))
        batch_op.add_column(sa.Column('description_om', sa.Text()))
        batch_op.add_column(sa.Column('location_am',    sa.String(200)))
        batch_op.add_column(sa.Column('location_om',    sa.String(200)))

    # ── Heroes ────────────────────────────────────────────────────────────────
    with op.batch_alter_table('heroes_table') as batch_op:
        batch_op.add_column(sa.Column('name_am',          sa.String(200)))
        batch_op.add_column(sa.Column('name_om',          sa.String(200)))
        batch_op.add_column(sa.Column('title_am',         sa.String(200)))
        batch_op.add_column(sa.Column('title_om',         sa.String(200)))
        batch_op.add_column(sa.Column('era_am',           sa.String(100)))
        batch_op.add_column(sa.Column('era_om',           sa.String(100)))
        batch_op.add_column(sa.Column('short_bio_am',     sa.String(500)))
        batch_op.add_column(sa.Column('short_bio_om',     sa.String(500)))
        batch_op.add_column(sa.Column('full_story_am',    sa.Text()))
        batch_op.add_column(sa.Column('full_story_om',    sa.Text()))
        batch_op.add_column(sa.Column('legacy_am',        sa.Text()))
        batch_op.add_column(sa.Column('legacy_om',        sa.Text()))
        batch_op.add_column(sa.Column('bravery_quote_am', sa.String(500)))
        batch_op.add_column(sa.Column('bravery_quote_om', sa.String(500)))

    # ── DidYouKnow ────────────────────────────────────────────────────────────
    with op.batch_alter_table('did_you_know_table') as batch_op:
        batch_op.add_column(sa.Column('label_am',  sa.String(100)))
        batch_op.add_column(sa.Column('label_om',  sa.String(100)))
        batch_op.add_column(sa.Column('fact_am',   sa.String(600)))
        batch_op.add_column(sa.Column('fact_om',   sa.String(600)))
        batch_op.add_column(sa.Column('detail_am', sa.Text()))
        batch_op.add_column(sa.Column('detail_om', sa.Text()))
        batch_op.add_column(sa.Column('source_am', sa.String(300)))
        batch_op.add_column(sa.Column('source_om', sa.String(300)))


def downgrade():
    with op.batch_alter_table('heritage_table') as batch_op:
        for col in ['title_am', 'title_om', 'content_am', 'content_om', 'era_am', 'era_om']:
            batch_op.drop_column(col)

    with op.batch_alter_table('dictionary_table') as batch_op:
        for col in ['oromo_translation', 'examples_am', 'examples_om']:
            batch_op.drop_column(col)

    with op.batch_alter_table('news_table') as batch_op:
        for col in ['title_am', 'title_om', 'content_am', 'content_om']:
            batch_op.drop_column(col)

    with op.batch_alter_table('events_table') as batch_op:
        for col in ['title_am', 'title_om', 'description_am', 'description_om', 'location_am', 'location_om']:
            batch_op.drop_column(col)

    with op.batch_alter_table('heroes_table') as batch_op:
        for col in ['name_am', 'name_om', 'title_am', 'title_om', 'era_am', 'era_om',
                    'short_bio_am', 'short_bio_om', 'full_story_am', 'full_story_om',
                    'legacy_am', 'legacy_om', 'bravery_quote_am', 'bravery_quote_om']:
            batch_op.drop_column(col)

    with op.batch_alter_table('did_you_know_table') as batch_op:
        for col in ['label_am', 'label_om', 'fact_am', 'fact_om',
                    'detail_am', 'detail_om', 'source_am', 'source_om']:
            batch_op.drop_column(col)
