import 'package:habix/data/model/habit_model.dart';
import 'package:habix/data/repositories/habits_repository_imp.dart';
import 'package:habix/domain/models/Habit.dart';

class HabitUsecases {

  final HabitRepositoryImpl _habitRepositoryImpl = HabitRepositoryImpl();

  List<HabitModel> getAllHabitsOnDate(DateTime dateTime)
  {
    return _habitRepositoryImpl.getAllHabitsOnDate(dateTime);
  }

  List<HabitModel> getAllHabits()
  {
    return _habitRepositoryImpl.getAllHabits();
  }

  void addHabit(HabitModel habit)
  {
    return _habitRepositoryImpl.addHabit(habit);
  }

  void updateHabit(HabitModel habit) {
    _habitRepositoryImpl.updateHabit(habit);
  }
}