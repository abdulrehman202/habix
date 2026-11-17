import 'dart:async';

import 'package:flutter_riverpod/legacy.dart';
import 'package:habix/core/Error/Result.dart';
import 'package:habix/domain/entity/Habit.dart';
import 'package:habix/domain/usecase/habit_usecases.dart';
import 'package:habix/domain/usecase/user_auth_usecases.dart';
import 'package:habix/main.dart';

Map<String, dynamic> todaysScreenVariables = {
  'habits_list': [],
  'selected_date': DateTime.now(),
  'data_loading': false,
};

class TodayScreenNotifier extends StateNotifier<Map<String, dynamic>> {
  final HabitUsecases _habitUsecases;
  final UserAuthUsecases _userAuthUsecases;
  final _timers = {};
  final _pendings = {};

  TodayScreenNotifier(this._habitUsecases, this._userAuthUsecases)
    : super({
        'habits_list': [],
        'progress_list': {},
        'selected_date': DateTime.now(),
        'data_loading': false,
      }) {
    fetchInitialHabitsList();
  }

  fetchInitialHabitsList() async {
    state = {...state, 'data_loading': true};

    final list = await _habitUsecases.getAllHabitsOnDate(DateTime.now());
    Result progressResult = await _habitUsecases.getAllProgressOfDate(
      DateTime.now(),
    );
    Map<String, int> progress = {};
    progress = progressResult is Ok
        ? progressResult.value
        : list.map((e) => MapEntry(e.id, 0)) as Map<String, int>;

    state = {
      ...state,
      'data_loading': false,
      'habits_list': list,
      'progress_list': progress,
    };
  }

  void changeDate(DateTime newDate) {
    state = {...state, 'selected_date': newDate};
  }

  Future<void> updateList(DateTime dateTime) async {
    final list = await _habitUsecases.getAllHabitsOnDate(dateTime);
    state = {...state, 'habits_list': list};
  }

  Future<bool> incrementProgress(Habit habit) async {
    
    final currentProgress = state['progress_list'];
    currentProgress[habit.id] = (currentProgress[habit.id] ?? 0) + 1;

    state = {...state, 'progress_list': currentProgress};
    _pendings[habit.id] = _pendings[habit.id] ??0;
    _pendings[habit.id]++;
    _timers[habit.id] = _timers[habit.id] ?? Timer(Duration(seconds: 5), ()async{
      print('this function ran after 5 seconds ith value ${_pendings[habit.id]} for habit ${habit.id}');
      await _callServer(habit.id,_pendings[habit.id]);
    });
    

    return state['progress_list'][habit.id] == habit.quantity;
  }

  _callServer(String id, int count) async
  {
    Result result = await _habitUsecases.incrementProgress(id, count);

       if (result is Error) {
      final currentProgress = state['progress_list'];
      currentProgress[id] = (currentProgress[id] ?? 0) - _pendings[id];
      _pendings[id] = 0;
      _timers[id] = null;

      state = {...state, 'progress_list': currentProgress};
    }

  }

  void decrementProgress(Habit habit) async {
    
    final currentProgress = state['progress_list'];
    currentProgress[habit.id] = (currentProgress[habit.id] ?? 0) - 1;

    state = {...state, 'progress_list': currentProgress};
    _pendings[habit.id] = _pendings[habit.id] ??0;
    _pendings[habit.id]--;
    _timers[habit.id] = _timers[habit.id] ?? Timer(Duration(seconds: 5), ()async{
      print('this function ran after 5 seconds ith value ${_pendings[habit.id]} for habit ${habit.id}');
       await _callServer(habit.id,_pendings[habit.id]);

       
    });
  }

  void markAsComplete(Habit habit) {
    // _habitUsecases.markAsComplete(habit);
    // List<Habit> l = state['habits_list'];
    // int index = l.indexOf(habit);
    // // l[index].progress = l[index].quantity;
    // l[index].dateFinished = DateTime.now();
    // state={...state,'habits_list':l};
  }

  void toggle() {
    bool currentState = state['data_loading'];
    state = {...state, 'data_loading': !currentState};
  }

  Future<bool> logout() async {
    toggle();
    Result<bool> result = await _userAuthUsecases.logOut();

    toggle();
    return result is Ok;
  }

  
}

final todaysScreenProvider =
    StateNotifierProvider<TodayScreenNotifier, Map<String, dynamic>>((ref) {
      return TodayScreenNotifier(
        getIt<HabitUsecases>(),
        getIt<UserAuthUsecases>(),
      );
    });
