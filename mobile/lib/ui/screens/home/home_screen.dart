import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:intl/intl.dart';
import '../../../core/theme/app_theme.dart';
import '../../../data/repositories/providers.dart';
import '../../../domain/entities/entities.dart';
import '../../../l10n/app_localizations.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final unreadCount = ref.watch(
      notificationProvider.select((list) => list.where((n) => !n.isRead).length),
    );
    return Scaffold(
      floatingActionButton: Padding(
        padding: EdgeInsets.only(bottom: MediaQuery.viewPaddingOf(context).bottom + 80),
        child: FloatingActionButton.extended(
          onPressed: () => context.push('/chat'),
          backgroundColor: AppColors.primary,
          icon: const Icon(Icons.chat_bubble_rounded, color: Colors.white, size: 20),
          label: Text(AppLocalizations.of(context)!.askKebenaAI,
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600)),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: RefreshIndicator(
        onRefresh: () async {
          ref.invalidate(didYouKnowProvider);
          ref.invalidate(heroesProvider);
          ref.invalidate(newsProvider);
          ref.invalidate(wordOfTheDayProvider);
        },
        child: CustomScrollView(
        slivers: [
          // ── Hero Banner ───────────────────────────────────────
          SliverAppBar(
            expandedHeight: 300,
            pinned: true,
            stretch: true,
            automaticallyImplyLeading: false,
            backgroundColor: Colors.transparent,
            surfaceTintColor: Colors.transparent,
            scrolledUnderElevation: 0,
            flexibleSpace: _AppBarFlexible(
              onSettings: () => context.push('/settings'),
              onNotifications: () => context.push('/notifications'),
              unreadCount: unreadCount,
            ),
          ),

          // ── Did You Know ──────────────────────────────────────
          SliverToBoxAdapter(
            child: const _DidYouKnowSection()
                .animate()
                .fadeIn(delay: 100.ms, duration: 400.ms),
          ),

          // ── Kebena Heroes ─────────────────────────────────────
          SliverToBoxAdapter(
            child: const _HeroesPreviewSection()
                .animate()
                .fadeIn(delay: 200.ms, duration: 400.ms),
          ),

          // ── Latest News ───────────────────────────────────────
          SliverToBoxAdapter(
            child: const _LatestNewsSection()
                .animate()
                .fadeIn(delay: 300.ms, duration: 400.ms),
          ),

          // ── Quick Facts ───────────────────────────────────────
          SliverToBoxAdapter(
            child: const _QuickFactsBanner()
                .animate()
                .fadeIn(delay: 400.ms, duration: 400.ms),
          ),

          SliverToBoxAdapter(
            child: SizedBox(
              height: MediaQuery.viewPaddingOf(context).bottom + 80 + 24,
            ),
          ),
        ],
      ),
    ),
    );
  }
}

class _StatBadge extends StatelessWidget {
  final String value, label;
  const _StatBadge({required this.value, required this.label});

  @override
  Widget build(BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            value,
            style: const TextStyle(
              color: AppColors.gold,
              fontSize: 16,
              fontWeight: FontWeight.w800,
              letterSpacing: -0.3,
            ),
          ),
          Text(
            label,
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.5),
              fontSize: 10,
              letterSpacing: 0.3,
            ),
          ),
        ],
      );
}

// ── App bar flexible — elegant transparent → opaque transition ────────────────
class _AppBarFlexible extends StatelessWidget {
  final VoidCallback onSettings;
  final VoidCallback onNotifications;
  final int unreadCount;
  const _AppBarFlexible({
    required this.onSettings,
    required this.onNotifications,
    required this.unreadCount,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final collapsedBg = isDark ? AppColors.darkBg : AppColors.lightBg;
    final topPad = MediaQuery.of(context).padding.top;

    return LayoutBuilder(
      builder: (context, constraints) {
        const minH = kToolbarHeight + 0.0;
        const maxH = 300.0;
        final t =
            ((constraints.maxHeight - minH) / (maxH - minH)).clamp(0.0, 1.0);
        final isCollapsed =
            t < 0.2; // Trigger collapse UI earlier for smoothness

        // Background color lerp for the collapsed bar
        final bgColor = Color.lerp(collapsedBg, Colors.transparent, t)!;

        // Foreground color: always white when expanded (over image), theme color when collapsed
        final fgColor = isCollapsed
            ? (isDark ? Colors.white : AppColors.lightTextPrimary)
            : Colors.white;

        return Stack(
          fit: StackFit.expand,
          children: [
            // ── 1. The Expanded Hero Image (Fades out as we scroll up) ──
            if (t > 0.0)
              Opacity(
                opacity: t,
                child: const _HeroBanner(),
              ),

            // ── 2. Collapsed AppBar Surface ──
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              height: kToolbarHeight + topPad,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 150),
                decoration: BoxDecoration(
                  color: bgColor,
                  boxShadow: isCollapsed
                      ? [
                          BoxShadow(
                            color: Colors.black
                                .withValues(alpha: isDark ? 0.4 : 0.05),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ]
                      : [],
                ),
                child: SafeArea(
                  bottom: false,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // Left: Logo & Title
                        AnimatedOpacity(
                          opacity: isCollapsed ? 1.0 : 0.0,
                          duration: const Duration(milliseconds: 200),
                          child: Row(
                            children: [
                              Container(
                                width: 36,
                                height: 36,
                                decoration: BoxDecoration(
                                  color:
                                      AppColors.primary.withValues(alpha: 0.1),
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                      color: AppColors.primary
                                          .withValues(alpha: 0.2)),
                                ),
                                child: const Center(
                                  child: Text('🏛️',
                                      style: TextStyle(fontSize: 16)),
                                ),
                              ),
                              const SizedBox(width: 12),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Kebena Heritage',
                                    style: TextStyle(
                                      color: fgColor,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      letterSpacing: -0.3,
                                    ),
                                  ),
                                  Text(
                                    'Special Woreda Portal',
                                    style: TextStyle(
                                      color: fgColor.withValues(alpha: 0.6),
                                      fontSize: 11,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),

                        const Spacer(),

                        // Right: Professional Utility Actions
                        _AnimatedIconButton(
                          icon: Icons.search_rounded,
                          color: fgColor,
                          onTap: () {}, // Add Search Navigation
                        ),
                        const SizedBox(width: 4),

                        // Notification Bell with Badge
                        Stack(
                          alignment: Alignment.center,
                          children: [
                            _AnimatedIconButton(
                              icon: Icons.notifications_none_rounded,
                              color: fgColor,
                              onTap: onNotifications,
                            ),
                            if (unreadCount > 0)
                              Positioned(
                                top: 10,
                                right: 10,
                                child: Container(
                                  width: 8,
                                  height: 8,
                                  decoration: BoxDecoration(
                                    color: Colors.redAccent,
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                        color: bgColor, width: 1.5),
                                  ),
                                ),
                              )
                          ],
                        ),
                        const SizedBox(width: 4),

                        // Settings / Profile avatar
                        GestureDetector(
                          onTap: onSettings,
                          child: CircleAvatar(
                            radius: 16,
                            backgroundColor:
                                Colors.white.withValues(alpha: 0.2),
                            child: Icon(Icons.settings_outlined,
                                color: fgColor, size: 18),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

// Helper for sleek appbar buttons
class _AnimatedIconButton extends StatelessWidget {
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  const _AnimatedIconButton(
      {required this.icon, required this.color, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      customBorder: const CircleBorder(),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Icon(icon, color: color, size: 24),
      ),
    );
  }
}

// ── Hero Banner — Premium Image & Glassmorphism ──────────────────────────────
class _HeroBanner extends ConsumerWidget {
  const _HeroBanner();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final String todayDate = DateFormat('EEEE, d MMM').format(DateTime.now());
    final wordState = ref.watch(wordOfTheDayProvider);

    return Stack(
      fit: StackFit.expand,
      children: [
        // 1. Kebena Community — local asset
        Image.asset(
          'assets/images/woreda.jpeg',
          fit: BoxFit.cover,
          color: Colors.black.withValues(alpha: 0.4),
          colorBlendMode: BlendMode.srcOver,
          errorBuilder: (_, __, ___) => Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xFF071A0E),
                  Color(0xFF1B4332),
                  Color(0xFF2D6A4F)
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
        ),

        // 2. Rich Gradient Overlay (so text at the bottom is perfectly readable)
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.black
                    .withValues(alpha: 0.6), // Dark top for Appbar icons
                Colors.transparent,
                Colors.black.withValues(alpha: 0.8), // Dark bottom for cards
              ],
              stops: const [0.0, 0.4, 1.0],
            ),
          ),
        ),

        // 3. Content Area — pinned to bottom, no overflow
        Positioned(
          left: 0,
          right: 0,
          bottom: 0,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                // Top Info Pill (Location & Context)
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.black.withValues(alpha: 0.3),
                    borderRadius: BorderRadius.circular(20),
                    border:
                        Border.all(color: Colors.white.withValues(alpha: 0.2)),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.location_on,
                          color: AppColors.gold, size: 14),
                      const SizedBox(width: 4),
                      Text(
                        'Wolkite, Central Ethiopia • $todayDate',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
                // Welcome Title
                Text(
                  AppLocalizations.of(context)!.goodEvening,
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  AppLocalizations.of(context)!.exploreKebena,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 34,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Playfair Display',
                    letterSpacing: -0.5,
                    height: 1.1,
                  ),
                ),
                const SizedBox(height: 20),

                // Premium Glassmorphism Utility Card (Word of the day / Highlight)
                wordState.when(
                  loading: () => const SizedBox.shrink(),
                  error: (_, __) => const SizedBox.shrink(),
                  data: (result) {
                    final word = result.data;
                    if (word == null) return const SizedBox.shrink();
                    return GestureDetector(
                      onTap: () => context.push('/word-detail', extra: word),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                          child: Container(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: Colors.white.withValues(alpha: 0.1),
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(
                                  color: Colors.white.withValues(alpha: 0.2)),
                            ),
                            child: Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(12),
                                  decoration: BoxDecoration(
                                    color: AppColors.gold.withValues(alpha: 0.2),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: const Icon(Icons.volume_up_rounded,
                                      color: AppColors.gold, size: 24),
                                ),
                                const SizedBox(width: 16),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        AppLocalizations.of(context)!.wordOfTheDay,
                                        style: const TextStyle(
                                          color: AppColors.gold,
                                          fontSize: 10,
                                          fontWeight: FontWeight.bold,
                                          letterSpacing: 1.2,
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        word.kebenaWord,
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        '${word.englishTranslation} • ${word.amharicTranslation}',
                                        style: TextStyle(
                                          color: Colors.white
                                              .withValues(alpha: 0.7),
                                          fontSize: 13,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const Icon(Icons.arrow_forward_ios,
                                    color: Colors.white54, size: 16),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 8),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _ArcPainter extends CustomPainter {
  final Color color;
  const _ArcPainter({required this.color});
  @override
  void paint(Canvas canvas, Size size) {
    final path = Path()
      ..moveTo(0, size.height)
      ..quadraticBezierTo(size.width / 2, 0, size.width, size.height)
      ..close();
    canvas.drawPath(path, Paint()..color = color);
  }

  @override
  bool shouldRepaint(_ArcPainter old) => old.color != color;
}

// ── Section Header ────────────────────────────────────────────────────────────
class _SectionHeader extends StatelessWidget {
  final String title;
  final String? actionLabel;
  final VoidCallback? onAction;

  const _SectionHeader(this.title, {this.actionLabel, this.onAction});

  @override
  Widget build(BuildContext context) {
    final tt = Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 28, 16, 14),
      child: Row(
        children: [
          Container(
            width: 3,
            height: 18,
            decoration: BoxDecoration(
              color: AppColors.gold,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(child: Text(title, style: tt.titleMedium)),
          if (actionLabel != null)
            GestureDetector(
              onTap: onAction,
              child: Text(
                actionLabel!,
                style: const TextStyle(
                  color: AppColors.primary,
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
        ],
      ),
    );
  }
}

// ── Did You Know Section ──────────────────────────────────────────────────────
class _DidYouKnowSection extends ConsumerWidget {
  const _DidYouKnowSection();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(didYouKnowProvider);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _SectionHeader(AppLocalizations.of(context)!.didYouKnow),
        SizedBox(
          height: 168,
          child: state.when(
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (_, __) => const SizedBox(),
            data: (result) {
              final items = result.data ?? [];
              if (items.isEmpty) return const SizedBox();
              return ListView.separated(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: items.length,
                separatorBuilder: (_, __) => const SizedBox(width: 12),
                itemBuilder: (_, i) => _DidYouKnowCard(items[i]),
              );
            },
          ),
        ),
      ],
    );
  }
}

class _DidYouKnowCard extends StatelessWidget {
  final DidYouKnowEntity item;
  const _DidYouKnowCard(this.item);

  Color get _accent {
    try {
      return Color(
          int.parse('FF${item.accentColor.replaceAll('#', '')}', radix: 16));
    } catch (_) {
      return AppColors.primary;
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final tt = Theme.of(context).textTheme;
    final accent = _accent;

    return GestureDetector(
      onTap: () => context.push('/did-you-know/detail', extra: item),
      child: Container(
        width: 240,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: LinearGradient(
            colors: [
              accent.withValues(alpha: isDark ? 0.5 : 0.1),
              accent.withValues(alpha: isDark ? 0.2 : 0.03),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          border:
              Border.all(color: accent.withValues(alpha: isDark ? 0.3 : 0.18)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(children: [
              Text(item.emoji, style: const TextStyle(fontSize: 20)),
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: AppColors.gold.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(20),
                  border:
                      Border.all(color: AppColors.gold.withValues(alpha: 0.3)),
                ),
                child: Text(
                  item.label.toUpperCase(),
                  style: const TextStyle(
                    color: AppColors.gold,
                    fontSize: 9,
                    fontWeight: FontWeight.w700,
                    letterSpacing: .8,
                  ),
                ),
              ),
            ]),
            const SizedBox(height: 10),
            Text(
              '\u201C',
              style: TextStyle(
                color: AppColors.gold.withValues(alpha: 0.5),
                fontSize: 28,
                height: 0.5,
                fontFamily: 'Playfair Display',
              ),
            ),
            const SizedBox(height: 6),
            Expanded(
              child: Text(
                item.fact,
                style: tt.bodySmall?.copyWith(height: 1.55),
                maxLines: 4,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const SizedBox(height: 8),
            Row(children: [
              Text(
                AppLocalizations.of(context)!.readMore,
                style: TextStyle(
                  color: accent,
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(width: 3),
              Icon(Icons.arrow_forward, color: accent, size: 11),
            ]),
          ],
        ),
      ),
    );
  }
}

// ── Heroes Preview Section ────────────────────────────────────────────────────
class _HeroesPreviewSection extends ConsumerWidget {
  const _HeroesPreviewSection();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(heroesProvider);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _SectionHeader(
          AppLocalizations.of(context)!.kebenaHeroes,
          actionLabel: AppLocalizations.of(context)!.seeAll,
          onAction: () => context.go('/heroes'),
        ),
        SizedBox(
          height: 200,
          child: state.when(
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (_, __) => const SizedBox(),
            data: (heroes) {
              final temps = heroes.data ?? [];
              if (temps.isEmpty) return const SizedBox();
              return ListView.separated(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: temps.length,
                separatorBuilder: (_, __) => const SizedBox(width: 12),
                itemBuilder: (_, i) => _HeroCard(temps[i]),
              );
            },
          ),
        ),
      ],
    );
  }
}

class _HeroCard extends StatelessWidget {
  final HeroEntity hero;
  const _HeroCard(this.hero);

  // Integrated with app palette — no loud colors
  Color _accent(bool isDark) {
    return switch (hero.category) {
      'Warrior' => isDark ? const Color(0xFF5C2A2A) : const Color(0xFF7B3A3A),
      'Scholar' => isDark ? const Color(0xFF1A2E4A) : const Color(0xFF1B4332),
      'Leader' => isDark ? const Color(0xFF1A3A2A) : const Color(0xFF1B4332),
      'Spiritual' => isDark ? const Color(0xFF2E1A3A) : const Color(0xFF3A2060),
      _ => AppColors.primary,
    };
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final accent = _accent(isDark);
    final cardBg = isDark ? AppColors.darkCard : AppColors.lightCard;
    final border = isDark ? AppColors.darkBorder : AppColors.lightBorder;
    final tt = Theme.of(context).textTheme;

    return GestureDetector(
      onTap: () => context.push('/heroes/detail', extra: hero),
      child: Container(
        width: 150,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: cardBg,
          border: Border.all(color: border),
        ),
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // top accent strip
            Container(
              height: 4,
              color: accent,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // category badge
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 7, vertical: 3),
                      decoration: BoxDecoration(
                        color: accent.withValues(alpha: 0.12),
                        borderRadius: BorderRadius.circular(20),
                        border:
                            Border.all(color: accent.withValues(alpha: 0.25)),
                      ),
                      child: Text(
                        hero.category.toUpperCase(),
                        style: TextStyle(
                          color: accent,
                          fontSize: 8,
                          fontWeight: FontWeight.w700,
                          letterSpacing: .8,
                        ),
                      ),
                    ),
                    const Spacer(),
                    Text(
                      hero.name,
                      style: tt.titleSmall?.copyWith(
                        fontWeight: FontWeight.w700,
                        height: 1.2,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 3),
                    Text(
                      hero.era,
                      style: tt.bodySmall,
                    ),
                    const SizedBox(height: 6),
                    Row(children: [
                      Text(
                        AppLocalizations.of(context)!.read,
                        style: TextStyle(
                          color: accent,
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(width: 3),
                      Icon(Icons.arrow_forward_rounded,
                          color: accent, size: 11),
                    ]),
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

// ── Latest News Section ───────────────────────────────────────────────────────
class _LatestNewsSection extends ConsumerWidget {
  const _LatestNewsSection();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(newsProvider);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _SectionHeader(
          AppLocalizations.of(context)!.latestNews,
          actionLabel: AppLocalizations.of(context)!.seeAll,
          onAction: () => context.go('/news'),
        ),
        state.when(
          loading: () => const Padding(
            padding: EdgeInsets.all(16),
            child: Center(child: CircularProgressIndicator()),
          ),
          error: (_, __) => const SizedBox(),
          data: (result) {
            if (result.failure != null || result.data == null) {
              return const SizedBox();
            }
            final items = result.data!.items.take(2).toList();
            return Column(
              children: items.map((n) => _NewsPreviewTile(n)).toList(),
            );
          },
        ),
      ],
    );
  }
}

class _NewsPreviewTile extends StatelessWidget {
  final NewsEntity article;
  const _NewsPreviewTile(this.article);

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final tt = Theme.of(context).textTheme;
    final border = isDark ? AppColors.darkBorder : AppColors.lightBorder;

    return GestureDetector(
      onTap: () => context.push('/news/detail', extra: article),
      child: Container(
        margin: const EdgeInsets.fromLTRB(16, 0, 16, 10),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: isDark ? AppColors.darkCard : AppColors.lightCard,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: border),
        ),
        child: Row(
          children: [
            if (article.imageUrl != null)
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: CachedNetworkImage(
                  imageUrl: article.imageUrl!,
                  width: 72,
                  height: 72,
                  fit: BoxFit.cover,
                  errorWidget: (_, __, ___) => Container(
                    width: 72,
                    height: 72,
                    color: AppColors.primary.withValues(alpha: 0.2),
                    child: const Icon(Icons.newspaper_outlined,
                        color: AppColors.primary),
                  ),
                ),
              )
            else
              Container(
                width: 72,
                height: 72,
                decoration: BoxDecoration(
                  color: AppColors.primary.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(Icons.newspaper_outlined,
                    color: AppColors.primary, size: 28),
              ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(children: [
                    _CategoryPill(article.category),
                    const Spacer(),
                    Text(
                      DateFormat('MMM d').format(article.timestamp),
                      style: tt.bodySmall,
                    ),
                  ]),
                  const SizedBox(height: 6),
                  Text(
                    article.title,
                    style: tt.titleSmall,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CategoryPill extends StatelessWidget {
  final String category;
  const _CategoryPill(this.category);

  @override
  Widget build(BuildContext context) {
    final color = AppColors.categoryColor(category);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        category.toUpperCase(),
        style: TextStyle(
          color: color,
          fontSize: 9,
          fontWeight: FontWeight.w700,
          letterSpacing: .6,
        ),
      ),
    );
  }
}

// ── Quick Facts Banner ────────────────────────────────────────────────────────
class _QuickFactsBanner extends StatelessWidget {
  const _QuickFactsBanner();

  // (emoji, label, value)
  static const _facts = [
    ('🏛️', 'Founded', '13th Century'),
    ('🗣️', 'Language', 'Affoo'),
    ('📍', 'Location', 'Kebena Woreda'),
    ('🏛️', 'Est. Woreda', '2023'),
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final tt = Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isDark ? AppColors.darkCard : AppColors.lightCard,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isDark ? AppColors.darkBorder : AppColors.lightBorder,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(AppLocalizations.of(context)!.quickFacts, style: tt.titleSmall),
              ],
            ),
            const SizedBox(height: 14),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: _facts
                  .map((f) => Flexible(
                        child: _FactItem(
                          emoji: f.$1,
                          label: f.$2,
                          value: f.$3,
                        ),
                      ))
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }
}

class _FactItem extends StatelessWidget {
  final String emoji, label, value;
  const _FactItem({
    required this.emoji,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    final tt = Theme.of(context).textTheme;
    return Column(
      children: [
        Text(emoji, style: const TextStyle(fontSize: 22)),
        const SizedBox(height: 4),
        Text(
          value,
          style: tt.labelLarge?.copyWith(color: AppColors.gold),
          textAlign: TextAlign.center,
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
        ),
        Text(
          label,
          style: tt.bodySmall,
          textAlign: TextAlign.center,
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
        ),
      ],
    );
  }
}
