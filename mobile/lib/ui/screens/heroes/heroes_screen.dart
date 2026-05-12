import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../../core/theme/app_theme.dart';
import '../../../data/repositories/providers.dart';
import '../../../domain/entities/entities.dart';
import '../../../l10n/app_localizations.dart';
import '../../widgets/shimmer_widgets.dart';

final _heroFilterProvider = StateProvider<String>((ref) => 'All');

class HeroesScreen extends ConsumerWidget {
  const HeroesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = AppLocalizations.of(context)!;
    final state = ref.watch(heroesProvider);
    final filter = ref.watch(_heroFilterProvider);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    // Map localized labels to category keys
    final categoryLabels = {
      'All': l.filterAll,
      'Warrior': l.filterWarrior,
      'Scholar': l.filterScholar,
      'Leader': l.filterLeader,
      'Spiritual': l.filterSpiritual,
    };

    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (_, __) => [
          SliverAppBar(
            expandedHeight: 220,
            pinned: true,
            stretch: true,
            automaticallyImplyLeading: false,
            backgroundColor: isDark ? AppColors.darkBg : AppColors.primary,
            surfaceTintColor: Colors.transparent,
            scrolledUnderElevation: 0,
            flexibleSpace: FlexibleSpaceBar(
              stretchModes: const [StretchMode.zoomBackground],
              background: _HeroesAppBarBackground(isDark: isDark, l: l),
            ),
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(52),
              child: _CategoryTabs(
                selected: filter,
                onSelect: (c) => ref.read(_heroFilterProvider.notifier).state = c,
                isDark: isDark,
                categoryLabels: categoryLabels,
              ),
            ),
          ),
        ],
        body: state.when(
          loading: () => const DictionaryShimmer(),
          error: (e, _) => ErrorStateWidget(
            message: e.toString(),
            onRetry: () => ref.invalidate(heroesProvider),
          ),
          data: (result) {
            final heroes = result.data ?? [];
            final filtered = filter == 'All'
                ? heroes
                : heroes.where((h) => h.category == filter).toList();
            if (filtered.isEmpty) {
              return Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.shield_outlined,
                        size: 52,
                        color: AppColors.primary.withValues(alpha: 0.25)),
                    const SizedBox(height: 16),
                    Text(l.noHeroesFound,
                        style: Theme.of(context).textTheme.titleMedium),
                  ],
                ),
              );
            }
            return RefreshIndicator(
              onRefresh: () async => ref.invalidate(heroesProvider),
              child: GridView.builder(
                physics: const AlwaysScrollableScrollPhysics(),
                padding: EdgeInsets.fromLTRB(16, 16, 16,
                    MediaQuery.viewPaddingOf(context).bottom + 80 + 24),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  childAspectRatio: 0.72,
                ),
                itemCount: filtered.length,
                itemBuilder: (_, i) => _HeroGridCard(filtered[i]),
              ),
            );
          },
        ),
      ),
    );
  }
}

// ── AppBar Background ─────────────────────────────────────────────────────────
class _HeroesAppBarBackground extends StatelessWidget {
  final bool isDark;
  final AppLocalizations l;
  const _HeroesAppBarBackground({required this.isDark, required this.l});

  @override
  Widget build(BuildContext context) {
    final topPad = MediaQuery.of(context).padding.top;
    return Stack(
      fit: StackFit.expand,
      children: [
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: isDark
                  ? const [Color(0xFF060F09), Color(0xFF0D2118), Color(0xFF1B4332)]
                  : const [Color(0xFF0D2118), Color(0xFF1B4332), Color(0xFF2D6A4F)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        Positioned(
          top: -40, right: -40,
          child: Container(
            width: 200, height: 200,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: AppColors.gold.withValues(alpha: 0.10), width: 1.5),
            ),
          ),
        ),
        Positioned(
          top: 30, right: 30,
          child: Container(
            width: 80, height: 80,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.gold.withValues(alpha: 0.06),
            ),
          ),
        ),
        Positioned(
          bottom: 0, left: 0, right: 0, height: 60,
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.transparent, Colors.black.withValues(alpha: 0.35)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
        ),
        Positioned(
          left: 20, right: 20, bottom: 20, top: topPad + 8,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                  color: AppColors.gold.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: AppColors.gold.withValues(alpha: 0.35)),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 5, height: 5,
                      decoration: const BoxDecoration(shape: BoxShape.circle, color: AppColors.gold),
                    ),
                    const SizedBox(width: 6),
                    Text(
                      l.hallOfLegends,
                      style: const TextStyle(
                        color: AppColors.gold, fontSize: 10,
                        fontWeight: FontWeight.w700, letterSpacing: 1.2,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              Text(
                l.kebenaHeroes,
                style: const TextStyle(
                  color: Colors.white, fontSize: 30,
                  fontWeight: FontWeight.w800,
                  fontFamily: 'Playfair Display',
                  letterSpacing: -0.5, height: 1.1,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                l.heroesSubtitle,
                style: TextStyle(color: Colors.white.withValues(alpha: 0.60), fontSize: 12, height: 1.5),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ],
    );
  }
}

// ── Category Tabs ─────────────────────────────────────────────────────────────
class _CategoryTabs extends StatelessWidget {
  final String selected;
  final ValueChanged<String> onSelect;
  final bool isDark;
  final Map<String, String> categoryLabels;

  static const _categoryKeys = ['All', 'Warrior', 'Scholar', 'Leader', 'Spiritual'];

  const _CategoryTabs({
    required this.selected,
    required this.onSelect,
    required this.isDark,
    required this.categoryLabels,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 52,
      decoration: BoxDecoration(
        color: isDark ? AppColors.darkBg : AppColors.primary,
        border: Border(bottom: BorderSide(color: Colors.white.withValues(alpha: 0.08), width: 1)),
      ),
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        itemCount: _categoryKeys.length,
        separatorBuilder: (_, __) => const SizedBox(width: 8),
        itemBuilder: (_, i) {
          final key = _categoryKeys[i];
          final label = categoryLabels[key] ?? key;
          final isSelected = key == selected;
          return GestureDetector(
            onTap: () => onSelect(key),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              curve: Curves.easeInOut,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              decoration: BoxDecoration(
                color: isSelected ? AppColors.gold : Colors.white.withValues(alpha: 0.10),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: isSelected ? AppColors.gold : Colors.white.withValues(alpha: 0.15),
                  width: 1,
                ),
              ),
              child: Text(
                label,
                style: TextStyle(
                  color: isSelected ? const Color(0xFF0D2118) : Colors.white70,
                  fontSize: 12,
                  fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                  letterSpacing: 0.2,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

// ── Hero Grid Card ────────────────────────────────────────────────────────────
class _HeroGridCard extends StatelessWidget {
  final HeroEntity hero;
  const _HeroGridCard(this.hero);

  static const _categoryAccents = {
    'Warrior': Color(0xFFB85C5C),
    'Scholar': Color(0xFF4A7FA5),
    'Leader': Color(0xFF2D6A4F),
    'Spiritual': Color(0xFF7B5EA7),
  };

  static const _categoryIcons = {
    'Warrior': '⚔️',
    'Scholar': '📜',
    'Leader': '👑',
    'Spiritual': '🕊️',
  };

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final tt = Theme.of(context).textTheme;
    final accent = _categoryAccents[hero.category] ?? AppColors.primary;
    final cardBg = isDark ? AppColors.darkCard : AppColors.lightCard;
    final border = isDark ? AppColors.darkBorder : AppColors.lightBorder;
    final textPrimary = isDark ? AppColors.darkTextPrimary : AppColors.lightTextPrimary;
    final textMuted = isDark ? AppColors.darkTextMuted : AppColors.lightTextMuted;
    final icon = _categoryIcons[hero.category] ?? '🏛️';

    return GestureDetector(
      onTap: () => context.push('/heroes/detail', extra: hero),
      child: Container(
        decoration: BoxDecoration(
          color: cardBg,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: border),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: isDark ? 0.30 : 0.06),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 5,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  if (hero.imageUrl != null)
                    CachedNetworkImage(
                      imageUrl: hero.imageUrl!,
                      fit: BoxFit.cover,
                      errorWidget: (_, __, ___) =>
                          _PlaceholderBg(accent: accent, icon: icon, isDark: isDark),
                    )
                  else
                    _PlaceholderBg(accent: accent, icon: icon, isDark: isDark),
                  if (hero.imageUrl != null)
                    Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Colors.transparent, Colors.black.withValues(alpha: 0.55)],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          stops: const [0.4, 1.0],
                        ),
                      ),
                    ),
                  Positioned(
                    top: 10, left: 10,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: accent.withValues(alpha: 0.90),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        hero.category.toUpperCase(),
                        style: const TextStyle(
                          color: Colors.white, fontSize: 8,
                          fontWeight: FontWeight.w700, letterSpacing: 0.8,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 4,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(12, 10, 12, 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(hero.title,
                        style: TextStyle(color: textMuted, fontSize: 10, fontWeight: FontWeight.w500),
                        maxLines: 1, overflow: TextOverflow.ellipsis),
                    const SizedBox(height: 3),
                    Text(hero.name,
                        style: tt.titleSmall?.copyWith(
                            color: textPrimary, fontWeight: FontWeight.w700, height: 1.2, fontSize: 13),
                        maxLines: 2, overflow: TextOverflow.ellipsis),
                    const Spacer(),
                    Row(
                      children: [
                        Container(
                          width: 3, height: 3,
                          decoration: const BoxDecoration(shape: BoxShape.circle, color: AppColors.gold),
                        ),
                        const SizedBox(width: 5),
                        Expanded(
                          child: Text(hero.era,
                              style: const TextStyle(color: AppColors.gold, fontSize: 10, fontWeight: FontWeight.w600),
                              maxLines: 1, overflow: TextOverflow.ellipsis),
                        ),
                        Icon(Icons.arrow_forward_rounded, size: 12, color: accent.withValues(alpha: 0.7)),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _PlaceholderBg extends StatelessWidget {
  final Color accent;
  final String icon;
  final bool isDark;
  const _PlaceholderBg({required this.accent, required this.icon, required this.isDark});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            accent.withValues(alpha: isDark ? 0.35 : 0.18),
            accent.withValues(alpha: isDark ? 0.15 : 0.07),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Center(child: Text(icon, style: const TextStyle(fontSize: 36))),
    );
  }
}
