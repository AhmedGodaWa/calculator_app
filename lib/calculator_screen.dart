import 'package:calculator_app/calculator_button.dart';
import 'package:flutter/material.dart';

class CalculatorScreen extends StatefulWidget {
  static const String routeName = '/calculator';

  const CalculatorScreen({super.key});

  @override
  State<CalculatorScreen> createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Calculator',
            style: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.w500,
              color: Colors.white,
            ),
          ),
          centerTitle: true,
          backgroundColor: Colors.blue,
        ),
        body: Column(
          children: [
            Expanded(
              child: Container(
                alignment: Alignment.bottomRight,
                margin: EdgeInsets.only(right: 12),
                child: Text(
                  display,
                  style: TextStyle(fontSize: 32, fontWeight: FontWeight.w800),
                ),
              ),
            ),
            SizedBox(height: 100),

            Expanded(
              child: Row(
                children: [
                  CalculatorButton(text: 'C', onPressed: clearClicked),
                  CalculatorButton(text: '⌫', onPressed: backSpaceClicked),
                  // Expanded(child: Container()),
                  // Expanded(child: Container()),
                ],
              ),
            ),

            Expanded(
              child: Row(
                children: [
                  CalculatorButton(text: '7', onPressed: onDigitClicked),
                  CalculatorButton(text: '8', onPressed: onDigitClicked),
                  CalculatorButton(text: '9', onPressed: onDigitClicked),
                  CalculatorButton(text: '*', onPressed: onOperatorClicked),
                ],
              ),
            ),
            Expanded(
              child: Row(
                children: [
                  CalculatorButton(text: '4', onPressed: onDigitClicked),
                  CalculatorButton(text: '5', onPressed: onDigitClicked),
                  CalculatorButton(text: '6', onPressed: onDigitClicked),
                  CalculatorButton(text: '/', onPressed: onOperatorClicked),
                ],
              ),
            ),
            Expanded(
              child: Row(
                children: [
                  CalculatorButton(text: '1', onPressed: onDigitClicked),
                  CalculatorButton(text: '2', onPressed: onDigitClicked),
                  CalculatorButton(text: '3', onPressed: onDigitClicked),
                  CalculatorButton(text: '+', onPressed: onOperatorClicked),
                ],
              ),
            ),
            Expanded(
              child: Row(
                children: [
                  CalculatorButton(text: '.', onPressed: onDotClicked),
                  CalculatorButton(text: '0', onPressed: onDigitClicked),
                  CalculatorButton(text: '=', onPressed: onEquelClicked),
                  CalculatorButton(text: '-', onPressed: onOperatorClicked),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  String display = '';
  String savedNumber = '';
  String savedOperator = '';

  void onDigitClicked(String value) {
    setState(() {
      display += value;
    });
  }

  void onOperatorClicked(String operator) {
    setState(() {
      //  (سيناريو 1)
      // الحل: return (زي ما عملنا) المستخدم ضغط Operator وهو مش كاتب رقم أصلاً
      if (display.isEmpty) return;

      //  (سيناريو 2)
      // لو فاضي يبقى لسه مفيش رقم أول
      if (savedNumber.isEmpty) {
        savedNumber = display; // خزّنا الرقم الأول
        savedOperator = operator; // خزّنا العملية
      } else {
        // لو حصل bug لأي سبب و savedOperator فاضي
        // من غيره الحساب هيبقى غلط أو هيكسر البرنامج
        if (savedOperator.isEmpty) return;

        //  (سيناريو 3)
        // المستخدم كتب رقم تاني وضغط Operator تاني
        // هنا لازم نحسب العملية القديمة الأول ونخزن الناتج
        savedNumber = calculate(savedNumber, savedOperator, display);

        // بعد ما حسبنا القديمة، نخزن العملية الجديدة اللي المستخدم ضغطها دلوقتي
        savedOperator = operator;
      }

      // بنفضي ال display بعد ما نضغط operator جديد علشان الرقم اللي بعده يتكتب كرقم جديد مش يكمل على اللي قبله
      display = '';
    });
  }

  String calculate(String lhs, String operator, String rhs) {
    double num1 = double.parse(lhs);
    double num2 = double.parse(rhs);

    late double result;

    switch (operator) {
      case '*':
        result = num1 * num2;
        break;
      case '/':
        result = num1 / num2;
        break;
      case '+':
        result = num1 + num2;
        break;
      case '-':
        result = num1 - num2;
        break;
    }

    // ده رقم صحيح ولا فيه عشري result إحنا عايزين نعرف هل
    if (result % 1 == 0) {
      return result.toInt().toString();
    } else {
      return result.toString();
    }
  }

  void onEquelClicked(String _) {
    setState(() {
      // لازم يكون في رقم أول + عملية + رقم تاني
      if (savedNumber.isEmpty || savedOperator.isEmpty || display.isEmpty) {
        return;
      }

      // نحسب الناتج
      display = calculate(savedNumber, savedOperator, display);

      // بعد = بنحط الناتج في display
      // و بنمسح savedNumber و savedOperator علشان الحساب الجديد يبدأ من جديد
      savedNumber = '';
      savedOperator = '';
    });
  }

  void onDotClicked(String _) {
    setState(() {
      // لو الشاشة فاضية ودوست dot -> نخليها 0.
      if (display.isEmpty) {
        display = '0.';
        return;
      }

      // لو فيه dot قبل كده -> متعملش حاجة
      if (display.contains('.')) return;

      // غير كده ضيف dot
      display += '.';
    });
  }

  void backSpaceClicked(String _) {
    setState(() {
      display = display.length > 1
          ? display.substring(0, display.length - 1)
          : '';
    });
  }

  void clearClicked(String _) {
    setState(() {
      display = '';
    });
  }
}
