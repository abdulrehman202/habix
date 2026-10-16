import 'package:habix/utilities/enums.dart';

final Map<String, Category> catMap = {
  'ALL': Category.ALL,
  'MORNING': Category.MORNING,
  'HEALTH': Category.HEALTH,
  'MIND': Category.MIND,
  'PRODUCTIVITY': Category.PRODUCTIVITY,
  'OTHER': Category.OTHER,
};

final Map<String, HabitInterval> intervalMap = {
  'DAILY': HabitInterval.DAILY,
  'WEEKDAYS': HabitInterval.WEEKDAYS,
  'WEEKEND': HabitInterval.WEEKEND,
};
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
      id: json["id"],
      name: json["name"], 
      category: catMap[json["category"]] as Category,
      quantity: json["quantity"],
      progress: json["progress"],
      interval: intervalMap[json["interval"]] as HabitInterval,
      dateCreated: DateTime.fromMillisecondsSinceEpoch(json['dateCreated']),
      streaks: json["streaks"]??0
    );
  }

  Map<String, dynamic> toJson() {
    return{
    "id":id,
    "name":name, 
     'category': category.name,
      "quantity": quantity,
      "progress":progress,
      "interval":interval.name,
      'dateCreated': 1791445698546,
      "streaks":streaks
  };}
}