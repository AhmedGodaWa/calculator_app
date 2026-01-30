import 'package:calculator_app/calculator_screen.dart';
import 'package:flutter/material.dart';


void main() {
  runApp(const CalculatorApp());
}

class CalculatorApp extends StatelessWidget {
  const CalculatorApp({super.key});


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      routes: {CalculatorScreen.routeName : (_) => CalculatorScreen()},
      initialRoute: CalculatorScreen.routeName,
    );
  }
}
