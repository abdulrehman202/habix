import 'package:flutter/material.dart';
import 'package:habix/models/Habit.dart';

Map<Category, IconData> icons = {
  Category.MORNING: Icons.wb_sunny_sharp,
  Category.MIND: Icons.question_mark_sharp,
  Category.HEALTH: Icons.health_and_safety_outlined,
  Category.PRODUCTIVITY: Icons.rocket_launch_rounded,
  Category.OTHER: Icons.dehaze_outlined,
};

Map<Category, Color> iconsColor = {
  Category.MORNING: Colors.amberAccent,
  Category.MIND: const Color.fromARGB(255, 135, 205, 237),
  Category.HEALTH: const Color.fromARGB(255, 222, 148, 236),
  Category.PRODUCTIVITY: Colors.blueGrey,
  Category.OTHER: const Color.fromARGB(255, 122, 137, 224),
}; 

class HabitTile extends StatelessWidget {
  Habit habit;
  HabitTile({super.key,required this.habit});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
      Container(
        
        padding: EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: iconsColor[habit.category]
        ),
      width: 50,
        child: Icon( icons[habit.category])),
        Expanded(
          child: ListTile(
            trailing: _trailingWidget(habit.streaks),
            title: Text(habit.name),
            subtitle: Text(habit.description,
          )),
        ),
      ],
    );
  }
  
  _trailingWidget(int streaks) 
  {
    return Row(
      mainAxisSize: MainAxisSize.min,
    children: [
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(habit.streaks.toString()),
          Text('Streaks',style: TextStyle(fontWeight: FontWeight.bold),)
        ],
      ),
      SizedBox(width: 10,),
      Icon(Icons.arrow_forward_ios_rounded),
    ],
  );
  }
}