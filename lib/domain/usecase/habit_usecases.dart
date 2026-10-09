import 'package:habix/core/utilities/enums.dart';
import 'package:habix/data/repositories/habits_repository_imp.dart';
import 'package:habix/domain/models/Habit.dart';

class HabitUsecases {

  final HabitRepositoryImpl _habitRepositoryImpl = HabitRepositoryImpl();

  Future<List<Habit>> getAllHabitsOnDate(DateTime dateTime) async
  {
    final list = await _habitRepositoryImpl.getAllHabits();

    return list.where(
      
          (h) {
            if( h.interval== HabitInterval.DAILY)
            {
              return true;
            }
            
            else if( h.interval== HabitInterval.WEEKDAYS && dateTime.weekday<=5 )
            {
              return true;
            }

            else if( h.interval== HabitInterval.WEEKEND && dateTime.weekday>5 )
            {
              return true;
            }

            return false;
            
          }
    ).toList();
  }

  Future<List<Habit>> getAllHabits() async
  {
    return await _habitRepositoryImpl.getAllHabits();
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

  void decrementProgress(Habit habit) {
    _habitRepositoryImpl.decrementProgress(habit);
  }

  void markAsComplete(Habit habit) {
    _habitRepositoryImpl.markAsComplete(habit);

  }
}