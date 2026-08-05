import 'package:habix/core/utilities/enums.dart';
import 'package:habix/data/model/habit_model.dart';

class HabitsListDummySource {

List<HabitModel> allHabits = [
  HabitModel('Walking', Category.HEALTH, 30, HabitInterval.DAILY ,DateTime.now()),
  HabitModel('Drink Water', Category.HEALTH, 8, HabitInterval.DAILY,DateTime.now()),
  HabitModel('Exercise', Category.PRODUCTIVITY, 15, HabitInterval.WEEKDAYS,DateTime.now()),
  HabitModel('Read Book', Category.MIND, 30, HabitInterval.WEEKEND,DateTime.now()),
  HabitModel('Long Drive', Category.MIND, 20, HabitInterval.WEEKEND,DateTime.now()),
];

}