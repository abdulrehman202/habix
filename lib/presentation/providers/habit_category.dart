
import 'package:flutter_riverpod/legacy.dart';
import 'package:habix/domain/models/Habit.dart';

class HabitsCategoryNotifier extends StateNotifier<Category>{

  HabitsCategoryNotifier():super(Category.ALL);
  
  void changeCategory (Category category){
    state = category;
  }

}

final habitsCategoryProvider = StateNotifierProvider<HabitsCategoryNotifier, Category>((ref){

return HabitsCategoryNotifier();

});