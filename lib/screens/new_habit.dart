import 'package:flutter/material.dart' hide Interval;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:habix/models/Habit.dart';
import 'package:habix/providers/habits_list.dart';
import 'package:habix/providers/new_habit.dart';
import 'package:habix/screens/habit_screen.dart';
import 'package:habix/screens/widgets/habit_list_tile.dart';

class NewHabit extends ConsumerStatefulWidget {
  const NewHabit({super.key});

  @override
  ConsumerState<NewHabit> createState() => _NewHabitState();
}

class _NewHabitState extends ConsumerState<NewHabit> {
  TextEditingController _nameController = TextEditingController(), _descriptionController = TextEditingController();
  Category _category = Category.OTHER;
  Interval _interval = Interval.DAILY;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FilledButton(onPressed: (){ref.read(habitsListProvider.notifier).addHabit(
        Habit(_nameController
        .text, _category, _descriptionController.text, _interval, 0)
      );
      Navigator.pop(context);
      }, child: Text('Add Habit')),
      body: Padding(
        padding: EdgeInsetsGeometry.symmetric(horizontal: 20, vertical: 10),
        child: SingleChildScrollView(
          child: LayoutBuilder(
            builder: (context, constraints) {
              _category = ref.watch(newHabitCategoryProvider);
              _interval = ref.watch(newHabitIntervalProvider);
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextField(
                    controller: _nameController,
                    decoration: InputDecoration(
                      hint: Text('Walk, Drink Water, Yoga'),
                      label: Text('Name'),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                    ),
                  ),
                  SizedBox(height: 10,),
                  TextField(
                    controller: _descriptionController,
                    decoration: InputDecoration(
                      hint: Text('8 glass of water, 30 minute of exercise'),
                      label: Text('Decscription'),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                      
                    ),
                  ),
                  SizedBox(height: 10,),
                  Text('Interval',style: TextStyle(fontWeight: FontWeight.bold),),
                  SizedBox(height: 10,),
                  intervalOption(constraints.maxWidth),
                  SizedBox(height: 10,),
                  Text('Category', style: TextStyle(fontWeight: FontWeight.bold),),
                  SizedBox(height: 10,),
                  categoryOption(constraints.maxWidth),
                  
                ],
              );
            }
          ),
        )
      )
    );
  }
  
  Widget intervalOption(double w) 
  {
    return Row(
      
      children: Interval.values.map((i)=>Expanded(
        child: GestureDetector(onTap: ()=>ref.read(newHabitIntervalProvider.notifier).changeIntervalSelection(i), child: Container(
          alignment: Alignment.center,
          width: w/3,
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
          margin: EdgeInsets.only(right: 10),
          decoration: _interval == i? BoxDecoration(
            border: Border.all(width: 2),
            borderRadius: BorderRadius.circular(10),
            shape: BoxShape.rectangle,
            color: const Color.fromARGB(255, 225, 225, 225)
          ): BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            shape: BoxShape.rectangle,
            color: const Color.fromARGB(255, 225, 225, 225)
          ),
          child: Text(i.name.capitalize, style: TextStyle(fontWeight: _interval == i?FontWeight.bold: FontWeight.normal),))),
      )).toList(),
    ); 
  }
  
  categoryOption(double w) 
  {
    return Wrap(
      alignment: WrapAlignment.start,
      children: Category.values.map((c)=> c!=Category.ALL? Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          GestureDetector(onTap: ()=>ref.read(newHabitCategoryProvider.notifier).changeCategorySelection(c), child: Container(
            width: w/Category.values.length,
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
            margin: EdgeInsets.only(right: 10,bottom: 10),
            decoration: _category == c?   BoxDecoration(
                border:  Border.all(width:2),
              borderRadius: BorderRadius.circular(10),
              shape: BoxShape.rectangle,
            color: const Color.fromARGB(255, 225, 225, 225)
            ):BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              shape: BoxShape.rectangle,
            color: const Color.fromARGB(255, 225, 225, 225)
            ),
            child: Icon(icons[c],))),
        Text(c.name, style: TextStyle(fontSize: 10),)
        ],
      ):Container()).toList(),
    );
  }
}