import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_echarts/flutter_echarts.dart';
import 'package:http/http.dart' as http;

class DatabaseUpdatingExample extends StatefulWidget {
  const DatabaseUpdatingExample({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _DatabaseUpdatingExampleState createState() =>
      _DatabaseUpdatingExampleState();
}

class _DatabaseUpdatingExampleState extends State<DatabaseUpdatingExample> {
  
  Future fetchState() async {
    var responce = await http.get(Uri.parse('https://api.openbrewerydb.org/breweries'));
    if(responce.statusCode == 200){
      var State = json.decode(responce.body);
    }
  }

  List<double> data = [150.0, 30.0, 50.0];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Database Updating Example'),
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
          )
        ],
      ),
    );
  }
}