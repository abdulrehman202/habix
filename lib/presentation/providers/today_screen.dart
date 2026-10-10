import 'package:flutter_riverpod/legacy.dart';
import 'package:habix/domain/models/Habit.dart';
import 'package:habix/domain/usecase/habit_usecases.dart';

Map<String, dynamic> todaysScreenVariables = {
  'habits_list':[],
  'selected_date': DateTime.now(),
  'data_loading': false

};

class TodayScreenNotifier extends StateNotifier<Map<String, dynamic>>{
  final HabitUsecases _habitUsecases = HabitUsecases();

  TodayScreenNotifier():super(
    {
  'habits_list':[],
  'selected_date': DateTime.now(),
  'data_loading': false
}

  ){
    
fetchInitialHabitsList();
  }

fetchInitialHabitsList()async
  {
    state={
      ...state,
      'data_loading':true,
    };

    final list = await _habitUsecases.getAllHabitsOnDate(DateTime.now());
    
    state={
      ...state,
      'data_loading':false,
      'habits_list':list
    };
  }
  
void changeDate (DateTime newDate){
  
    state={
      ...state,
      'selected_date':newDate
    };
  }

Future<void> updateList(DateTime dateTime) async{
    final list = await _habitUsecases.getAllHabitsOnDate(dateTime);
    state={
      ...state,
      'habits_list':list
    };
  }

bool incrementProgress(Habit habit) {
    _habitUsecases.incrementProgress(habit);
    List<Habit> l = state['habits_list'];
    int index = l.indexOf(habit);
    l[index].progress++;
    if (l[index].progress == l[index].quantity) {
      l[index].dateFinished = DateTime.now();
    }
    state = {
      ...state,
      'habits_list':l
    };

    return l[index].progress == l[index].quantity;
  }

  void decrementProgress(Habit habit) {
    
    _habitUsecases.decrementProgress(habit);
    List<Habit> l = state['habits_list'];
    int index = l.indexOf(habit);
    l[index].progress--;
    state={...state,'habits_list':l};
  }

  void markAsComplete(Habit habit) {
    _habitUsecases.markAsComplete(habit);
    List<Habit> l = state['habits_list'];
    int index = l.indexOf(habit);
    l[index].progress = l[index].quantity;
    l[index].dateFinished = DateTime.now();
    state={...state,'habits_list':l};
  }

void toggle (){
    bool currentState = state['data_loading'];
    state={
      ...state,
      'data_loading':!currentState,
    };
  }

}

final todaysScreenProvider = StateNotifierProvider<TodayScreenNotifier, Map<String, dynamic>>((ref){

return TodayScreenNotifier();

});