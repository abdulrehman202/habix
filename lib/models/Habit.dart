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

class Habit {
String name;
Category category;
String description;
Interval interval;
int streaks;

Habit(this.name, this.category, this.description,this.interval,this.streaks
);
  
}