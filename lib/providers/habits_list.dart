import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:habix/models/Habit.dart';
import 'package:habix/providers/habit_category.dart';
import 'package:state_notifier/state_notifier.dart';

List<Habit> allHabits = [
  RegularHabit('Walking', Category.HEALTH, 30, Interval.DAILY ,0),
  WaterHabit('Drink Water', Category.HEALTH, 8, Interval.DAILY,0),
  RegularHabit('Exercise', Category.PRODUCTIVITY, 15, Interval.WEEKDAYS,0),
  ReadingHabit('Read Book', Category.MIND, 30, Interval.WEEKEND,0),
];

// final habitsProvider = Provider((ref)=> allHabits);


class HabitsListNotifier extends StateNotifier<List<Habit>>{

  HabitsListNotifier():super(allHabits);
  
  void addHabit (Habit habit){
    state = [...state, habit];
  }

  void incrementProgress (int index){
    List<Habit> l = state;
    l[index].progress++;
    state=[...l];
  }

  void decrementProgress (int index){
    List<Habit> l = state;
    l[index].progress--;
    state=[...l];
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