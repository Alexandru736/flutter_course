import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeWork1 extends StatelessWidget {
  const HomeWork1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'MoneyConvertor',
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
  final TextEditingController _textFieldController = TextEditingController();
  String? convertedSum = '';
  String? errorText;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text('Currency convertor'),
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: <Widget>[
              Image.network(
                  'https://s.iw.ro/gateway/g/ZmlsZVNvdXJjZT1odHRwJTNBJTJGJTJG/c3RvcmFnZTA1dHJhbnNjb2Rlci5yY3Mt/cmRzLnJvJTJGc3RvcmFnZSUyRjIwMTUl/MkYwNyUyRjIzJTJGNDgxNDY4XzQ4MTQ2/OF9jdXJzX3NjaGltYl92YWx1dGFyX2xl/aV9ldXJvXy1fbWVkaWFmYXguanBnJnc9/NzgwJmg9NDQwJmhhc2g9YjY1MTE3MGU3ZTdkMmIwNmU4Yjc3YjVkNmYyNzVkMTY=.thumb.jpg'),
              Padding(
                padding: const EdgeInsets.only(top: 15.0),
                child: SizedBox(
                  width: 350,
                  child: TextField(
                    keyboardType: const TextInputType.numberWithOptions(decimal: true),
                    style: const TextStyle(fontSize: 25),
                    controller: _textFieldController,
                    decoration: InputDecoration(
                      errorText: errorText,
                      hintText: 'Enter the amount in EURO',
                      focusedBorder: const OutlineInputBorder(borderSide: BorderSide(color: Colors.blue)),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: TextButton(
                  onPressed: () => convertCurrency(_textFieldController),
                  style: TextButton.styleFrom(
                    fixedSize: const Size(150, 75),
                    backgroundColor: Colors.blue,
                  ),
                  child: const Text(
                    'Convert',
                    style: TextStyle(fontSize: 30, color: Colors.white),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Text(
                  '$convertedSum LEI',
                  style: const TextStyle(fontSize: 40, color: Colors.grey),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void convertCurrency(TextEditingController _controller) {
    final double? doubleValue;
    doubleValue = double.tryParse(_controller.value.text);

    if (doubleValue == null) {
      setState(() {
        errorText = 'Please enter a number';
      });
    } else {
      setState(() {
        if (doubleValue != null) {
          errorText = null;
          convertedSum = (doubleValue * 4.5).toStringAsFixed(2);
        }
      });
    }
  }
}
