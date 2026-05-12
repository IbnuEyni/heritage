import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../core/theme/app_theme.dart';
import '../../l10n/app_localizations.dart';
import 'home/home_screen.dart';
import 'heritage/heritage_screen.dart';
import 'dictionary/dictionary_screen.dart';
import 'news/news_screen.dart';
import 'heroes/heroes_screen.dart';

class AppShell extends StatefulWidget {
  final int initialIndex;
  const AppShell({super.key, this.initialIndex = 0});

  @override
  State<AppShell> createState() => _AppShellState();
}

class _AppShellState extends State<AppShell> {
  late int _index;

  static const _screens = [
    HeritageScreen(),
    DictionaryScreen(),
    HomeScreen(),
    NewsScreen(),
    HeroesScreen(),
  ];

  @override
  void initState() {
    super.initState();
    _index = widget.initialIndex == 0 ? 2 : widget.initialIndex;
  }

  void _onTap(int i) {
    HapticFeedback.lightImpact();
    setState(() => _index = i);
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      extendBody: true,
      body: IndexedStack(index: _index, children: _screens),
      bottomNavigationBar: _FloatingNav(
        currentIndex: _index,
        onTap: _onTap,
        isDark: isDark,
        items: _items,
      ),
    );
  }
}

// ── Floating nav ──────────────────────────────────────────────────────────────
class _FloatingNav extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;
  final bool isDark;
  final List<_NavItem> items;

  const _FloatingNav({
    required this.currentIndex,
    required this.onTap,
    required this.isDark,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;
    final _items = [
      _NavItem(Icons.account_balance_outlined, Icons.account_balance_rounded, l.navHeritage),
      _NavItem(Icons.menu_book_outlined,        Icons.menu_book_rounded,        l.navDictionary),
      _NavItem(Icons.home_rounded,              Icons.home_rounded,             l.navHome),
      _NavItem(Icons.newspaper_outlined,        Icons.newspaper_rounded,        l.navNews),
      _NavItem(Icons.shield_outlined,           Icons.shield_rounded,           l.navHeroes),
    ];
    final bg     = isDark ? AppColors.darkCard : Colors.white;
    final border = isDark ? AppColors.darkBorder : AppColors.lightBorder;
    final shadow = isDark ? Colors.black : AppColors.primary;

    return SafeArea(
      top: false,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 14),
        child: Container(
          height: 80,
          decoration: BoxDecoration(
            color: bg,
            borderRadius: BorderRadius.circular(40),
            border: Border.all(color: border, width: 1),
            boxShadow: [
              BoxShadow(
                color: shadow.withValues(alpha: isDark ? 0.55 : 0.14),
                blurRadius: 28,
                spreadRadius: 0,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Row(
            children: items.asMap().entries.map((e) {
              final i   = e.key;
              final sel = currentIndex == i;
              return Expanded(
                child: _Tab(
                  item: e.value,
                  selected: sel,
                  isDark: isDark,
                  onTap: () => onTap(i),
                ),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}

// ── Regular tab ───────────────────────────────────────────────────────────────
class _Tab extends StatefulWidget {
  final _NavItem item;
  final bool selected;
  final bool isDark;
  final VoidCallback onTap;

  const _Tab({
    required this.item,
    required this.selected,
    required this.isDark,
    required this.onTap,
  });

  @override
  State<_Tab> createState() => _TabState();
}

class _TabState extends State<_Tab> with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;
  late final Animation<double> _scale;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 120),
      lowerBound: 0.88,
      upperBound: 1.0,
      value: 1.0,
    );
    _scale = _ctrl;
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  void _onTapDown(_) => _ctrl.reverse();
  void _onTapUp(_) {
    _ctrl.forward();
    widget.onTap();
  }
  void _onTapCancel() => _ctrl.forward();

  @override
  Widget build(BuildContext context) {
    final inactiveColor = widget.isDark
        ? AppColors.darkTextMuted
        : AppColors.lightTextMuted;
    final sel = widget.selected;

    return GestureDetector(
      onTapDown: _onTapDown,
      onTapUp: _onTapUp,
      onTapCancel: _onTapCancel,
      behavior: HitTestBehavior.opaque,
      child: ScaleTransition(
        scale: _scale,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 250),
              curve: Curves.easeInOut,
              width: 46,
              height: 46,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: sel ? AppColors.primary : Colors.transparent,
                boxShadow: sel
                    ? [
                        BoxShadow(
                          color: AppColors.primary.withValues(alpha: 0.30),
                          blurRadius: 12,
                          spreadRadius: 0,
                          offset: const Offset(0, 3),
                        ),
                      ]
                    : [],
              ),
              child: Icon(
                sel ? widget.item.activeIcon : widget.item.icon,
                color: sel ? Colors.white : inactiveColor,
                size: 22,
              ),
            ),
            const SizedBox(height: 2),
            AnimatedDefaultTextStyle(
              duration: const Duration(milliseconds: 200),
              style: TextStyle(
                fontSize: 10,
                fontWeight: sel ? FontWeight.w700 : FontWeight.w400,
                color: sel ? AppColors.primary : inactiveColor,
              ),
              child: Text(widget.item.label),
            ),
          ],
        ),
      ),
    );
  }
}


class _NavItem {
  final IconData icon;
  final IconData activeIcon;
  final String label;
  const _NavItem(this.icon, this.activeIcon, this.label);
}
