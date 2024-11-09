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
    final deviceWidth = MediaQuery.of(context).size.width;

    // Sort users by descending score
    final users = ref.watch(userProviderProvider).toList()
      ..sort((a, b) => b.score.compareTo(a.score));

    int currentRank = 1; // Current rank
    int displayRank = 1; // Display rank for tied groups
    int? lastScore; // Track last score to handle ties

    return Scaffold(
      appBar: AppBar(
        title: Text('最終ランキング'),
      ),
      body: Stack(
        children: [
          // Background images layer
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
          // Main content layer
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: users.map((user) {
                // Update display rank for new score groups
                if (lastScore == null || user.score != lastScore) {
                  displayRank = currentRank;
                }
                lastScore = user.score;
                currentRank++;

                // Conditionally set font size for the first place
                final fontSize = displayRank == 1 ? 55.0 : 40.0;

                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4.0),
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '${displayRank}位　',
                          style: TextStyle(fontSize: fontSize),
                        ),
                        Text(
                          '${user.name}　${user.score}点',
                          style: TextStyle(fontSize: fontSize),
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
