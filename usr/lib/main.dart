import 'package:flutter/material.dart';
import 'package:couldai_user_app/poker_game_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Texas Hold\'em Poker',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: Colors.blue[900],
        primaryColor: Colors.blueGrey[800],
      ),
      home: const PokerGameScreen(),
    );
  }
}
