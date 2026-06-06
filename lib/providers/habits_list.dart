import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:habix/models/Habit.dart';
import 'package:habix/providers/habit_category.dart';
import 'package:state_notifier/state_notifier.dart';

List<Habit> allHabits = [
  Habit('Walking', Category.HEALTH, '30 minutes', true, false, false,0),
  Habit('Drink Water', Category.HEALTH, '8 glasses of water', true, false, false,0),
  Habit('Exercise', Category.PRODUCTIVITY, '15 minutes', false, true, false,0),
  Habit('Read Book', Category.MIND, '30 minutes', true, false, false,0),
];

// final habitsProvider = Provider((ref)=> allHabits);


class HabitsListNotifier extends StateNotifier<List<Habit>>{

  HabitsListNotifier():super(allHabits);
  
  void addHabit (Habit habit){
    state = [...state, habit];
  }

}

final habitsListProvider = StateNotifierProvider<HabitsListNotifier, List<Habit>>((ref){

return HabitsListNotifier();

});

final categorizedlist = Provider((ref)
{
  final chosenCategory  = ref.watch(habitsCategoryProvider);
  final allHabitsList = ref.watch(habitsListProvider);

  if(chosenCategory ==Category.ALL)
  {
    return allHabitsList;
  }

  return allHabitsList.where((h)=>h.category == chosenCategory).toList();
});