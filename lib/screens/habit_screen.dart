import 'package:chips_choice/chips_choice.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:habix/models/Habit.dart';
import 'package:habix/providers/habit_category.dart';
import 'package:habix/providers/habits_list.dart';
import 'package:habix/providers/new_habit.dart';
import 'package:habix/screens/new_habit.dart';
import 'package:habix/screens/widgets/habit_list_tile.dart';

extension abc on String{

  get capitalize {
    return this[0].toUpperCase() + substring(1).toLowerCase();
  }
}

class AllHabits extends ConsumerStatefulWidget {
  const AllHabits({super.key});

  @override
  ConsumerState<AllHabits> createState() => _AllHabitsState();
}

class _AllHabitsState extends ConsumerState<AllHabits> {
  Category? _selectedCategory = Category.ALL;
  @override
  Widget build(BuildContext context) {
    _selectedCategory = ref.watch(habitsCategoryProvider);
    List<Habit> habits = ref.watch(categorizedlist);

    return Scaffold(
      appBar: AppBar(title: Text('All Habits'), automaticallyImplyLeading: false,),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          ChipsChoice<Category>.single(
            padding: EdgeInsets.zero,
            choiceStyle: C2ChipStyle.filled(
          color: Colors.white,
          selectedStyle:  C2ChipStyle(
            foregroundColor: Colors.white,
            backgroundColor:  Theme.of(context).colorScheme.primary,
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
          ),
        ),
            choiceItems: Category.values.map((element)=>C2Choice(value: element, label: element.name.capitalize)).toList(),
            value: _selectedCategory, onChanged: (category)=>ref.read(habitsCategoryProvider.notifier).changeCategory(category)),
      
             Expanded(
               child: Container(
                margin: EdgeInsets.symmetric(horizontal: 10),
                 child: ListView.separated(
                  physics: ScrollPhysics(),
                  separatorBuilder: (context, index) => Divider(),
                  shrinkWrap: true,
                  itemCount: habits.length,
                  itemBuilder: (context, index)=> HabitTile(
                    onHabitSelected: (){
                      ref.read(newHabitCategoryProvider.notifier).changeCategorySelection(habits[index].category);
                      ref.read(newHabitIntervalProvider.notifier).changeIntervalSelection(habits[index].interval);
                      Navigator.push( context, MaterialPageRoute(builder: (ctx)=>NewHabit(habit: habits[index],)));},
                    habit: habits[index])),
               ),
             )
          
        ],
      ),
    );
  }
}