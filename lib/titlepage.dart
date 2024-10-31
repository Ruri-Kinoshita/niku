import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:niku/router.dart';

class TitlePage extends StatefulWidget {
  @override
  State<TitlePage> createState() => _TitlePageState();
}

class _TitlePageState extends State<TitlePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Column(
        children: [
          Text('ここはタイトルページ，ロゴとかが入る'),
          ElevatedButton(
              onPressed: () {
                context.go('/usersetting');
              },
              child: Text('ユーザー登録に遷移するはず')),
        ],
      ),
    ));
  }
}
