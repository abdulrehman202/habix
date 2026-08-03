import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:habix/models/Habit.dart';
import 'package:habix/providers/habit_category.dart';

List<Habit> allHabits = [
  RegularHabit('Walking', Category.HEALTH, 30, Interval.DAILY ,DateTime.now()),
  WaterHabit('Drink Water', Category.HEALTH, 8, Interval.DAILY,DateTime.now()),
  RegularHabit('Exercise', Category.PRODUCTIVITY, 15, Interval.WEEKDAYS,DateTime.now()),
  ReadingHabit('Read Book', Category.MIND, 30, Interval.WEEKEND,DateTime.now()),
  RegularHabit('Long Drive', Category.MIND, 20, Interval.WEEKEND,DateTime.now()),
];

// final habitsProvider = Provider((ref)=> allHabits);

 
class HabitsListNotifier extends StateNotifier<List<Habit>>{

  HabitsListNotifier():super(allHabits);
  
  void addHabit (Habit habit){
    state = [...state, habit];
  }

  void updateHabit (Habit habit){
    final l = state;
    final index = l.indexWhere((h)=>h.id==habit.id);
    l[index] = habit;
    state = l;
  }

  bool incrementProgress (Habit habit){
    
    List<Habit> l = state;
    int index = l.indexOf(habit);
    l[index].progress++;
    if(l[index].progress == l[index].quantity)
    {
      l[index].dateFinished = DateTime.now();
    }
    state=[...l];

    return state[index].progress == state[index].quantity;
  }

  void decrementProgress (Habit habit){
    List<Habit> l = state;
    int index = l.indexOf(habit);
    l[index].progress--;
    state=[...l];
  }

  void markAsComplete (Habit habit){
    List<Habit> l = state;
    int index = l.indexOf(habit);
    l[index].progress = l[index].quantity;
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