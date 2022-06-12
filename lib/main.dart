import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String equation = '';
  bool ansDisplayed = false;

  TextEditingController controller = TextEditingController();
  @override
  void initState() {
    super.initState();
    controller = TextEditingController();
  }

  void onClick(String s) {
    setState(() {
      equation += s;
      controller.text = equation;
    });
  }

  void answer() {
    Parser p = Parser();
    Expression exp = p.parse(equation);
    ContextModel cm = ContextModel();
    double eval = exp.evaluate(EvaluationType.REAL, cm);
    print(eval);
    controller.clear();
    setState(() {
      //evaluate equation
      equation = "$eval";
      controller.text = equation;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        TextField(
          controller: controller,
        ),
        Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          NumberButton("1", onClick),
          NumberButton("2", onClick),
          NumberButton("3", onClick),
          NumberButton("+", onClick),
        ]),
        Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          NumberButton("4", onClick),
          NumberButton("5", onClick),
          NumberButton("6", onClick),
          NumberButton("-", onClick),
        ]),
        Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          NumberButton("7", onClick),
          NumberButton("8", onClick),
          NumberButton("9", onClick),
          NumberButton("*", onClick),
        ]),
        Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          NumberButton("(", onClick),
          NumberButton("0", onClick),
          NumberButton(")", onClick),
          NumberButton("/", onClick),
        ]),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            NumberButton("=", (s) {
              answer();
            }),
            NumberButton("<", (s) {
              if (equation.length == 0) return;
              setState(() {
                equation = equation.substring(0, equation.length - 1);
                controller.text = equation;
              });
            }),
          ],
        ),
      ],
    ));
  }
}

class NumberButton extends StatelessWidget {
  Function(String) onClick;
  String value;

  NumberButton(this.value, this.onClick);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onClick(value);
      },
      child: Container(
        height: 75,
        width: 75,
        decoration: BoxDecoration(
          color: Colors.pinkAccent,
          borderRadius: BorderRadius.circular(25.0),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "$value",
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}
