import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:habix/constants.dart';
import 'package:habix/screens/habit_screen.dart';
import 'package:material_charts/material_charts.dart';

enum TimePeriod { TODAY, WEEK, MONTH }

class Statistics extends ConsumerStatefulWidget {
  const Statistics({super.key});

  @override
  ConsumerState<Statistics> createState() => _StatisticsState();
}

class _StatisticsState extends ConsumerState<Statistics> {
  TimePeriod _selectedTimeperiod = TimePeriod.TODAY;
  late double screenSize;

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
    final data = [
      const PieChartData(value: 30, label: 'Mobile', color: Colors.blue),
      const PieChartData(value: 25, label: 'Desktop', color: Colors.red),
      const PieChartData(value: 20, label: 'Tablet', color: Colors.green),
      const PieChartData(value: 15, label: 'Watch', color: Colors.orange),
      const PieChartData(value: 10, label: 'Other', color: Colors.purple),
    ];


    return Card(
      elevation: 3,
      child: Container(
        height: 300,
                      width: screenSize>maxScreenSizeInPortraitMode? (screenSize/2)-50:screenSize-50,
        margin: EdgeInsets.only(left: 20,top: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Habit Completion', style: TextStyle(fontWeight: FontWeight.bold)),
            SizedBox(height: 40),
            Center(
              child: Stack(
                alignment: Alignment.center,
                children: [
                  MaterialPieChart(
                    padding: EdgeInsets.all(8.0),
                      data: data,
                      width: screenSize>maxScreenSizeInPortraitMode? screenSize/2:screenSize,
                      height: 200,
                      style: const PieChartStyle(
                        showConnectorLines: false,
                        showValues: false,
                        showLabels: false,
                        ),
                    ),
                    CircleAvatar(
                      radius: 60,
                      backgroundColor: Colors.white,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text('100%',style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),),
                          Text('Completed',style: TextStyle(fontSize: 10,),)
                        ],
                      ),
                    ),
                ],
              ),
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
        dataPoints: _selectedTimeperiod == TimePeriod.MONTH
            ? [
                ChartDataPoint(value: 10, label: 'Week 1'),
                ChartDataPoint(value: 25, label: 'Week 2'),
                ChartDataPoint(value: 15, label: 'Week 3'),
                ChartDataPoint(value: 30, label: 'Week 4'),
              ]
            : [
                ChartDataPoint(value: 10, label: 'Monday'),
                ChartDataPoint(value: 25, label: 'Tuesday'),
                ChartDataPoint(value: 15, label: 'Wednesday'),
                ChartDataPoint(value: 30, label: 'Thursday'),
                ChartDataPoint(value: 45, label: 'Friday'),
                ChartDataPoint(value: 60, label: 'Saturday'),
                ChartDataPoint(value: 15, label: 'Sunday'),
              ],
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
}
