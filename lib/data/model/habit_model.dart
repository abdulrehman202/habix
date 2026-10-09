import 'package:habix/core/utilities/enums.dart';
import 'package:habix/data/datasource/habit/remote_datasource.dart';

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

HabitModel({required this.id, required this.name, required this.category, required this.quantity,this.progress=0, required this.interval,this.streaks=0, required this.dateCreated});

factory HabitModel.fromJson(Map<String, dynamic> json) {
    return HabitModel(
      id:json["id"],
      name: json["name"], 
      category: catMap[json["category"]] as Category,
      quantity: json["quantity"],
      progress: json["progress"],
      interval: intervalMap[json["interval"]] as HabitInterval,
      dateCreated: DateTime.fromMillisecondsSinceEpoch(1791445698546),
      streaks: json["streaks"]
    );
  }
}