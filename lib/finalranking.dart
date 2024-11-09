import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:niku/user_provider.dart';

class Finalranking extends ConsumerStatefulWidget {
  @override
  ConsumerState<Finalranking> createState() => _FinalrankingState();
}

class _FinalrankingState extends ConsumerState<Finalranking> {
  @override
  Widget build(BuildContext context) {
    // ユーザーをスコアの降順に並び替え
    final users = ref.watch(userProviderProvider).toList()
      ..sort((a, b) => b.score.compareTo(a.score));

    int currentRank = 1; // 現在の順位
    int displayRank = 1; // 同点グループの最初の表示順位
    int? lastScore; // 前回のスコアを追跡して同点を処理

    return Scaffold(
      appBar: AppBar(
        title: Text('最終ランキング'),
      ),
      body: Stack(
        children: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: users.map((user) {
                // スコアが前のユーザーと異なるかを確認
                if (lastScore == null || user.score != lastScore) {
                  // 新しいスコアグループの開始、displayRankとcurrentRankを更新
                  displayRank = currentRank;
                }
                // 前回のスコアを更新し、次のユーザーの順位を1つ進める
                lastScore = user.score;
                currentRank++;

                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4.0),
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          // 各スコアグループの最初のユーザーのみ順位を表示
                          '${displayRank}位　',
                          style: TextStyle(fontSize: 24),
                        ),
                        Text(
                          '${user.name}　${user.score}点',
                          style: TextStyle(fontSize: 24),
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
