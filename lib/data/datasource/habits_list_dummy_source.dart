import 'package:habix/core/utilities/enums.dart';
import 'package:habix/core/utilities/extensions.dart';
import 'package:habix/data/model/habit_model.dart';

List<HabitModel> allHabits = [
  HabitModel( id: '1',name:'Walking', category:  Category.HEALTH, quantity:  30, interval:  HabitInterval.DAILY , dateCreated:  DateTime.now()),
  HabitModel(id: '2', name: 'Drink Water', category:  Category.HEALTH, quantity:  8, interval:  HabitInterval.DAILY, dateCreated:  DateTime.now()),
  HabitModel(id: '3', name: 'Exercise', category:  Category.PRODUCTIVITY, quantity:  15, interval:  HabitInterval.WEEKDAYS, dateCreated: DateTime.now()),
  HabitModel(id: '4', name:  'Read Book', category:  Category.MIND, quantity:  30, interval:  HabitInterval.WEEKEND, dateCreated: DateTime.now()),
  HabitModel(id: '5',name:'Long Drive', category:  Category.MIND, quantity:  20, interval:  HabitInterval.WEEKEND, dateCreated:  DateTime.now()),
];

class HabitsListDummySource {

List<HabitModel> getAllHabits()
{
return allHabits;
}

void updateList(List<HabitModel> list)
{
  allHabits  = [...list];
}


}