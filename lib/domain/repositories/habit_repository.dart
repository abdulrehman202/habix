import 'package:habix/data/model/habit_model.dart';

abstract class HabitRepository {

  List<HabitModel> getAllHabits();
  void addHabit(HabitModel habit);
  void removeHabit(HabitModel habit);
  void updateHabit(HabitModel habit);
  List<HabitModel> getAllHabitsOnDate(DateTime dateTime);
}