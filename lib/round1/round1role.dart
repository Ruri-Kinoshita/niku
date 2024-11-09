import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'dart:math';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:niku/constant/app_color.dart';
import 'package:niku/round1/provider.dart';
import 'package:niku/user_provider.dart';
import 'provider.dart'; // プロバイダをインポート

class Round1RoleSetting extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var state = ref.watch(userProviderProvider);
    final deviceWidth = MediaQuery.of(context).size.width;
    final deviceHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Round 1 役割設定"),
      ),
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
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 300,
                    height: 400,
                    decoration: BoxDecoration(
                      color: Colors.red.withOpacity(0.2),
                      border: Border.all(
                          width: 4, color: Colors.black.withOpacity(0.5)),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Center(
                        child: Column(
                      children: [
                        Container(
                          width: 300,
                          height: 100,
                          decoration: BoxDecoration(
                            color: Colors.red.withOpacity(0.7),
                            borderRadius: const BorderRadius.vertical(
                              top: Radius.circular(10),
                            ),
                          ),
                          child: const Center(
                            child: Text(
                              'Aチーム',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 40),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 60,
                        ),
                        for (int i = 0; i < 5; i++)
                          if (state[i].role == 'A1' || state[i].role == 'A2')
                            Column(
                              children: [
                                Text(
                                  state[i].name,
                                  style: const TextStyle(fontSize: 30),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                              ],
                            ),
                      ],
                    )),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Container(
                    width: 300,
                    height: 400,
                    decoration: BoxDecoration(
                      color: Colors.purple.withOpacity(0.2),
                      border: Border.all(
                          width: 4, color: Colors.black.withOpacity(0.5)),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Center(
                        child: Column(
                      children: [
                        Container(
                          width: 300,
                          height: 100,
                          decoration: BoxDecoration(
                            color: Colors.purple.withOpacity(0.7),
                            borderRadius: const BorderRadius.vertical(
                              top: Radius.circular(10),
                            ),
                          ),
                          child: const Center(
                            child: Text(
                              'Judge',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 40),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 60,
                        ),
                        for (int i = 0; i < 5; i++)
                          if (state[i].role == 'J')
                            Column(
                              children: [
                                Text(
                                  state[i].name,
                                  style: const TextStyle(fontSize: 30),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                              ],
                            ),
                      ],
                    )),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Container(
                    width: 300,
                    height: 400,
                    decoration: BoxDecoration(
                      color: Colors.blue.withOpacity(0.2),
                      border: Border.all(
                          width: 4, color: Colors.black.withOpacity(0.5)),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Center(
                        child: Column(
                      children: [
                        Container(
                          width: 300,
                          height: 100,
                          decoration: BoxDecoration(
                            color: Colors.blue.withOpacity(0.7),
                            borderRadius: const BorderRadius.vertical(
                              top: Radius.circular(10),
                            ),
                          ),
                          child: const Center(
                            child: Text(
                              'Bチーム',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 40),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 60,
                        ),
                        for (int i = 0; i < 5; i++)
                          if (state[i].role == 'B1' || state[i].role == 'B2')
                            Column(
                              children: [
                                Text(
                                  state[i].name,
                                  style: const TextStyle(fontSize: 30),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                              ],
                            ),
                      ],
                    )),
                  )
                ],
              ),
              ElevatedButton(
                onPressed: () {
                  context.go('/roulette');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColor.ui.lightgreen,
                  side:
                      BorderSide(width: 3, color: Colors.green.withOpacity(1)),
                  fixedSize: const Size(100, 50),
                ),
                child: const Text("次へ"),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
