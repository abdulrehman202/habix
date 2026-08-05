import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:habix/domain/models/Habit.dart';
import 'package:habix/presentation/providers/habits_list.dart';
import 'package:habix/core/utilities/constants.dart';
import 'package:habix/core/utilities/extensions.dart';
import 'package:material_charts/material_charts.dart' hide LegendPosition;
import 'package:pie_chart/pie_chart.dart';

enum TimePeriod { TODAY, WEEK, MONTH }

class Statistics extends ConsumerStatefulWidget {
  const Statistics({super.key});

  @override
  ConsumerState<Statistics> createState() => _StatisticsState();
}

class _StatisticsState extends ConsumerState<Statistics> {
  TimePeriod _selectedTimeperiod = TimePeriod.TODAY;
  late double screenSize;  

  final categorizedList = [
    HabitBucket.filter( Category.HEALTH , allHabits),
    HabitBucket.filter( Category.MIND , allHabits),
    HabitBucket.filter( Category.MORNING , allHabits),
    HabitBucket.filter( Category.PRODUCTIVITY , allHabits),
    HabitBucket.filter( Category.OTHER , allHabits),
  ];  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('Statistics')),
        actions: [TextButton(onPressed: () {}, child: Text('Insights'))],
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          screenSize = constraints.maxWidth;
          return constraints.maxWidth>maxScreenSizeInPortraitMode?_landscape():_portrait();
        },
      ),
    );
  }

  Widget _portrait() {
    return Container(
      margin: EdgeInsetsDirectional.symmetric(horizontal: 10),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [_dropdown(), SizedBox(height: 10), _graph(), SizedBox(height: 10),_pieChart()],
        ),
      ),
    );
  }

  Widget _landscape() {
    return Container(
      margin: EdgeInsetsDirectional.symmetric(horizontal: 10),
      child: SingleChildScrollView(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _dropdown(),
                SizedBox(height: 10,),
                _graph()
              ],
            )),
            SizedBox(width: 10,),
            Expanded(child: Column(
              children: [
                _pieChart()
              ],
            )),],
        ),
      ),
    );
  }

  Widget _dropdown() {
    return Card(
      child: DropdownButton<TimePeriod>(
        padding: EdgeInsets.symmetric(horizontal: 10),
        value: _selectedTimeperiod,
        underline: Container(),
        items: TimePeriod.values
            .map(
              (tp) => DropdownMenuItem<TimePeriod>(
                value: tp,
                child: Text(
                  '${tp != TimePeriod.TODAY ? 'This' : ''} ${tp.name.capitalize}',
                ),
              ),
            )
            .toList(),
        onChanged: (tp) {
          setState(() {
            _selectedTimeperiod = tp!;
          });
        },
      ),
    );
  }

  Widget _pieChart() 
  {
    final dataMap = <String, double>{
    Category.MIND.name : categorizedList.firstWhere((e)=>e.category == Category.MIND).list.length/allHabits.length,
    Category.MORNING.name : categorizedList.firstWhere((e)=>e.category == Category.MORNING).list.length/allHabits.length,
    Category.HEALTH.name : categorizedList.firstWhere((e)=>e.category == Category.HEALTH).list.length/allHabits.length,
    Category.PRODUCTIVITY.name : categorizedList.firstWhere((e)=>e.category == Category.PRODUCTIVITY).list.length/allHabits.length,
    Category.OTHER.name : categorizedList.firstWhere((e)=>e.category == Category.OTHER).list.length/allHabits.length,
    
  };

    return Card(
      elevation: 3,
      child: Container(
        margin: EdgeInsets.only(left: 20,top: 10),
        width: screenSize>maxScreenSizeInPortraitMode?screenSize/2:screenSize,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Habit Completion', style: TextStyle(fontWeight: FontWeight.bold)),
            SizedBox(height: 20),
            Container(
              padding: EdgeInsets.all(30),
              child: PieChart(
                legendOptions: LegendOptions(
                  showLegendsInRow: screenSize<=864&& screenSize>maxScreenSizeInPortraitMode,
                  legendPosition: screenSize<=864&& screenSize>maxScreenSizeInPortraitMode ?LegendPosition.bottom: LegendPosition.right
                ),
                chartValuesOptions: ChartValuesOptions(
                  showChartValuesOutside: true,
                  showChartValueBackground: false,
                  showChartValuesInPercentage: true,
                  decimalPlaces: 0
                ),
                dataMap: dataMap),
            ),
          ],
        ),
      ),
);
  }

  Widget _graph() {
    final series = [
      ChartSeries(
        smoothLine: true,
        name: '',
        dataPoints: getTimeIntervals( _selectedTimeperiod ), 
        color: Colors.green,
      ),
      ChartSeries(
        showPoints: false,
        name: '',
        dataPoints: const [
          ChartDataPoint(value: 0, label: ''),
          ChartDataPoint(value: 10, label: ''),
          ChartDataPoint(value: 20, label: ''),
          ChartDataPoint(value: 30, label: ''),
          ChartDataPoint(value: 40, label: ''),
          ChartDataPoint(value: 50, label: ''),
          ChartDataPoint(value: 60, label: ''),
          ChartDataPoint(value: 70, label: ''),
          ChartDataPoint(value: 80, label: ''),
          ChartDataPoint(value: 90, label: ''),
          ChartDataPoint(value: 100, label: ''),
        ],
        color: Colors.transparent,
      ),
    ];
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Overview', style: TextStyle(fontWeight: FontWeight.bold)),
                Text('78 %', style: TextStyle(fontWeight: FontWeight.bold)),
              ],
            ),
            SizedBox(height: 10),
            MultiLineChart(
              series: series,
              style: const MultiLineChartStyle(
                horizontalGridLines: 4,

                colors: [Colors.green],
                showLegend: false,
              ),
              height: 300,
            ),
          ],
        ),
      ),
    );
  }
  
  List<ChartDataPoint> getTimeIntervals(TimePeriod tp) 
  {
    if(tp == TimePeriod.MONTH){
            return [
                ChartDataPoint(value: 10, label: 'Week 1'),
                ChartDataPoint(value: 25, label: 'Week 2'),
                ChartDataPoint(value: 15, label: 'Week 3'),
                ChartDataPoint(value: 30, label: 'Week 4'),
              ];}
            else if(tp==TimePeriod.WEEK) {return [
                ChartDataPoint(value: 10, label: 'Monday'),
                ChartDataPoint(value: 25, label: 'Tuesday'),
                ChartDataPoint(value: 15, label: 'Wednesday'),
                ChartDataPoint(value: 30, label: 'Thursday'),
                ChartDataPoint(value: 45, label: 'Friday'),
                ChartDataPoint(value: 60, label: 'Saturday'),
                ChartDataPoint(value: 15, label: 'Sunday'),
              ];}
              else{
                return [
                ChartDataPoint(value: 10, label: '12:00 pm'),
                ChartDataPoint(value: 15, label: '6:00 pm'),
                ChartDataPoint(value: 45, label: '12:00 am'),
                ChartDataPoint(value: 15, label: '6:00 am'),
              ];
              }
  }
}
