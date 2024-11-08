import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'dart:math';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:niku/round1/provider.dart';
import 'package:niku/user_provider.dart';
import '../round1/provider.dart'; // プロバイダをインポート

class Round3RoleSetting extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var state = ref.watch(userProviderProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Round 3 役割設定"),
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
              context.go('/roulette3');
            },
            child: const Text("次へ"),
          ),
        ],
      ),
    );
  }
}
