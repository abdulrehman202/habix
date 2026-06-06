
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:habix/models/Habit.dart';
import 'package:habix/providers/habits_list.dart';

class HabitsCategoryNotifier extends StateNotifier<Category>{

  HabitsCategoryNotifier():super(Category.ALL);
  
  void changeCategory (Category category){
    state = category;
  }

}

final habitsCategoryProvider = StateNotifierProvider<HabitsCategoryNotifier, Category>((ref){

return HabitsCategoryNotifier();

});