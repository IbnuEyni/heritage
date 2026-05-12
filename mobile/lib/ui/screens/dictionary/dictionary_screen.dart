import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../data/repositories/providers.dart';
import '../../../domain/entities/entities.dart';
import '../../../core/theme/app_theme.dart';
import '../../../l10n/app_localizations.dart';

class DictionaryScreen extends ConsumerWidget {
  const DictionaryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = AppLocalizations.of(context)!;
    final query   = ref.watch(searchQueryProvider);
    final state   = ref.watch(dictionaryProvider);
    final isDark  = Theme.of(context).brightness == Brightness.dark;
    final primary = Theme.of(context).colorScheme.primary;
    final scheme  = Theme.of(context).colorScheme;

    // surface colors driven by theme
    final searchFill   = isDark ? AppColors.darkCard    : AppColors.lightSurface;
    final searchBorder = isDark ? AppColors.darkBorder  : AppColors.lightBorder;
    final hintColor    = isDark ? AppColors.darkTextMuted : AppColors.lightTextMuted;
    final iconColor    = isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary;
    final divColor     = isDark ? AppColors.darkDivider : AppColors.lightDivider;

    return Scaffold(
      appBar: AppBar(
        title: Text(l.affooDictionary),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(64),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
            child: TextField(
              onChanged: (v) =>
                  ref.read(searchQueryProvider.notifier).state = v,
              style: TextStyle(
                color: isDark
                    ? AppColors.darkTextPrimary
                    : AppColors.lightTextPrimary,
                fontSize: 14,
              ),
              decoration: InputDecoration(
                hintText: l.searchHint,
                hintStyle: TextStyle(color: hintColor, fontSize: 14),
                prefixIcon: Icon(Icons.search_rounded, color: iconColor, size: 20),
                suffixIcon: query.isNotEmpty
                    ? IconButton(
                        icon: Icon(Icons.close_rounded,
                            color: iconColor, size: 18),
                        onPressed: () =>
                            ref.read(searchQueryProvider.notifier).state = '',
                      )
                    : null,
                filled: true,
                fillColor: searchFill,
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: searchBorder),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: searchBorder),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: primary, width: 1.5),
                ),
              ),
            ),
          ),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () async => ref.invalidate(dictionaryProvider),
        child: state.when(
          loading: () => Center(child: CircularProgressIndicator(color: primary)),
          error: (e, _) => Center(
            child: Text('Error: $e', style: TextStyle(color: scheme.error)),
          ),
          data: (result) {
            if (result.failure != null) {
              return Center(
                child: Text('Error: ${result.failure!.message}',
                    style: TextStyle(color: scheme.error)),
              );
            }
            final entries = result.data ?? [];
            if (entries.isEmpty && query.trim().isNotEmpty) {
              return _NoResults(query: query, l: l);
            }
            if (entries.isEmpty) {
              return _EmptyLibrary(l: l);
            }
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 10, 16, 2),
                  child: Text(
                    query.trim().isEmpty
                        ? l.wordsInLibrary(entries.length)
                        : l.searchResults(entries.length, query),
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ),
                Expanded(
                  child: ListView.separated(
                    padding: EdgeInsets.fromLTRB(16, 8, 16, MediaQuery.viewPaddingOf(context).bottom + 80 + 24),
                    itemCount: entries.length,
                    separatorBuilder: (_, __) =>
                        Divider(height: 1, color: divColor),
                    itemBuilder: (_, i) => _WordTile(entries[i]),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

// ── Word tile ──────────────────────────────────────────────────────────────
class _WordTile extends StatelessWidget {
  final DictionaryEntity entry;
  const _WordTile(this.entry);

  @override
  Widget build(BuildContext context) {
    final isDark  = Theme.of(context).brightness == Brightness.dark;
    final tt      = Theme.of(context).textTheme;
    final primary = Theme.of(context).colorScheme.primary;

    final textPrimary   = isDark ? AppColors.darkTextPrimary   : AppColors.lightTextPrimary;
    final textSecondary = isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary;

    return GestureDetector(
      onTap: () => context.push('/word-detail', extra: entry),
      child: Padding(
      padding: const EdgeInsets.symmetric(vertical: 14),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // left accent bar
          Container(
            width: 3,
            height: 58,
            margin: const EdgeInsets.only(right: 14),
            decoration: BoxDecoration(
              color: primary.withValues(alpha: 0.45),
              borderRadius: BorderRadius.circular(2),
            ),
          ),

          // content
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // kebena word + category badge
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Flexible(
                      child: Text(
                        entry.kebenaWord,
                        style: tt.titleLarge?.copyWith(
                          color: primary,
                          fontWeight: FontWeight.w700,
                          fontSize: 18,
                        ),
                      ),
                    ),
                    if (entry.category != null) ...[
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 7, vertical: 2),
                        decoration: BoxDecoration(
                          color: primary.withValues(alpha: 0.08),
                          borderRadius: BorderRadius.circular(4),
                          border: Border.all(
                              color: primary.withValues(alpha: 0.2)),
                        ),
                        child: Text(
                          entry.category!,
                          style: TextStyle(
                            color: primary,
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
                const SizedBox(height: 6),

                // amharic
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('🇪🇹 ', style: TextStyle(fontSize: 13)),
                    Expanded(
                      child: Text(
                        entry.amharicTranslation,
                        style: tt.bodyMedium?.copyWith(
                          color: textPrimary,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 3),

                // english
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('🇬🇧 ', style: TextStyle(fontSize: 13)),
                    Expanded(
                      child: Text(
                        entry.englishTranslation,
                        style: tt.bodyMedium?.copyWith(color: textSecondary),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // chevron
          Padding(
            padding: const EdgeInsets.only(left: 8, top: 4),
            child: Icon(Icons.chevron_right_rounded,
                color: primary.withValues(alpha: 0.4), size: 20),
          ),
        ],
      ),
     ),
    );
  }
}

// ── Empty states ───────────────────────────────────────────────────────────
class _NoResults extends StatelessWidget {
  final String query;
  final AppLocalizations l;
  const _NoResults({required this.query, required this.l});

  @override
  Widget build(BuildContext context) {
    final tt      = Theme.of(context).textTheme;
    final primary = Theme.of(context).colorScheme.primary;
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.search_off_rounded,
                size: 52, color: primary.withValues(alpha: 0.25)),
            const SizedBox(height: 16),
            Text(l.noResultsFor(query), style: tt.titleMedium),
            const SizedBox(height: 6),
            Text(l.tryDifferentSpelling, style: tt.bodyMedium, textAlign: TextAlign.center),
          ],
        ),
      ),
    );
  }
}

class _EmptyLibrary extends StatelessWidget {
  final AppLocalizations l;
  const _EmptyLibrary({required this.l});

  @override
  Widget build(BuildContext context) {
    final tt      = Theme.of(context).textTheme;
    final primary = Theme.of(context).colorScheme.primary;
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.menu_book_outlined,
              size: 52, color: primary.withValues(alpha: 0.25)),
          const SizedBox(height: 16),
          Text(l.dictionaryEmpty, style: tt.titleMedium),
          const SizedBox(height: 6),
          Text(l.wordsWillAppear, style: tt.bodyMedium),
        ],
      ),
    );
  }
}
