import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'provider.dart'; // プロバイダをインポート

class Jaddpoint1 extends ConsumerWidget {
  const Jaddpoint1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final prompts = ref.watch(promptProvider); // ここで直接プロバイダを監視

    return Scaffold(
      appBar: AppBar(title: Text('選ばれたお題')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
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
        ),
      ),
    );
  }
}
