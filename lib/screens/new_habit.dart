import 'package:flutter/material.dart' hide Interval;
import 'package:flutter/rendering.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:habix/constants.dart';
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
  void dispose() {
    // TODO: implement dispose
    _nameController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  _resetStates()
  {
    ref.invalidate(newHabitIntervalProvider);
    ref.invalidate(newHabitCategoryProvider);
    ref.invalidate(newHabitReminderTime);
    ref.invalidate(newHabitButtonText);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(onPressed: (){
            _resetStates();
            Navigator.pop(context);}, icon: Icon(Icons.close))
        ],
        automaticallyImplyLeading: false,
        title: Center(child: Text('New Habit')),
      ),
      body: Padding(
        padding: EdgeInsetsGeometry.symmetric(horizontal: 20, vertical: 10),
        child: SingleChildScrollView(
          child: LayoutBuilder(
            builder: (context, constraints) {
              _category = ref.watch(newHabitCategoryProvider);
              _interval = ref.watch(newHabitIntervalProvider);
              return constraints.maxWidth>maxScreenSizeInPortraitMode?_landscape(constraints): _portrait(constraints);
            }
          ),
        )
      )
    );
  }
  
  Widget _landscape(BoxConstraints constraints)
  {
    return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        
                    Center(
                      child: Image.asset(
                        'assets/images/calendar.jpg',
                        fit: BoxFit.fitHeight,
                        width: constraints.maxWidth,
                        height: 100,
                        errorBuilder: (context, error, stackTrace) => Container(),
                      ),
                    ),
                    Center(child: Text('Let us know about the new habit you are about to add to your schedule',style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),textAlign: TextAlign.center,)),
                    SizedBox(height: 10,),
                    TextField(
                      controller: _nameController,
                      onChanged: (txt)=>ref.read(newHabitButtonText.notifier).updateHabitName(txt),
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
                  _reminderTimeSet(),
                    
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text('Interval',style: TextStyle(fontWeight: FontWeight.bold),),
                        SizedBox(height: 10,),
                    intervalOption(constraints.maxWidth),
                    SizedBox(height: 10,),
                    Text('Category', style: TextStyle(fontWeight: FontWeight.bold),),
                    
                    SizedBox(height: 10,),
                    categoryOption(constraints.maxWidth),
                      ],
                    ),
                  ),
                ],
              );
  }

  Widget _portrait(BoxConstraints constraints)
  {
    return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Image.asset(
                      'assets/images/calendar.jpg',
                      fit: BoxFit.fitHeight,
                      width: constraints.maxWidth,
                      height: 150,
                      errorBuilder: (context, error, stackTrace) => Container(),
                    ),
                  ),
                  Center(child: Text('Let us know about the new habit you are about to add to your schedule',style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),textAlign: TextAlign.center,)),
                  SizedBox(height: 10,),
                  TextField(
                    controller: _nameController,
                    onChanged: (txt)=>ref.read(newHabitButtonText.notifier).updateHabitName(txt),
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
                  Card(
                    elevation: 5,
                    child: 
                  Container(
                    margin: EdgeInsets.all(15),
                    child: Column(
                      children: [
                        intervalOption(constraints.maxWidth),
                    SizedBox(height: 20,),
                    _reminderTimeSet(),
                      ],
                    ),
                  ),),
                  SizedBox(height: 10,),
                  Text('Category', style: TextStyle(fontWeight: FontWeight.bold),),
                  SizedBox(height: 10,),
                  Card(
                    elevation: 5,
                    child: Container(
                      margin: EdgeInsets.only(top: 10),
                      child: categoryOption(constraints.maxWidth))),
                  SizedBox(height: 10,),
                  _button()
                ],
              );
  }
  
  Widget intervalOption(double w) 
  {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        ...Interval.values.map((i)=>Expanded(
        child: GestureDetector(onTap: ()=>ref.read(newHabitIntervalProvider.notifier).changeIntervalSelection(i), child: Container(
          alignment: Alignment.center,
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
          margin: EdgeInsets.only(right: i.index==2?0: 5),
          decoration: _interval == i? BoxDecoration(
            border: Border.all(width: 2,color: Colors.blueGrey),
            borderRadius: BorderRadius.circular(10),
            shape: BoxShape.rectangle,
            color: const Color.fromARGB(255, 225, 225, 225)
          ): BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            shape: BoxShape.rectangle,
            color: const Color.fromARGB(255, 225, 225, 225)
          ),
          child: Text(i.name.capitalize,maxLines: 1, style: TextStyle(fontWeight: _interval == i?FontWeight.bold: FontWeight.normal),))),
      ))],
    ); 
  }

  Widget _button(){final hName = ref.watch(newHabitButtonText);    
    return SizedBox(
      width: double.infinity,
      height: 60,
      child: FilledButton(
        onPressed: ()
        {
          if(_nameController.text.isEmpty || _descriptionController.text.isEmpty)
          {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(duration: Duration(milliseconds: 750), content: Text('Please fill all the fields') ));
            return;
          }
          ref.read(habitsListProvider.notifier).addHabit(
          Habit(_nameController
          .text, _category, _descriptionController.text, _interval, 0)
        );
            _resetStates();
            Navigator.pop(context);
        
        },
        child: Text('Add $hName as my new Hobby'),
      ),
    );
    }

  
  Widget categoryOption(double w) 
  {
    return Wrap(
      alignment: w>maxScreenSizeInPortraitMode? WrapAlignment.center:WrapAlignment.start,
      children: Category.values.map((c)=> c!=Category.ALL? Container(
        height: 90,
        width: 80,
        margin: EdgeInsets.only(bottom: 5,right: w>maxScreenSizeInPortraitMode?10:0),
        child: Column(
          children: [
            GestureDetector(onTap: ()=>ref.read(newHabitCategoryProvider.notifier).changeCategorySelection(c), child: Container(
              width: w/Category.values.length,
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
              margin: EdgeInsets.only(bottom: 10),
              decoration: _category == c?   BoxDecoration(
                  border:  Border.all(width:2,color:  Colors.blueGrey),
                borderRadius: BorderRadius.circular(10),
                shape: BoxShape.rectangle,
              color: const Color.fromARGB(255, 225, 225, 225)
              ):BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                shape: BoxShape.rectangle,
              color: const Color.fromARGB(255, 225, 225, 225)
              ),
              child: Icon(icons[c],))),
          Text(c.name, style: TextStyle(fontSize: 10,),textAlign: TextAlign.center,overflow: TextOverflow.ellipsis,)
          ],
        ),
      ):Container()).toList(),
    );
  }
  
  Widget _reminderTimeSet()
  {
    final time = ref.watch(newHabitReminderTime);
    return ListTile(
      onTap: ()async {
        
        final selectedTime = await showTimePicker(
          initialEntryMode: TimePickerEntryMode.inputOnly,
          context: context, initialTime: TimeOfDay.now());
        ref.read(newHabitReminderTime.notifier).updateHabitReminder(selectedTime??time);
        },
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8)
      ),
      tileColor: const Color.fromARGB(255, 232, 232, 232),
      leading: Icon(Icons.alarm),
      title: Text('Reminder', style: TextStyle(fontWeight: FontWeight.bold),),
      trailing: Row(
      mainAxisSize: MainAxisSize.min,
        children: [
          Text(time.format(context).toString(),style: TextStyle(fontSize: 15),),
          Icon(Icons.keyboard_arrow_right_rounded),
        ],
      ),
    );
  }
}