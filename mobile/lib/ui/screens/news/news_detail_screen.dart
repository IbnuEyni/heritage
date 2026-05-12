import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import '../../../domain/entities/entities.dart';
import '../../../core/theme/app_theme.dart';

class NewsDetailScreen extends StatelessWidget {
  final NewsEntity article;
  const NewsDetailScreen({super.key, required this.article});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final tt = Theme.of(context).textTheme;
    final catColor = AppColors.categoryColor(article.category);

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // ── Hero app bar ────────────────────────────────────
          SliverAppBar(
            expandedHeight: article.imageUrl != null ? 300 : 100,
            pinned: true,
            stretch: true,
            leading: Padding(
              padding: const EdgeInsets.all(8),
              child: CircleAvatar(
                backgroundColor:
                    (isDark ? Colors.black : Colors.white).withValues(alpha: 0.7),
                child: IconButton(
                  icon: Icon(Icons.arrow_back_rounded,
                      color: isDark ? Colors.white : Colors.black, size: 20),
                  onPressed: () => context.pop(),
                ),
              ),
            ),
            flexibleSpace: FlexibleSpaceBar(
              stretchModes: const [StretchMode.zoomBackground],
              background: article.imageUrl != null
                  ? Stack(
                      fit: StackFit.expand,
                      children: [
                        CachedNetworkImage(
                          imageUrl: article.imageUrl!,
                          fit: BoxFit.cover,
                          placeholder: (_, __) => Container(
                              color: catColor.withValues(alpha: 0.08)),
                          errorWidget: (_, __, ___) => Container(
                            color: catColor.withValues(alpha: 0.08),
                            child: Icon(Icons.newspaper_outlined,
                                color: catColor.withValues(alpha: 0.3),
                                size: 48),
                          ),
                        ),
                        DecoratedBox(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                Colors.black.withValues(alpha: 0.4),
                                Colors.transparent,
                                Colors.black.withValues(alpha: 0.65),
                              ],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              stops: const [0, 0.4, 1],
                            ),
                          ),
                        ),
                      ],
                    )
                  : Container(color: catColor.withValues(alpha: 0.08)),
            ),
          ),

          // ── Content ─────────────────────────────────────────
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 24, 20, 48),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // category + date row
                  Row(
                    children: [
                      _CategoryChip(
                          label: article.category, color: catColor),
                      const Spacer(),
                      Icon(Icons.access_time_rounded,
                          size: 13,
                          color: isDark
                              ? AppColors.darkTextMuted
                              : AppColors.lightTextMuted),
                      const SizedBox(width: 4),
                      Text(
                        DateFormat('MMM d, y').format(article.timestamp),
                        style: tt.bodySmall,
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // title
                  Text(
                    article.title,
                    style: tt.displaySmall?.copyWith(height: 1.25),
                  ),
                  const SizedBox(height: 20),

                  Divider(
                    color: isDark ? AppColors.darkBorder : AppColors.lightBorder,
                    height: 1,
                  ),
                  const SizedBox(height: 20),

                  // full content
                  Text(
                    article.content,
                    style: tt.bodyLarge?.copyWith(height: 1.8),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _CategoryChip extends StatelessWidget {
  final String label;
  final Color color;
  const _CategoryChip({required this.label, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Text(
        label.toUpperCase(),
        style: TextStyle(
          color: color,
          fontSize: 10,
          fontWeight: FontWeight.w700,
          letterSpacing: .8,
        ),
      ),
    );
  }
}
