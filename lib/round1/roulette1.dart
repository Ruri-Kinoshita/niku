import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:niku/user_provider.dart';
import 'dart:math';
import 'provider.dart';

// Providers to manage visibility and press state of buttons
final secondPromptVisibilityProvider = StateProvider<bool>((ref) => false);
final isAnimalPromptPressedProvider = StateProvider<bool>((ref) => false);
final isFoodPromptPressedProvider = StateProvider<bool>((ref) => false);
final animalProvider = StateProvider<String>((ref) => '');
final isTextVisibleProvider =
    StateProvider<bool>((ref) => false); // Add provider for text visibility

class Roulette extends ConsumerWidget {
  const Roulette({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final firstPrompts = ['ねこ', 'フラミンゴ', 'もぐら', 'カラス'];
    //TODO animal画像コピペ
    final Map<String, String> animalList = {
      'ねこ': 'cat',
      'フラミンゴ': 'flamingo',
      'もぐら': 'mole',
      'カラス': 'crow'
    };
    final secondPrompts = ['ケーキ', 'オムライス', 'ドーナツ', 'プリン', 'サンドイッチ', 'カレーライス'];
    final prompts = ref.watch(promptProvider);
    final selectedPrompt1 = prompts.isNotEmpty ? prompts[0] : '';
    final selectedPrompt2 = prompts.isNotEmpty ? prompts[1] : '';
    final deviceWidth = MediaQuery.of(context).size.width;
    final deviceHeight = MediaQuery.of(context).size.height;
    final jRolePlayerName =
        ref.watch(userProviderProvider).firstWhere((User user) {
      return user.role == 'J';
    });

    // animal の状態を監視
    //TODO animal画像コピペ
    final animal = ref.watch(animalProvider);

    // 動物のお題をランダムに選ぶ
    void getRandomPrompts() {
      final random = Random();
      final firstPrompt = firstPrompts[random.nextInt(firstPrompts.length)];
      final secondPrompt = secondPrompts[random.nextInt(secondPrompts.length)];

      ref.read(promptProvider.notifier).setPrompts(firstPrompt, secondPrompt);

      // animal の値を animalProvider を通して更新
      ref.read(animalProvider.state).state = firstPrompt;

      ref.read(isAnimalPromptPressedProvider.state).state = true;
      ref.read(isTextVisibleProvider.state).state = true;
    }

    void showFoodPrompt() {
      ref.read(secondPromptVisibilityProvider.state).state = true;
      ref.read(isFoodPromptPressedProvider.state).state =
          true; // Mark food prompt as pressed
    }

    final isAnimalPromptPressed = ref.watch(isAnimalPromptPressedProvider);
    final isFoodPromptPressed = ref.watch(isFoodPromptPressedProvider);
    final isTextVisible =
        ref.watch(isTextVisibleProvider); // Watch the text visibility state

    return Scaffold(
      appBar: AppBar(title: Text('Round1 お題発表')),
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

          // 動物のお題が押されたとき、画像を表示
          if (isAnimalPromptPressed && animal.isNotEmpty)
            //TODO animal画像コピペ
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/${animalList[animal]}.png'),
                  alignment: Alignment.bottomLeft,
                  fit: BoxFit.contain,
                ),
              ),
            ),

          // ルーレットのUI
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
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
                if (ref.watch(secondPromptVisibilityProvider.state).state)
                  Text(
                    selectedPrompt2.isEmpty ? '' : 'お題の料理は$selectedPrompt2！',
                    style: TextStyle(fontSize: 45),
                  ),
                SizedBox(height: 50),
                ElevatedButton(
                  onPressed: isAnimalPromptPressed && isFoodPromptPressed
                      ? () {
                          context.go('/countdowntimer');
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
