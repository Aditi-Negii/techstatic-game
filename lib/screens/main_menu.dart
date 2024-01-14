
// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:spacescape/screens/game_into.dart';

import 'settings_menu.dart';
import 'select_spaceship.dart';

// Represents the main menu screen of Spacescape, allowing
// players to start the game or modify in-game settings.
class MainMenu extends StatelessWidget {
  const MainMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Game title.
            SizedBox(height: 50),
            Padding(
              padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
              child: Text(
                'Stardust',
                style: TextStyle(
                  fontSize: 50.0,
                  color: Colors.white,
                  shadows: [
                    Shadow(
                      blurRadius: 10,
                      color: Colors.blueAccent,
                      offset: Offset(3, 3),
                    )
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(0, 3, 0, 50),
              child: Text(
                'Crusade',
                style: TextStyle(
                  fontSize: 50.0,
                  color: Colors.white,
                  shadows: [
                    Shadow(
                      blurRadius: 10,
                      color: Colors.blueAccent,
                      offset: Offset(03, 3),
                    )
                  ],
                ),
              ),
            ),

            // Play button.
            SizedBox(
              width: MediaQuery.of(context).size.width / 3,
              height: 40,
              child: ElevatedButton(
                onPressed: () {
                  // Push and replace current screen (i.e MainMenu) with
                  // SelectSpaceship(), so that player can select a spaceship.
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (context) => const SelectSpaceship(),
                    ),
                  );
                },
                child: const Text(
                  'Play',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            const SizedBox(
              height: 12,
            ),
            SizedBox(
              height: 40,
              width: MediaQuery.of(context).size.width / 3,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) =>  GameIntroScreen(),
                    ),
                  );
                },
                child: const Text(
                  'Game Guide',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            const SizedBox(
              height: 12,
            ),
            // Settings button.
            SizedBox(
              height: 40,
              width: MediaQuery.of(context).size.width / 3,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const SettingsMenu(),
                    ),
                  );
                },
                child: const Text(
                  'Settings',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            SizedBox(
              height: 70,
            ),
            Align(
                alignment: AlignmentDirectional.bottomCenter,
                child: Column(
                  children: <Widget>[
                    Text('Made by', style: TextStyle(shadows: [
                    Shadow(
                      blurRadius: 10,
                      color: Colors.blueAccent,
                      offset: Offset(03, 3),
                    )
                  ],),),
                    Text('The Techstatic Creatives and Devs Teams', style: TextStyle(shadows: [
                    Shadow(
                      blurRadius: 10,
                      color: Colors.blueAccent,
                      offset: Offset(03, 3),
                    )
                  ],
                  )
                  ,
                  ),
                  SizedBox(height: 15,),
                  Center(child: SizedBox(height: 100, width: 100 ,child: Image.asset('assets/images/techstatic_logo.png'),),)
                  ],

                  )
                ),
          ],
        ),
      ),
    );
  }
}
