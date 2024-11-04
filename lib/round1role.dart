import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'dart:math';

import 'package:niku/titlepage.dart'; // ランダムにシャッフルするためにインポート

class Round1RoleSetting extends StatefulWidget {
  final List<String> playerNames; // プレイヤー名を受け取るためのフィールド

  Round1RoleSetting({required this.playerNames});

  @override
  State<Round1RoleSetting> createState() => _Round1RoleSettingState();
}

class _Round1RoleSettingState extends State<Round1RoleSetting> {
  // 割り当てる役割のリスト
  final List<String> roles = ['A1', 'A2', 'B1', 'B2', 'J'];
  List<String>? randomizedRoles;

  @override
  void initState() {
    super.initState();
    _assignRandomRoles();
  }

  void _assignRandomRoles() {
    // 役割リストをシャッフル
    randomizedRoles = List.from(roles); // 役割をコピー
    randomizedRoles!.shuffle(Random()); // シャッフル
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Round 1 役割設定'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // 各プレイヤーにランダムに割り当てられた役割を表示
            for (int i = 0; i < widget.playerNames.length; i++)
              ListTile(
                title: Text('${widget.playerNames[i]}: ${randomizedRoles![i]}'),
              ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // 次の画面や処理に進むためのアクション
                print(
                    '役割が割り当てられました: ${widget.playerNames.asMap().map((i, name) => MapEntry(i, '$name: ${randomizedRoles![i]}'))}');
                context.go('/roulette');
              },
              child: Text('次へ'),
            ),
          ],
        ),
      ),
    );
  }
}
