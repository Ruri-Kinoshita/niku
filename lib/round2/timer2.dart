import 'dart:async';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../round1/provider.dart'; // プロバイダをインポート

class CountdownTimer2 extends ConsumerStatefulWidget {
  const CountdownTimer2({Key? key}) : super(key: key);

  @override
  _CountdownTimerState createState() => _CountdownTimerState();
}

class _CountdownTimerState extends ConsumerState<CountdownTimer2> {
  int _remainingTime = 60;
  Timer? _timer;

  void startTimer() {
    _remainingTime = 60;
    _timer?.cancel();
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (_remainingTime > 0) {
          _remainingTime--;
        } else {
          timer.cancel();
        }
      });
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final prompts = ref.watch(promptProvider); // ここで直接プロバイダを監視

    return Scaffold(
      appBar: AppBar(title: Text('カウントダウンタイマー')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              _remainingTime > 0 ? '残り時間: $_remainingTime 秒' : 'タイムアップ！',
              style: TextStyle(fontSize: 32),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: startTimer,
              child: Text('タイマー開始'),
            ),
            SizedBox(height: 50),
            ElevatedButton(
              onPressed: () {
                context.go('/jaddpoint2');
              },
              child: Text('次へ'),
            ),
          ],
        ),
      ),
    );
  }
}
