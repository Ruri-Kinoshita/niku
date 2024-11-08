import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class Jadge3 extends StatefulWidget {
  @override
  State<Jadge3> createState() => _Jadge3State();
}

class _Jadge3State extends State<Jadge3> {
  // 各項目の選択状態を管理する変数
  String? selectedA;
  String? selectedB;
  String? selectedC;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AチームとBチームのジャッジ'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('審査員役の人以外この画面は見てはいけません！！！！！！！'),
            const SizedBox(height: 20),

            // 項目Aの選択
            const Text(
              '項目A: ミッションブロックへの対応力',
              style: TextStyle(fontSize: 18),
            ),
            Row(
              children: [
                Expanded(
                  child: RadioListTile<String>(
                    title: const Text('A'),
                    value: 'A',
                    groupValue: selectedA,
                    onChanged: (value) {
                      setState(() {
                        selectedA = value;
                      });
                    },
                  ),
                ),
                Expanded(
                  child: RadioListTile<String>(
                    title: const Text('B'),
                    value: 'B',
                    groupValue: selectedA,
                    onChanged: (value) {
                      setState(() {
                        selectedA = value;
                      });
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // 項目Bの選択
            const Text(
              '項目B: 料理に見えるか(再現力)',
              style: TextStyle(fontSize: 18),
            ),
            Row(
              children: [
                Expanded(
                  child: RadioListTile<String>(
                    title: const Text('A'),
                    value: 'A',
                    groupValue: selectedB,
                    onChanged: (value) {
                      setState(() {
                        selectedB = value;
                      });
                    },
                  ),
                ),
                Expanded(
                  child: RadioListTile<String>(
                    title: const Text('B'),
                    value: 'B',
                    groupValue: selectedB,
                    onChanged: (value) {
                      setState(() {
                        selectedB = value;
                      });
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // 項目Cの選択
            const Text(
              '項目C: どっちが好きか（完全主観）',
              style: TextStyle(fontSize: 18),
            ),
            Row(
              children: [
                Expanded(
                  child: RadioListTile<String>(
                    title: const Text('A'),
                    value: 'A',
                    groupValue: selectedC,
                    onChanged: (value) {
                      setState(() {
                        selectedC = value;
                      });
                    },
                  ),
                ),
                Expanded(
                  child: RadioListTile<String>(
                    title: const Text('B'),
                    value: 'B',
                    groupValue: selectedC,
                    onChanged: (value) {
                      setState(() {
                        selectedC = value;
                      });
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 32),

            // 決定して次へボタン
            Center(
              child: ElevatedButton(
                onPressed: () {
                  // 3つの項目がすべて選択されている場合にのみ次の画面に進む
                  if (selectedA != null &&
                      selectedB != null &&
                      selectedC != null) {
                    // 各チームの選択数をカウント
                    int countA = 0;
                    int countB = 0;

                    if (selectedA == 'A') countA++;
                    if (selectedB == 'A') countA++;
                    if (selectedC == 'A') countA++;

                    if (selectedA == 'B') countB++;
                    if (selectedB == 'B') countB++;
                    if (selectedC == 'B') countB++;

                    // 勝利チームを判定
                    String winningTeam;
                    if (countA > countB) {
                      winningTeam = 'A';
                    } else if (countB > countA) {
                      winningTeam = 'B';
                    } else {
                      winningTeam = '引き分け'; // 引き分けの場合の処理
                    }

                    // 次の画面に結果を渡して遷移
                    context.go('/jadgeresult3', extra: {
                      'resultA': selectedA!,
                      'resultB': selectedB!,
                      'resultC': selectedC!,
                      'winningTeam': winningTeam,
                    });
                  } else {
                    // すべての項目を選択するようにユーザーに通知
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: const Text('エラー'),
                        content: const Text('すべての項目を選択してください。'),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.of(context).pop(),
                            child: const Text('OK'),
                          ),
                        ],
                      ),
                    );
                  }
                },
                child: const Text('決定して次へ'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
