import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:niku/constant/app_color.dart';
import 'package:niku/round1/roulette1.dart';
import 'package:niku/user_provider.dart';
import 'provider.dart'; // プロバイダをインポート

class Jaddpoint1 extends ConsumerStatefulWidget {
  const Jaddpoint1({Key? key}) : super(key: key);

  @override
  _Jaddpoint1State createState() => _Jaddpoint1State();
}

class _Jaddpoint1State extends ConsumerState<Jaddpoint1> {
  bool _buttonPressed = false; // お題表示ボタンの押下状態を追跡
  bool _buttonDisabled = false; // 判定ボタンの押下状態を追跡
  String _judgePressed = ""; // 判定結果の表示用

  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;
    final prompts = ref.watch(promptProvider); // お題プロバイダを監視
    final jRolePlayerName =
        ref.watch(userProviderProvider).firstWhere((User user) {
      return user.role == 'J';
    }); // "J" 役プロバイダを監視

    return Scaffold(
      appBar: AppBar(title: const Text('審査員の挑戦')),
      body: Stack(
        children: [
          Opacity(
            opacity: 0.7,
            child: Container(
                width: deviceWidth * 0.4,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/leaf_left.png'),
                    alignment: Alignment.bottomLeft,
                  ),
                )),
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
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '審査員役の${jRolePlayerName.name ?? '〇〇'}さん',
                  style: const TextStyle(fontSize: 30),
                ), // "J" 役の名前またはプレースホルダーを表示
                const Text(
                  'これはなんの料理でしょうか？',
                  style: TextStyle(fontSize: 30),
                ),
                const Text(
                  '2回まで回答できます',
                  style: TextStyle(fontSize: 30),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      '1回目で正解したら',
                      style: TextStyle(fontSize: 30),
                    ),
                    Text(
                      '◎',
                      style:
                          TextStyle(fontSize: 30, color: Colors.red.shade800),
                    ),
                    const Text(
                      '，2回目で正解したら',
                      style: TextStyle(fontSize: 30),
                    ),
                    Text(
                      '○',
                      style: TextStyle(
                        fontSize: 25,
                        color: Colors.pink.shade600,
                      ),
                    ),
                    const Text(
                      '，不正解なら',
                      style: TextStyle(fontSize: 30),
                    ),
                    Text(
                      '×',
                      style:
                          TextStyle(fontSize: 30, color: Colors.blue.shade900),
                    ),
                    const Text(
                      'を押してください',
                      style: TextStyle(fontSize: 30),
                    ),
                  ],
                ),
                const SizedBox(height: 30),
                ElevatedButton(
                  onPressed: _buttonPressed
                      ? null
                      : () {
                          setState(() {
                            _buttonPressed = true;
                          });
                        },
                  child: const Text('答えを表示'),
                ),
                if (_buttonPressed) ...[
                  const SizedBox(height: 20),
                  Text(
                    '料理: ${prompts[1]}',
                    style: const TextStyle(fontSize: 24),
                  ),
                ],
                const SizedBox(height: 30),
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: _buttonDisabled
                            ? null
                            : () {
                                ref
                                    .read(userProviderProvider.notifier)
                                    .addScore(2, "J");
                                setState(() {
                                  _judgePressed =
                                      '審査員の${jRolePlayerName.name ?? '〇〇'}さんに2ポイント加算されました。';
                                  _buttonDisabled = true; // ボタンを無効化
                                });
                              },
                        style: ElevatedButton.styleFrom(
                          shape: const CircleBorder(),
                          padding: const EdgeInsets.all(30),
                          backgroundColor: Colors.white,
                          side:
                              BorderSide(color: Colors.red.shade800, width: 6),
                        ),
                        child: Text(
                          '◎',
                          style: TextStyle(
                              fontWeight: FontWeight.w900,
                              fontSize: 80,
                              color: Colors.red.shade800),
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      ElevatedButton(
                        onPressed: _buttonDisabled
                            ? null
                            : () {
                                ref
                                    .read(userProviderProvider.notifier)
                                    .addScore(1, "J");
                                setState(() {
                                  _judgePressed =
                                      '審査員の${jRolePlayerName.name ?? '〇〇'}さんに1ポイント加算されました。';
                                  _buttonDisabled = true; // ボタンを無効化
                                });
                              },
                        style: ElevatedButton.styleFrom(
                          shape: const CircleBorder(),
                          padding: const EdgeInsets.all(35),
                          backgroundColor: Colors.white,
                          side:
                              BorderSide(color: Colors.pink.shade600, width: 6),
                        ),
                        child: Center(
                          child: Text(
                            '○',
                            style: TextStyle(
                              fontWeight: FontWeight.w900,
                              fontSize: 70,
                              color: Colors.pink.shade600,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      ElevatedButton(
                        onPressed: _buttonDisabled
                            ? null
                            : () {
                                setState(() {
                                  _judgePressed = "ざんねん！0ポイントです。";
                                  _buttonDisabled = true; // ボタンを無効化
                                });
                              },
                        style: ElevatedButton.styleFrom(
                          shape: const CircleBorder(),
                          padding: const EdgeInsets.all(30),
                          backgroundColor: Colors.white,
                          side:
                              BorderSide(color: Colors.blue.shade900, width: 6),
                        ),
                        child: Text(
                          '×',
                          style: TextStyle(
                              fontWeight: FontWeight.w900,
                              fontSize: 80,
                              color: Colors.blue.shade900),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 20),
                if (_judgePressed.isNotEmpty)
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        _judgePressed,
                        style: const TextStyle(fontSize: 24),
                      ),
                      // Text(ref
                      //     .watch(userProviderProvider)
                      //     .firstWhere((test) => test.role == 'J')
                      //     .score
                      //     .toString())
                      const SizedBox(height: 20),
                    ],
                  ),
                ElevatedButton(
                    onPressed: () {
                      context.go('/teampresentation1');
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColor.ui.lightgreen,
                      side: BorderSide(
                          width: 3, color: Colors.green.withOpacity(1)),
                      fixedSize: const Size(100, 50),
                    ),
                    child: const Text('次へ'))
              ],
            ),
          ),
        ],
      ),
    );
  }
}
