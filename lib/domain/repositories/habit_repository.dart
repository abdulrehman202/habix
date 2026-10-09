import 'package:habix/core/Error/Result.dart';
import 'package:habix/domain/models/Habit.dart';

abstract class HabitRepository {

  Future<Result<List<Habit>>> getAllHabits();
  void addHabit(Habit habit);
  void removeHabit(Habit habit);
  void updateHabit(Habit habit);
  void incrementProgress(Habit habit);
  void decrementProgress(Habit habit);
  void markAsComplete(Habit habit);
}