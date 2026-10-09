import 'package:flutter/material.dart';
import 'package:kornia/core/theme/app_colors.dart';

class WeekDaySelector extends StatelessWidget {
  final DateTime selectedDate;
  final ValueChanged<DateTime>? onDateSelected;

  const WeekDaySelector({
    super.key,
    required this.selectedDate,
    this.onDateSelected,
  });

  static const List<String> _dayNames = [
    'LUN',
    'MAR',
    'MIÉ',
    'JUE',
    'VIE',
    'SÁB',
    'DOM',
  ];

  List<DateTime> _getCurrentWeekDays(DateTime referenceDate) {
    // Monday is weekday 1 in Dart DateTime
    final monday = referenceDate.subtract(Duration(days: referenceDate.weekday - 1));
    return List.generate(7, (index) {
      final day = monday.add(Duration(days: index));
      return DateTime(day.year, day.month, day.day);
    });
  }

  bool _isSameDay(DateTime a, DateTime b) {
    return a.year == b.year && a.month == b.month && a.day == b.day;
  }

  @override
  Widget build(BuildContext context) {
    final weekDays = _getCurrentWeekDays(selectedDate);

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: weekDays.map((date) {
          final isSelected = _isSameDay(date, selectedDate);
          final dayName = _dayNames[date.weekday - 1];

          return Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 3.0),
              child: _DayCard(
                dayName: dayName,
                dayNumber: date.day.toString(),
                isSelected: isSelected,
                onTap: () => onDateSelected?.call(date),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}

class _DayCard extends StatelessWidget {
  final String dayName;
  final String dayNumber;
  final bool isSelected;
  final VoidCallback? onTap;

  const _DayCard({
    required this.dayName,
    required this.dayNumber,
    required this.isSelected,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    const unselectedBg = Color(0xFFF3EFE6);
    const unselectedDayLabelColor = Color(0xFF6E645A);
    const unselectedDayNumberColor = Color(0xFF2C2520);

    const selectedBg = AppColors.darkBackground;
    const selectedAccentColor = Color(0xFFDFC187); // Bronze / gold accent
    const selectedDayNumberColor = Colors.white;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
          decoration: BoxDecoration(
            color: isSelected ? selectedBg : unselectedBg.withValues(alpha: 0.8),
            borderRadius: BorderRadius.circular(12),
            boxShadow: isSelected
                ? [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.2),
                      blurRadius: 8,
                      offset: const Offset(0, 3),
                    ),
                  ]
                : null,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                dayName,
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.5,
                  color: isSelected
                      ? selectedAccentColor
                      : unselectedDayLabelColor,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                dayNumber,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: isSelected
                      ? selectedDayNumberColor
                      : unselectedDayNumberColor,
                ),
              ),
              const SizedBox(height: 4),
              // Indicator dot
              Container(
                width: 4,
                height: 4,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: isSelected
                      ? selectedAccentColor
                      : Colors.transparent,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
