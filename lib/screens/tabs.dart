import 'package:flutter/material.dart';
import 'package:habix/screens/habit_screen.dart';
import 'package:habix/screens/new_habit.dart';

class TabScreen extends StatefulWidget {
  const TabScreen({super.key});

  @override
  State<TabScreen> createState() => _TabScreenState();
}

class _TabScreenState extends State<TabScreen> {
  int _selectedTabIndex = 0;
  Widget activeScreen = Container();

  @override
  Widget build(BuildContext context) {
    if (_selectedTabIndex == 0) {
      activeScreen = Scaffold(body: Center(child: Text('Today')));
    } else if (_selectedTabIndex == 1) {
      activeScreen = AllHabits();
    } else if (_selectedTabIndex == 2) {
      activeScreen = Center(child: Text('Stats'));
    } else if (_selectedTabIndex == 3) {
      activeScreen = Center(child: Text('Profile'));
    }

    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: activeScreen,
      floatingActionButton: FloatingActionButton(
        elevation: 9,
        shape: CircleBorder(),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => NewHabit()),
          );
        },
        child: Icon(Icons.add),
      ),
      bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: _selectedTabIndex,
          onTap: (i) {
            setState(() {
              _selectedTabIndex = i;
            });
          },
          showUnselectedLabels: true,
        
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.sunny), label: 'Today'),
            BottomNavigationBarItem(
              icon: Icon(Icons.health_and_safety_outlined),
              label: 'Habits',
            ),
            BottomNavigationBarItem(icon: SizedBox(), label: ''),
            BottomNavigationBarItem(
              icon: Icon(Icons.auto_graph_sharp),
              label: 'Stats',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Profile',
            ),
          ],
        ),
    );
  }
}
