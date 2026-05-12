import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../../core/theme/app_theme.dart';
import '../../../domain/entities/entities.dart';
import '../../../l10n/app_localizations.dart';

class HeroDetailScreen extends StatelessWidget {
  final HeroEntity hero;
  const HeroDetailScreen({super.key, required this.hero});

  static const _categoryColors = {
    'Warrior': Color(0xFF8B1A1A),
    'Scholar': Color(0xFF1A3A6B),
    'Leader': Color(0xFF1B4332),
    'Spiritual': Color(0xFF4A1A6B),
  };

  @override
  Widget build(BuildContext context) {
    final accent = _categoryColors[hero.category] ?? AppColors.primary;
    final tt = Theme.of(context).textTheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // ── Hero image header ───────────────────────────────
          SliverAppBar(
            expandedHeight: 320,
            pinned: true,
            foregroundColor: Colors.white,
            backgroundColor: accent,
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                fit: StackFit.expand,
                children: [
                  if (hero.imageUrl != null)
                    CachedNetworkImage(
                      imageUrl: hero.imageUrl!,
                      fit: BoxFit.cover,
                      errorWidget: (_, __, ___) => Container(color: accent),
                    )
                  else
                    Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [accent, accent.withValues(alpha: 0.6)],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ),
                      ),
                      child: const Center(
                        child: Icon(Icons.shield_rounded,
                            color: Colors.white38, size: 100),
                      ),
                    ),
                  // gradient overlay
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Colors.transparent,
                          accent.withValues(alpha: 0.95),
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        stops: const [0.4, 1.0],
                      ),
                    ),
                  ),
                  // name + title at bottom
                  Positioned(
                    bottom: 24,
                    left: 20,
                    right: 20,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(
                            color: Colors.black.withValues(alpha: 0.4),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            hero.category.toUpperCase(),
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                              fontWeight: FontWeight.w700,
                              letterSpacing: 1,
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          hero.name,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 28,
                            fontWeight: FontWeight.w800,
                            fontFamily: 'Playfair Display',
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '${hero.title}  ·  ${hero.era}',
                          style: TextStyle(
                            color: Colors.white.withValues(alpha: 0.75),
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          // ── Content ─────────────────────────────────────────
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // life dates
                  if (hero.birthYear != null || hero.deathYear != null)
                    _InfoRow(
                      icon: Icons.calendar_today_outlined,
                      text:
                          '${hero.birthYear ?? '?'} — ${hero.deathYear ?? 'Unknown'}',
                      accent: accent,
                    ),

                  const SizedBox(height: 20),

                  // bravery quote
                  if (hero.braveryQuote != null) ...[
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: accent.withValues(alpha: isDark ? 0.15 : 0.07),
                        borderRadius: BorderRadius.circular(14),
                        border:
                            Border.all(color: accent.withValues(alpha: 0.25)),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            '\u201C',
                            style: TextStyle(
                              color: AppColors.gold,
                              fontSize: 40,
                              height: 0.8,
                              fontFamily: 'Playfair Display',
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Text(
                              hero.braveryQuote!,
                              style: tt.bodyMedium?.copyWith(
                                fontStyle: FontStyle.italic,
                                height: 1.6,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),
                  ],

                  // full story
                  _SectionLabel(AppLocalizations.of(context)!.theStory, accent),
                  const SizedBox(height: 10),
                  Text(
                    hero.fullStory,
                    style: tt.bodyMedium?.copyWith(height: 1.75),
                  ),

                  const SizedBox(height: 28),

                  // legacy
                  _SectionLabel(AppLocalizations.of(context)!.legacySection, accent),
                  const SizedBox(height: 10),
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color:
                          AppColors.gold.withValues(alpha: isDark ? 0.1 : 0.06),
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(
                          color: AppColors.gold.withValues(alpha: 0.2)),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Icon(Icons.lightbulb_outline,
                            color: AppColors.gold, size: 20),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            hero.legacy,
                            style: tt.bodyMedium?.copyWith(height: 1.7),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SectionLabel extends StatelessWidget {
  final String text;
  final Color accent;
  const _SectionLabel(this.text, this.accent);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 3,
          height: 18,
          decoration: BoxDecoration(
            color: accent,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        const SizedBox(width: 10),
        Text(text, style: Theme.of(context).textTheme.titleMedium),
      ],
    );
  }
}

class _InfoRow extends StatelessWidget {
  final IconData icon;
  final String text;
  final Color accent;
  const _InfoRow(
      {required this.icon, required this.text, required this.accent});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, color: accent, size: 16),
        const SizedBox(width: 8),
        Text(text, style: Theme.of(context).textTheme.bodySmall),
      ],
    );
  }
}
