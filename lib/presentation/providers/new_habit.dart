// import 'package:flutter/material.dart';
import 'package:flutter/material.dart' show TimeOfDay;
import 'package:flutter_riverpod/legacy.dart';
import 'package:habix/utilities/enums.dart';


class NewHabitProvider extends StateNotifier<Map<String, dynamic>>{

  NewHabitProvider():super({
    'interval': HabitInterval.DAILY,
    'category':Category.MORNING,
    'button_text': '',
    'time':TimeOfDay.now()


    
    });

  void changeIntervalSelection(HabitInterval interval)=>changeState('interval', interval);
  void changeCategorySelection(Category category)=>changeState('category', category);
  void changebuttonText(String text)=>changeState('button_text', text);
  void changeTime(TimeOfDay time)=>changeState('time', time);

  void changeState(String key, dynamic value)
  {
    state = {
      ...state,
      key:value
    };
  }
}

final newHabitProvider = StateNotifierProvider<NewHabitProvider, Map<String, dynamic>>((ref)=>NewHabitProvider());