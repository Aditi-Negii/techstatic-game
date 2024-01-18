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
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController nameController = TextEditingController();

  // String high = GoogleSheetsApi().currentHighestScore;
  //Future<dynamic> leaderScore = getscore();

  GameOverMenu({super.key, required this.game});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Game Over Screen
          Padding(
            padding: EdgeInsets.symmetric(vertical: 30.0),
            child: Column(
              children: [
                Text(
                  'Game Over',
                  style: TextStyle(
                    fontSize: 50.0,
                    color: Colors.white,
                    shadows: [
                      Shadow(
                        blurRadius: 20.0,
                        color: Color.fromARGB(0, 92, 225, 230),
                        offset: Offset(0, 0),
                      )
                    ],
                  ),
                ),
                Text('Your Score is $score'),
                //Text('Current HighScore is $high'),
              ],
            ),
          ),

          SizedBox(
            width: MediaQuery.of(context).size.width / 2,
            child: ElevatedButton(
              onPressed: () => showDialog<String>(
                context: context,
                builder: (BuildContext context) => AlertDialog(
                  title: Text('Submit your Score'),
                  content: Text('Your Curent Score is $score'),
                  actions: <Widget>[
                    TextField(
                      controller: nameController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Enter Your Full Name',
                      ),
                    ),
                    SizedBox(height: 12,),
                    TextField(
                      controller: phoneNumberController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Enter Phone Number',
                      ),
                    ),
                    SizedBox(height: 12,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        TextButton(
                      onPressed: () => Navigator.pop(context, 'Cancel'),
                      child: Text(
                        'Cancel',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    
                    TextButton(
                      onPressed: () {
                        try {
                          print(phoneNumberController.text);
                          post(phoneNumberController.text, score, nameController.text);
                          Navigator.pop(context, 'Submit');
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: const Text(
                                  "Score Submitted Successfully !")));
                        } catch (e) {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: const Text(
                                  "Please Enter A Valid Phone Number")));
                        }
                      },
                      child: const Text('Submit', style: TextStyle(color: Colors.white),),
                    ),
                      ],
                    ),
                    
                  ],
                ),
              ),
              child: Text(
                'Submit Score',
                style: TextStyle(color: Colors.white, ),
              ),
            ),
          ),
          SizedBox(height: 12,),
          // Restart button.
          SizedBox(
            width: MediaQuery.of(context).size.width / 2,
            child: ElevatedButton(
              onPressed: () {
                game.overlays.remove(GameOverMenu.id);
                game.overlays.add(PauseButton.id);
                game.reset();
                game.resumeEngine();
              },
              child: const Text(
                'Restart',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
          SizedBox(height: 12,),

          // Exit button.
          SizedBox(
            width: MediaQuery.of(context).size.width / 2,
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
              child: const Text(
                'Exit',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void post(mobileNumber, score, name) {
    RegExp phoneNumberCheck = RegExp(
      r'^[0-9]{10}$',
    );
    String mobNo = mobileNumber;
    Match? match = phoneNumberCheck.firstMatch(mobNo);
    if (match != null) {
      GoogleSheetsApi.insert(mobileNumber,score, name);
      return;
    }

    throw FormatException('enter valid phone number');
  }

  void clearField() {
    phoneNumberController.clear();
  }
}
