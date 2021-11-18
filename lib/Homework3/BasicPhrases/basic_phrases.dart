import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

class BasicPhrases extends StatelessWidget {
  const BasicPhrases({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Basic Phrases',
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
  final List<TileContent> phrases = <TileContent>[
    TileContent('audio/romana/salut.mp3', 'salut', 'audio/english/salut(English).mp3'),
    TileContent('audio/romana/ma_numesc.mp3', 'ma numesc', 'audio/english/ma_numesc(English).mp3'),
    TileContent('audio/romana/sunt_bine.mp3', 'sunt bine', 'audio/english/sunt_bine(English).mp3'),
    TileContent('audio/romana/ce_mai_faci.mp3', 'ce mai faci?', 'audio/english/ce_mai_faci(English).mp3'),
  ];

  bool isTapped = true;

  void tap(String fileName) {
    audioCache.load(fileName);
    audioCache.play(fileName);
  }

  AudioCache audioCache = AudioCache();

  Widget rowGenerator(BuildContext context, TileContent phrase) {
    final double width = MediaQuery.of(context).size.width * 0.4;
    final double height = MediaQuery.of(context).size.height * 0.2;

    return Padding(
      padding: const EdgeInsetsDirectional.only(top: 10.0, bottom: 5.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          GestureDetector(
            onTap: () => tap(phrase.fileName),
            child: Container(
              width: width,
              height: height,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadiusDirectional.circular(20),
                gradient: const LinearGradient(
                  colors: <Color>[
                    Color(0xff6aaeea),
                    Color(0xff5d9ace),
                    Color(0xff5186b5),
                  ],
                ),
              ),
              child: Text(
                phrase.tileTitle,
                style: const TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: () => tap(phrase.fileNameEnglish),
            child: Container(
              width: width,
              height: height,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadiusDirectional.circular(20),
                color: Colors.green,
                gradient: const LinearGradient(
                  colors: <Color>[
                    Color(0xff6aaeea),
                    Color(0xff5d9ace),
                    Color(0xff5186b5),
                  ],
                ),
              ),
              child: Text(
                '${phrase.tileTitle} (English)',
                style: const TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Basic Phrases',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        backgroundColor: const Color(0xff5d9ace),
      ),
      backgroundColor: isTapped ? const Color(0xffe1f5fe) : Colors.blue,
      body: ListView.builder(
        itemCount: 4,
        itemBuilder: (BuildContext context, int index) {
          return rowGenerator(context, phrases[index]);
        },
      ),
    );
  }
}

class TileContent {

  TileContent(this.fileName, this.tileTitle, this.fileNameEnglish);

  String fileName;
  String tileTitle;
  String fileNameEnglish;
}
