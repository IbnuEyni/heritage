import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:go_router/go_router.dart';
import '../../../domain/entities/entities.dart';
import '../../../core/theme/app_theme.dart';

class HeritageDetailScreen extends StatelessWidget {
  final HeritageEntity article;
  const HeritageDetailScreen({super.key, required this.article});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final primary = Theme.of(context).colorScheme.primary;
    final tt = Theme.of(context).textTheme;

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: article.imageUrl != null ? 280 : 120,
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
                              color: primary.withValues(alpha: 0.08)),
                          errorWidget: (_, __, ___) => Container(
                            color: primary.withValues(alpha: 0.08),
                            child: Icon(Icons.account_balance_outlined,
                                color: primary.withValues(alpha: 0.3),
                                size: 48),
                          ),
                        ),
                        DecoratedBox(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                Colors.black.withValues(alpha: 0.45),
                                Colors.transparent,
                                Colors.black.withValues(alpha: 0.6),
                              ],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              stops: const [0, 0.4, 1],
                            ),
                          ),
                        ),
                      ],
                    )
                  : Container(
                      color: primary.withValues(alpha: 0.08),
                      child: Center(
                        child: Icon(Icons.account_balance_outlined,
                            color: primary.withValues(alpha: 0.3), size: 56),
                      ),
                    ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 24, 20, 48),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                      color: primary.withValues(alpha: 0.08),
                      borderRadius: BorderRadius.circular(6),
                      border:
                          Border.all(color: primary.withValues(alpha: 0.2)),
                    ),
                    child: Text(
                      article.era.toUpperCase(),
                      style: TextStyle(
                        color: primary,
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 1.2,
                      ),
                    ),
                  ),
                  const SizedBox(height: 14),
                  Text(article.title,
                      style: tt.displaySmall?.copyWith(height: 1.25)),
                  const SizedBox(height: 20),
                  Divider(
                    color:
                        isDark ? AppColors.darkBorder : AppColors.lightBorder,
                    height: 1,
                  ),
                  const SizedBox(height: 20),
                  Text(article.content,
                      style: tt.bodyLarge?.copyWith(height: 1.8)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
