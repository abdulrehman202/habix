import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:habix/models/Habit.dart';
import 'package:habix/providers/habits_list.dart';

class NewHabit extends ConsumerStatefulWidget {
  const NewHabit({super.key});

  @override
  ConsumerState<NewHabit> createState() => _NewHabitState();
}

class _NewHabitState extends ConsumerState<NewHabit> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IconButton(onPressed: ()
      {
        ref.read(habitsListProvider.notifier).addHabit(
          
  Habit('Gaming', Category.OTHER, '30 minutes', true, false, false,0),
        );
        Navigator.pop(context);
      }, icon: Icon(Icons.add)),
    );
  }
}