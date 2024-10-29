import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';

class CountdownTimer extends StatefulWidget {
  @override
  _CountdownTimerState createState() => _CountdownTimerState();
}

class _CountdownTimerState extends State<CountdownTimer> {
  int _remainingTime = 60;
  Timer? _timer;

  void startTimer() {
    _remainingTime = 60; // カウントダウンの開始秒数
    _timer?.cancel(); // 既にタイマーが動作中の場合はキャンセル
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (_remainingTime > 0) {
          _remainingTime--; // 1秒ずつ減らす
        } else {
          timer.cancel(); // カウントダウンが終了したらタイマーを止める
        }
      });
    });
  }

  @override
  void dispose() {
    _timer?.cancel(); // ウィジェットが破棄される際にタイマーをキャンセル
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
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
            ],
          ),
        ),
      ),
    );
  }
}
