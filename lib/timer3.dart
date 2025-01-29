import 'dart:async';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:niku/provider3.dart';
import 'package:niku/roulette3.dart';
import '../round1/provider.dart'; // プロバイダをインポート

import 'dart:html' as html;

class CountdownTimer3 extends ConsumerStatefulWidget {
  const CountdownTimer3({Key? key}) : super(key: key);

  @override
  _CountdownTimerState createState() => _CountdownTimerState();
}

class _CountdownTimerState extends ConsumerState<CountdownTimer3> {
  int _remainingTime = 60;
  Timer? _timer;
  bool thirtyremain = false;
  bool timeup = false;
  bool timerstart = false;
  final Map<String, String> animalList = {
    'ねこ': 'cat',
    'フラミンゴ': 'flamingo',
    'もぐら': 'mole',
    'カラス': 'crow'
  };

  void thirtyRemainSound() {
    final sound = html.AudioElement('assets/audios/ドアチャイム1.mp3');
    sound.play();
  }

  void timeupSound() {
    final sound = html.AudioElement('assets/audios/試合終了のゴング.mp3');
    sound.play();
  }

  void startTimer() {
    timerstart = true;
    _remainingTime = 60;
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        //TODO デバックする時は0を59にするといいかも！！
        if (_remainingTime > 0) {
          _remainingTime--;
          if (_remainingTime < 30 && thirtyremain == false) {
            thirtyremain = true;
            thirtyRemainSound();
            debugPrint('30秒経ったよ');
          }
        } else {
          timeup = true;
          timeupSound();
          debugPrint('タイマー止まったよ');
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
    final prompts = ref.watch(promptProvider3); // ここで直接プロバイダを監視
    final deviceWidth = MediaQuery.of(context).size.width;
    final animal = ref.watch(animalProvider3);

    return Scaffold(
      appBar: AppBar(title: Text('タイマー')),
      body: Stack(
        children: [
          Opacity(
            opacity: 0.7,
            child: Container(
                width: deviceWidth * 0.4,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/leaf_left.png'),
                    alignment: Alignment.bottomLeft,
                  ),
                )),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Opacity(
              opacity: 0.7,
              child: Container(
                width: deviceWidth * 0.62,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/leaf_right.png'),
                    alignment: Alignment.bottomRight,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                    'assets/images/${animalList[animal]}.png'), // animalListのキーを使って画像を表示
                alignment: Alignment.bottomLeft,
                fit: BoxFit.contain,
              ),
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  '各チームの用意ができたら、審査員はスタートボタンを押してください',
                  style: TextStyle(fontSize: 32),
                ),
                const SizedBox(
                  height: 20,
                ),
                timeup
                    ? const Text(
                        'タイムアップ！',
                        style: TextStyle(fontSize: 100),
                      )
                    : Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text('残り時間', style: TextStyle(fontSize: 64)),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const SizedBox(width: 64),
                              Text(
                                '$_remainingTime',
                                style: const TextStyle(fontSize: 210),
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              const Column(
                                children: [
                                  SizedBox(
                                    height: 100,
                                  ),
                                  Text('秒', style: TextStyle(fontSize: 64)),
                                ],
                              ),
                            ],
                          )
                        ],
                      ),
                const Column(
                  children: [
                    Text(
                      '残り30秒になったらチャイムが鳴るから、',
                      style: TextStyle(fontSize: 32),
                    ),
                    Text(
                      '審査員はミッションブロックを各チームに渡してね',
                      style: TextStyle(fontSize: 32),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: timerstart ? null : startTimer,
                  child: const Text('タイマー開始'),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: timeup
                      ? () {
                          context.go('/jaddpoint3');
                        }
                      : null,
                  child: Text('次へ'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
