import 'dart:math';

import 'package:flutter/material.dart';

class HomeWork2 extends StatelessWidget {
  const HomeWork2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Guess Number',
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final String guessText = "I'm thinking of a number between 1 and 100";
  final String turnText = "It's your turn to guess my number";
  final String tryText = 'Try a number!';

  TextEditingController numberController = TextEditingController();

  String? errorText;
  String buttonText = 'Guess';
  String compareText = '';

  int randomGeneratedNumber = Random().nextInt(100) + 1;
  bool showCompareText = false;

  final TextInputType keyboardType = TextInputType.number;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text('Guess my number'),
        ),
        backgroundColor: const Color(0xff3d9b9b),
      ),
      backgroundColor: const Color(0xffF5F5F5),
      body: ListView(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 16.0),
            child: Text(
              guessText,
              style: const TextStyle(
                fontSize: 27.0,
                color: Color(0xff757575),
              ),
              textAlign: TextAlign.center,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: Text(
              turnText,
              style: const TextStyle(fontSize: 19.0, color: Color(0xff757575)),
              textAlign: TextAlign.center,
            ),
          ),
          Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: showCompareText
                  ? Text(
                      compareText,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 37.0,
                        color: Color(0xff757575),
                      ),
                    )
                  : null),
          Padding(
            padding: const EdgeInsets.only(top: 50.0, left: 10.0, right: 10.0),
            child: SizedBox(
              width: 350,
              height: 270,
              child: Card(
                  shape: RoundedRectangleBorder(
                    side: const BorderSide(color: Colors.white70),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                      child: Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(top: 20.0),
                        child: Text(
                          tryText,
                          style: const TextStyle(color: Color(0xff9E9E9E), fontSize: 40.0),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10.0, right: 15.0, left: 15.0),
                        child: TextField(
                          controller: numberController,
                          style: const TextStyle(fontSize: 25.0),
                          keyboardType: keyboardType,
                          decoration: InputDecoration(
                              hintText: 'Enter a number: ',
                              hintStyle: const TextStyle(fontSize: 25.0),
                              errorText: errorText,
                              errorStyle: const TextStyle(fontSize: 16.0),
                              focusedBorder: const OutlineInputBorder(borderSide: BorderSide(color: Colors.grey))),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 35.0, bottom: 10.0),
                        child: SizedBox(
                          width: 120,
                          height: 50,
                          child: ElevatedButton(
                            style: ButtonStyle(backgroundColor: MaterialStateProperty.all(const Color(0xff3d9b9b))),
                            onPressed: buttonPressed,
                            child: Text(
                              buttonText,
                              style: const TextStyle(
                                fontSize: 22.0,
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ))),
            ),
          )
        ],
      ),
    );
  }

  void buttonPressed() {
    final int? textInputValue = int.tryParse(numberController.value.text);
    if (textInputValue != null && buttonText == 'Guess') {
      setState(() {
        if (textInputValue > 100 || textInputValue < 1) {
          errorText = 'Try a number between 1 and 100';
          showCompareText = false;
          numberController.clear();
        } else {
          showCompareText = true;
          errorText = null;
          if (textInputValue > randomGeneratedNumber) {
            compareText = 'You tried $textInputValue\nTry Lower!';
          } else if (textInputValue < randomGeneratedNumber) {
            compareText = 'You tried $textInputValue\nTry Higher!';
          } else {
            compareText = 'You guessed right!';
            buttonText = 'Reset';
            showDialog<void>(
                context: context,
                builder: (BuildContext context) => AlertDialog(
                        title: const Text('You guessed right'),
                        content: Text('The number was $randomGeneratedNumber'),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () {
                              setState(() {
                                compareText = '';
                                buttonText = 'Guess';
                                showCompareText = false;
                                randomGeneratedNumber = Random().nextInt(100) + 1;
                                numberController.clear();
                              });
                              Navigator.pop(context, 'Try Again');
                            },
                            child: const Text('Try Again'),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context, 'Ok');
                            },
                            child: const Text('Ok'),
                          ),
                        ]));
          }
        }
      });
      return;
    }
    if (buttonText == 'Reset') {
      setState(() {
        compareText = '';
        buttonText = 'Guess';
        showCompareText = false;
        numberController.clear();
        randomGeneratedNumber = Random().nextInt(100) + 1;
      });
    }
  }
}
