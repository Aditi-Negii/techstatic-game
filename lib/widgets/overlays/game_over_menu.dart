// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, must_be_immutable, use_build_context_synchronously, unused_import

import 'package:flutter/material.dart';
import 'package:gsheets/gsheets.dart';
import 'package:spacescape/widgets/overlays/google_sheets_api.dart';

import '../../game/game.dart';
import '../../screens/main_menu.dart';
import 'pause_button.dart';

// This class represents the game over menu overlay.
class GameOverMenu extends StatelessWidget {
  static const String id = 'GameOverMenu';
  static late int score;
  final SpacescapeGame game;
  late int phoneNumber;
  // late int finalScorePlayer;
  TextEditingController phoneNumberController = TextEditingController();

  GameOverMenu({super.key, required this.game});
  
  var mobile = TextEditingController();

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
                    builder: (context) => MainMenu(),
                  ),
                );
              },
              child: const Text('Exit'),
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width / 3,
            child: ElevatedButton(
              onPressed: () => showDialog<String>(
                context: context,
                builder: (BuildContext context) => AlertDialog(
                  title: Text('Submit your Score'),
                  content: Text('Your Curent Score is $score'),
                  actions: <Widget>[
                    TextField(
                      controller: phoneNumberController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Enter Phone Number',
                      ),
                    ),
                    TextButton(
                      onPressed: () => Navigator.pop(context, 'Cancel'),
                      child: Text('Cancel'),
                    ),
                    TextButton(
                      onPressed: () {
                        print(phoneNumberController.text);
                        post(phoneNumberController.text, score); 
                        Navigator.pop(context, 'Submit');
                      },
                      child: const Text('Submit'),
                    ),
                  ],
                ),
              ),
              child: const Text('Submit Score'),
            ),
          ),
        ],
      ),
    );
  }
  
  void post(mobileNumber, score) {
    GoogleSheetsApi.insert(mobileNumber, score);
    print('data added');
  }
}
