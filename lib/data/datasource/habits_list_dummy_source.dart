import 'package:habix/core/utilities/enums.dart';
import 'package:habix/core/utilities/extensions.dart';
import 'package:habix/data/model/habit_model.dart';

class HabitsListDummySource {

List<HabitModel> allHabits = [
  HabitModel( id: getNewHabitId(),name:'Walking', category:  Category.HEALTH, quantity:  30, interval:  HabitInterval.DAILY , dateCreated:  DateTime.now()),
  HabitModel(id: getNewHabitId(), name: 'Drink Water', category:  Category.HEALTH, quantity:  8, interval:  HabitInterval.DAILY, dateCreated:  DateTime.now()),
  HabitModel(id: getNewHabitId(), name: 'Exercise', category:  Category.PRODUCTIVITY, quantity:  15, interval:  HabitInterval.WEEKDAYS, dateCreated: DateTime.now()),
  HabitModel(id: getNewHabitId(), name:  'Read Book', category:  Category.MIND, quantity:  30, interval:  HabitInterval.WEEKEND, dateCreated: DateTime.now()),
  HabitModel(id: getNewHabitId(),name:'Long Drive', category:  Category.MIND, quantity:  20, interval:  HabitInterval.WEEKEND, dateCreated:  DateTime.now()),
];

}