// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, must_be_immutable

import 'package:flutter/material.dart';
import 'package:gsheets/gsheets.dart';
import 'package:spacescape/widgets/overlays/score_to_sheets.dart';

import '../../game/game.dart';
import '../../screens/main_menu.dart';
import 'pause_button.dart';

// This class represents the game over menu overlay.
class GameOverMenu extends StatelessWidget {
  static const String id = 'GameOverMenu';
  static late int score;
  final SpacescapeGame game;
  late int phoneNumber;
  late String finalScorePlayer;

  GameOverMenu({super.key, required this.game});

//to add the data to sheets

  Future<bool> insertData(int mobile, int score, Worksheet workSheet) {
    return workSheet.values
        .appendRow([mobile, score, DateTime.now().toString()]);
  }

  // final sheetsId = '1V15hUng0U8FKwUxfBT2Bav0C8E127JGiWMaeXYpzKwc';
  // final worksheetId = 2146561186;
  // late final gsheets = GSheets(credentials);
  


  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Game Over Screen
          Padding(
            padding: EdgeInsets.symmetric(vertical: 30.0),
            child: Text(
              'Game Over',
              style: TextStyle(
                fontSize: 50.0,
                color: Colors.black,
                shadows: [
                  Shadow(
                    blurRadius: 20.0,
                    color: Colors.white,
                    offset: Offset(0, 0),
                  )
                ],
              ),
            ),
          ),
          // Restart button.
          SizedBox(
            width: MediaQuery.of(context).size.width / 3,
            child: ElevatedButton(
              onPressed: () {
                game.overlays.remove(GameOverMenu.id);
                game.overlays.add(PauseButton.id);
                game.reset();
                game.resumeEngine();
              },
              child: const Text('Restart'),
            ),
          ),

          // Exit button.
          SizedBox(
            width: MediaQuery.of(context).size.width / 3,
            child: ElevatedButton(
              onPressed: () {
                game.overlays.remove(GameOverMenu.id);
                game.reset();
                game.resumeEngine();

                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) =>  MainMenu(),
                  ),
                );
              },
              child: const Text('Exit'),
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width / 3,
            child: ElevatedButton(
              onPressed: () {
                SubmitScore(score: score);
              },
              child: const Text('Submit Score'),
            ),
          ),
        ],
      ),
    );
  }


}
