import 'package:flutter_riverpod/legacy.dart';

class ProgressNotifier extends StateNotifier<int>{

  ProgressNotifier():super(0);
  
  void increment ()=>state++;
  void decrement ()=>state--;

}

final progressProvider = StateNotifierProvider<ProgressNotifier, int>((ref){

return ProgressNotifier();

});

class DateNotifier extends StateNotifier<DateTime>{

  DateNotifier():super(DateTime.now());
  
  void changeDate (DateTime newDate){
    state = newDate;
  }
}

final dateProvider = StateNotifierProvider<DateNotifier, DateTime>((ref){

return DateNotifier();

});