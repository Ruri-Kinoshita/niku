import 'dart:math';
import 'dart:ui';

import 'package:niku/provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'user_provider.g.dart';

@Riverpod(keepAlive: true)
class UserProvider extends _$UserProvider {
  final List<String> roles = ['A1', 'A2', 'B1', 'B2', 'J'];
  List<String>? randomizedRoles;

  @override
  List<User> build() {
    return [];
  }

  void setRole(String role, String name) {
    var list = List<User>.from(state).map((User user) {
      if (user.name == name) {
        user.role = role;
      }
      return user;
    }).toList();
    state = list;
  }

  void addUser(List<User> users) {
    randomizedRoles = List.from(roles);
    randomizedRoles!.shuffle(Random());
    for (var i = 0; i < randomizedRoles!.length; i++) {
      users[i].role = randomizedRoles![i];
    }

    state = users;
  }

  // roleの人に加算
  void addScore(int score, String role) {
    var list = List<User>.from(state).map((User user) {
      if (role == user.role) {
        user.score = user.score + score;
      }
      return user;
    });
    state = list.toList();
  }
}
