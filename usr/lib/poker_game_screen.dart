import 'package:flutter/material.dart';
import 'models/card_model.dart';
import 'widgets/playing_card_widget.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

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

  String? _weatherInfo;
  bool _isLoadingWeather = true;
  String? _weatherError;

  @override
  void initState() {
    super.initState();
    _fetchWeather();
  }

  Future<void> _fetchWeather() async {
    setState(() {
      _isLoadingWeather = true;
      _weatherError = null;
    });

    try {
      final response = await http.get(Uri.parse('http://t.weather.itboy.net/api/weather/city/101010100'));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data != null && data['status'] == 200) {
          final today = data['data']['forecast'][0];
          setState(() {
            _weatherInfo = '北京天气：${today['type']}，${today['low']} ~ ${today['high']}，${today['fx']}${today['fl']}';
            _isLoadingWeather = false;
          });
        } else {
          setState(() {
            _weatherError = '无法获取天气信息';
            _isLoadingWeather = false;
          });
        }
      } else {
        setState(() {
          _weatherError = '请求天气接口失败';
          _isLoadingWeather = false;
        });
      }
    } catch (e) {
      setState(() {
        _weatherError = '加载天气时出错';
        _isLoadingWeather = false;
      });
    }
  }

  Widget _buildWeatherWidget() {
    if (_isLoadingWeather) {
      return const Row(
        children: [
          SizedBox(
            width: 16,
            height: 16,
            child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
          ),
          SizedBox(width: 8),
          Text('正在加载天气...', style: TextStyle(color: Colors.white)),
        ],
      );
    }

    if (_weatherError != null) {
      return Text(_weatherError!, style: const TextStyle(color: Colors.redAccent));
    }

    if (_weatherInfo != null) {
      return Text(
        _weatherInfo!,
        style: const TextStyle(color: Colors.white, fontSize: 14),
      );
    }

    return const SizedBox.shrink();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Texas Hold\'em'),
        backgroundColor: Colors.blueGrey[900],
      ),
      body: Stack(
        children: [
          Center(
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
          Positioned(
            top: 10,
            left: 10,
            child: _buildWeatherWidget(),
          ),
        ],
      ),
    );
  }
}
