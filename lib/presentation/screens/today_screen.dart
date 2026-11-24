import 'package:audioplayers/audioplayers.dart';
import 'package:awesome_shake_widget/enum/vibration_type.dart';
import 'package:awesome_shake_widget/shake_config.dart';
import 'package:awesome_shake_widget/shake_widget.dart';
import 'package:confetti/confetti.dart';
import 'package:habix/presentation/providers/notification_provider.dart';
import 'package:material_ui/material_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:habix/domain/entity/Habit.dart';
import 'package:habix/presentation/screens/login_screen.dart';
import 'package:habix/presentation/screens/widgets/animated_progress_bar.dart';
import 'package:habix/presentation/screens/widgets/epmty_list_widget.dart';
import 'package:habix/presentation/screens/widgets/week_strip.dart';
import 'package:habix/utilities/constants.dart';
import 'package:habix/presentation/providers/today_screen.dart';
import 'package:habix/presentation/screens/habit_detail.dart';
import 'package:habix/presentation/screens/widgets/habit_list_tile.dart';
import 'package:habix/utilities/extensions.dart';
import 'package:habix/utilities/navigator.dart';
import 'package:habix/utilities/shimmer_animation.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class TodayScreen extends ConsumerStatefulWidget {
  const TodayScreen({super.key});

  @override
  ConsumerState<TodayScreen> createState() => _TodayScreenState();
}

class _TodayScreenState extends ConsumerState<TodayScreen>
    with SingleTickerProviderStateMixin {
  late Map<String, dynamic> _params;

  late ConfettiController _controllerCenter;

  final AudioPlayer _audioPlayer = AudioPlayer();
  final shakeKey = GlobalKey<ShakeWidgetState>();

  late final AnimationController _controller = AnimationController(
    duration: const Duration(milliseconds: 500),
    vsync: this,
  );

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    precacheImage(
      const AssetImage('assets/images/habbit_tracker.jpg'),
      context,
    );
  }

  @override
  void dispose() {
    _controllerCenter.dispose();
    _audioPlayer.dispose();
    _controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _controllerCenter = ConfettiController(
      duration: const Duration(seconds: 2),
    );
  }
  
  @override
  Widget build(BuildContext context) {
    _params = ref.watch(todaysScreenProvider);
    _controller.forward();
    
    return Scaffold(
      appBar: AppBar(
        title: Text('Good Afternoon Flex,'),
        actions: [
          IconButton(
            onPressed: () async {
              bool success = await ref
                  .read(todaysScreenProvider.notifier)
                  .logout();
              if (success) {
                 await ref.read(notificationServiceProvider).unregisterDevice();
                try{
                }catch(e){}
                navigateTo(
                  context,
                  LoginScreen()
                );
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Logout failed. Please try again.')),
                );
              }
            },
            icon: Icon(Icons.power_settings_new_outlined),
          ),
        ],
      ),
      body: Stack(
        children: [
          LayoutBuilder(
            builder: (context, constraints) {
              return Container(
                margin: EdgeInsets.symmetric(horizontal: 10),
                child: constraints.maxWidth > maxScreenSizeInPortraitMode + 220
                    ? _landscape()
                    : _portrait(),
              );
            },
          ),
          Align(
            alignment: Alignment.center,
            child: ConfettiWidget(
              numberOfParticles: 50,
              confettiController: _controllerCenter,
              blastDirectionality: BlastDirectionality
                  .explosive, // don't specify a direction, blast randomly
              shouldLoop:
                  false, // start again as soon as the animation is finished
              colors: const [
                Colors.green,
                Colors.blue,
                Colors.pink,
                Colors.orange,
                Colors.purple,
              ], // manually specify the colors to be used
              // define a custom shape/path.
            ),
          ),
        ],
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

        _progressBar(),
        SizedBox(height: 20),
        _dayRow(),
        SizedBox(height: 10),
        Expanded(
          child: _params['data_loading']
              ? ShimmerAnimation.listPlaceholder()
              : _habitsList(),
        ),
      ],
    );
  }

  Widget _dayRow() {
    DateTime _date = _params['selected_date'];
    return Text(
      '${_date.day} ${_date.month.monthInAlphabets} ${_date.year} ( ${_date.weekday.dayInAlphabets} )',
      style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
    );
  }

  Widget _progressBar() {
    final completedHabitsQuantity = (_params['habits_list'] as List)
        .cast<Habit>()
        .fold<int>(
          0,
          (int s, Habit h) =>
              s + (_params['progress_list'][h.id] == h.quantity ? 1 : 0),
        );

    double percentageOfCompletedTasks =
        completedHabitsQuantity / _params['habits_list'].length;
    return _params['habits_list'].isEmpty
        ? Container()
        : Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Progress'),
                  Text('${(percentageOfCompletedTasks * 100).round()}%'),
                ],
              ),
              SizedBox(height: 5),
              AnimatedProgressBar(value: percentageOfCompletedTasks),
            ],
          );
  }

  Widget _horizontaCalendar() {
    return WeekStrip(
      selected: _params['selected_date'],
      onSelect: (date) {
        ref.read(todaysScreenProvider.notifier).changeDate(date);
        ref.read(todaysScreenProvider.notifier).updateList(date);
      },
    );
  }

  Widget _habitsList() {
    if(_params['habits_list'].isEmpty)
    {return EmptyListWidget();}

    return ShakeWidget(
                                      key: shakeKey,
                                      customConfig: ShakeConfig(
                                        offset: 20,
                                        vibrationType: VibrationType.none,
                                      ),
          child: ListView.builder(
              padding: EdgeInsets.zero,
              physics: ScrollPhysics(),
              itemCount: _params['habits_list'].length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return AnimatedBuilder(
                  animation: _controller,
                  builder: (context, child) =>  Container(
                    margin: EdgeInsets.only(top: 200 - 200 * _controller.value),
                    child: child,
                  ),
                  child: Card(
                    elevation: 5,
                    child: ListTile(
                      minTileHeight: 75,
                      leading: GestureDetector(
                        onTap: () async {
                          final completed = await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => HabitDetail(
                                habit: _params['habits_list'][index],
                              ),
                            ),
                          );
                          if (completed ?? false) {
                            ref
                                .read(todaysScreenProvider.notifier)
                                .markAsComplete(_params['habits_list'][index]);
                          }
                        },
                        child: CircularPercentIndicator(
                          radius: 20,
                          lineWidth: 3.0,
                          percent:
                              (_params['progress_list']
                                      as Map<
                                        String,
                                        int
                                      >)[_params['habits_list'][index].id] ==
                                  null
                              ? 0
                              : (_params['progress_list']
                                        as Map<
                                          String,
                                          int
                                        >)[_params['habits_list'][index].id]! /
                                    _params['habits_list'][index].quantity,
                          progressColor:
                              iconsColor[_params['habits_list'][index].category]!,
                          center: ClipOval(
                            child: ColoredBox(
                              color:
                                  iconsColor[_params['habits_list'][index]
                                          .category]!
                                      .withValues(alpha: 0.3),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Icon(
                                  icons[_params['habits_list'][index].category],
                                  size: 20,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      title: Text(
                        _params['habits_list'][index].name,
                        maxLines: 1,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(
                        _params['habits_list'][index].descriptionDetail(),
                        maxLines: 1,
                      ),
                      trailing: _params['progress_list'] == null
                          ? Container()
                          : AnimatedSwitcher(
                              duration: const Duration(milliseconds: 200),
                              transitionBuilder:
                                  (Widget child, Animation<double> animation) {
                                    return FadeTransition(
                                      opacity: animation,
                                      child: child,
                                    );
                                  },
                              child: Container(
                                key: ValueKey<bool>(
                                  _params['progress_list'][_params['habits_list'][index]
                                          .id] ==
                                      _params['habits_list'][index].quantity,
                                ),
                                child:
                                    _params['progress_list'][_params['habits_list'][index]
                                            .id] ==
                                        _params['habits_list'][index].quantity
                                    ? Icon(Icons.check, color: Colors.green)
                                    : Row(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children:
                                          _params['progress_list'][_params['habits_list'][index]
                                                  .id] ==
                                              {}
                                          ? [Text('Error fetching progress')]
                                          : [
                                              IconButton(
                                                onPressed: () async {
                                                  try {
                                                    if (_params['progress_list'][_params['habits_list'][index]
                                                            .id] >
                                                        0) {
                                                      bool? success = await ref
                                                          .read(
                                                            todaysScreenProvider
                                                                .notifier,
                                                          )
                                                          .decrementProgress(
                                                            _params['habits_list'][index],
                                                          );
                                                          if(!success!)
                                                          {
                                                            shakeKey.currentState?.shake();
                                                          }
                                                    }
                                                  }
                                                  // ignore: empty_catches
                                                  catch (e) {}
                                                },
                                                icon: Icon(Icons.remove),
                                              ),
                                              SizedBox(
                                                width: 30,
                                                child: Text(
                                                  (_params['progress_list'][_params['habits_list'][index]
                                                              .id] ??
                                                          0)
                                                      .toString(),
                                                  textAlign: TextAlign.center,
                                                ),
                                              ),
                                              IconButton(
                                                onPressed: () async {
                                                  try {
                                                    if (_params['progress_list'][_params['habits_list'][index]
                                                            .id] <
                                                        _params['habits_list'][index]
                                                            .quantity) {
                                                      bool?
                                                      success = await ref
                                                          .read(
                                                            todaysScreenProvider
                                                                .notifier,
                                                          )
                                                          .incrementProgress(
                                                            _params['habits_list'][index],
                                                          );
                                                          if(!success!)
                                                          {
                                                            shakeKey.currentState?.shake();
                                                          }
                                                      if (_params['progress_list'][_params['habits_list'][index]
                                                            .id] ==
                                                        _params['habits_list'][index]
                                                            .quantity) {
                                                        await _audioPlayer.play(
                                                          AssetSource(
                                                            'sounds/celebration.mp3',
                                                          ),
                                                        );
                                                        _controllerCenter
                                                            .play();
                                                      }
                                                    }
                                                  }
                                                  // ignore: empty_catches
                                                  catch (e) {
                                                    print(
                                                      'Error incrementing progress: $e',
                                                    );
                                                  }
                                                },
                                                icon: Icon(Icons.add),
                                              ),
                                            ],
                                    ),
                              ),
                            ),
                    ),
                  ),
                );
              },
            ),
        );
  }

  Widget _landscape() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            children: [
              Text(
                'Small habits, big changes,',
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
              Expanded(child: _verticalCalendar()),
            ],
          ),
        ),
        SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(child: _dayRow()),

                  Expanded(child: _landscapeProgressBar()),
                ],
              ),
              SizedBox(height: 10),
              Expanded(
                child: _params['data_loading']
                    ? ShimmerAnimation.listPlaceholder()
                    : _habitsList(),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _verticalCalendar() {
    return SingleChildScrollView(
      child: Column(
        children: [
          CalendarDatePicker(
            initialDate: _params['selected_date'],
            firstDate: DateTime.now().subtract(Duration(days: 720)),
            lastDate: DateTime.now().add(Duration(days: 720)),
            onDateChanged: (date) {
              ref.read(todaysScreenProvider.notifier).changeDate(date);
              ref.read(todaysScreenProvider.notifier).updateList(date);
            },
          ),
        ],
      ),
    );
  }

  Widget _landscapeProgressBar() {
    final completedHabitsQuantity = (_params['habits_list'] as List)
        .cast<Habit>()
        .fold<int>(
          0,
          (int s, h) =>
              s += (_params['progress_list'][h.id] == h.quantity ? 1 : 0),
        );

    double percentageOfCompletedTasks =
        completedHabitsQuantity / _params['habits_list'].length;
    return _params['habits_list'].isEmpty
        ? Container()
        : Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text('Progress: '),
              SizedBox(width: 5),
              Expanded(
                child: AnimatedProgressBar(value: percentageOfCompletedTasks),
              ),
              SizedBox(width: 5),
              Text('${(percentageOfCompletedTasks * 100).round()}%'),
            ],
          );
  }
}
