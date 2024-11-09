import 'package:flutter/material.dart';

class AppColor {
  // ignore: library_private_types_in_public_api
  static final _Brand brand = _Brand();
  static final _Text text = _Text();
  static final _Ui ui = _Ui();
}

class _Brand {
  final Color primary = const Color(0xFFFFFFFF);
  final Color secondary = const Color(0xFFFB2C43);
}

class _Text {
  //final Color primary = const Color(0xFF373737);
  //final Color appBarTitle = const Color(0xFF373737);
  //final Color gray = const Color(0xFF808080);
  final Color blackMid = const Color(0x61000000);
  final Color white = const Color(0xFFFFFFFF);
  //final Color link = const Color(0xFF6699ff);
  //final Color darkgray = const Color(0xFF404040);

  final Color darkred = const Color(0xFFA12115);
}

class _Ui {
  final Color white = const Color(0xFFFFFFFF);
  final Color black = const Color(0xFF000000);
  final Color background = const Color(0xFF202124);

  final Color lightred = const Color(0xFFFADBDA);
  final Color lightgreen = const Color(0xFFDBFFD2);

  final Color a = const Color(0xFFffe0e0);
  final Color b = const Color(0xFFe0efff);
  final Color j = const Color(0xFFefe0ff);
}
