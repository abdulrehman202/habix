import 'package:uuid/uuid.dart';

enum Category{
  ALL,
  MORNING,
  HEALTH,
  MIND,
  PRODUCTIVITY,
  OTHER
}

enum Interval{
  DAILY,
  WEEKDAYS,
  WEEKEND,
}

var uuid = Uuid();

class Habit  {
  String id = uuid.v4();
String name;
Category category;
int quantity;
int progress = 0;
Interval interval;
int streaks = 0;
DateTime time;

Habit(this.name, this.category, this.quantity,this.interval,this.time);

String descriptionDetail() {
  return '$quantity Repititons';
}
  
}

class WaterHabit extends Habit
{
  WaterHabit(super.name, super.category, super.quantity, super.interval,super.time);
  
  @override
  String descriptionDetail() {
    return '${super.quantity} glass of water';
  }
}

class RegularHabit extends Habit{
  RegularHabit(super.name, super.category, super.quantity, super.interval,super.time);
  
  @override
  String descriptionDetail() {
    return '${super.quantity} minutes';
  }
}

class ReadingHabit extends Habit
{
  ReadingHabit(super.name, super.category, super.quantity, super.interval,super.time);
  
  @override
  String descriptionDetail() {
    return '${super.quantity} pages';
  }
}

class HabitBucket{
  Category category;
  List<Habit> list;

  HabitBucket.filter(this.category,List<Habit> all): list = all.where((h)=>h.category == category).toList();
}

extension example on Habit{

  String get editedDescription{
    return '${descriptionDetail()} is edited';
  }

}