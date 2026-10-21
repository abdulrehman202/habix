
import 'package:flutter_riverpod/legacy.dart';
import 'package:habix/core/Error/Result.dart';
import 'package:habix/domain/models/Habit.dart';
import 'package:habix/domain/usecase/habit_usecases.dart';
import 'package:habix/utilities/enums.dart';

class HabitsCategoryNotifier extends StateNotifier<Map<String, dynamic>>{
  final HabitUsecases _habitUsecases = HabitUsecases();

  HabitsCategoryNotifier():super({
    'selected_categories': Category.values.toList(),
    'list':[],
    'error':false,
    'error_message':'',
    'loading':false,
    'removing':false
    }){
    
fetchInitialHabitsList();
  }

fetchInitialHabitsList()async
  {
    toggleLoader(true);
    Result result = await _habitUsecases.getAllHabits();
    List<Habit> allHabitsList = result is Ok? result.value:[];

    state={
      ...state,
      'list':allHabitsList,
      'loading':false,
      'error': result is Error
    };
  }
  

  void addCategory (Category category){
    List<Category> currentSelectedCategories = state['selected_categories'];
    currentSelectedCategories.add(category);
    state = {...state, 'selected_categories': currentSelectedCategories,};
  }

    void removeCategory (Category category){
    List<Category> currentSelectedCategories = state['selected_categories'];
    currentSelectedCategories.remove(category);
    state = {...state, 'selected_categories': currentSelectedCategories,};
  }

  void changeErrorMessage (String msg){
    state = {...state, 'error_message': msg};
  }

  void toggleLoader (bool toggle){
    state = {...state, 'loading': toggle};
  }

  void isRemoving (bool toggle){
    state = {...state, 'removing': toggle};
  }

  void deleteHabitfromList (String habitId){
    List<Habit> list = state['list'];
    int index = list.indexWhere((e)=>e.id == habitId);
    list.removeAt(index);
    state = {...state, 'list': list};
  }

  Future<bool> deleteHabit(String id)async {
    isRemoving(true);
    Result result =  await _habitUsecases.remove(id);
    if(result is Error)
    {
      changeErrorMessage(result.failure.message);
    }

    else{
      deleteHabitfromList(id);
    }
    isRemoving(false);
    return result is Ok;
  }

}

final habitsCategoryProvider = StateNotifierProvider<HabitsCategoryNotifier, Map<String, dynamic>>((ref){

return HabitsCategoryNotifier();

});