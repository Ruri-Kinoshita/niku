import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:niku/round1/provider.dart';
import 'package:niku/round1/roulette1.dart';
import '../user_provider.dart';

class JadgeResult1 extends ConsumerStatefulWidget {
  final String winningTeam;

  JadgeResult1({required this.winningTeam});

  @override
  _JadgeResult1State createState() => _JadgeResult1State();
}

class _JadgeResult1State extends ConsumerState<JadgeResult1> {
  bool _buttonPressed = false; // スコア加算ボタンの押下状態を追跡
  final Map<String, String> animalList = {
    'ねこ': 'cat',
    'フラミンゴ': 'flamingo',
    'もぐら': 'mole',
    'カラス': 'crow'
  };

  // スコアを更新する処理
  void addScoreToWinningTeam() {
    if (widget.winningTeam == 'A') {
      ref.read(userProviderProvider.notifier).addScore(1, 'A1');
      ref.read(userProviderProvider.notifier).addScore(1, 'A2');
    } else if (widget.winningTeam == 'B') {
      ref.read(userProviderProvider.notifier).addScore(1, 'B1');
      ref.read(userProviderProvider.notifier).addScore(1, 'B2');
    }
  }

  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;
    final deviceHeight = MediaQuery.of(context).size.height;
    final animal = ref.watch(animalProvider);

    final users = ref.watch(userProviderProvider); // ユーザープロバイダを監視
    debugPrint("ue");
    final A1RolePlayerName =
        ref.watch(userProviderProvider).firstWhere((User user) {
      return user.role == 'A1';
    }); // A1のプロバイダを監視
    final A2RolePlayerName =
        ref.watch(userProviderProvider).firstWhere((User user) {
      return user.role == 'A2';
    }); // A2のプロバイダを監視
    final B1RolePlayerName =
        ref.watch(userProviderProvider).firstWhere((User user) {
      return user.role == 'B1';
    }); // B1のプロバイダを監視
    final B2RolePlayerName =
        ref.watch(userProviderProvider).firstWhere((User user) {
      return user.role == 'B2';
    }); // B2のプロバイダを監視
    debugPrint("sita");

    return Scaffold(
      appBar: AppBar(
        title: Text('審査結果'),
      ),
      body: Stack(
        children: [
          // Background images layer
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
                image: AssetImage('assets/images/${animalList[animal]}.png'),
                alignment: Alignment.bottomLeft,
                fit: BoxFit.contain,
              ),
            ),
          ),
          // Main content layer
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '勝者: ${widget.winningTeam}チーム',
                  style: TextStyle(fontSize: 80, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 40),
                // 勝利チームのメンバー表示
                if (widget.winningTeam == 'A')
                  Text(
                    'Aチームの${A1RolePlayerName.name ?? '〇〇'}さん、${A2RolePlayerName.name ?? '〇〇'}さんに1ポイントずつ加算されました。',
                    style: TextStyle(fontSize: 30),
                  ),
                if (widget.winningTeam == 'B')
                  Text(
                    'Bチームの${B1RolePlayerName.name ?? '〇〇'}さん、${B2RolePlayerName.name ?? '〇〇'}さんに1ポイントずつ加算されました。',
                    style: TextStyle(fontSize: 30),
                  ),
                SizedBox(height: 40),
                Consumer(builder: (context, ref, _) {
                  return ElevatedButton(
                    onPressed: _buttonPressed
                        ? null
                        : () {
                            // 勝ったチームにスコアを加算
                            addScoreToWinningTeam();
                            ref.read(userProviderProvider.notifier).setRole2();
                            setState(() {
                              _buttonPressed = true; // ボタンを無効化
                            });
                            // 次の画面に遷移
                            context.go('/round2roleSetting');
                          },
                    child: Text('次へ'),
                  );
                }),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
