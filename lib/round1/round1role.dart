import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'dart:math';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:niku/provider.dart';
import 'package:niku/user_provider.dart';
import '../provider.dart'; // プロバイダをインポート

class Round1RoleSetting extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var state = ref.watch(userProviderProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Round 1 役割設定"),
      ),
      body: Column(
        children: [
          Flexible(
            child: ListView.builder(
              itemBuilder: (context, i) {
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [Text(state[i].name), Text(state[i].role)],
                );
              },
              itemCount: state.length,
            ),
          ),
          ElevatedButton(
            onPressed: () {
              context.go('/roulette');
            },
            child: Text("次へ"),
          ),
        ],
      ),
    );
  }
}
