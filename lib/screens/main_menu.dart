// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';

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
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 50.0),
              child: Text(
                'Whacky Warp',
                style: TextStyle(
                  fontSize: 50.0,
                  color: Color.fromARGB(255, 99, 40, 235),
                  shadows: [
                    Shadow(
                      blurRadius: 20.0,
                      color: Colors.purpleAccent,
                      offset: Offset(0, 0),
                    )
                  ],
                ),
              ),
            ),

            // Play button.
            SizedBox(
              width: MediaQuery.of(context).size.width / 3,
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
                child: const Text('Play', style: TextStyle(color: Colors.white),),
              ),
            ),
            const SizedBox(
              height: 12,
            ),
            // Settings button.
            SizedBox(
              width: MediaQuery.of(context).size.width / 3,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const SettingsMenu(),
                    ),
                  );
                },
                child: const Text('Settings',  style: TextStyle(color: Colors.white),),
              ),
            ),
            SizedBox(height: 70,),
            Align(alignment: AlignmentDirectional.bottomCenter,
            child: Text('Made By The Techstatic Devs team')),
          ],
        ),
      ),
    );
  }
}
