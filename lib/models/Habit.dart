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

class Habit  {
String name;
Category category;
int quantity;
int progress = 0;
Interval interval;
int streaks;

Habit(this.name, this.category, this.quantity,this.interval,this.streaks,);

String descriptionDetail() {
  return '';
}
  
}

class WaterHabit extends Habit
{
  WaterHabit(super.name, super.category, super.quantity, super.interval, super.streaks);
  
  @override
  String descriptionDetail() {
    return '${super.quantity} glass of water';
  }
}

class RegularHabit extends Habit{
  RegularHabit(super.name, super.category, super.quantity, super.interval, super.streaks);
  
  @override
  String descriptionDetail() {
    return '${super.quantity} minutes';
  }
}

class ReadingHabit extends Habit
{
  ReadingHabit(super.name, super.category, super.quantity, super.interval, super.streaks);
  
  @override
  String descriptionDetail() {
    return '${super.quantity} pages';
  }
}