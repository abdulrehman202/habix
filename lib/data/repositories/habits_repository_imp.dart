import 'package:habix/core/utilities/enums.dart';
import 'package:habix/data/datasource/habits_list_dummy_source.dart';
import 'package:habix/data/model/habit_model.dart';
import 'package:habix/domain/repositories/habit_repository.dart';
import 'package:habix/domain/usecase/habit_usecases.dart';

class HabitRepositoryImpl implements HabitRepository{

  final HabitsListDummySource _habitsListDummySource = HabitsListDummySource();
  @override
  void addHabit(HabitModel habit) {
    // TODO: implement addHabit

    _habitsListDummySource.allHabits.add(habit);
  }

  @override
  List<HabitModel> getAllHabits() {
    // TODO: implement getAllHabits
    return _habitsListDummySource.allHabits;
  }

  @override
  List<HabitModel> getAllHabitsOnDate(DateTime dateTime) {

    List<HabitModel> allList = _habitsListDummySource.allHabits;
    // TODO: implement getAllHabitsForToday

    List<HabitModel> todaysHabit = allList.where(
      
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

    return todaysHabit;
  }

  @override
  void removeHabit(HabitModel habit) {
    // TODO: implement removeHabit
  }

  @override
  void updateHabit(HabitModel habit) {
    // TODO: implement updateHabit

    final l = _habitsListDummySource.allHabits;
    final index = l.indexWhere((h)=>h.id==habit.id);
    l[index] = habit;
    _habitsListDummySource.allHabits = l;
  }
}