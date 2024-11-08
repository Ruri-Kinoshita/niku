import 'dart:math';
import 'dart:ui';

import 'package:niku/round1/provider.dart';
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

  void setRole2() {
    var list = List<User>.from(state).map((User user) {
      if (user.role == 'A1') {
        user.role = 'B1';
      } else if (user.role == 'A2') {
        user.role = 'J';
      } else if (user.role == 'B1') {
        user.role = 'A1';
      } else if (user.role == 'B2') {
        user.role = 'B2';
      } else if (user.role == 'J') {
        user.role = 'A2';
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
