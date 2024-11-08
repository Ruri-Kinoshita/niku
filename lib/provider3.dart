import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final promptProvider3 =
    StateNotifierProvider<PromptNotifier, List<String>>((ref) {
  return PromptNotifier();
});

class PromptNotifier extends StateNotifier<List<String>> {
  PromptNotifier() : super(['', '']); // 初期状態は空のお題

  void setPrompts(String prompt1, String prompt2) {
    state = [prompt1, prompt2];
  }
}
