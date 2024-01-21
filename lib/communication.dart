import 'dart:convert';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_echarts/flutter_echarts.dart';
import 'package:http/http.dart' as http;

Future<Data> fetchAlbum() async {
    final response = await http
        .get(Uri.parse('https://api.openbrewerydb.org/breweries'));

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      return Data.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }
  }

class Data{
  final String state;

  Data({
    required this.state
  });

  factory Data.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
        'title': String stateId
      } =>
        Data(
          state: stateId
        ),
      _ => throw const FormatException('Failed to load album.'),
    };
  }
}


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


