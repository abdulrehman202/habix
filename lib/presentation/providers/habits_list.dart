import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:habix/utilities/enums.dart';
import 'package:habix/domain/models/Habit.dart';
import 'package:habix/domain/usecase/habit_usecases.dart';
import 'package:habix/presentation/providers/habit_category.dart';
class HabitsListNotifier extends StateNotifier<List<Habit>> {
  final HabitUsecases _habitUsecases = HabitUsecases();

  HabitsListNotifier() : super([]){
    fetchInitialHabitsList();
  }

  fetchInitialHabitsList()async
  {
    state = await _habitUsecases.getAllHabitsOnDate(DateTime.now());
  }

  void addHabit(Habit habit) {
    _habitUsecases.addHabit(habit);
    state = [...state, habit];
  }

  Future<void> updateList(DateTime dateTime) async{
    final list = await _habitUsecases.getAllHabitsOnDate(dateTime);
    state = [...list];
  }

  void updateHabit(Habit habit) {
    _habitUsecases.updateHabit(habit);

    final l = state;
    final index = l.indexWhere((h) => h.id == habit.id);
    l[index] = habit;
    state = l;
  }
}

final habitsListProvider =
    StateNotifierProvider<HabitsListNotifier, List<Habit>>((ref) {
      return HabitsListNotifier();
    });

final categorizedlist = Provider((ref) {
  final chosenCategory = ref.watch(habitsCategoryProvider);
  final ll = ref.watch(habitsListProvider);

  return ll
      .where(
        (h) => chosenCategory == Category.ALL
            ? true
            : h.category == chosenCategory,
      )
      .toList();
});