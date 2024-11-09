import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:niku/router.dart';
import 'package:niku/constant/app_color.dart';

class TitlePage extends StatefulWidget {
  @override
  State<TitlePage> createState() => _TitlePageState();
}

class _TitlePageState extends State<TitlePage> {
  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;
    final deviceHeight = MediaQuery.of(context).size.height;
    return Scaffold(
        body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Image(
            height: deviceHeight * 0.5,
            image: AssetImage('assets/images/titlelogo.png'),
          ),
          Text(
            '更新しないでね！！',
            style: TextStyle(
              color: AppColor.text.darkred,
            ),
          ),
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
