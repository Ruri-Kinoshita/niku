import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:niku/provider3.dart';
import 'package:niku/round2/provider2.dart';
import 'dart:math';
import '../round1/provider.dart'; // プロバイダをインポート

class roulette3 extends ConsumerWidget {
  const roulette3({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final firstPrompts = ['ぞう', 'フラミンゴ', 'ナマケモノ', 'カラス'];
    final secondPrompts = ['ケーキ', 'オムライス', 'ドーナツ', 'プリン'];
    final prompts = ref.watch(promptProvider3); // ここで直接プロバイダを監視
    final selectedPrompt1 = prompts.isNotEmpty ? prompts[0] : '';
    final selectedPrompt2 = prompts.isNotEmpty ? prompts[1] : '';
    final hasRolled = selectedPrompt1.isNotEmpty && selectedPrompt2.isNotEmpty;

    void getRandomPrompts() {
      final random = Random();
      ref.read(promptProvider2.notifier).setPrompts(
            firstPrompts[random.nextInt(firstPrompts.length)],
            secondPrompts[random.nextInt(secondPrompts.length)],
          );
    }

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
                onPressed: hasRolled
                    ? () {
                        context.go('/countdowntimer2');
                      }
                    : null,
                child: Text('次へ'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
