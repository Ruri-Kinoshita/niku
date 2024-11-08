import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:niku/round1/provider.dart';
import '../../user_provider.dart'; // プロバイダのインポート

class Jadgeresult3 extends ConsumerStatefulWidget {
  final String winningTeam;

  Jadgeresult3({required this.winningTeam});

  @override
  _JadgeResult3State createState() => _JadgeResult3State();
}

class _JadgeResult3State extends ConsumerState<Jadgeresult3> {
  bool _buttonPressed = false; // スコア加算ボタンの押下状態を追跡

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
    final users = ref.watch(userProviderProvider); // ユーザープロバイダを監視
    debugPrint("ue");
    final A1RolePlayerName =
        ref.watch(userProviderProvider).firstWhere((User user) {
      return user.role == 'A1';
    }); //A1のプロバイダを監視
    final A2RolePlayerName =
        ref.watch(userProviderProvider).firstWhere((User user) {
      return user.role == 'A2';
    }); //A2のプロバイダを監視
    final B1RolePlayerName =
        ref.watch(userProviderProvider).firstWhere((User user) {
      return user.role == 'B1';
    }); //B1のプロバイダを監視
    final B2RolePlayerName =
        ref.watch(userProviderProvider).firstWhere((User user) {
      return user.role == 'B2';
    }); //B2のプロバイダを監視\
    debugPrint("sita");

    return Scaffold(
      appBar: AppBar(
        title: Text('審査結果'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '勝者: ${widget.winningTeam}チーム',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            // 勝利チームのメンバー表示
            if (widget.winningTeam == 'A')
              Text(
                  'Aチームの${A1RolePlayerName.name ?? '〇〇'}さん、${A2RolePlayerName.name ?? '〇〇'}さんに1ポイントずつ加算されました。'),
            if (widget.winningTeam == 'B')
              Text(
                  'Bチームの${B1RolePlayerName.name ?? '〇〇'}さん、${B2RolePlayerName.name ?? '〇〇'}さんに1ポイントずつ加算されました。'),
            SizedBox(height: 40),
            Consumer(builder: (context, ref, _) {
              return ElevatedButton(
                onPressed: _buttonPressed
                    ? () {}
                    : () {
                        // 勝ったチームにスコアを加算
                        addScoreToWinningTeam();
                        ref.read(userProviderProvider.notifier).setRole3();
                        setState(() {
                          _buttonPressed = true; // ボタンを無効化
                        });
                        // 次の画面に遷移
                        context.push('/finalranking');
                      },
                child: Text('次へ'),
              );
            }),
          ],
        ),
      ),
    );
  }
}
