import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';

void main() {
  runApp(DiceApp());
}

class DiceApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DiceScreen(),
    );
  }
}

class DiceScreen extends StatefulWidget {
  @override
  _DiceScreenState createState() => _DiceScreenState();
}

class _DiceScreenState extends State<DiceScreen> {
  int leftDiceNumber = 1;
  int rightDiceNumber = 1;
  bool isRolling = false; // Trạng thái đang tung xúc xắc

  void rollDice() {
    if (isRolling) return; // Ngăn spam nút khi xúc xắc đang tung
    isRolling = true;

    int count = 0;
    Timer.periodic(Duration(milliseconds: 100), (timer) {
      setState(() {
        leftDiceNumber = Random().nextInt(6) + 1;
        rightDiceNumber = Random().nextInt(6) + 1;
      });

      count++;
      if (count >= 10) { // Sau 1 giây (10 lần), dừng hiệu ứng
        timer.cancel();
        isRolling = false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green[100],
      appBar: AppBar(
        title: Text('Mô phỏng tung xúc xắc'),
        backgroundColor: Colors.pink[200],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AnimatedContainer(
                  duration: Duration(milliseconds: 100),
                  child: Image.asset('assets/dice$leftDiceNumber.png', width: 150),
                ),
                SizedBox(width: 20),
                AnimatedContainer(
                  duration: Duration(milliseconds: 100),
                  child: Image.asset('assets/dice$rightDiceNumber.png', width: 150),
                ),
              ],
            ),
            SizedBox(height: 30),
            ElevatedButton(
              onPressed: rollDice,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red[400],
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                textStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              child: Text('Tung xúc xắc'),
            ),
          ],
        ),
      ),
    );
  }
}
