import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:habix/providers/habits_list.dart';
import 'package:habix/utilities/constants.dart';
import 'package:habix/models/Habit.dart';
import 'package:habix/screens/widgets/habit_list_tile.dart';
import 'package:table_calendar/table_calendar.dart';

class HabitDetail extends ConsumerStatefulWidget {
  Habit habit;
  HabitDetail({super.key, required this.habit});

  @override
  ConsumerState<HabitDetail> createState() => _HabitDetailState();
}

class _HabitDetailState extends ConsumerState<HabitDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Center(child: Text('Habit Detail')),
      ),
      body:  LayoutBuilder(
        builder: (context, constraints)
        {
          return constraints.maxWidth>maxScreenSizeInPortraitMode?_landscape():_portrait();
        }),
    );
  }

  Widget _landscape()
  {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10,),
      child: Row(
        children: [
          Expanded(child: 
          SingleChildScrollView(
            child: Column(
              children: [
                _iconHeading(),
            SizedBox(height: 10,),
            Text(widget.habit.name,style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),),
            Text(widget.habit.descriptionDetail() ,),
            Align(
              alignment: Alignment.bottomLeft,
              child: Text('Overview',style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),)),
              _overviewCard(),
              SizedBox(height: 10,),
            
              ],
            ),
          )
          ),
          SizedBox(width: 20,),
          Expanded(child: SingleChildScrollView(
            child: Column(
              children: [
                Align(
              alignment: Alignment.bottomLeft,
              child: Text('Streak Calendar',style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),)),
              TableCalendar(
                headerStyle: HeaderStyle(
                  formatButtonVisible: false
                ),
                focusedDay: DateTime.now(), firstDay: DateTime.now().subtract(Duration(days: 900)), lastDay: DateTime.now().add(Duration(days: 900))),
            
            SizedBox(height: 20,),
            _button(),
            SizedBox(height: 20,),
            
              ],
            ),
          )),
          
            
        ],
      ),
    );
  }

  Widget _portrait()
  {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10,),
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 20,),
            _iconHeading(),
            SizedBox(height: 10,),
            Text(widget.habit.name,style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),),
            Text(widget.habit.descriptionDetail(),),
            Align(
              alignment: Alignment.bottomLeft,
              child: Text('Overview',style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),)),
              _overviewCard(),
              SizedBox(height: 10,),
              Align(
              alignment: Alignment.bottomLeft,
              child: Text('Streak Calendar',style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),)),
              SizedBox(height: 10,),
              TableCalendar(
                headerStyle: HeaderStyle(
                  formatButtonVisible: false
                ),
                focusedDay: DateTime.now(), firstDay: DateTime.now().subtract(Duration(days: 900)), lastDay: DateTime.now().add(Duration(days: 900))),
            
            SizedBox(height: 20,),
            _button(),
            SizedBox(height: 20,)
              
          ],
        ),
      ),
    );
  }

  Widget _button()
  {
    return SizedBox(
      width: double.infinity,
      height: 60,
      child: FilledButton(
        style: FilledButton.styleFrom(
          backgroundColor: iconsColor[widget.habit.category]!.withValues(alpha: 0.4)
        ),
        onPressed:(){
          ref.read(habitsListProvider.notifier)
                                        .markAsComplete(
                                          widget.habit
                                        );
                              Navigator.pop(context);

        },
        child: Text(
          'Mark as done',
        ),
      ),
    );
  }
  
  Widget _overviewCard()
  {
    return Card(
      elevation: 3,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical:  18.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(child: _infoCard('Streak', '10')),
                      Expanded(child: _infoCard('Best Streak', '24')),
                    ],
                  ),
                  SizedBox(height: 40,),
                  Row(
                    children: [
                      Expanded(child: _infoCard('Success Rate', '85%')),
                      Expanded(child: _infoCard('Total Completion', '18')),
                    ],
                  ),
                ],
              ),
            )
          );
  }
  Widget _infoCard(String heading, String info)
  {
    return Column(
      children: [
        Text(info,style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),),
        Text(heading,style: TextStyle(fontSize: 15), ),
      ],
    );
  }

  Widget _iconHeading()
  {

    return Container(
      width: 100,
      height: 100,
      decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    shape: BoxShape.rectangle,
                                    color: iconsColor[widget.habit.category]!.withValues(alpha: 0.2),
                                  ),
                                  child: Icon(icons[widget.habit.category], size: 50,),
    );
  }
}