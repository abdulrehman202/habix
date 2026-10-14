
import 'package:flutter_riverpod/legacy.dart';
import 'package:habix/core/Error/Result.dart';
import 'package:habix/domain/usecase/habit_usecases.dart';
import 'package:habix/utilities/enums.dart';

class HabitsCategoryNotifier extends StateNotifier<Category>{
  final HabitUsecases _habitUsecases = HabitUsecases();

  HabitsCategoryNotifier():super(Category.ALL);
  
  void changeCategory (Category category){
    state = category;
  }

  Future<bool> deleteHabit(String id)async {
    Result result =  await _habitUsecases.remove(id);
    
    // if(result is Error)
    // {
    //   changeErrorMessage(result.failure.message);
    // }
    return result is Ok;
  }

}

final habitsCategoryProvider = StateNotifierProvider<HabitsCategoryNotifier, Category>((ref){

return HabitsCategoryNotifier();

});