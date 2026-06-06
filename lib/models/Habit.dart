enum Category{
  ALL,
  MORNING,
  HEALTH,
  MIND,
  PRODUCTIVITY,
  OTHER
}

class Habit {
String name;
Category category;
String description;
bool isDaily;
bool onWeekDay;
bool onWeekend;
int streaks;

Habit(this.name, this.category, this.description,this.isDaily, this.onWeekDay, this.onWeekend,this.streaks
);
  
}