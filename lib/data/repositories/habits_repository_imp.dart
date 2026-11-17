import 'package:habix/core/Error/Failures.dart';
import 'package:habix/core/Error/Result.dart';
import 'package:habix/data/Mappers/habit_mapper.dart';
import 'package:habix/data/datasource/habit/local_datasource.dart';
import 'package:habix/data/datasource/habit/remote_datasource.dart';
import 'package:habix/data/model/habit_model.dart';
import 'package:habix/domain/entity/Habit.dart';
import 'package:habix/domain/repositories/habit_repository.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: HabitRepository)
class HabitRepositoryImpl implements HabitRepository {
  final HabitLocalDataSource _habitsListLocalSource;
  final HabitRemoteDataSource _habitsListRemoteSource;
  HabitRepositoryImpl(this._habitsListLocalSource, this._habitsListRemoteSource);
  @override
  Future<Result<bool>> addHabit(Habit habit) async{
    try{HabitModel habitModel = toHabitModel(habit);
    List<HabitModel> list = await _habitsListRemoteSource.addHabit(habitModel);
   
     _habitsListLocalSource.addToCache({'list':list});
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
      _habitsListLocalSource.addToCache({'list':list});
      }

      return Result.ok( list.map((item) => toHabit(item)).toList());
    }catch (e) {
      
      return Result.error(e as Failure);
    }
  }

  @override
  Future<Result<bool>> removeHabit(String habitId) async {
    // TODO: implement removeHabit

    try{
      List<HabitModel> list = await _habitsListRemoteSource.removeHabit(habitId);
   
      _habitsListLocalSource.addToCache( {'list':list});
    return Result.ok(true);
    }
    catch(e)
    {
      return Result.error(e as Failure);
    }
  }

  @override
    Future<Result<bool>> updateHabit(Habit habit)async {
    // TODO: implement updateHabit
     try{
      HabitModel habitModel = toHabitModel(habit);
      List<HabitModel> list = await _habitsListRemoteSource.updateHabit(habitModel);
   
      _habitsListLocalSource.addToCache({'list':list});
    return Result.ok(true);
    }
    catch(e)
    {
      return Result.error(e as Failure);
    }
  }

  @override
  Future<Result<bool>> incrementProgress(String habitId,int count) async {
    try{
      
      bool success = await _habitsListRemoteSource.incrementProgress(habitId,count);
   
    return Result.ok(success);
    }
    catch(e)
    {
      return Result.error(e as Failure);
    }
  }

  @override
  Future<Result<bool>> decrementProgress(String habitId) async {
    try{
      
      bool success = await _habitsListRemoteSource.decrementProgress(habitId);
   
    return Result.ok(success);
    }
    catch(e)
    {
      return Result.error(e as Failure);
    }
  }

  @override
  Future<Result<Map<String, int>>> getAllProgressOfDate(DateTime dateTime) async {
    // TODO: implement getAllProgressOfDate
    try {
      Map<String, int> progress = {};
      try {
        // list = await _habitsListLocalSource.getAllHabits();
        progress = await _habitsListRemoteSource.getAllProgress();
        
      } catch (_) {
        // progress = await _habitsListRemoteSource.getAllProgress();
      // _habitsListLocalSource.addToCache({'list':list});
      }

      return Result.ok( progress);
    }catch (e) {
      
      return Result.error(e as Failure);
    }
  }
}
