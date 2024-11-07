import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:niku/roulette.dart';
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
    final prompts = ref.watch(promptProvider); // お題プロバイダを監視
    final jRolePlayerName =
        ref.watch(userProviderProvider).firstWhere((User user) {
      return user.role == 'J';
    }); // "J" 役プロバイダを監視

    return Scaffold(
      appBar: AppBar(title: Text('選ばれたお題')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
                '審査員役の${jRolePlayerName.name ?? '〇〇'}さん'), // "J" 役の名前またはプレースホルダーを表示
            Text('これはなんの料理でしょうか？'),
            Text('2回まで回答できます'),
            Text('1回目で正解したら◎，2回目で正解したら○，不正解なら×を押してください'),
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
                              _judgePressed = "2点加算";
                              _buttonDisabled = true; // ボタンを無効化
                            });
                          },
                    child: const Text('◎'),
                    style: ElevatedButton.styleFrom(
                      shape: CircleBorder(),
                      padding: EdgeInsets.all(60),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: _buttonDisabled
                        ? null
                        : () {
                            ref
                                .read(userProviderProvider.notifier)
                                .addScore(1, "J");
                            setState(() {
                              _judgePressed = "1点加算";
                              _buttonDisabled = true; // ボタンを無効化
                            });
                          },
                    child: const Text('○'),
                    style: ElevatedButton.styleFrom(
                      shape: CircleBorder(),
                      padding: EdgeInsets.all(60),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: _buttonDisabled
                        ? null
                        : () {
                            setState(() {
                              _judgePressed = "ざまあ";
                              _buttonDisabled = true; // ボタンを無効化
                            });
                          },
                    child: const Text('×'),
                    style: ElevatedButton.styleFrom(
                      shape: CircleBorder(),
                      padding: EdgeInsets.all(60),
                    ),
                  ),
                ],
              ),
            ),
            if (_buttonPressed) ...[
              Text(
                'お客さん: ${prompts[0]}',
                style: TextStyle(fontSize: 24),
              ),
              SizedBox(height: 20),
              Text(
                '料理: ${prompts[1]}',
                style: TextStyle(fontSize: 24),
              ),
            ],
            SizedBox(height: 30),
            ElevatedButton(
              onPressed: _buttonPressed
                  ? null
                  : () {
                      setState(() {
                        _buttonPressed = true;
                      });
                    },
              child: Text('お題を表示'),
            ),
            SizedBox(height: 50),
            if (_judgePressed.isNotEmpty)
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(_judgePressed),
                  Text(ref
                      .watch(userProviderProvider)
                      .firstWhere((test) => test.role == 'J')
                      .score
                      .toString())
                ],
              ),
            ElevatedButton(
                onPressed: () {
                  context.go('/teampresentation1');
                },
                child: Text('次へ'))
          ],
        ),
      ),
    );
  }
}
