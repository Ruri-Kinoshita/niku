import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CountdownTimer extends StatefulWidget {
  final String selectedPrompt1;
  final String selectedPrompt2;

  const CountdownTimer({
    Key? key,
    required this.selectedPrompt1,
    required this.selectedPrompt2,
  }) : super(key: key);

  @override
  _CountdownTimerState createState() => _CountdownTimerState();
}

class _CountdownTimerState extends State<CountdownTimer> {
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
                context.go('/jaddpoint1',
                    extra: [widget.selectedPrompt1, widget.selectedPrompt2]);
              },
              child: Text('次へ'),
            ),
          ],
        ),
      ),
    );
  }
}
