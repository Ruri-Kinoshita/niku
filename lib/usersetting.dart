import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class Usersetting extends StatefulWidget {
  @override
  State<Usersetting> createState() => _UsersettingState();
}

class _UsersettingState extends State<Usersetting> {
  final List<TextEditingController> _controllers =
      List.generate(5, (_) => TextEditingController());

  bool _isFormValid = false;

  void _checkFormValid() {
    setState(() {
      _isFormValid =
          _controllers.every((controller) => controller.text.isNotEmpty);
    });
  }

  @override
  void initState() {
    super.initState();
    for (var controller in _controllers) {
      controller.addListener(_checkFormValid); // 各コントローラにリスナーを追加
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('プレイヤー登録'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            for (int i = 0; i < 5; i++)
              TextField(
                controller: _controllers[i],
                decoration: InputDecoration(
                  labelText: 'プレイヤー ${i + 1} の名前',
                  border: OutlineInputBorder(),
                ),
              ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _isFormValid
                  ? () {
                      final playerNames =
                          _controllers.map((c) => c.text).toList();
                      print('プレイヤー名: $playerNames');
                      context.go(
                        '/round1RoleSetting',
                        extra: playerNames,
                      );
                    }
                  : null,
              child: Text('ゲームスタート！'),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.removeListener(_checkFormValid); // リスナーを削除
      controller.dispose();
    }
    super.dispose();
  }
}
