import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:niku/provider3.dart';
import 'dart:math';

class roulette3 extends ConsumerWidget {
  const roulette3({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final firstPrompts = ['ねこ', 'フラミンゴ', 'もぐら', 'カラス'];
    final secondPrompts = ['ケーキ', 'オムライス', 'ドーナツ', 'プリン', 'サンドイッチ', 'カレーライス'];
    final prompts = ref.watch(promptProvider3);
    final selectedPrompt1 = prompts.isNotEmpty ? prompts[0] : '';
    final selectedPrompt2 = prompts.isNotEmpty ? prompts[1] : '';
    final hasRolled = selectedPrompt1.isNotEmpty && selectedPrompt2.isNotEmpty;
    final deviceWidth = MediaQuery.of(context).size.width;

    void getRandomPrompts() {
      final random = Random();
      ref.read(promptProvider3.notifier).setPrompts(
            firstPrompts[random.nextInt(firstPrompts.length)],
            secondPrompts[random.nextInt(secondPrompts.length)],
          );
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Round3 お題発表')),
      body: Stack(
        children: [
          // 左側の背景画像
          Opacity(
            opacity: 0.7,
            child: Container(
              width: deviceWidth * 0.4,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/leaf_left.png'),
                  alignment: Alignment.bottomLeft,
                ),
              ),
            ),
          ),
          // 右側の背景画像
          Align(
            alignment: Alignment.bottomRight,
            child: Opacity(
              opacity: 0.7,
              child: Container(
                width: deviceWidth * 0.62,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/leaf_right.png'),
                    alignment: Alignment.bottomRight,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),
          ),
          // ルーレットのUI
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(height: 170),
                Text(
                  selectedPrompt1.isEmpty ? '' : 'あなたたちは$selectedPrompt1になったよ！',
                  style: const TextStyle(fontSize: 45),
                ),
                const SizedBox(height: 20),
                Text(
                  selectedPrompt2.isEmpty ? '' : 'お題の料理は$selectedPrompt2！',
                  style: const TextStyle(fontSize: 45),
                ),

                // ファーストプロンプトごとの説明文を枠で囲む
                if (selectedPrompt1 == 'フラミンゴ')
                  buildPromptBox('フラミンゴは片足立ちが得意だよ！\n片足立ちで料理を作ってね'),
                if (selectedPrompt1 == 'ねこ')
                  buildPromptBox('ねこは鳴き声と視線で会話をするよ\nにゃんにゃん！（猫語で協力だ！）'),
                if (selectedPrompt1 == 'もぐら')
                  buildPromptBox('もぐらは太陽の光が苦手...\nサングラスをつけて料理を作ろう！'),
                if (selectedPrompt1 == 'カラス')
                  buildPromptBox('カラスはくちばしを上手に使うのが得意だよ！\n手をくちばしの形にして料理を作ってね'),
                const SizedBox(height: 20),

                const SizedBox(height: 40),
                ElevatedButton(
                  onPressed: hasRolled ? null : getRandomPrompts,
                  child: const Text('お題を発表'),
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: hasRolled
                      ? () {
                          context.go('/countdowntimer3');
                        }
                      : null,
                  child: const Text('次へ'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // 説明文を枠で囲むためのウィジェット
  Widget buildPromptBox(String text) {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0),
      child: Container(
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.redAccent, width: 2.0),
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Text(
          text,
          style: const TextStyle(fontSize: 28, color: Colors.redAccent),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
