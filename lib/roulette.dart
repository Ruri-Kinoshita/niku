import 'package:flutter/material.dart';
import 'dart:math';

class Roulette extends StatefulWidget {
  const Roulette({super.key});

  @override
  State<Roulette> createState() => _RouletteState();
}

class _RouletteState extends State<Roulette> {
  final List<String> prompts = ['りんご', 'きのこ', 'くるま', 'クレープ', 'いちご'];
  String selectedPrompt = '';

  void getRandomPrompt() {
    final random = Random();
    setState(() {
      selectedPrompt = prompts[random.nextInt(prompts.length)];
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('ランダムお題表示')),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                selectedPrompt.isEmpty ? 'お題を表示します' : selectedPrompt,
                style: TextStyle(fontSize: 24),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: getRandomPrompt,
                child: Text('お題を表示'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
