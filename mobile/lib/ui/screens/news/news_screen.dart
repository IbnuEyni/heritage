import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import '../../../data/repositories/providers.dart';
import '../../../domain/entities/entities.dart';
import '../../../core/theme/app_theme.dart';
import '../../../l10n/app_localizations.dart';

class NewsScreen extends ConsumerWidget {
  const NewsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = AppLocalizations.of(context)!;
    final state = ref.watch(newsProvider);
    final page  = ref.watch(newsPageProvider);
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final primary = Theme.of(context).colorScheme.primary;

    return Scaffold(
      appBar: AppBar(title: Text(l.woredaNews)),
      body: RefreshIndicator(
        onRefresh: () async => ref.invalidate(newsProvider),
        child: state.when(
          loading: () => Center(child: CircularProgressIndicator(color: primary)),
          error: (e, _) => Center(
            child: Text('Error: $e',
                style: TextStyle(color: Theme.of(context).colorScheme.error)),
          ),
          data: (result) {
            if (result.failure != null) {
              return Center(child: Text('Error: ${result.failure!.message}'));
            }
            final items = result.data?.items ?? [];
            if (items.isEmpty) {
              return Center(
                child: Column(mainAxisSize: MainAxisSize.min, children: [
                  Icon(Icons.newspaper_outlined,
                      size: 52, color: primary.withValues(alpha: 0.25)),
                  const SizedBox(height: 16),
                  Text(l.noNewsYet,
                      style: Theme.of(context).textTheme.bodyMedium),
                ]),
              );
            }
            return Column(
              children: [
                Expanded(
                  child: ListView.separated(
                    padding: EdgeInsets.fromLTRB(0, 12, 0, MediaQuery.viewPaddingOf(context).bottom + 80 + 24),
                    itemCount: items.length,
                    separatorBuilder: (_, __) => Divider(
                      height: 1,
                      color: isDark ? AppColors.darkDivider : AppColors.lightDivider,
                      indent: 16,
                      endIndent: 16,
                    ),
                    itemBuilder: (_, i) => i == 0
                        ? _FeaturedCard(items[i])
                        : _NewsListTile(items[i]),
                  ),
                ),
                _PaginationBar(
                  page: page,
                  hasNext: result.data?.hasNextPage ?? false,
                  ref: ref,
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

// ── Featured card ──────────────────────────────────────────────────────────
class _FeaturedCard extends StatelessWidget {
  final NewsEntity article;
  const _FeaturedCard(this.article);

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final tt = Theme.of(context).textTheme;
    final catColor = AppColors.categoryColor(article.category);

    return GestureDetector(
      onTap: () => context.push('/news/detail', extra: article),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 4, 16, 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (article.imageUrl != null)
              ClipRRect(
                borderRadius: BorderRadius.circular(14),
                child: CachedNetworkImage(
                  imageUrl: article.imageUrl!,
                  height: 200,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  placeholder: (_, __) => Container(
                    height: 200,
                    color: catColor.withValues(alpha: 0.08),
                  ),
                  errorWidget: (_, __, ___) => const SizedBox.shrink(),
                ),
              ),
            const SizedBox(height: 12),
            Row(children: [
              _Chip(label: article.category, color: catColor),
              const Spacer(),
              Text(DateFormat('MMM d, y').format(article.timestamp),
                  style: tt.bodySmall),
            ]),
            const SizedBox(height: 8),
            Text(article.title,
                style: tt.displaySmall?.copyWith(fontSize: 20, height: 1.3)),
            const SizedBox(height: 6),
            Text(article.content,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                style: tt.bodyMedium),
            const SizedBox(height: 12),
            Divider(
              height: 1,
              color: isDark ? AppColors.darkDivider : AppColors.lightDivider,
            ),
          ],
        ),
      ),
    );
  }
}

// ── Compact list tile ──────────────────────────────────────────────────────
class _NewsListTile extends StatelessWidget {
  final NewsEntity article;
  const _NewsListTile(this.article);

  @override
  Widget build(BuildContext context) {
    final tt = Theme.of(context).textTheme;
    final catColor = AppColors.categoryColor(article.category);

    return GestureDetector(
      onTap: () => context.push('/news/detail', extra: article),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _Chip(label: article.category, color: catColor),
                  const SizedBox(height: 6),
                  Text(article.title,
                      style: tt.titleMedium?.copyWith(height: 1.35),
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis),
                  const SizedBox(height: 6),
                  Text(DateFormat('MMM d, y').format(article.timestamp),
                      style: tt.bodySmall),
                ],
              ),
            ),
            if (article.imageUrl != null) ...[
              const SizedBox(width: 14),
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: CachedNetworkImage(
                  imageUrl: article.imageUrl!,
                  width: 80,
                  height: 80,
                  fit: BoxFit.cover,
                  placeholder: (_, __) => Container(
                    width: 80,
                    height: 80,
                    color: catColor.withValues(alpha: 0.08),
                  ),
                  errorWidget: (_, __, ___) => const SizedBox.shrink(),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

// ── Category chip ──────────────────────────────────────────────────────────
class _Chip extends StatelessWidget {
  final String label;
  final Color color;
  const _Chip({required this.label, required this.color});

  @override
  Widget build(BuildContext context) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(5),
          border: Border.all(color: color.withValues(alpha: 0.3)),
        ),
        child: Text(
          label.toUpperCase(),
          style: TextStyle(
              color: color,
              fontSize: 10,
              fontWeight: FontWeight.w700,
              letterSpacing: .8),
        ),
      );
}

// ── Pagination ─────────────────────────────────────────────────────────────
class _PaginationBar extends StatelessWidget {
  final int page;
  final bool hasNext;
  final WidgetRef ref;
  const _PaginationBar(
      {required this.page, required this.hasNext, required this.ref});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final primary = Theme.of(context).colorScheme.primary;
    final tt = Theme.of(context).textTheme;

    return Container(
      padding: EdgeInsets.fromLTRB(20, 12, 20, MediaQuery.viewPaddingOf(context).bottom + 80 + 4),
      decoration: BoxDecoration(
        color: isDark ? AppColors.darkSurface : AppColors.lightSurface,
        border: Border(
            top: BorderSide(
                color:
                    isDark ? AppColors.darkBorder : AppColors.lightBorder)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: page > 1
                ? () => ref.read(newsPageProvider.notifier).state--
                : null,
            child: Text(AppLocalizations.of(context)!.previousPage,
                style: TextStyle(
                    color: page > 1
                        ? primary
                        : (isDark ? AppColors.darkTextMuted : AppColors.lightTextMuted),
                    fontWeight: FontWeight.w600,
                    fontSize: 13)),
          ),
          Text(AppLocalizations.of(context)!.page(page), style: tt.labelLarge),
          GestureDetector(
            onTap: hasNext
                ? () => ref.read(newsPageProvider.notifier).state++
                : null,
            child: Text(AppLocalizations.of(context)!.nextPage,
                style: TextStyle(
                    color: hasNext
                        ? primary
                        : (isDark ? AppColors.darkTextMuted : AppColors.lightTextMuted),
                    fontWeight: FontWeight.w600,
                    fontSize: 13)),
          ),
        ],
      ),
    );
  }
}
