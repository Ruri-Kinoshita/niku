import 'package:flutter/material.dart';

class JadgeResult1 extends StatefulWidget {
  final String resultA;
  final String resultB;
  final String resultC;

  JadgeResult1({
    required this.resultA,
    required this.resultB,
    required this.resultC,
  });

  @override
  State<JadgeResult1> createState() => _JadgeResult1State();
}

class _JadgeResult1State extends State<JadgeResult1> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('勝敗結果'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text('項目A: ${widget.resultA}'),
            Text('項目B: ${widget.resultB}'),
            Text('項目C: ${widget.resultC}'),
            // 2秒ごとの結果表示は後に追加可能
          ],
        ),
      ),
    );
  }
}
