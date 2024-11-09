import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:niku/provider3.dart';
import 'dart:math';

//import 'package:niku/round1/provider.dart';
import 'package:niku/user_provider.dart';

import 'round1/provider.dart';

final secondPromptVisibilityProvider3 = StateProvider<bool>((ref) => false);
final isAnimalPromptPressedProvider3 = StateProvider<bool>((ref) => false);
final isFoodPromptPressedProvider3 = StateProvider<bool>((ref) => false);
final isTextVisibleProvider3 =
    StateProvider<bool>((ref) => false); // Add provider for text visibility

class roulette3 extends ConsumerWidget {
  const roulette3({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final firstPrompts = ['ねこ', 'フラミンゴ', 'もぐら', 'カラス'];
    final secondPrompts = ['ケーキ', 'オムライス', 'ドーナツ', 'プリン', 'サンドイッチ', 'カレーライス'];
    final prompts = ref.watch(promptProvider3);
    final selectedPrompt1 = prompts.isNotEmpty ? prompts[0] : '';
    final selectedPrompt2 = prompts.isNotEmpty ? prompts[1] : '';
    final deviceWidth = MediaQuery.of(context).size.width;
    final deviceHeight = MediaQuery.of(context).size.height;
    final jRolePlayerName =
        ref.watch(userProviderProvider).firstWhere((User user) {
      return user.role == 'J';
    });

    void getRandomPrompts() {
      final random = Random();
      ref.read(promptProvider3.notifier).setPrompts(
            firstPrompts[random.nextInt(firstPrompts.length)],
            secondPrompts[random.nextInt(secondPrompts.length)],
          );
      ref.read(isAnimalPromptPressedProvider3.state).state =
          true; // Mark animal prompt as pressed
      ref.read(isTextVisibleProvider3.state).state =
          true; // Show the text when animal prompt is pressed
    }

    void showFoodPrompt() {
      ref.read(secondPromptVisibilityProvider3.state).state = true;
      ref.read(isFoodPromptPressedProvider3.state).state =
          true; // Mark food prompt as pressed
    }

    final isAnimalPromptPressed = ref.watch(isAnimalPromptPressedProvider3);
    final isFoodPromptPressed = ref.watch(isFoodPromptPressedProvider3);
    final isTextVisible =
        ref.watch(isTextVisibleProvider3); // Watch the text visibility state

    return Scaffold(
      appBar: AppBar(title: Text('Round3 お題発表')),
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
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                //SizedBox(height: 170),
                Text(
                  selectedPrompt1.isEmpty ? '' : 'あなたたちは$selectedPrompt1になったよ！',
                  style: TextStyle(fontSize: 45),
                ),
                SizedBox(height: 20),

                // ファーストプロンプトごとの説明文を枠で囲む
                if (selectedPrompt1 == 'フラミンゴ')
                  buildPromptBox('フラミンゴは片足立ちが得意だよ！\n片足立ちで料理を作ってね'),
                if (selectedPrompt1 == 'ねこ')
                  buildPromptBox('ねこは鳴き声と視線で会話をするよ\nにゃんにゃん！（猫語で協力だ！）'),
                if (selectedPrompt1 == 'もぐら')
                  buildPromptBox('もぐらは太陽の光が苦手...\nサングラスをつけて料理を作ろう！'),
                if (selectedPrompt1 == 'カラス')
                  buildPromptBox('カラスはくちばしを上手に使うのが得意だよ！\n手をくちばしの形にして料理を作ってね'),

                SizedBox(height: 40),
                ElevatedButton(
                  onPressed: isAnimalPromptPressed
                      ? null
                      : getRandomPrompts, // Disable if animal prompt pressed
                  child: Text('動物を発表'),
                ),
                if (isTextVisible == false)
                  SizedBox(
                    height: 30,
                  ),

                // Show text after animal prompt button is pressed
                if (isTextVisible)
                  Text(
                    '料理を発表するよ！審査員の${jRolePlayerName.name ?? '〇〇'}さんが画面を見ないようにして\n下のボタンを押してね',
                    style: TextStyle(fontSize: 28),
                    textAlign: TextAlign.center,
                  ),

                // Button to show the second prompt
                ElevatedButton(
                  onPressed: isAnimalPromptPressed
                      ? showFoodPrompt
                      : null, // Disable if animal prompt not pressed
                  child: Text('お題の料理を発表'),
                ),
                // Show second prompt if visibility is true
                if (ref.watch(secondPromptVisibilityProvider3.state).state)
                  Text(
                    selectedPrompt2.isEmpty ? '' : 'お題の料理は$selectedPrompt2！',
                    style: TextStyle(fontSize: 45),
                  ),
                SizedBox(height: 50),
                ElevatedButton(
                  onPressed: isAnimalPromptPressed && isFoodPromptPressed
                      ? () {
                          context.go('/countdowntimer3');
                        }
                      : null, // Disable if both prompts are not pressed
                  child: Text('次へ'),
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
          style: TextStyle(fontSize: 28, color: Colors.redAccent),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
