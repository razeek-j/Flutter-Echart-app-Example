import 'package:flutter/material.dart';
import 'package:flutter_echarts/flutter_echarts.dart';

class TwoWayCommunication extends StatelessWidget {
  const TwoWayCommunication({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Two-Way Communication Example'),
      ),
      body: Echarts(
        extraScript: '''
          chart.on('click', function (params) {
            // Send the clicked data back to Flutter
            sendMessage(JSON.stringify(params));
          });
        ''',
        onMessage: (String message) {
          // Handle the message received from JavaScript
          print('Received message from ECharts: $message');
        },
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
              data: [30, 50, 80],
              type: 'bar'
            }]
          }
        ''',
      ),
    );
  }
}


