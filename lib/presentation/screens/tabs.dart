import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:habix/presentation/providers/habit_category.dart';
import 'package:habix/presentation/providers/today_screen.dart';
import 'package:habix/presentation/screens/habit_screen.dart';
import 'package:habix/presentation/screens/new_habit.dart';
import 'package:habix/presentation/screens/profile_screen.dart';
import 'package:habix/presentation/screens/statistics.dart';
import 'package:habix/presentation/screens/today_screen.dart';

class TabScreen extends ConsumerStatefulWidget {
  const TabScreen({super.key});

  @override
  ConsumerState<TabScreen> createState() => _TabScreenState();
}

class _TabScreenState extends ConsumerState<TabScreen> {
  int _selectedTabIndex = 0;
  Widget activeScreen = Container();

  @override
  Widget build(BuildContext context) {
    if (_selectedTabIndex == 0) {
      activeScreen = TodayScreen();
    } else if (_selectedTabIndex == 1) {
      ref.invalidate(habitsCategoryProvider);
      activeScreen = AllHabits();
    } else if (_selectedTabIndex == 3) {
      activeScreen = Statistics();
    } else if (_selectedTabIndex == 4) {
      activeScreen = Profile();
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
          if (_selectedTabIndex != i) {
            if (i == 0) {
              ref.invalidate(todaysScreenProvider);
            } else if (i == 1) {
              ref.invalidate(habitsCategoryProvider);
            }
            setState(() {
              _selectedTabIndex = i;
            });
          }
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
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }
}
