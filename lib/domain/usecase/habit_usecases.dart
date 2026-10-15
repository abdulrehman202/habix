import 'package:habix/core/Error/Result.dart';
import 'package:habix/utilities/enums.dart';
import 'package:habix/data/repositories/habits_repository_imp.dart';
import 'package:habix/domain/models/Habit.dart';

class HabitUsecases {
  final HabitRepositoryImpl _habitRepositoryImpl = HabitRepositoryImpl();

  Future<List<Habit>> getAllHabitsOnDate(DateTime dateTime) async {
    Result result = await getAllHabits();
    List<Habit> list = result is Ok ? result.value:[];

      return list.where((h) {
        if (h.interval == HabitInterval.DAILY) {
          return true;
        } else if (h.interval == HabitInterval.WEEKDAYS &&
            dateTime.weekday <= 5) {
          return true;
        } else if (h.interval == HabitInterval.WEEKEND &&
            dateTime.weekday > 5) {
          return true;
        }

        return false;
      }).toList();
  }

  Future<Result<List<Habit>>> getAllHabits() async {
    final result =  await _habitRepositoryImpl.getAllHabits();
    return result;
  }

  Future<Result<bool>> addHabit(Habit habit) async{
     final result = await _habitRepositoryImpl.addHabit(habit);
     return result;
  }

  Future<Result<bool>> updateHabit(Habit habit) async{
    final result = await _habitRepositoryImpl.updateHabit(habit);
     return result;
  }

  Future<Result<bool>> remove(String habitId) async{
    final result = await _habitRepositoryImpl.removeHabit(habitId);
     return result;
  }

  void incrementProgress(Habit habit) {
    _habitRepositoryImpl.incrementProgress(habit);
  }

  void decrementProgress(Habit habit) {
    _habitRepositoryImpl.decrementProgress(habit);
  }

  void markAsComplete(Habit habit) {
    _habitRepositoryImpl.markAsComplete(habit);
  }
}
