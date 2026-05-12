import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:go_router/go_router.dart';
import '../../../data/repositories/providers.dart';
import '../../../domain/entities/entities.dart';
import '../../../core/theme/app_theme.dart';
import '../../../l10n/app_localizations.dart';

class HeritageScreen extends ConsumerWidget {
  const HeritageScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = AppLocalizations.of(context)!;
    final state = ref.watch(heritageProvider);
    final primary = Theme.of(context).colorScheme.primary;

    return Scaffold(
      appBar: AppBar(title: Text(l.heritageTimeline)),
      body: RefreshIndicator(
        onRefresh: () async => ref.invalidate(heritageProvider),
        child: state.when(
          loading: () => Center(child: CircularProgressIndicator(color: primary)),
          error: (e, _) => _ErrorState(
            message: e.toString(),
            onRetry: () => ref.invalidate(heritageProvider),
          ),
          data: (result) {
            if (result.failure != null) {
              return _ErrorState(
                message: result.failure!.message,
                onRetry: () => ref.invalidate(heritageProvider),
              );
            }
            final articles = result.data ?? [];
            if (articles.isEmpty) return const _EmptyState();
            return ListView.builder(
              padding: EdgeInsets.fromLTRB(0, 16, 16, MediaQuery.viewPaddingOf(context).bottom + 80 + 24),
              itemCount: articles.length,
              itemBuilder: (context, i) => _TimelineItem(
                article: articles[i],
                isLast: i == articles.length - 1,
              ),
            );
          },
        ),
      ),
    );
  }
}

class _TimelineItem extends StatelessWidget {
  final HeritageEntity article;
  final bool isLast;
  const _TimelineItem({required this.article, required this.isLast});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final primary = Theme.of(context).colorScheme.primary;
    final lineColor = isDark ? AppColors.darkBorder : AppColors.lightBorder;

    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(
            width: 48,
            child: Column(
              children: [
                const SizedBox(height: 22),
                Container(
                  width: 12,
                  height: 12,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: primary,
                    border: Border.all(
                      color: isDark ? AppColors.darkBg : AppColors.lightBg,
                      width: 2.5,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: primary.withValues(alpha: 0.35),
                        blurRadius: 6,
                        spreadRadius: 1,
                      ),
                    ],
                  ),
                ),
                if (!isLast)
                  Expanded(
                    child: Center(
                      child: Container(width: 1.5, color: lineColor),
                    ),
                  ),
              ],
            ),
          ),
          Expanded(child: _ArticleCard(article: article)),
        ],
      ),
    );
  }
}

class _ArticleCard extends StatelessWidget {
  final HeritageEntity article;
  const _ArticleCard({required this.article});

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final tt = Theme.of(context).textTheme;
    final primary = Theme.of(context).colorScheme.primary;
    final cardColor = isDark ? AppColors.darkCard : AppColors.lightCard;
    final borderColor = isDark ? AppColors.darkBorder : AppColors.lightBorder;

    return GestureDetector(
      onTap: () => context.push('/heritage/detail', extra: article),
      child: Container(
        margin: const EdgeInsets.only(top: 10, bottom: 16),
        decoration: BoxDecoration(
          color: cardColor,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: borderColor),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (article.imageUrl != null)
              ClipRRect(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(13)),
                child: CachedNetworkImage(
                  imageUrl: article.imageUrl!,
                  height: 160,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  placeholder: (_, __) => Container(
                    height: 160,
                    color: primary.withValues(alpha: 0.06),
                    child: Icon(Icons.image_outlined,
                        color: primary.withValues(alpha: 0.2), size: 32),
                  ),
                  errorWidget: (_, __, ___) => const SizedBox.shrink(),
                ),
              ),
            Padding(
              padding: const EdgeInsets.all(14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 4),
                    decoration: BoxDecoration(
                      color: primary.withValues(alpha: 0.08),
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(color: primary.withValues(alpha: 0.2)),
                    ),
                    child: Text(
                      article.era.toUpperCase(),
                      style: TextStyle(
                        color: primary,
                        fontSize: 10,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 1.2,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(article.title,
                      style: tt.titleMedium?.copyWith(fontWeight: FontWeight.w700, height: 1.3)),
                  const SizedBox(height: 8),
                  Text(article.content,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: tt.bodyMedium?.copyWith(height: 1.55)),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Text(l.readMore,
                          style: TextStyle(color: primary, fontSize: 13, fontWeight: FontWeight.w600)),
                      const SizedBox(width: 4),
                      Icon(Icons.arrow_forward_rounded, color: primary, size: 14),
                    ],
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

class _EmptyState extends StatelessWidget {
  const _EmptyState();

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;
    final primary = Theme.of(context).colorScheme.primary;
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.account_balance_outlined, size: 56, color: primary.withValues(alpha: 0.25)),
          const SizedBox(height: 16),
          Text(l.noHeritageArticles, style: Theme.of(context).textTheme.bodyMedium),
        ],
      ),
    );
  }
}

class _ErrorState extends StatelessWidget {
  final String message;
  final VoidCallback onRetry;
  const _ErrorState({required this.message, required this.onRetry});

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(l.error(message),
                style: TextStyle(color: Theme.of(context).colorScheme.error)),
            const SizedBox(height: 16),
            ElevatedButton(onPressed: onRetry, child: Text(l.retry)),
          ],
        ),
      ),
    );
  }
}
