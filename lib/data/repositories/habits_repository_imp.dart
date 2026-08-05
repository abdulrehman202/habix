import 'package:habix/core/utilities/enums.dart';
import 'package:habix/data/Mappers/mapper.dart';
import 'package:habix/data/datasource/habits_list_dummy_source.dart';
import 'package:habix/data/model/habit_model.dart';
import 'package:habix/domain/models/Habit.dart';
import 'package:habix/domain/repositories/habit_repository.dart';

class HabitRepositoryImpl implements HabitRepository{

  final HabitsListDummySource _habitsListDummySource = HabitsListDummySource();
  @override
  void addHabit(Habit habit) {
    // TODO: implement addHabit
    HabitModel habitModel = toHabitModel(habit);
    _habitsListDummySource.allHabits.add(habitModel);
  }

  @override
  List<Habit> getAllHabits() {
    // TODO: implement getAllHabits
    List<HabitModel> list = _habitsListDummySource.allHabits;
    return  list.map((item)=> toHabit(item) ).toList();
  }

  @override
  List<Habit> getAllHabitsOnDate(DateTime dateTime) {

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

    return todaysHabit.map((item) => toHabit(item)).toList();
  }

  @override
  void removeHabit(Habit habit) {
    // TODO: implement removeHabit
  }

  @override
  void updateHabit(Habit habit) {
    // TODO: implement updateHabit
    HabitModel habitModel = toHabitModel(habit);
    final l = _habitsListDummySource.allHabits;
    final index = l.indexWhere((h)=>h.id==habitModel.id);
    l[index] = habitModel;
    _habitsListDummySource.allHabits = l;
  }
}