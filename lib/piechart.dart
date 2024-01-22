import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:fl_chart/fl_chart.dart';

class PieChartPage extends StatefulWidget {
  const PieChartPage({super.key});

  @override
  _PieChartPage createState() => _PieChartPage();
}

class _PieChartPage extends State<PieChartPage> {
  List<Map<String, dynamic>> jsonData = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    final response = await http.get(Uri.parse('https://api.openbrewerydb.org/breweries')); // Replace with your API endpoint

    if (response.statusCode == 200) {
      setState(() {
        jsonData = List<Map<String, dynamic>>.from(json.decode(response.body));
      });
    } else {
      throw Exception('Failed to load JSON data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PieChart State Province'),
      ),
      body: Column(
        children: [
          jsonData.isEmpty
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : buildEChart(),
        ],
      ),
    );
  }

  Widget buildEChart() {
    Map<String, int> stateCounts = {};
    for (var data in jsonData) {
      String state = data['state_province'];
      stateCounts[state] = (stateCounts[state] ?? 0) + 1;
    }

    // Create data for EChart
    List<PieChartSectionData> pieChartSections = [];
    int index = 0;
    stateCounts.forEach((state, count) {
      pieChartSections.add(
        PieChartSectionData(
          color: Colors.primaries[index % Colors.primaries.length],
          value: count.toDouble(),
          title: '$state\n$count',
          radius: 100,
          titleStyle: const TextStyle(fontSize: 12, color: Colors.white),
        ),
      );
      index++;
    });

    return PieChart(
  PieChartData(
    sections: pieChartSections,
    borderData: FlBorderData(show: false),
    centerSpaceRadius: 0,
    sectionsSpace: 0,
    pieTouchData: PieTouchData(
      touchCallback: (FlTouchEvent event, PieTouchResponse? response) {
        // Your touch handling logic here
      },
    ),
  ),
);

  }
}
