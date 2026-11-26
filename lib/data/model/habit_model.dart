import 'package:habix/utilities/enums.dart';

final Map<String, Category> catMap = {
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
HabitInterval interval;
String reminderHour;
String reminderMinute;
int streaks = 0;
DateTime dateCreated;
DateTime? dateFinished;

HabitModel({required this.id, required this.name, required this.category, required this.quantity, required this.interval,required  this.reminderHour,required this.reminderMinute, this.streaks=0, required this.dateCreated});

factory HabitModel.fromJson(Map<String, dynamic> json) {
    return HabitModel(
      id: json["id"],
      name: json["name"], 
      category: catMap[json["category"]] as Category,
      quantity: json["quantity"],
      interval: intervalMap[json["interval"]] as HabitInterval,
      reminderHour: json['hour'],
      reminderMinute: json['minute'],
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
      "interval":interval.name,
      "hour":reminderHour,
      "minute":reminderMinute,
      'dateCreated': 1791445698546,
      "streaks":streaks
  };}
}