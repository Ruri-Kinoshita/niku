import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class Teampresentation1 extends StatefulWidget {
  @override
  State<Teampresentation1> createState() => _Teampresentation1State();
}

class _Teampresentation1State extends State<Teampresentation1> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('プレゼンテーション'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'プレゼンテーションをして下さい',
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(height: 50),
            ElevatedButton(
              onPressed: () {
                context.go('/jadge1'); // 次の画面に遷移
              },
              child: Text('次へ'),
            ),
          ],
        ),
      ),
    );
  }
}
