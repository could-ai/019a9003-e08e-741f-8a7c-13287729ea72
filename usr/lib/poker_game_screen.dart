import 'package:flutter/material.dart';
import 'models/card_model.dart';
import 'widgets/playing_card_widget.dart';

class PokerGameScreen extends StatefulWidget {
  const PokerGameScreen({super.key});

  @override
  State<PokerGameScreen> createState() => _PokerGameScreenState();
}

class _PokerGameScreenState extends State<PokerGameScreen> {
  // Mock data for now
  final List<CardModel> _communityCards = [
    CardModel(suit: Suit.hearts, rank: Rank.ace),
    CardModel(suit: Suit.diamonds, rank: Rank.king),
    CardModel(suit: Suit.clubs, rank: Rank.queen),
    CardModel(suit: Suit.spades, rank: Rank.jack),
    CardModel(suit: Suit.hearts, rank: Rank.ten),
  ];

  final List<CardModel> _playerCards = [
    CardModel(suit: Suit.spades, rank: Rank.ace),
    CardModel(suit: Suit.clubs, rank: Rank.ace),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Texas Hold\'em'),
        backgroundColor: Colors.blueGrey[900],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            // Pot display
            const Text(
              'Pot: \$1500',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
            ),

            // Community cards
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: _communityCards
                  .map((card) => PlayingCardWidget(card: card))
                  .toList(),
            ),

            // Player's hand
            Column(
              children: [
                 const Text(
                  'Your Hand',
                  style: TextStyle(fontSize: 20, color: Colors.white70),
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: _playerCards
                      .map((card) => PlayingCardWidget(card: card))
                      .toList(),
                ),
              ],
            ),


            // Action buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(onPressed: () {}, child: const Text('Fold')),
                ElevatedButton(onPressed: () {}, child: const Text('Check')),
                ElevatedButton(onPressed: () {}, child: const Text('Bet')),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
