// import 'package:flutter/material.dart';
import 'package:flutter/material.dart' show TimeOfDay;
import 'package:flutter_riverpod/legacy.dart';
import 'package:habix/core/utilities/enums.dart';

class NewHabitInterval extends StateNotifier<HabitInterval>{

  NewHabitInterval():super(HabitInterval.DAILY);

  void changeIntervalSelection(HabitInterval interval)=>state = interval;
}

final newHabitIntervalProvider = StateNotifierProvider<NewHabitInterval, HabitInterval>((ref)=>NewHabitInterval());

class NewHabitCategory extends StateNotifier<Category>{

  NewHabitCategory():super(Category.MORNING);

  void changeCategorySelection(Category category)=>state = category;
}

final newHabitCategoryProvider = StateNotifierProvider<NewHabitCategory, Category>((ref)=>NewHabitCategory());

class NewHabitButtonText extends StateNotifier<String>{

  NewHabitButtonText():super('');

  void updateHabitName(String txt)=>state = txt;
}

final newHabitButtonText = StateNotifierProvider<NewHabitButtonText, String>((ref)=>NewHabitButtonText());

class NewHabitReminderTime extends StateNotifier<TimeOfDay>{

  NewHabitReminderTime():super(TimeOfDay.now());

  void updateHabitReminder(TimeOfDay time)=>state = time;
}

final newHabitReminderTime = StateNotifierProvider<NewHabitReminderTime, TimeOfDay>((ref)=>NewHabitReminderTime());