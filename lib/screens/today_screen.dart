import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:habix/constants.dart';
import 'package:habix/providers/habits_list.dart';
import 'package:habix/screens/habit_detail.dart';
import 'package:habix/screens/new_habit.dart';
import 'package:habix/screens/widgets/habit_list_tile.dart';
import 'package:horizontal_week_calendar/horizontal_week_calendar.dart';

class TodayScreen extends ConsumerStatefulWidget {
  const TodayScreen({super.key});

  @override
  ConsumerState<TodayScreen> createState() => _TodayScreenState();
}

class _TodayScreenState extends ConsumerState<TodayScreen> { 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Good Afternoon Flex,'),
        actions: [
          IconButton(onPressed: (){}, icon: Icon(Icons.notifications_none))
        ],
      ),
      body: LayoutBuilder(
        
        builder: (context, constraints)
        {
          return Container(
            margin: EdgeInsets.symmetric(horizontal: 10),
            child: constraints.maxWidth>maxScreenSizeInPortraitMode?_landscape(): _portrait()
          );
        }),
    );
  }

  Widget _portrait()
  {
    return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Small habits,\nbig changes,',style: TextStyle(

                  fontSize: 30,
                  fontWeight: FontWeight.bold
                ),),
                SizedBox(height: 20,),
                _horizontaCalendar(),
                SizedBox(height: 20,),
                Expanded(
                  child: _habitsList()
                )
              ],
            );
  }
  
  Widget _horizontaCalendar()
  {
    return HorizontalWeekCalendar(
      showTopNavbar: false,
      activeBackgroundColor: Colors.green,
      inactiveBackgroundColor: Colors.grey.withValues(alpha: 0.2),
      inactiveTextColor: Colors.black,
      initialDate: DateTime.now(),
      borderRadius: BorderRadius.circular(15),
      monthColor: Colors.green,
      minDate: DateTime.now().subtract(Duration(days: 720)),
      maxDate: DateTime.now().add(Duration(days: 720)),
      onDateChange: (date) {
    setState(() {
    });
  },
    );
  }
  
  Widget _habitsList() 
  {
    
    final habitsListOnDate = ref.watch(habitsListProvider);
    return ListView.builder(
                    physics: ScrollPhysics(),
                    itemCount: habitsListOnDate.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index)=>Card(
                      elevation: 5,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CheckboxListTile(
                          secondary: GestureDetector(
                            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context)=>HabitDetail(
                              habit: habitsListOnDate[index],
                            ))),
                            child: Container(
                                                    padding: EdgeInsets.all(10.0),
                                    decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: iconsColor[habitsListOnDate[index].category]!.withValues(alpha: 0.5)
                                    ),
                                  width: 50,
                                                    child: Icon( icons[habitsListOnDate[index].category])),
                          ),
                          title: Text(habitsListOnDate[index].name,style: TextStyle(fontWeight: FontWeight.bold),),
                          subtitle: Text(habitsListOnDate[index].description),
                          value: false, onChanged: (isChecked){}),
                      ),
                    ));
  }
  
  Widget _landscape()
  {
    return Row(
      children: [
        Expanded(child: 
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
          Text('Small habits,\nbig changes,',style: TextStyle(

                  fontSize: 30,
                  fontWeight: FontWeight.bold
                ),),
                SizedBox(height: 20,),
                _horizontaCalendar(),
        ],)
        ),
        SizedBox(width: 10,),
        Expanded(child: _habitsList()),
      ],
    );
  }
}