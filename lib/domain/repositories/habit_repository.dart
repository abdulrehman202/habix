import 'package:habix/core/Error/Result.dart';
import 'package:habix/domain/entity/Habit.dart';

abstract class HabitRepository {

  Future<Result<List<Habit>>> getAllHabits();
  Future<Result<bool>> addHabit(Habit habit);
  Future<Result<bool>> removeHabit(String habitId);
  Future<Result<bool>> updateHabit(Habit habit);
  Future<Result<Map<String, int>>> getAllProgressOfDate(DateTime dateTime);
  Future<Result<bool>> incrementProgress(String habitId,int count);
}