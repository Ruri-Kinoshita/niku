import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:niku/jaddpoint1.dart';
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
      name: 'countdowntimer',
      pageBuilder: (context, state) {
        final prompts = state.extra as List<String>?;
        final selectedPrompt1 = prompts?[0] ?? '';
        final selectedPrompt2 = prompts?[1] ?? '';
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
          child: Round1RoleSetting(),
        );
      },
    ),
    GoRoute(
      path: '/jaddpoint1',
      name: 'jaddpoint1',
      pageBuilder: (context, state) {
        final prompts = state.extra as List<String>?;
        final selectedPrompt1 = prompts?[0] ?? '';
        final selectedPrompt2 = prompts?[1] ?? '';
        return MaterialPage(
          key: state.pageKey,
          child: Jaddpoint1(),
        );
      },
    ),
  ],
);
