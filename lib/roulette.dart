import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'dart:math';

import 'package:niku/titlepage.dart';

class Roulette extends StatefulWidget {
  const Roulette({super.key});

  @override
  State<Roulette> createState() => _RouletteState();
}

class _RouletteState extends State<Roulette> {
  final List<String> firstPrompts = ['ぞう', 'フラミンゴ', 'ナマケモノ', 'カラス'];
  final List<String> secondPrompts = ['ケーキ', 'オムライス', 'ドーナツ', 'プリン'];
  String selectedPrompt1 = '';
  String selectedPrompt2 = '';
  bool hasRolled = false; // ルーレットを回したかどうかのフラグ

  void getRandomPrompts() {
    if (!hasRolled) {
      // まだルーレットを回していない場合のみ実行
      final random = Random();
      setState(() {
        selectedPrompt1 = firstPrompts[random.nextInt(firstPrompts.length)];
        selectedPrompt2 = secondPrompts[random.nextInt(secondPrompts.length)];
        hasRolled = true; // 一度回したらフラグを立てる
      });
    }
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
                selectedPrompt1.isEmpty
                    ? 'お客さんは誰だろう？'
                    : 'お客さん: $selectedPrompt1',
                style: TextStyle(fontSize: 24),
              ),
              SizedBox(height: 20),
              Text(
                selectedPrompt2.isEmpty
                    ? '作る料理は何にしよう？'
                    : '料理: $selectedPrompt2',
                style: TextStyle(fontSize: 24),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: hasRolled ? null : getRandomPrompts, // 2回目以降は無効化
                child: Text('お題を表示'),
              ),
              SizedBox(height: 10),
              ElevatedButton(
                  onPressed: () {
                    context.go('/countdowntimer');
                  },
                  child: Text('次へ'))
            ],
          ),
        ),
      ),
    );
  }
}
