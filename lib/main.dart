import 'package:echart_app/echart_app.dart';
import 'package:flutter/material.dart';

void main() => runApp(const Echart());

class Echart extends StatelessWidget{
  const Echart({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const Echartapp(),
      title: 'Charts',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,

        // Define the default brightness and colors.
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.purple,
        ))
    ); 
  }}