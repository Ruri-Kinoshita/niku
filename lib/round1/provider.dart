import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final promptProvider =
    StateNotifierProvider<PromptNotifier, List<String>>((ref) {
  return PromptNotifier();
});

class PromptNotifier extends StateNotifier<List<String>> {
  PromptNotifier() : super(['', '']); // 初期状態は空のお題

  void setPrompts(String prompt1, String prompt2) {
    state = [prompt1, prompt2];
  }
}

final roleProvider = StateProvider<String?>((ref) => null);

@immutable
class User {
  String name = '';
  String role = '';
  int score = 0;

  User(this.name);
}
