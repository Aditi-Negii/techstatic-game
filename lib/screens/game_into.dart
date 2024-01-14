// ignore_for_file: prefer_const_constructors

import 'package:card_actions/card_action_button.dart';
import 'package:flutter/material.dart';
import 'package:card_actions/card_actions.dart';

class GameIntroScreen extends StatefulWidget {
  GameIntroScreen({super.key});

  @override
  State<GameIntroScreen> createState() => _GameIntroScreenState();
}

class _GameIntroScreenState extends State<GameIntroScreen> {
  final List<String> images = [
    "assets/images/ship_A.png",
    "assets/images/ship_B.png",
    "assets/images/ship_C.png",
    "assets/images/ship_D.png",
    "assets/images/ship_E.png",
  ];

  final List<String> texts = [
    "Use Joystick to move the player around",
    "Use Joystick to move the player around",
    "Use Joystick to move the player around",
    "Use Joystick to move the player around",
    "Use Joystick to move the player around",
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text('Game Guide'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
          itemCount: 5,
          itemBuilder: (context, index) {
            return Container(
              padding: EdgeInsets.all(16),
              child: buildCard(
                context,
                image: images[index],
                text: texts[index],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget buildCard(BuildContext context,
      {required String image, required String text}) {
    return Card(
      color: const Color(0xff7a306c),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      elevation: 4,
      child: Column(
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
            ),
            child: Image.asset(
              image,
              height: 250,
              width: MediaQuery.of(context).size.width,
              fit: BoxFit.fill,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            text,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
