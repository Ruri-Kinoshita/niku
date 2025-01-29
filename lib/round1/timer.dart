import 'dart:async';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:niku/constant/app_color.dart';
import 'package:niku/round1/roulette1.dart';
import 'provider.dart'; // プロバイダをインポート

import 'dart:html' as html;

class CountdownTimer extends ConsumerStatefulWidget {
  const CountdownTimer({Key? key}) : super(key: key);

  @override
  _CountdownTimerState createState() => _CountdownTimerState();
}

class _CountdownTimerState extends ConsumerState<CountdownTimer> {
  int _remainingTime = 60;
  Timer? _timer;
  bool thirtyremain = false;
  bool timeup = false;
  bool timerstart = false;

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
    final prompts = ref.watch(promptProvider); // ここで直接プロバイダを監視
    final deviceWidth = MediaQuery.of(context).size.width;
    final Map<String, String> animalList = {
      'ねこ': 'cat',
      'フラミンゴ': 'flamingo',
      'もぐら': 'mole',
      'カラス': 'crow'
    };
    final animal = ref.watch(animalProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('タイマー')),
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
          // 動物のお題が押されたとき、画像を表示
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/${animalList[animal]}.png'),
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
                          context.go('/jaddpoint1');
                        }
                      : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColor.ui.lightgreen,
                    side: BorderSide(
                        width: 3, color: Colors.green.withOpacity(1)),
                    fixedSize: const Size(100, 50),
                  ),
                  child: const Text('次へ'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
