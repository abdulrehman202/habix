import 'package:habix/core/Error/Failures.dart';
import 'package:habix/core/Error/Result.dart';
import 'package:habix/data/Mappers/mapper.dart';
import 'package:habix/data/datasource/habit/local_datasource.dart';
import 'package:habix/data/datasource/habit/remote_datasource.dart';
import 'package:habix/data/model/habit_model.dart';
import 'package:habix/domain/models/Habit.dart';
import 'package:habix/domain/repositories/habit_repository.dart';

class HabitRepositoryImpl implements HabitRepository {
  final HabitLocalDataSource _habitsListLocalSource = HabitLocalDataSource();
  final HabitRemoteDataSource _habitsListRemoteSource = HabitRemoteDataSource();

  @override
  Future<Result<bool>> addHabit(Habit habit) async{
    try{HabitModel habitModel = toHabitModel(habit);
    List<HabitModel> list = await _habitsListRemoteSource.addHabit(habitModel);
   
      _habitsListLocalSource.addToCache('allHabitsList', {'list':list});
    return Result.ok(true);
    }
    catch(e)
    {
      return Result.error(e as Failure);
    }
  }

  @override
  Future<Result<List<Habit>>> getAllHabits() async {
    try {
      List<HabitModel> list = [];
      try {
        list = await _habitsListLocalSource.getAllHabits();
        
      } catch (_) {
        list = await _habitsListRemoteSource.getAllHabits();
      _habitsListLocalSource.addToCache('allHabitsList', {'list':list});
      }

      return Result.ok( list.map((item) => toHabit(item)).toList());
    }catch (e) {
      
      return Result.error(e as Failure);
    }
  }

  @override
  void removeHabit(Habit habit) {
    // TODO: implement removeHabit
  }

  @override
  void updateHabit(Habit habit) {
    // TODO: implement updateHabit
    // HabitModel habitModel = toHabitModel(habit);
    // final l = _habitsListLocalSource.getAllHabits();
    // final index = l.indexWhere((h)=>h.id==habitModel.id);
    // l[index] = habitModel;
    // _habitsListLocalSource.updateList(l);
  }

  @override
  void incrementProgress(Habit habit) {
    // TODO: implement incrementProgress
    // HabitModel habitModel = toHabitModel(habit);
    // List<HabitModel> l = _habitsListLocalSource.getAllHabits();
    // int index = l.indexWhere( (hm)=> hm.id == habitModel.id);
    // l[index].progress++;
    // if(l[index].progress == l[index].quantity)
    // {
    //   l[index].dateFinished = DateTime.now();
    // }
    // _habitsListLocalSource.updateList(l);
  }

  @override
  void decrementProgress(Habit habit) {
    //  HabitModel habitModel = toHabitModel(habit);
    //   List<HabitModel> l = _habitsListLocalSource.getAllHabits();
    //   int index = l.indexWhere( (hm)=> hm.id == habitModel.id);
    //   l[index].progress--;

    //   _habitsListLocalSource.updateList(l);
  }

  @override
  void markAsComplete(Habit habit) {
    //  HabitModel habitModel = toHabitModel(habit);
    //   List<HabitModel> l = _habitsListLocalSource.getAllHabits();
    //   int index = l.indexWhere( (hm)=> hm.id == habitModel.id);
    //   l[index].progress = l[index].quantity;

    //   _habitsListLocalSource.updateList(l);
  }
}
