import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class Jadge1 extends StatefulWidget {
  @override
  State<Jadge1> createState() => _Jadge1State();
}

class _Jadge1State extends State<Jadge1> {
  // 各項目の選択状態を管理する変数
  String? selectedA;
  String? selectedB;
  String? selectedC;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('AチームとBチームのジャッジ'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('審査員役の人以外この画面は見てはいけません！！！！！！！'),
            SizedBox(height: 20),

            // 項目Aの選択
            Text(
              '項目A: ミッションブロックへの対応力',
              style: TextStyle(fontSize: 18),
            ),
            Row(
              children: [
                Expanded(
                  child: RadioListTile<String>(
                    title: Text('A'),
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
                    title: Text('B'),
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
            SizedBox(height: 16),

            // 項目Bの選択
            Text(
              '項目B: 料理に見えるか(再現力)',
              style: TextStyle(fontSize: 18),
            ),
            Row(
              children: [
                Expanded(
                  child: RadioListTile<String>(
                    title: Text('A'),
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
                    title: Text('B'),
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
            SizedBox(height: 16),

            // 項目Cの選択
            Text(
              '項目C: どっちが好きか（完全主観）',
              style: TextStyle(fontSize: 18),
            ),
            Row(
              children: [
                Expanded(
                  child: RadioListTile<String>(
                    title: Text('A'),
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
                    title: Text('B'),
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
            SizedBox(height: 32),

            // 決定して次へボタン
            Center(
              child: ElevatedButton(
                onPressed: () {
                  // 3つの項目がすべて選択されている場合にのみ次の画面に進む
                  if (selectedA != null &&
                      selectedB != null &&
                      selectedC != null) {
                    context.push('/jadgeresult1', extra: {
                      'resultA': selectedA!,
                      'resultB': selectedB!,
                      'resultC': selectedC!,
                    });
                  } else {
                    // すべての項目を選択するようにユーザーに通知
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: Text('エラー'),
                        content: Text('すべての項目を選択してください。'),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.of(context).pop(),
                            child: Text('OK'),
                          ),
                        ],
                      ),
                    );
                  }
                },
                child: Text('決定して次へ'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
