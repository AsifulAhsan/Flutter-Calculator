import 'package:flutter/material.dart';
import 'package:flutter_simple_calculator/colors.dart';
import 'package:math_expressions/math_expressions.dart';

void main() {
  runApp(const MaterialApp(
    home: CalculatorApp(),
  ));
}

class CalculatorApp extends StatefulWidget {
  const CalculatorApp({Key? key}) : super(key: key);

  @override
  State<CalculatorApp> createState() => _CalculatorAppState();
}

class _CalculatorAppState extends State<CalculatorApp> {
  //variables

  double firstNum = 0.0;
  double secondNum = 0.0;
  var input = '';
  var output = '';
  var operation = '';
  var hideInput = false;
  var outputSize = 34.0;
  // var π = 3.14159265

  onButtonClick(value) {
    //if value is AC
    if (value == "AC") {
      input = '';
      output = '';
    } else if (value == "⌫") {
      if (input.isNotEmpty) {
        input = input.substring(0, input.length - 1);
      }
    } else if (value == "=") {
      var userInput = input;
      userInput = input.replaceAll("x", "*");
      if (input.isNotEmpty) {
        Parser p = Parser();
        Expression expression = p.parse(userInput);
        ContextModel cm = ContextModel();
        var finalValue = expression.evaluate(EvaluationType.REAL, cm);
        output = finalValue.toString();
        if (output.endsWith(".0")) {
          output = output.substring(0, output.length - 2);
        }
        input = output;
        hideInput = true;
        outputSize = 52;
      }
    } else {
      input += value;
      hideInput = false;
      outputSize = 34;
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 5, 28, 23),
      body: Column(
        children: [
          //input output area
          Expanded(
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      hideInput ? '' : input,
                      style: const TextStyle(
                        fontSize: 50,
                        color: Colors.white70,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      output,
                      style: TextStyle(
                        fontSize: outputSize,
                        color: Colors.white.withOpacity(0.7),
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                  ]),
            ),
          ),

          //buttons area
          Row(
            children: [
              button(
                  text: "⌫",
                  buttonBgColor: operatorColor,
                  tColor: Colors.greenAccent),
              /*button(
                  text: "%",
                  tColor: Colors.greenAccent,
                  buttonBgColor: operatorColor),*/
              button(
                  text: "AC",
                  tColor: const Color.fromARGB(255, 0, 0, 0),
                  buttonBgColor: const Color.fromARGB(255, 255, 0, 0)),
              button(
                  text: "/",
                  tColor: Colors.greenAccent,
                  buttonBgColor: operatorColor),
            ],
          ),
          Row(
            children: [
              button(text: "7"),
              button(text: "8"),
              button(text: "9"),
              button(
                  text: "x",
                  tColor: Colors.greenAccent,
                  buttonBgColor: operatorColor),
            ],
          ),
          Row(
            children: [
              button(text: "4"),
              button(text: "5"),
              button(text: "6"),
              button(
                  text: "-",
                  tColor: Colors.greenAccent,
                  buttonBgColor: operatorColor),
            ],
          ),
          Row(
            children: [
              button(text: "1"),
              button(text: "2"),
              button(text: "3"),
              button(
                  text: "+",
                  tColor: Colors.greenAccent,
                  buttonBgColor: operatorColor),
            ],
          ),
          Row(
            children: [
              /*button(
                  text: "π",
                  tColor: Colors.greenAccent,
                  buttonBgColor: Colors.transparent),*/
              button(text: ".", tColor: Colors.greenAccent),
              button(text: "0"),
              button(
                  text: "=",
                  tColor: Colors.black87,
                  buttonBgColor: Colors.blueAccent),
            ],
          ),
        ],
      ),
    );
  }

  Widget button({
    text,
    tColor = Colors.white,
    buttonBgColor = buttonColor,
  }) {
    return Expanded(
        child: Container(
            margin: const EdgeInsets.all(8),
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                    padding: const EdgeInsets.all(22),
                    backgroundColor: buttonBgColor),
                onPressed: () => onButtonClick(text),
                child: Text(text,
                    style: TextStyle(
                      fontSize: 18,
                      color: tColor,
                      fontWeight: FontWeight.bold,
                    )))));
  }
}
