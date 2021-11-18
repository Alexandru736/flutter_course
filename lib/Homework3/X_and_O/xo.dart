import 'package:collection/collection.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TicTacToe extends StatelessWidget {
  const TicTacToe({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'TicTacToe',
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
  List<Box> checkedBoxes = <Box>[];

  //false - 1st player; true - 2nd player
  bool turn = false;
  final Color player1Color = Colors.green;
  final Color player2Color = Colors.red;

  int player1Score = 0;
  int player2Score = 0;

  String? verifySet(int index1, int index2, int index3) {
    final Box? element1 =
        checkedBoxes.firstWhereOrNull((Box element) => element.index == index1);
    final Box? element2 =
        checkedBoxes.firstWhereOrNull((Box element) => element.index == index2);
    final Box? element3 =
        checkedBoxes.firstWhereOrNull((Box element) => element.index == index3);
    if (element1 == null || element2 == null || element3 == null) {
      return null;
    } else {
      if (element1.color == element2.color &&
          element2.color == element3.color) {
        if (element1.color == player1Color) {
          return '1';
        }
        return '2';
      }
    }
  }

  String? verifyWinner() {
    if (verifySet(0, 3, 6) != null) {
      return verifySet(0, 3, 6);
    }
    if (verifySet(2, 5, 8) != null) {
      return verifySet(1, 4, 7);
    }
    if (verifySet(2, 5, 8) != null) {
      return verifySet(2, 5, 8);
    }
    if (verifySet(0, 1, 2) != null) {
      return verifySet(0, 1, 2);
    }
    if (verifySet(3, 4, 5) != null) {
      return verifySet(3, 4, 5);
    }
    if (verifySet(6, 7, 8) != null) {
      return verifySet(6, 7, 8);
    }
    if (verifySet(0, 4, 8) != null) {
      return verifySet(0, 4, 8);
    }
    if (verifySet(2, 4, 6) != null) {
      return verifySet(2, 4, 6);
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TicTacToe'),
      ),
      body: ListView(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  'Green Player Score: $player1Score',
                  style: const TextStyle(fontSize: 20.0),
                ),
                Text(
                  'Red Player Score: $player2Score',
                  style: const TextStyle(fontSize: 20.0),
                )
              ],
            ),
          ),
          GridView.builder(
            shrinkWrap: true,
            padding: const EdgeInsetsDirectional.fromSTEB(10.0, 10.0, 10.0, 0),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3),
            itemCount: 9,
            itemBuilder: (BuildContext context, int index) {
              final Box? element = checkedBoxes
                  .firstWhereOrNull((Box item) => item.index == index);

              return GestureDetector(
                onTap: () {
                  setState(() {
                    if (element == null) {
                      if (turn) {
                        checkedBoxes.add(Box(index, player1Color));
                      } else {
                        checkedBoxes.add(Box(index, player2Color));
                      }
                      turn = !turn;
                    }
                    if (checkedBoxes.length == 9 || verifyWinner() != null) {
                      showDialog<void>(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text('Winner'),
                            content: Text(verifyWinner() != null
                                ? 'Player ${verifyWinner()} won the game'
                                : 'Draw'),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () {
                                  setState(() {
                                    if (verifyWinner() == '1') {
                                      player1Score += 1;
                                    } else if (verifyWinner() == '2') {
                                      player2Score += 1;
                                    }
                                    checkedBoxes = <Box>[];
                                  });
                                  Navigator.pop(context, 'Play Again');
                                },
                                child: const Text('Play Again'),
                              )
                            ],
                          );
                        },
                      );
                    }
                  });
                },
                child: AnimatedContainer(
                  decoration: BoxDecoration(
                    color: element == null ? Colors.white : element.color,
                    border: Border.all(color: Colors.black45, width: 3.0),
                  ),
                  duration: const Duration(milliseconds: 300),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class Box {
  Box(this.index, this.color);

  final int index;
  Color color;
}
