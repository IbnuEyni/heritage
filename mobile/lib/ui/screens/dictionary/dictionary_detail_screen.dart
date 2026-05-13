import '../../../core/utils/l10n_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/services/tts_service.dart';
import '../../../domain/entities/entities.dart';
import '../../../l10n/app_localizations.dart';

class DictionaryDetailScreen extends StatefulWidget {
  final DictionaryEntity entry;
  const DictionaryDetailScreen({super.key, required this.entry});

  @override
  State<DictionaryDetailScreen> createState() => _DictionaryDetailScreenState();
}

class _DictionaryDetailScreenState extends State<DictionaryDetailScreen> {
  final _tts = TtsService.instance;
  _TtsState _ttsState = _TtsState.idle;

  Future<void> _speak(String text, String language) async {
    if (_ttsState == _TtsState.playing) {
      await _tts.stop();
      setState(() => _ttsState = _TtsState.idle);
      return;
    }
    setState(() => _ttsState = _TtsState.loading);
    try {
      await _tts.speak(text, language);
      if (mounted) setState(() => _ttsState = _TtsState.playing);
      _tts.playingStream.firstWhere((p) => !p).then((_) {
        if (mounted) setState(() => _ttsState = _TtsState.idle);
      });
    } catch (_) {
      if (mounted) {
        setState(() => _ttsState = _TtsState.idle);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(context.l.audioUnavailable),
            behavior: SnackBarBehavior.floating,
            backgroundColor: Colors.red.shade700,
          ),
        );
      }
    }
  }

  @override
  void dispose() {
    _tts.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final entry = widget.entry;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final primary = Theme.of(context).colorScheme.primary;
    final tt = Theme.of(context).textTheme;
    final cardBg = isDark ? AppColors.darkCard : AppColors.lightCard;
    final border = isDark ? AppColors.darkBorder : AppColors.lightBorder;
    final textSecondary =
        isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary;

    return Scaffold(
      backgroundColor: isDark ? AppColors.darkBg : AppColors.lightBg,
      appBar: AppBar(
        title: Text(context.l.affooDictionary),
        actions: [
          IconButton(
            icon: const Icon(Icons.copy_rounded, size: 20),
            tooltip: context.l.copyWord,
            onPressed: () {
              Clipboard.setData(ClipboardData(text: entry.kebenaWord));
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(context.l.wordCopied(entry.kebenaWord)),
                  behavior: SnackBarBehavior.floating,
                  duration: const Duration(seconds: 2),
                ),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(
            20, 16, 20, MediaQuery.viewPaddingOf(context).bottom + 32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Hero word card ───────────────────────────────────────────
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: cardBg,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: border),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (entry.category != null) ...[
                    _CategoryBadge(label: entry.category!, color: primary),
                    const SizedBox(height: 16),
                  ],
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Text(
                          entry.kebenaWord,
                          style: tt.displaySmall?.copyWith(
                            color: primary,
                            fontWeight: FontWeight.w800,
                            fontFamily: 'Playfair Display',
                            letterSpacing: -0.5,
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      _TtsButton(
                        state: _ttsState,
                        primaryColor: primary,
                        onTap: () => _speak(entry.kebenaWord, 'kebena'),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Text(
                    context.l.affooLanguage,
                    style: tt.bodySmall?.copyWith(color: textSecondary),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      _SpeakChip(
                        label: 'English',
                        flag: '🇬🇧',
                        color: primary,
                        onTap: () =>
                            _speak(entry.englishTranslation, 'english'),
                      ),
                      const SizedBox(width: 8),
                      _SpeakChip(
                        label: 'Amharic',
                        flag: '🇪🇹',
                        color: primary,
                        onTap: () =>
                            _speak(entry.amharicTranslation, 'amharic'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // ── Translations ─────────────────────────────────────────────
            _SectionCard(
              title: context.l.translations,
              cardBg: cardBg,
              border: border,
              child: Column(
                children: [
                  _TranslationRow(
                    flag: '🇬🇧',
                    language: 'English',
                    translation: entry.englishTranslation,
                  ),
                  const SizedBox(height: 14),
                  _TranslationRow(
                    flag: '🇪🇹',
                    language: 'Amharic',
                    translation: entry.amharicTranslation,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // ── Example sentences ────────────────────────────────────────
            if (entry.examples.isNotEmpty) ...[
              _SectionCard(
                title: context.l.exampleSentences,
                cardBg: cardBg,
                border: border,
                child: Column(
                  children: entry.examples
                      .asMap()
                      .entries
                      .map((e) => _ExampleTile(
                            index: e.key + 1,
                            text: e.value,
                            color: primary,
                            onSpeak: () => _speak(e.value, 'kebena'),
                          ))
                      .toList(),
                ),
              ),
              const SizedBox(height: 16),
            ],

            // ── Synonyms ─────────────────────────────────────────────────
            if (entry.synonyms.isNotEmpty)
              _SectionCard(
                title: context.l.synonyms,
                cardBg: cardBg,
                border: border,
                child: Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: entry.synonyms
                      .map((s) => _SynonymChip(
                            word: s,
                            color: primary,
                            onTap: () => _speak(s, 'kebena'),
                          ))
                      .toList(),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

enum _TtsState { idle, loading, playing }

// ── TTS main button ───────────────────────────────────────────────────────────
class _TtsButton extends StatelessWidget {
  final _TtsState state;
  final Color primaryColor;
  final VoidCallback onTap;

  const _TtsButton({
    required this.state,
    required this.primaryColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isPlaying = state == _TtsState.playing;
    final isLoading = state == _TtsState.loading;

    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: 52,
        height: 52,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: isPlaying
              ? primaryColor.withValues(alpha: 0.18)
              : primaryColor.withValues(alpha: 0.08),
          border: Border.all(
              color: primaryColor.withValues(alpha: 0.3), width: 1.5),
        ),
        child: isLoading
            ? Padding(
                padding: const EdgeInsets.all(14),
                child: CircularProgressIndicator(
                    strokeWidth: 2, color: primaryColor),
              )
            : Icon(
                isPlaying ? Icons.stop_rounded : Icons.volume_up_rounded,
                color: primaryColor,
                size: 24,
              ),
      ),
    );
  }
}

// ── Small speak chip ──────────────────────────────────────────────────────────
class _SpeakChip extends StatelessWidget {
  final String label, flag;
  final Color color;
  final VoidCallback onTap;

  const _SpeakChip({
    required this.label,
    required this.flag,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.08),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: color.withValues(alpha: 0.2)),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(flag, style: const TextStyle(fontSize: 13)),
            const SizedBox(width: 5),
            Icon(Icons.volume_up_rounded, color: color, size: 13),
            const SizedBox(width: 4),
            Text(label,
                style: TextStyle(
                    color: color,
                    fontSize: 11,
                    fontWeight: FontWeight.w600)),
          ],
        ),
      ),
    );
  }
}

// ── Reusable section card ─────────────────────────────────────────────────────
class _SectionCard extends StatelessWidget {
  final String title;
  final Widget child;
  final Color cardBg;
  final Color border;

  const _SectionCard({
    required this.title,
    required this.child,
    required this.cardBg,
    required this.border,
  });

  @override
  Widget build(BuildContext context) {
    final tt = Theme.of(context).textTheme;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: cardBg,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(children: [
            Container(
              width: 3,
              height: 14,
              decoration: BoxDecoration(
                color: AppColors.gold,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(width: 8),
            Text(title,
                style: tt.titleSmall?.copyWith(fontWeight: FontWeight.w700)),
          ]),
          const SizedBox(height: 16),
          child,
        ],
      ),
    );
  }
}

// ── Translation row ───────────────────────────────────────────────────────────
class _TranslationRow extends StatelessWidget {
  final String flag, language, translation;
  const _TranslationRow({
    required this.flag,
    required this.language,
    required this.translation,
  });

  @override
  Widget build(BuildContext context) {
    final tt = Theme.of(context).textTheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textSecondary =
        isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(flag, style: const TextStyle(fontSize: 22)),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(language,
                  style: tt.bodySmall?.copyWith(color: textSecondary)),
              const SizedBox(height: 3),
              Text(translation,
                  style: tt.bodyLarge?.copyWith(fontWeight: FontWeight.w600)),
            ],
          ),
        ),
      ],
    );
  }
}

// ── Example sentence tile ─────────────────────────────────────────────────────
class _ExampleTile extends StatelessWidget {
  final int index;
  final String text;
  final Color color;
  final VoidCallback onSpeak;

  const _ExampleTile({
    required this.index,
    required this.text,
    required this.color,
    required this.onSpeak,
  });

  @override
  Widget build(BuildContext context) {
    final tt = Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 22,
            height: 22,
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.1),
              shape: BoxShape.circle,
              border: Border.all(color: color.withValues(alpha: 0.2)),
            ),
            child: Center(
              child: Text('$index',
                  style: TextStyle(
                      color: color,
                      fontSize: 11,
                      fontWeight: FontWeight.w700)),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(text,
                style: tt.bodyMedium
                    ?.copyWith(fontStyle: FontStyle.italic, height: 1.5)),
          ),
          GestureDetector(
            onTap: onSpeak,
            child: Icon(Icons.volume_up_rounded,
                color: color.withValues(alpha: 0.5), size: 18),
          ),
        ],
      ),
    );
  }
}

// ── Synonym chip ──────────────────────────────────────────────────────────────
class _SynonymChip extends StatelessWidget {
  final String word;
  final Color color;
  final VoidCallback onTap;

  const _SynonymChip({
    required this.word,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.08),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: color.withValues(alpha: 0.2)),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(word,
                style: TextStyle(
                    color: color,
                    fontSize: 13,
                    fontWeight: FontWeight.w600)),
            const SizedBox(width: 5),
            Icon(Icons.volume_up_rounded,
                color: color.withValues(alpha: 0.5), size: 13),
          ],
        ),
      ),
    );
  }
}

// ── Category badge ────────────────────────────────────────────────────────────
class _CategoryBadge extends StatelessWidget {
  final String label;
  final Color color;

  const _CategoryBadge({required this.label, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withValues(alpha: 0.2)),
      ),
      child: Text(
        label.toUpperCase(),
        style: TextStyle(
          color: color,
          fontSize: 10,
          fontWeight: FontWeight.w700,
          letterSpacing: 1,
        ),
      ),
    );
  }
}
