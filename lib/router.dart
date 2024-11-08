import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:niku/round2/jaddpoint2.dart';
import 'package:niku/round2/jadge2.dart';
import 'package:niku/round2/roulette2.dart';
import 'package:niku/round1/jaddpoint1.dart';
import 'package:niku/round1/jadge1.dart';
import 'package:niku/round1/jadgeresult1.dart';
import 'package:niku/round1/roulette1.dart';
import 'package:niku/round1/round1role.dart';
import 'package:niku/round2/round2role.dart';
import 'package:niku/round1/teampresentation1.dart';
import 'package:niku/round1/timer.dart';
import 'package:niku/round2/timer2.dart';
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
    GoRoute(
      path: '/teampresentation1',
      name: 'teampresentation1',
      pageBuilder: (context, state) {
        return MaterialPage(
          key: state.pageKey,
          child: Teampresentation1(),
        );
      },
    ),
    GoRoute(
      path: '/jadge1',
      name: 'jadge1',
      pageBuilder: (context, state) {
        return MaterialPage(
          key: state.pageKey,
          child: Jadge1(),
        );
      },
    ),
    GoRoute(
      path: '/jadgeresult1',
      name: 'jadgeresult1',
      pageBuilder: (context, state) {
        final results = state.extra as Map<String, String>;
        debugPrint(results.keys.toString());
        return MaterialPage(
          key: state.pageKey,
          child: JadgeResult1(
            winningTeam: results['winningTeam']!,
          ),
        );
      },
    ),
    GoRoute(
      path: '/round2roleSetting',
      name: 'round2roleSetting',
      pageBuilder: (context, state) {
        return MaterialPage(
          key: state.pageKey,
          child: Round2RoleSetting(),
        );
      },
    ),
    GoRoute(
      path: '/roulette2',
      name: 'roulette2',
      pageBuilder: (context, state) {
        return MaterialPage(
          key: state.pageKey,
          child: const Roulette2(),
        );
      },
    ),
    GoRoute(
      path: '/countdowntimer2',
      name: 'countdowntimer2',
      pageBuilder: (context, state) {
        final prompts = state.extra as List<String>?;
        final selectedPrompt1 = prompts?[0] ?? '';
        final selectedPrompt2 = prompts?[1] ?? '';
        return MaterialPage(
          key: state.pageKey,
          child: CountdownTimer2(),
        );
      },
    ),
    GoRoute(
      path: '/jaddpoint2',
      name: 'jaddpoint2',
      pageBuilder: (context, state) {
        final prompts = state.extra as List<String>?;
        final selectedPrompt1 = prompts?[0] ?? '';
        final selectedPrompt2 = prompts?[1] ?? '';
        return MaterialPage(
          key: state.pageKey,
          child: jaddpoint2(),
        );
      },
    ),
    GoRoute(
      path: '/teampresentation2',
      name: 'teampresentation2',
      pageBuilder: (context, state) {
        return MaterialPage(
          key: state.pageKey,
          child: Teampresentation1(),
        );
      },
    ),
    GoRoute(
      path: '/jadge2',
      name: 'jadge2',
      pageBuilder: (context, state) {
        return MaterialPage(
          key: state.pageKey,
          child: Jadge2(),
        );
      },
    ),
  ],
);
