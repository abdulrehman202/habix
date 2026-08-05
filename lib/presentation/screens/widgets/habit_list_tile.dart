import 'package:flutter/material.dart';
import 'package:habix/core/utilities/enums.dart';
import 'package:habix/domain/models/Habit.dart';

Map<Category, IconData> icons = {
  Category.MORNING: Icons.wb_sunny_sharp,
  Category.MIND: Icons.question_mark_sharp,
  Category.HEALTH: Icons.health_and_safety_outlined,
  Category.PRODUCTIVITY: Icons.rocket_launch_rounded,
  Category.OTHER: Icons.dehaze_outlined,
};

Map<Category, Color> iconsColor = {
  Category.MORNING:  Colors.blue,
  Category.MIND: Colors.purple,
  Category.HEALTH: Colors.green,
  Category.PRODUCTIVITY: Colors.red,
  Category.OTHER: Colors.orange,
}; 

class HabitTile extends StatelessWidget {
  Habit habit;
  VoidCallback onHabitSelected;
  HabitTile({super.key,required this.habit, required this.onHabitSelected});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onHabitSelected,
      leading: Container(
            
            padding: EdgeInsets.all(10.0),
            decoration: BoxDecoration(
    shape: BoxShape.circle,
    color: iconsColor[habit.category]!.withValues(alpha: 0.5)
            ),
          width: 50,
            child: Icon( icons[habit.category])),
      trailing: _trailingWidget(habit.streaks),
      title: Text(habit.name),
      subtitle: Text(habit.descriptionDetail(),
    ));
  }
  
  _trailingWidget(int streaks) 
  {
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(habit.streaks.toString()),
          Text('Streaks',style: TextStyle(fontWeight: FontWeight.bold),)
        ],
      ),
      SizedBox(width: 3,),
      Icon(Icons.arrow_forward_ios_rounded),
    ],
  );
  }
}