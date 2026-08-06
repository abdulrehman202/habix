import 'package:habix/domain/models/Habit.dart';

abstract class HabitRepository {

  List<Habit> getAllHabits();
  void addHabit(Habit habit);
  void removeHabit(Habit habit);
  void updateHabit(Habit habit);
  List<Habit> getAllHabitsOnDate(DateTime dateTime);
  void incrementProgress(Habit habit);
}