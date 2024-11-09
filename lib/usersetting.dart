import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:niku/constant/app_size.dart';
import 'package:niku/round1/provider.dart';
import 'package:niku/user_provider.dart';

class Usersetting extends ConsumerStatefulWidget {
  @override
  _UsersettingState createState() => _UsersettingState();
}

class _UsersettingState extends ConsumerState<Usersetting> {
  final List<TextEditingController> _controllers =
      List.generate(5, (_) => TextEditingController());

  // ゲームスタートボタンが押された時の処理
  void _startGame() {
    final playerNames = _controllers.map((c) => c.text).toList();

    // 名前の重複をチェック
    final hasDuplicates = playerNames.toSet().length != playerNames.length;

    if (hasDuplicates) {
      // ダイアログを表示
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('エラー'),
          content: const Text('同じ名前は使えません'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(), // OKボタンでダイアログを閉じる
              child: const Text('OK'),
            ),
          ],
        ),
      );
    } else {
      // 重複がなければゲームスタート
      var users = playerNames.map((value) => User(value)).toList();
      ref.read(userProviderProvider.notifier).addUser(users); // refを使用

      // 次の画面に遷移
      context.go('/round1RoleSetting');
    }
  }

  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: const Text('プレイヤー登録'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: Column(
            children: [
              SizedBox(height: 50),
              const Text(
                'プレイヤーを登録しよう！名前を入力してね！',
                style: TextStyle(fontSize: FontSize.body),
              ),
              const SizedBox(height: 20),
              for (int i = 0; i < 5; i++)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: Container(
                    width: deviceWidth * 0.5,
                    child: TextField(
                      controller: _controllers[i],
                      decoration: InputDecoration(
                        labelText: 'プレイヤー ${i + 1} の名前',
                        border: const OutlineInputBorder(),
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 12.0,
                          vertical: 8.0,
                        ),
                      ),
                    ),
                  ),
                ),
              //const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _startGame, // ボタン押下時に処理を実行
                child: const Text('ゲームスタート！'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }
}
