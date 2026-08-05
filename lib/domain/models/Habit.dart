import 'package:habix/core/utilities/enums.dart';

class Habit  {
  String id;
String name;
Category category;
int quantity;
int progress = 0;
HabitInterval interval;
int streaks = 0;
DateTime dateCreated;
DateTime? dateFinished;

Habit( {required this.id, required this.name, required this.category, required this.quantity,required this.interval,required this.dateCreated});

String descriptionDetail() {
  return '$quantity Repititons';
}
  
}

// class WaterHabit extends Habit
// {
//   WaterHabit(super.name, super.category, super.quantity, super.interval,super.dateCreated);
  
//   @override
//   String descriptionDetail() {
//     return '${super.quantity} glass of water';
//   }
// }

// class RegularHabit extends Habit{
//   RegularHabit(super.name, super.category, super.quantity, super.interval,super.dateCreated);
  
//   @override
//   String descriptionDetail() {
//     return '${super.quantity} minutes';
//   }
// }

// class ReadingHabit extends Habit
// {
//   ReadingHabit(super.name, super.category, super.quantity, super.interval,super.dateCreated);
  
//   @override
//   String descriptionDetail() {
//     return '${super.quantity} pages';
//   }
// }

class HabitBucket{
  Category category;
  List<Habit> list;

  HabitBucket.filter(this.category,List<Habit> all): list = all.where((h)=>h.category == category).toList();
}

// extension example on Habit{

//   String get editedDescription{
//     return '${descriptionDetail()} is edited';
//   }

// }