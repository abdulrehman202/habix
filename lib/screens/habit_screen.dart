import 'package:chips_choice/chips_choice.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:habix/models/Habit.dart';
import 'package:habix/providers/habit_category.dart';
import 'package:habix/providers/habits_list.dart';
import 'package:habix/providers/new_habit.dart';
import 'package:habix/screens/new_habit.dart';
import 'package:habix/screens/widgets/epmty_list_widget.dart';
import 'package:habix/screens/widgets/habit_list_tile.dart';
import 'package:habix/utilities/image_paths.dart';
import 'package:habix/utilities/extensions.dart';

class AllHabits extends ConsumerStatefulWidget {
  const AllHabits({super.key});

  @override
  ConsumerState<AllHabits> createState() => _AllHabitsState();
}

class _AllHabitsState extends ConsumerState<AllHabits> with SingleTickerProviderStateMixin{
  Category? _selectedCategory = Category.ALL;
  late AnimationController _animationController;
  

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  precacheImage( AssetImage( emptyListPlaceholder), context);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _animationController = AnimationController(vsync: this,
    duration: Duration(milliseconds: 300),

    );

    _animationController.forward();
  }


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
            scrollToSelectedOnChanged: true,
            clipBehavior: Clip.none,
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
               child: habits.isEmpty?
               EmptyListWidget()
               : Container(
                margin: EdgeInsets.symmetric(horizontal: 10),
                 child: ListView.separated(
                  physics: ScrollPhysics(),
                  separatorBuilder: (context, index) => Divider(),
                  shrinkWrap: true,
                  itemCount: habits.length,
                  itemBuilder: (context, index)=> AnimatedBuilder(
                    animation: _animationController,
                    child: HabitTile(
                          onHabitSelected: (){
                            ref.read(newHabitCategoryProvider.notifier).changeCategorySelection(habits[index].category);
                            ref.read(newHabitIntervalProvider.notifier).changeIntervalSelection(habits[index].interval);
                            Navigator.push( context, MaterialPageRoute(builder: (ctx)=>NewHabit(habit: habits[index],)));},
                          habit: habits[index]),
                    builder: (context, child) {
                      return Padding(
                        padding: EdgeInsetsGeometry.only(top: 100 - _animationController.value*100),
                        child: child,
                      );
                    }
                  )),
               ),
             )
          
        ],
      ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _animationController.dispose();
    super.dispose();
  }
}