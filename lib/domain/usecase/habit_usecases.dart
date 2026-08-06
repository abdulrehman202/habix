import 'package:habix/data/repositories/habits_repository_imp.dart';
import 'package:habix/domain/models/Habit.dart';

class HabitUsecases {

  final HabitRepositoryImpl _habitRepositoryImpl = HabitRepositoryImpl();

  List<Habit> getAllHabitsOnDate(DateTime dateTime)
  {
    return _habitRepositoryImpl.getAllHabitsOnDate(dateTime);
  }

  List<Habit> getAllHabits()
  {
    return _habitRepositoryImpl.getAllHabits();
  }

  void addHabit(Habit habit)
  {
    return _habitRepositoryImpl.addHabit(habit);
  }

  void updateHabit(Habit habit) {
    _habitRepositoryImpl.updateHabit(habit);
  }

  void incrementProgress(Habit habit) {
    _habitRepositoryImpl.incrementProgress(habit);
  }
}