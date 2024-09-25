import 'package:flutter/material.dart';

import 'home_page.dart';
class CalculatorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: CalculatorScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class CalculatorScreen extends StatefulWidget {
  @override
  _CalculatorScreenState createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  String _output = '0';
  String _input = '';
  double _num1 = 0;
  double _num2 = 0;
  String _operator = '';

  buttonPressed(String buttonText) {
    if (buttonText == 'C') {
      _input = '';
      _num1 = 0;
      _num2 = 0;
      _operator = '';
      _output = '0';
    } else if (buttonText == '+' ||
        buttonText == '-' ||
        buttonText == '*' ||
        buttonText == '/') {
      _num1 = double.parse(_input);
      _operator = buttonText;
      _input = '';
    } else if (buttonText == '.') {
      if (!_input.contains('.')) {
        _input += buttonText;
      }
    } else if (buttonText == '=') {
      _num2 = double.parse(_input);
      if (_operator == '+') {
        _output = (_num1 + _num2).toString();
      } else if (_operator == '-') {
        _output = (_num1 - _num2).toString();
      } else if (_operator == '×') {
        _output = (_num1 * _num2).toString();
      } else if (_operator == '/') {
        _output = (_num1 / _num2).toString();
      }

      _input = _output;
      _operator = '';
    } else {
      _input += buttonText;
      _output = _input;
    }

    setState(() {
      _output = _output;
    });
  }

  Widget buildButton(String buttonText) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.all(20.0),
            backgroundColor: Colors.black38,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30.0), // Curved edges with a radius of 12
            ), // Gray color for the buttons
          ),
          child: Text(
            buttonText,
            style: TextStyle(fontSize: 24.0, color: Colors.white),
          ),
          onPressed: () => buttonPressed(buttonText),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey,
        title: Text('Calculator',),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => HomePage()), // Navigate to HomePage
                  (Route<dynamic> route) => false, // Removes all previous routes
            );
          },
        ),

      ),
      body: Column(
        children: <Widget>[
          Container(
            alignment: Alignment.centerRight,
            padding: EdgeInsets.symmetric(vertical: 24.0, horizontal: 12.0),
            child: Text(
              _output,
              style: TextStyle(fontSize: 48.0, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(child: Divider()),
          Column(
            children: [
              Row(
                children: [
                  buildButton('7'),
                  buildButton('8'),
                  buildButton('9'),
                  buildButton('/'),
                ],
              ),
              Row(
                children: [
                  buildButton('4'),
                  buildButton('5'),
                  buildButton('6'),
                  buildButton('×'),
                ],
              ),
              Row(
                children: [
                  buildButton('1'),
                  buildButton('2'),
                  buildButton('3'),
                  buildButton('-'),
                ],
              ),
              Row(
                children: [
                  buildButton('.'),
                  buildButton('0'),
                  buildButton('00'),
                  buildButton('+'),
                ],
              ),
              Row(
                children: [
                  buildButton('C'),
                  buildButton('='),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
