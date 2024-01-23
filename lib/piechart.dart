import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // Import the services.dart package
import 'package:flutter_echarts/flutter_echarts.dart';

class EChartPieChartPage extends StatefulWidget {
  const EChartPieChartPage({super.key});

  @override
  _EChartPieChartPageState createState() => _EChartPieChartPageState();
}

class _EChartPieChartPageState extends State<EChartPieChartPage> {
  List<Map<String, dynamic>> jsonData = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    // Load the local JSON file
    final String jsonString = await rootBundle.loadString('assets/dataoffline.json');

    // Parse the JSON data
    List<dynamic> jsonList = json.decode(jsonString);
    jsonData = List<Map<String, dynamic>>.from(jsonList);

    // setState to trigger a rebuild with the loaded data
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('EChart PieChart State Province'),
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
      String? state = data['state_province'];
      if (state != null) {
        stateCounts[state] = (stateCounts[state] ?? 0) + 1;
      }
    }

    // Prepare data for EChart
    List<Map<String, dynamic>> chartData = [];
    stateCounts.forEach((state, count) {
      chartData.add({'name': state, 'value': count});
    });

    // Build EChart options
    String option = '''
    {
      title: {
        text: 'Breweries by State Province',
        x: 'center',
      },
      tooltip: {
        trigger: 'item',
        formatter: '{a} <br/>{b} : {c} ({d}%)',
      },
      legend: {
        orient: 'vertical',
        left: 'left',
        data: ${jsonEncode(stateCounts.keys.toList())},
      },
      series: [
        {
          name: 'Breweries',
          type: 'pie',
          radius: '55%',
          center: ['50%', '60%'],
          data: ${jsonEncode(chartData)},
          emphasis: {
            itemStyle: {
              shadowBlur: 10,
              shadowOffsetX: 0,
              shadowColor: 'rgba(0, 0, 0, 0.5)',
            },
          },
          label: {
            show: true,
            formatter: '{b} : {c} ({d}%)',
          },
          emphasis: {
            label: {
              show: true,
              fontSize: '20',
              fontWeight: 'bold',
            },
          },
        },
      ],
    }
    ''';

    return Echarts(
      option: option,
    );
  }
}
