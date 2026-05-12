import 'package:add_2_calendar/add_2_calendar.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../core/theme/app_theme.dart';
import '../../../l10n/app_localizations.dart';

final _mockEvents = [
  _EventData(
    title: 'Kebena Cultural Festival',
    description: 'Annual celebration of Kebena heritage, traditions, music and food.',
    location: 'Kebena Special Woreda',
    start: DateTime(2025, 9, 11),
    end: DateTime(2025, 9, 12),
    color: AppColors.primary,
  ),
  _EventData(
    title: 'Woreda Community Meeting',
    description: 'Quarterly community coordination and planning meeting.',
    location: 'Woreda Administration Hall',
    start: DateTime(2025, 8, 1, 9, 0),
    end: DateTime(2025, 8, 1, 12, 0),
    color: const Color(0xFF1565C0),
  ),
];

class EventsScreen extends StatelessWidget {
  const EventsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(title: Text(l.communityEvents)),
      body: ListView.separated(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 32),
        itemCount: _mockEvents.length,
        separatorBuilder: (_, __) => const SizedBox(height: 12),
        itemBuilder: (_, i) => _EventCard(_mockEvents[i]),
      ),
    );
  }
}

class _EventCard extends StatelessWidget {
  final _EventData event;
  const _EventCard(this.event);

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final tt = Theme.of(context).textTheme;
    final cardColor = isDark ? AppColors.darkCard : AppColors.lightCard;
    final borderColor = isDark ? AppColors.darkBorder : AppColors.lightBorder;

    return Container(
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: borderColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 5,
            decoration: BoxDecoration(
              color: event.color,
              borderRadius: const BorderRadius.vertical(top: Radius.circular(15)),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                    color: event.color.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(7),
                    border: Border.all(color: event.color.withValues(alpha: 0.25)),
                  ),
                  child: Text(
                    DateFormat('EEE, MMM d · y').format(event.start),
                    style: TextStyle(color: event.color, fontSize: 12, fontWeight: FontWeight.w600),
                  ),
                ),
                const SizedBox(height: 12),
                Text(event.title, style: tt.titleLarge),
                const SizedBox(height: 8),
                Text(event.description, style: tt.bodyMedium),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Icon(Icons.location_on_outlined, size: 15,
                        color: isDark ? AppColors.darkTextMuted : AppColors.lightTextMuted),
                    const SizedBox(width: 5),
                    Text(event.location, style: tt.bodySmall),
                  ],
                ),
                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: event.color,
                      foregroundColor: Colors.white,
                    ),
                    icon: const Icon(Icons.calendar_today_outlined, size: 16),
                    label: Text(l.addToCalendar),
                    onPressed: () => Add2Calendar.addEvent2Cal(Event(
                      title: event.title,
                      description: event.description,
                      location: event.location,
                      startDate: event.start,
                      endDate: event.end,
                    )),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _EventData {
  final String title, description, location;
  final DateTime start, end;
  final Color color;
  const _EventData({
    required this.title,
    required this.description,
    required this.location,
    required this.start,
    required this.end,
    required this.color,
  });
}
