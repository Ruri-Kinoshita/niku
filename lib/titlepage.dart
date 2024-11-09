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
      body: Stack(
        children: [
          Opacity(
            opacity: 0.7,
            child: Container(
                width: deviceWidth * 0.4,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/leaf_left.png'),
                    alignment: Alignment.bottomLeft,
                  ),
                )),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Opacity(
              opacity: 0.7,
              child: Container(
                width: deviceWidth * 0.62,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/leaf_right.png'),
                    alignment: Alignment.bottomRight,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  height: deviceHeight * 0.01,
                ),
                Image(
                  height: deviceHeight * 0.4,
                  image: const AssetImage('assets/images/titlelogo.png'),
                ),
                SizedBox(
                  width: deviceWidth * 0.3,
                  child: Card(
                    color: AppColor.ui.lightred,
                    child: Center(
                      child: Column(
                        children: [
                          Text(
                            '注意',
                            style: TextStyle(
                              color: AppColor.text.darkred,
                            ),
                          ),
                          Text(
                            '１．フルスクリーンで遊んでね',
                            style: TextStyle(
                              color: AppColor.text.darkred,
                            ),
                          ),
                          Text(
                            '２．ブラウザの更新ボタンは押さずに遊んでね',
                            style: TextStyle(
                              color: AppColor.text.darkred,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                ElevatedButton(
                    onPressed: () {
                      context.go('/usersetting');
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColor.ui.lightgreen,
                      side: BorderSide(
                          width: 3, color: Colors.green.withOpacity(1)),
                      fixedSize: const Size(100, 50),
                    ),
                    child: const Text('次へ')),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
