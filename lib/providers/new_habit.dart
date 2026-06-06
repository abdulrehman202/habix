import 'package:flutter_riverpod/legacy.dart';
import 'package:habix/models/Habit.dart';

class NewHabitInterval extends StateNotifier<Interval>{

  NewHabitInterval():super(Interval.DAILY);

  void changeIntervalSelection(Interval interval)=>state = interval;
}

final newHabitIntervalProvider = StateNotifierProvider<NewHabitInterval, Interval>((ref)=>NewHabitInterval());

class NewHabitCategory extends StateNotifier<Category>{

  NewHabitCategory():super(Category.MORNING);

  void changeCategorySelection(Category category)=>state = category;
}

final newHabitCategoryProvider = StateNotifierProvider<NewHabitCategory, Category>((ref)=>NewHabitCategory());