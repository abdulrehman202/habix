import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:habix/constants.dart';
import 'package:habix/providers/habits_list.dart';
import 'package:habix/providers/today_screen.dart';
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
  late DateTime _selectedDate;
  @override
  Widget build(BuildContext context) {
    _selectedDate = ref.watch(dateProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text('Good Afternoon Flex,'),
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.notifications_none)),
        ],
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return Container(
            margin: EdgeInsets.symmetric(horizontal: 10),
            child: constraints.maxWidth > maxScreenSizeInPortraitMode + 220
                ? _landscape()
                : _portrait(),
          );
        },
      ),
    );
  }

  Widget _portrait() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Small habits,\nbig changes,',
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 20),
        _horizontaCalendar(),
        SizedBox(height: 10),
        _dayRow(),
        SizedBox(height: 10),
        
        Expanded(child: _habitsList()),
      ], 
    );
  }
  
  Widget _dayRow()
  {
    return Text(
          '${_selectedDate.day} ${_selectedDate.month.monthInAlphabets} ${_selectedDate.year} ( ${_selectedDate.weekday.dayInAlphabets} )',
          style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
        );
  }
  Widget _horizontaCalendar() {
    return HorizontalWeekCalendar(
      showTopNavbar: false,
      activeBackgroundColor: Colors.blueAccent.withValues(alpha: 0.3),
      inactiveBackgroundColor: Colors.transparent,
      inactiveTextColor: Colors.black,
      activeTextColor: Colors.black,
      initialDate: DateTime.now(),
      borderRadius: BorderRadius.circular(15),
      monthColor: Colors.green,
      minDate: DateTime.now().subtract(Duration(days: 720)),
      maxDate: DateTime.now().add(Duration(days: 720)),
      onDateChange: (date) {
       ref.read(dateProvider.notifier).changeDate(date);
      },
    );
  }

  Widget _habitsList() {
    final list = ref.watch(habitsListProvider);
    final habitsListOnDate = list
        .where(
          (h) =>
              h.time.day == _selectedDate.day &&
              h.time.month == _selectedDate.month &&
              h.time.year == _selectedDate.year,
        )
        .toList();
    return habitsListOnDate.isEmpty?Center(
      child: Column(
        children: [
          Expanded(
            flex: 3,
            child: Image.asset('assets/images/habbit_tracker.jpg',errorBuilder: (context, error, stackTrace) => Container(), fit: BoxFit.fitHeight,)),
          Expanded(
            flex: 1,
            child: Text('No habits on this date',style: TextStyle(fontWeight: FontWeight.bold),))
        ],
      ),
    ): ListView.builder(
      padding: EdgeInsets.zero,
      physics: ScrollPhysics(),
      itemCount: habitsListOnDate.length,
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return Card(
          elevation: 5,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListTile(
              leading: GestureDetector(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        HabitDetail(habit: habitsListOnDate[index]),
                  ),
                ),
                child: Container(
                  padding: EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: iconsColor[habitsListOnDate[index].category]!
                        .withValues(alpha: 0.5),
                  ),
                  width: 50,
                  child: Icon(icons[habitsListOnDate[index].category]),
                ),
              ),
              title: Text(
                habitsListOnDate[index].name,
                maxLines: 1,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                habitsListOnDate[index].descriptionDetail(),
                maxLines: 1,
              ),
              trailing:
                  habitsListOnDate[index].progress ==
                      habitsListOnDate[index].quantity
                  ? Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.grey.withValues(alpha: 0.3),
                      borderRadius: BorderRadius.all(Radius.circular(10)) 

                    ),
                    child: Text('Completed'))
                  : Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        IconButton(
                          onPressed: () {
                            if (habitsListOnDate[index].progress > 0) {
                              ref
                                  .read(habitsListProvider.notifier)
                                  .decrementProgress(habitsListOnDate[index]);
                            }
                          },
                          icon: Icon(Icons.remove),
                        ),
                        SizedBox(
                          width: 30,
                          child: Text(
                            habitsListOnDate[index].progress.toString(),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            if (habitsListOnDate[index].progress <
                                habitsListOnDate[index].quantity) {
                              ref
                                  .read(habitsListProvider.notifier)
                                  .incrementProgress(habitsListOnDate[index]);
                              if (habitsListOnDate[index].progress ==
                                  habitsListOnDate[index].quantity) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      'Congratulations on completing your goal',
                                    ),
                                  ),
                                );
                              }
                            }
                          },
                          icon: Icon(Icons.add),
                        ),
                      ],
                    ),
            ),
          ),
        );
      },
    );
  }

  Widget _landscape() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Small habits, big changes,',
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 20),
        Expanded(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(child: _verticalCalendar()),
              SizedBox(width: 10),
              Expanded(child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _dayRow(),
                  SizedBox(height: 10,),
                  Expanded(child: _habitsList()),
                ],
              )),
            ],
          ),
        ),
      ],
    );
  }

  _verticalCalendar()
  {
    return CalendarDatePicker(
      
      initialDate: DateTime.now(), 
      firstDate: DateTime.now().subtract(Duration(days: 720)),
      lastDate: DateTime.now().add(Duration(days: 720)), onDateChanged: (date)
    {
      ref.read(dateProvider.notifier).changeDate(date);
    });
  }
}

extension on int{

  String get dayInAlphabets
  {
    switch(this){
      case DateTime.monday:
      return 'Monday';
      case DateTime.tuesday:
      return 'Tuesday';
      case DateTime.wednesday:
      return 'Wednesday';
      case DateTime.thursday:
      return 'Thursday';
      case DateTime.friday:
      return 'Friday';
      case DateTime.saturday:
      return 'Saturday';

      case DateTime.sunday:
      return 'Sunday';

      default:
      return '';
    }
  }

  String get monthInAlphabets
  {
    switch(this){
      case DateTime.january:
      return 'January';
      case DateTime.february:
      return 'February';
      case DateTime.march:
      return 'March';

      case DateTime.april:
      return 'April';

      case DateTime.may:
      return 'May';
      
      case DateTime.june:
      return 'June';
      
      case DateTime.july:
      return 'July';
      case DateTime.august:
      return 'August';
      case DateTime.september:
      return 'September';
      case DateTime.october:
      return 'October';
      case DateTime.november:
      return 'November';

      case DateTime.december:
      return 'December';

      default:
      return '';
    }
  }
}
