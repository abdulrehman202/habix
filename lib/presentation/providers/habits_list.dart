import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:habix/core/utilities/enums.dart';
import 'package:habix/domain/models/Habit.dart';
import 'package:habix/domain/usecase/habit_usecases.dart';
import 'package:habix/presentation/providers/habit_category.dart';


int days = 0;

final initialList = HabitUsecases().getAllHabitsOnDate(DateTime.now().add(Duration(days: days)));

 
class HabitsListNotifier extends StateNotifier<List<Habit>>{

  final HabitUsecases _habitUsecases = HabitUsecases();

  HabitsListNotifier():super(initialList);
  
  void addHabit (Habit habit){
    _habitUsecases.addHabit(habit);
    state = [...state, habit];
  }

  void updateList(DateTime dateTime)
  { 
    final list = _habitUsecases.getAllHabitsOnDate(dateTime);
    state = [...list];
  }

  void updateHabit (Habit habit){

    _habitUsecases.updateHabit(habit);

    final l = state;
    final index = l.indexWhere((h)=>h.id==habit.id);
    l[index] = habit;
    state = l;
  }

  bool incrementProgress (Habit habit){
    return false;
    // List<Habit> l = state;
    // int index = l.indexOf(habit);
    // l[index].progress++;
    // if(l[index].progress == l[index].quantity)
    // {
    //   l[index].dateFinished = DateTime.now();
    // }
    // state=[...l];

    // return state[index].progress == state[index].quantity;
  }

  void decrementProgress (Habit habit){
    // List<Habit> l = state;
    // int index = l.indexOf(habit);
    // l[index].progress--;
    // state=[...l];
  }

  void markAsComplete (Habit habit){
    // List<Habit> l = state;
    // int index = l.indexOf(habit);
    // l[index].progress = l[index].quantity;
    // state=[...l];
  }
}

final habitsListProvider = StateNotifierProvider<HabitsListNotifier, List<Habit>>((ref){

return HabitsListNotifier();

});

final categorizedlist = Provider((ref)
{
  final chosenCategory  = ref.watch(habitsCategoryProvider);
  final allHabitsList = HabitUsecases().getAllHabits();

  if(chosenCategory ==Category.ALL)
  {
    return allHabitsList;
  }

  return allHabitsList.where((h)=>h.category == chosenCategory).toList();
});

