import 'package:flutter/material.dart';
import 'dart:math';

class Roulette extends StatefulWidget {
  const Roulette({super.key});

  @override
  State<Roulette> createState() => _RouletteState();
}

class _RouletteState extends State<Roulette> {
  final List<String> firstPrompts = ['りんご', 'きのこ', 'くるま', 'クレープ', 'いちご'];
  final List<String> secondPrompts = ['みかん', 'ぶどう', 'バナナ', 'パイナップル', 'もも'];
  String selectedPrompt1 = '';
  String selectedPrompt2 = '';

  void getRandomPrompts() {
    final random = Random();
    setState(() {
      selectedPrompt1 = firstPrompts[random.nextInt(firstPrompts.length)];
      selectedPrompt2 = secondPrompts[random.nextInt(secondPrompts.length)];
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('2つのランダムお題表示')),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                selectedPrompt1.isEmpty ? 'お題1を表示します' : 'お題1: $selectedPrompt1',
                style: TextStyle(fontSize: 24),
              ),
              SizedBox(height: 20),
              Text(
                selectedPrompt2.isEmpty ? 'お題2を表示します' : 'お題2: $selectedPrompt2',
                style: TextStyle(fontSize: 24),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: getRandomPrompts,
                child: Text('お題を表示'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
