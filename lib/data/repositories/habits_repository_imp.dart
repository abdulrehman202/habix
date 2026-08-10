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
    _habitsListDummySource.getAllHabits().add(habitModel);
  }

  @override
  List<Habit> getAllHabits() {
    // TODO: implement getAllHabits
    List<HabitModel> list = _habitsListDummySource.getAllHabits();
    return  list.map((item)=> toHabit(item) ).toList();
  }

  @override
  List<Habit> getAllHabitsOnDate(DateTime dateTime) {

    List<HabitModel> allList = _habitsListDummySource.getAllHabits();
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
    final l = _habitsListDummySource.getAllHabits();
    final index = l.indexWhere((h)=>h.id==habitModel.id);
    l[index] = habitModel;
    _habitsListDummySource.updateList(l);
  }

  @override
  void incrementProgress(Habit habit) {
    // TODO: implement incrementProgress
    HabitModel habitModel = toHabitModel(habit);
    List<HabitModel> l = _habitsListDummySource.getAllHabits();
    int index = l.indexWhere( (hm)=> hm.id == habitModel.id);
    l[index].progress++;
    if(l[index].progress == l[index].quantity)
    {
      l[index].dateFinished = DateTime.now();
    }
    _habitsListDummySource.updateList(l);
  
  }

  @override
  void decrementProgress(Habit habit) {
   HabitModel habitModel = toHabitModel(habit);
    List<HabitModel> l = _habitsListDummySource.getAllHabits();
    int index = l.indexWhere( (hm)=> hm.id == habitModel.id);
    l[index].progress--;
    
    _habitsListDummySource.updateList(l); 
  }

  @override
  void markAsComplete(Habit habit) {    
   HabitModel habitModel = toHabitModel(habit);
    List<HabitModel> l = _habitsListDummySource.getAllHabits();
    int index = l.indexWhere( (hm)=> hm.id == habitModel.id);
    l[index].progress = l[index].quantity;
    
    _habitsListDummySource.updateList(l); 
  }

  
}