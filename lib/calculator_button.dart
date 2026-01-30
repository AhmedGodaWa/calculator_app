import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CalculatorButton extends StatelessWidget {
  String text;
  final Function(String) onPressed;

  CalculatorButton({super.key, required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        height: double.infinity,
        margin: EdgeInsets.all(2),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue,
            //shape: RoundedRectangleBorder(),
          ),
          onPressed:() => onPressed(text),
          child: Text(
            text,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
