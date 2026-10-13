// import 'package:flutter/material.dart';
import 'package:flutter/material.dart' show TimeOfDay;
import 'package:flutter_riverpod/legacy.dart';
import 'package:habix/core/Error/Result.dart';
import 'package:habix/domain/models/Habit.dart';
import 'package:habix/domain/usecase/habit_usecases.dart';
import 'package:habix/utilities/enums.dart';


class NewHabitProvider extends StateNotifier<Map<String, dynamic>>{
  final HabitUsecases _habitUsecases = HabitUsecases();

  NewHabitProvider():super({
    'interval': HabitInterval.DAILY,
    'category':Category.MORNING,
    'button_text': '',
    'time':TimeOfDay.now(),
    'error_message':'Something went wrong'
    });

  void changeIntervalSelection(HabitInterval interval)=>changeState('interval', interval);
  void changeCategorySelection(Category category)=>changeState('category', category);
  void changebuttonText(String text)=>changeState('button_text', text);
  void changeTime(TimeOfDay time)=>changeState('time', time);
  void changeErrorMessage(String eMsg)=>changeState('error_message', eMsg);
  void resetErrorMessage()=>changeState('error_message', 'Something went wrong');
  Future<bool> addHabit(Habit habit)async {
    Result result =  await _habitUsecases.addHabit(habit);
    
    if(result is Error)
    {
      changeErrorMessage(result.failure.message);
    }
    return result is Ok;
  }

  void changeState(String key, dynamic value)
  {
    state = {
      ...state,
      key:value
    };
  }
}

final newHabitProvider = StateNotifierProvider<NewHabitProvider, Map<String, dynamic>>((ref)=>NewHabitProvider());