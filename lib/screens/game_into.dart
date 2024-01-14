// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';

class GameIntroScreen extends StatelessWidget {
  const GameIntroScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('How to Play'),
        backgroundColor: Colors.transparent,
      ),
      body:ListView(
        children: <Widget>[
          SizedBox(height: 20,),
          Column(
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.purple[200],
                      ),
                height: 150,
                width: 500,
                child: Column(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.all(20),
                      child: Column(
                        children: <Widget>[
                          Text("How to Move: ", style: TextStyle(fontSize: 20),),
                          Text('In order to move, use the joystick on the bottom left of the screen',  style: TextStyle(fontSize: 20), 
                           ), Text('Get GUD', style: TextStyle(color: Colors.black),)],
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(height: 30,),
              Container(
                decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.purple[200],
                      ),
                height: 180,
                width: 500,
                child: Column(
                  children: <Widget>[
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20)
                      ),
                      padding: EdgeInsets.all(20),
                      child: Column( 
                      
                        children: <Widget>[
                          Text("How to Shoot: ", style: TextStyle(fontSize: 20),),
                          Text('In order to shoot the astroids, press the button on the bottom right of the screen', style: TextStyle(fontSize: 20),),
                          Text('DUHH', style: TextStyle(color: Colors.black),)
                          ],
                      ),
                    )
                  ],
                )
              ),
              SizedBox(height: 30,),
              Container(
                decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.purple[200],
                      ),
                height: 190,
                width: 500,
                child: Column(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.all(20),
                      child: Column(
                        children: <Widget>[
                          Text("Think you are the exception: ", style: TextStyle(fontSize: 20),),
                          Text('Submit your high score at the end of the game to stand a chance to win free techstatic merch!!', style: TextStyle(fontSize: 20),), 
                          Text('NAH Id WIN', style: TextStyle(color: Colors.black), )],
                      ),
                    )
                  ],
                )
              ),
            ],
          )
        ],
      )
    );
  }
}