import 'package:chips_choice/chips_choice.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:habix/utilities/enums.dart';
import 'package:habix/domain/models/Habit.dart';
import 'package:habix/presentation/providers/habit_category.dart';
import 'package:habix/presentation/providers/new_habit.dart';
import 'package:habix/presentation/screens/new_habit.dart';
import 'package:habix/presentation/screens/widgets/epmty_list_widget.dart';
import 'package:habix/presentation/screens/widgets/habit_list_tile.dart';
import 'package:habix/utilities/image_paths.dart';
import 'package:habix/utilities/extensions.dart';
import 'package:habix/utilities/lottie_animation.dart';
import 'package:habix/utilities/shimmer_animation.dart';

class AllHabits extends ConsumerStatefulWidget {
  const AllHabits({super.key});

  @override
  ConsumerState<AllHabits> createState() => _AllHabitsState();
}

class _AllHabitsState extends ConsumerState<AllHabits>
    with SingleTickerProviderStateMixin {
  late Map<String, dynamic> _params;
  late AnimationController _animationController;

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    precacheImage(AssetImage(emptyListPlaceholder), context);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 300),
    );

    _animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    _params = ref.watch(habitsCategoryProvider);
    if (_params['loading']) {
      return ShimmerAnimation.listPlaceholder();
    }

    if (_params['removing']) {
      return LottieAnimation.erasing();
    }

    if (_params['error']) {
      // return LottieAnimation.serverError(
      //   reload: (){
      //       ref.read(habitsCategoryProvider.notifier).fetchInitialHabitsList();

      //   }//
      // );
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          LottieAnimation.serverError(),
          SizedBox(
            child: FilledButton(
              onPressed: () {
                ref
                    .read(habitsCategoryProvider.notifier)
                    .fetchInitialHabitsList();
              },
              child: Wrap(
                children: [
                  Icon(Icons.refresh),
                  SizedBox(width: 5),
                  Text('Retry'),
                ],
              ),
            ),
          ),
        ],
      );
    }

    List<Habit> list = (_params['selected_categories'] as List<Category>).isEmpty
        ? _params['list']
        : _params['list']
              .where((e) => (_params['selected_categories'] as List<Category>).contains(e.category))
              .toList();

    return Scaffold(
      appBar: AppBar(
        title: Text('All Habits'),
        automaticallyImplyLeading: false,
      ),
      body: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                _selectCategory(),

                Expanded(
                  child: list.isEmpty
                      ? EmptyListWidget()
                      : Container(
                          margin: EdgeInsets.symmetric(horizontal: 10),
                          child: ListView.separated(
                            physics: ScrollPhysics(),
                            separatorBuilder: (context, index) => Divider(),
                            shrinkWrap: true,
                            itemCount: list.length,
                            itemBuilder: (context, index) => AnimatedBuilder(
                              animation: _animationController,
                              child: Slidable(
                                key: Key(list[index].id),
                                endActionPane: ActionPane(
                                  motion: const ScrollMotion(),
                                  children: [
                                    SlidableAction(
                                      onPressed: (doNothing) async {
                                        bool success = await ref
                                            .watch(
                                              habitsCategoryProvider.notifier,
                                            )
                                            .deleteHabit(list[index].id);
                                        if (!success) {
                                          showErrorDialog();
                                        }
                                      },
                                      backgroundColor: Colors.red,
                                      foregroundColor: Colors.white,
                                      icon: Icons.delete,
                                      label: 'Delete',
                                    ),
                                  ],
                                ),
                                startActionPane: ActionPane(
                                  motion: const ScrollMotion(),
                                  children: [
                                    SlidableAction(
                                      onPressed: (doNothing) {},
                                      backgroundColor: Colors.green,
                                      foregroundColor: Colors.white,
                                      icon: Icons.check,
                                      label: 'Mark as complete',
                                    ),
                                  ],
                                ),
                                child: HabitTile(
                                  onHabitSelected: () {
                                    ref
                                        .read(newHabitProvider.notifier)
                                        .changeCategorySelection(
                                          list[index].category,
                                        );
                                    ref
                                        .read(newHabitProvider.notifier)
                                        .changeIntervalSelection(
                                          list[index].interval,
                                        );
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (ctx) =>
                                            NewHabit(habit: list[index]),
                                      ),
                                    );
                                  },
                                  habit: list[index],
                                ),
                              ),
                              builder: (context, child) {
                                return Padding(
                                  padding: EdgeInsetsGeometry.only(
                                    top: 100 - _animationController.value * 100,
                                  ),
                                  child: child,
                                );
                              },
                            ),
                          ),
                        ),
                ),
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

  showErrorDialog() {
    if (context.mounted) {
      showDialog(
        context: context,
        builder: (context) => Scaffold(
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Failed to delete Habit'),
                FilledButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text('OK'),
                ),
              ],
            ),
          ),
        ),
      );
    }
  }

  _selectCategory() {
    return ExpansionTile(
      title: Text('Selected Category: '),
      children: Category.values
          .map(
            (toElement) =>
                CheckboxMenuButton (
                  value: (_params['selected_categories'] as List<Category>).contains(toElement), onChanged: (newCheck)
                  {
                    if((_params['selected_categories'] as List<Category>).contains(toElement))
                    {
                      ref.read(habitsCategoryProvider.notifier).removeCategory(toElement);
                    }
                    else{
                      ref.read(habitsCategoryProvider.notifier).addCategory(toElement);
                    }                    
                  }, child: Text(toElement.name.capitalize),)
          )
          .toList(),
    );
    // return ChipsChoice<Category>.single(
    //               scrollToSelectedOnChanged: true,
    //               clipBehavior: Clip.none,
    //               padding: EdgeInsets.zero,
    //               choiceStyle: C2ChipStyle.filled(
    //                 color: Colors.white,
    //                 selectedStyle: C2ChipStyle(
    //                   foregroundColor: Colors.white,
    //                   backgroundColor: Theme.of(context).colorScheme.primary,
    //                   borderRadius: BorderRadius.all(Radius.circular(10)),
    //                 ),
    //               ),
    //               choiceItems: Category.values
    //                   .map(
    //                     (element) => C2Choice(
    //                       value: element,
    //                       label: element.name.capitalize,
    //                     ),
    //                   )
    //                   .toList(),
    //               value: _params['category'],
    //               onChanged: (category) => ref
    //                   .read(habitsCategoryProvider.notifier)
    //                   .changeCategory(category),
    //             );
  }
}
