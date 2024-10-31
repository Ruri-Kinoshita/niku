import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:niku/roulette.dart';
import 'package:niku/timer.dart';
import 'package:niku/titlepage.dart';

final router = GoRouter(initialLocation: '/', routes: [
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
    name: 'rcountdoentimer',
    pageBuilder: (context, state) {
      return MaterialPage(
        key: state.pageKey,
        child: CountdownTimer(),
      );
    },
  ),
]);
