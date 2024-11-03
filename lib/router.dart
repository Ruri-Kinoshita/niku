import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:niku/roulette.dart';
import 'package:niku/round1role.dart';
import 'package:niku/timer.dart';
import 'package:niku/titlepage.dart';
import 'package:niku/usersetting.dart';

final router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      name: 'title',
      pageBuilder: (context, state) {
        return MaterialPage(
          key: state.pageKey,
          child: TitlePage(),
        );
      },
    ),
    GoRoute(
      path: '/roulette',
      name: 'roulette',
      pageBuilder: (context, state) {
        return MaterialPage(
          key: state.pageKey,
          child: const Roulette(),
        );
      },
    ),
    GoRoute(
      path: '/countdowntimer',
      name: 'countdoentimer',
      pageBuilder: (context, state) {
        return MaterialPage(
          key: state.pageKey,
          child: CountdownTimer(),
        );
      },
    ),
    GoRoute(
      path: '/usersetting',
      name: 'usersetting',
      pageBuilder: (context, state) {
        return MaterialPage(
          key: state.pageKey,
          child: Usersetting(),
        );
      },
    ),
    GoRoute(
      path: '/round1RoleSetting',
      name: 'round1RoleSetting',
      pageBuilder: (context, state) {
        final playerNames = state.extra as List<String>?;
        return MaterialPage(
          key: state.pageKey,
          child: Round1RoleSetting(playerNames: playerNames ?? []),
        );
      },
    ),
  ],
);
