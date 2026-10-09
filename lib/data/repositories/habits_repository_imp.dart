import 'package:dio/dio.dart';
import 'package:habix/core/Error/ErrorInfo.dart';
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
  void addHabit(Habit habit) {
    // add to database and then cache
    // HabitModel habitModel = toHabitModel(habit);
    // _habitsListLocalSource.getAllHabits().add(habitModel);
  }

  @override
  Future<Result<List<Habit>>> getAllHabits() async {
    try {
      late Map<String, dynamic> resData;
      try {
        resData = await _habitsListLocalSource.getAllHabits();
      } catch (_) {
        final response = await _habitsListRemoteSource.getAllHabits();
        if (response.statusCode == 200) {
          resData = response.data;
          _habitsListLocalSource.addToCache('allHabitsList', resData);
        }
      }

      final decodedJson = resData['allHabitsList'] as List;
      List<HabitModel> list = [];

      for (var listItem in decodedJson) {
        HabitModel habitModel = HabitModel.fromJson(listItem);
        list.add(habitModel);
      }

      return Result.ok( list.map((item) => toHabit(item)).toList());
    } 
    on DioException catch (e) {
      // Safely map raw HTTP / SDK exceptions to your Domain Failures
      final statusCode = e.response?.statusCode;
      return Error(
        ServerFailure(
         statusCode: statusCode,
        ),
      );
    } catch (e) {
      return Error(ServerFailure());
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
