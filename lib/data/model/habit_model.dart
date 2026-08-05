import 'package:habix/core/utilities/enums.dart';

class HabitModel{

  String id;
String name;
Category category;
int quantity;
int progress = 0;
HabitInterval interval;
int streaks = 0;
DateTime dateCreated;
DateTime? dateFinished;

HabitModel({required this.id, required this.name, required this.category, required this.quantity,required this.interval,required this.dateCreated});
}