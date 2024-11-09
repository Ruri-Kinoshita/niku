import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:niku/round1/roulette1.dart';

// Define providers for each selection
final selectedAProvider = StateProvider<String?>((ref) => null);
final selectedBProvider = StateProvider<String?>((ref) => null);
final selectedCProvider = StateProvider<String?>((ref) => null);

class Jadge1 extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final deviceWidth = MediaQuery.of(context).size.width;

    // Access selected values using providers
    final selectedA = ref.watch(selectedAProvider);
    final selectedB = ref.watch(selectedBProvider);
    final selectedC = ref.watch(selectedCProvider);
    final Map<String, String> animalList = {
      'ねこ': 'cat',
      'フラミンゴ': 'flamingo',
      'もぐら': 'mole',
      'カラス': 'crow'
    };
    final animal = ref.watch(animalProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('AチームとBチームのジャッジ'),
      ),
      body: Stack(
        children: [
          // Left background image
          Opacity(
            opacity: 0.7,
            child: Container(
              width: deviceWidth * 0.4,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/leaf_left.png'),
                  alignment: Alignment.bottomLeft,
                ),
              ),
            ),
          ),
          // Right background image
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
                image: AssetImage('assets/images/${animalList[animal]}.png'),
                alignment: Alignment.bottomLeft,
                fit: BoxFit.contain,
              ),
            ),
          ),
          // Main content
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('審査員役の人以外この画面は見てはいけません！！！！！！！'),
                const SizedBox(height: 20),
                const Text(
                  '項目A: ミッションブロックへの対応力',
                  style: TextStyle(fontSize: 18),
                ),
                Row(
                  children: [
                    Expanded(
                      child: RadioListTile<String>(
                        title: const Text('A'),
                        value: 'A',
                        groupValue: selectedA,
                        onChanged: (value) {
                          ref.read(selectedAProvider.notifier).state = value;
                        },
                      ),
                    ),
                    Expanded(
                      child: RadioListTile<String>(
                        title: const Text('B'),
                        value: 'B',
                        groupValue: selectedA,
                        onChanged: (value) {
                          ref.read(selectedAProvider.notifier).state = value;
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                const Text(
                  '項目B: チームワーク',
                  style: TextStyle(fontSize: 18),
                ),
                Row(
                  children: [
                    Expanded(
                      child: RadioListTile<String>(
                        title: const Text('A'),
                        value: 'A',
                        groupValue: selectedB,
                        onChanged: (value) {
                          ref.read(selectedBProvider.notifier).state = value;
                        },
                      ),
                    ),
                    Expanded(
                      child: RadioListTile<String>(
                        title: const Text('B'),
                        value: 'B',
                        groupValue: selectedB,
                        onChanged: (value) {
                          ref.read(selectedBProvider.notifier).state = value;
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                const Text(
                  '項目C: リーダーシップ',
                  style: TextStyle(fontSize: 18),
                ),
                Row(
                  children: [
                    Expanded(
                      child: RadioListTile<String>(
                        title: const Text('A'),
                        value: 'A',
                        groupValue: selectedC,
                        onChanged: (value) {
                          ref.read(selectedCProvider.notifier).state = value;
                        },
                      ),
                    ),
                    Expanded(
                      child: RadioListTile<String>(
                        title: const Text('B'),
                        value: 'B',
                        groupValue: selectedC,
                        onChanged: (value) {
                          ref.read(selectedCProvider.notifier).state = value;
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 32),
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      if (selectedA != null &&
                          selectedB != null &&
                          selectedC != null) {
                        int countA = 0;
                        int countB = 0;
                        if (selectedA == 'A') countA++;
                        if (selectedB == 'A') countA++;
                        if (selectedC == 'A') countA++;
                        if (selectedA == 'B') countB++;
                        if (selectedB == 'B') countB++;
                        if (selectedC == 'B') countB++;
                        String winningTeam = countA > countB
                            ? 'A'
                            : countB > countA
                                ? 'B'
                                : '引き分け';
                        context.go('/jadgeresult1', extra: {
                          'resultA': selectedA!,
                          'resultB': selectedB!,
                          'resultC': selectedC!,
                          'winningTeam': winningTeam,
                        });
                      } else {
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: const Text('エラー'),
                            content: const Text('すべての項目を選択してください。'),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.of(context).pop(),
                                child: const Text('OK'),
                              ),
                            ],
                          ),
                        );
                      }
                    },
                    child: const Text('決定して次へ'),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
