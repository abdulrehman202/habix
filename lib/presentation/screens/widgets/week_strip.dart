import 'package:flutter/material.dart';
import 'package:habix/utilities/extensions.dart';

class WeekStrip extends StatelessWidget {
  final DateTime selected;
  final ValueChanged<DateTime> onSelect;
  WeekStrip({required this.selected, required this.onSelect});

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final monday = DateTime(
      now.year,
      now.month,
      now.day,
    ).subtract(Duration(days: now.weekday - 1));
    final days = List.generate(7, (i) => monday.add(Duration(days: i)));

    return Row(
      children: [
        for (final d in days)
          Expanded(
            child: GestureDetector(
              onTap: () => onSelect(d),
              child: Container(
                width: 46,
                padding: const EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(
                  color: DateUtils.isSameDay(d, selected)
                      ?  Colors.grey.shade200
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  children: [
                    Text(
                      '${d.day}',
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      
                      d.weekday.dayInAlphabets,
                      maxLines: 1,
                      
                      style: const TextStyle(fontSize: 15,),
                    ),
                  ],
                ),
              ),
            ),
          ),
      ],
    );
  }
}
