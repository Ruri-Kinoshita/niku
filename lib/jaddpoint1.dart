import 'package:flutter/material.dart';

class Jaddpoint1 extends StatefulWidget {
  final String selectedPrompt1;
  final String selectedPrompt2;

  const Jaddpoint1({
    Key? key,
    required this.selectedPrompt1,
    required this.selectedPrompt2,
  }) : super(key: key);

  @override
  State<Jaddpoint1> createState() => _Jaddpoint1State();
}

class _Jaddpoint1State extends State<Jaddpoint1> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('選ばれたお題')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'お客さん: ${widget.selectedPrompt1}',
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(height: 20),
            Text(
              '料理: ${widget.selectedPrompt2}',
              style: TextStyle(fontSize: 24),
            ),
          ],
        ),
      ),
    );
  }
}
