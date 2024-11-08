import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class teampresentation2 extends StatefulWidget {
  @override
  State<teampresentation2> createState() => _Teampresentation1State();
}

class _Teampresentation1State extends State<teampresentation2> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('プレゼンテーション'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'プレゼンテーションをして下さい',
              style: TextStyle(fontSize: 24),
            ),
            const Text(
              '各チームが審査員に説明するフェーズ．もうちょい説明入れる',
              style: TextStyle(fontSize: 24),
            ),
            const SizedBox(height: 50),
            ElevatedButton(
              onPressed: () {
                context.go('/jadge2'); // 次の画面に遷移
              },
              child: const Text('次へ'),
            ),
          ],
        ),
      ),
    );
  }
}
