import 'package:flutter/material.dart';
import 'package:flutter_echarts/flutter_echarts.dart';

class ReactiveUpdatingExample extends StatefulWidget {
  @override
  _ReactiveUpdatingExampleState createState() =>
      _ReactiveUpdatingExampleState();
}

class _ReactiveUpdatingExampleState extends State<ReactiveUpdatingExample> {
  List<double> data = [30.0, 50.0, 80.0];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Reactive Updating Example'),
      ),
      body: Column(
        children: [
          Container(
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
            child: Text('Update Data'),
          ),
        ],
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: ReactiveUpdatingExample(),
  ));
}
