import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:niku/round2/roulette2.dart';

class teampresentation2 extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final Map<String, String> animalList = {
      'ねこ': 'cat',
      'フラミンゴ': 'flamingo',
      'もぐら': 'mole',
      'カラス': 'crow'
    };
    final animal = ref.watch(animalProvider2); // animalProvider2の状態を監視

    final deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: const Text('料理の紹介'),
      ),
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
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                    'assets/images/${animalList[animal]}.png'), // animalListのキーを使って画像を表示
                alignment: Alignment.bottomLeft,
                fit: BoxFit.contain,
              ),
            ),
          ),
          // プレゼンテーション内容
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(height: 120),
                const Text(
                  '審査員に料理のこだわりポイントを紹介しよう！',
                  style: TextStyle(fontSize: 40),
                  textAlign: TextAlign.center, // Center-aligns the text
                ),
                const SizedBox(height: 70),
                Text(
                  '審査基準',
                  style: TextStyle(fontSize: 35),
                  textAlign: TextAlign.center,
                ),
                // Bordered Text Container with Background Color
                Container(
                  padding:
                      const EdgeInsets.all(16.0), // Padding inside the border
                  decoration: BoxDecoration(
                    color: Colors.green.withOpacity(0.5), // Background color
                    border: Border.all(
                      color: Colors.grey, // Border color
                      width: 2.0, // Border width
                    ),
                    borderRadius:
                        BorderRadius.circular(10.0), // Rounded corners
                  ),
                  child: const Text(
                    '料理の再現度\nミッションブロックへの対応力\n審査員の心への刺さり度合い',
                    style: TextStyle(fontSize: 30, color: Colors.black87),
                    textAlign: TextAlign.center, // Center-aligns the text
                  ),
                ),
                const SizedBox(height: 30),
                Text(
                  '両チームの説明が終わったら次のページに進んでください',
                  style: TextStyle(fontSize: 35),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 50),
                ElevatedButton(
                  onPressed: () {
                    context.go('/jadge2'); // 次の画面に遷移
                  },
                  child: const Text('次へ'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
