import 'package:echart_app/communication.dart';
import 'package:echart_app/piechart.dart';
import 'package:echart_app/test.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_echarts/flutter_echarts.dart';

class ReactiveUpdatingExample extends StatefulWidget {
  const ReactiveUpdatingExample({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ReactiveUpdatingExampleState createState() =>
      _ReactiveUpdatingExampleState();
}

class _ReactiveUpdatingExampleState extends State<ReactiveUpdatingExample> {
  List<double> data = [10.0, 60.0, 70.0];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reactive Updating Example'),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 300,
            child: Echarts(
              option: '''
              {
                xAxis: {
                  type: 'category',
                  data: ['Category 1', 'Category 2', 'Category 3']
                },
                yAxis: {
                  type: 'value'
                },
                series: [{
                  data: $data,
                  type: 'bar'
                }]
              }
              ''',
            ),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                // Simulate data update
                data = [50.0, 70.0, 90.0];
              });
            },
            child: const Text('Update Data'),
          ),
          ElevatedButton( 
                  onPressed: () { 
                    Navigator.push( context, MaterialPageRoute(builder: (context) =>  const EChartPieChartPage())); 
                  }, child: const Text('Next'), 
          )
        ],
      ),
    );
  }
}
