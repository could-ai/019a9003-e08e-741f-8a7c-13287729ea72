import 'package:flutter/material.dart';
import '../models/card_model.dart';

class PlayingCardWidget extends StatelessWidget {
  final CardModel card;

  const PlayingCardWidget({super.key, required this.card});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 60,
      height: 90,
      margin: const EdgeInsets.symmetric(horizontal: 4),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.black, width: 1),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              card.rankString,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: card.suit == Suit.hearts || card.suit == Suit.diamonds
                    ? Colors.red
                    : Colors.black,
              ),
            ),
            Text(
              card.suitString,
              style: TextStyle(
                fontSize: 24,
                color: card.suit == Suit.hearts || card.suit == Suit.diamonds
                    ? Colors.red
                    : Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
