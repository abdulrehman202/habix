import 'package:habix/data/model/habit_model.dart';
import 'package:habix/domain/models/Habit.dart';

HabitModel toHabitModel(Habit habit)
{
  return HabitModel(id: habit.id, name: habit.name, category: habit.category, quantity: habit.quantity, interval: habit.interval, dateCreated: habit.dateCreated);
}

Habit toHabit(HabitModel habitModel)
{
  return Habit(id: habitModel.id, name: habitModel.name, category: habitModel.category, quantity: habitModel.quantity, interval: habitModel.interval, dateCreated: habitModel.dateCreated);
}