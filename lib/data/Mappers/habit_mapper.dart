import 'package:habix/data/model/habit_model.dart';
import 'package:habix/domain/entity/Habit.dart';
import 'package:material_ui/material_ui.dart';

HabitModel toHabitModel(Habit habit)
{
  String xHour = habit.reminderTime.hour.toString();
  String xMinute = habit.reminderTime.minute.toString();
  return HabitModel(id: habit.id, name: habit.name, category: habit.category, quantity: habit.quantity, interval: habit.interval, reminderHour: xHour, reminderMinute: xMinute,  dateCreated: habit.dateCreated,);
}

Habit toHabit(HabitModel habitModel)
{
  TimeOfDay xTimeOfDay = TimeOfDay(hour: int.parse(habitModel.reminderHour), minute: int.parse(habitModel.reminderMinute));
  return Habit(id: habitModel.id, name: habitModel.name, category: habitModel.category, quantity: habitModel.quantity, interval: habitModel.interval, reminderTime: xTimeOfDay ,dateCreated: habitModel.dateCreated,);
}