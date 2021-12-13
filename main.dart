//import 'dart:ui';

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'tonnahm.com',
      // Set Raleway as the default app font.
      theme: ThemeData(fontFamily: 'Sarabun'),
      home: const Homepage(),
    );
  }
}

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);
  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  //ควบคุม กล่อง  height
  final _heightController = TextEditingController();

  //ควบคุม กล่อง  weight
  final _weightController = TextEditingController();

  double? _bmi;

  //ข้อความเริ่มต้น
  String _message = "กรุณาใส่ ความสูง และ น้ำหนัก";

  void _calculate() {
    final double? height = double.tryParse(_heightController.value.text);
    final double? weight = double.tryParse(_weightController.value.text);

    // Check input
    if (height == null || height <= 0 || weight == null || weight <= 0) {
      setState(() {
        _message = "กรุณาใส่ข้อมูลให้ถูกต้อง";
      });

      return;
    } //if

    setState(() {
      _bmi = weight / ((height / 100) * (height / 100));

      if (_bmi! < 18.5) {
        _message = "ร่างกายคุณ ผอม เกินไป";
      } else if (_bmi! < 25) {
        _message = "ร่างกายคุณ ปกติ";
      } else if (_bmi! < 30) {
        _message = "ร่างกายคุณ เริ่มท้วม";
      } else {
        _message = "คุณ อ้วนแล้วนะ";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepOrange,
      body: Center(
        child: SizedBox(
          width: 320,
          child: Card(
            color: Colors.white,
            elevation: 10,
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "โปรแกรมแรกของ Code Am\n บน Flutter",
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 30),
                  ),
                  TextField(
                    keyboardType:
                        const TextInputType.numberWithOptions(decimal: true),
                    decoration:
                        const InputDecoration(labelText: 'ความสูง (ซม.)'),
                    controller: _heightController,
                  ),
                  TextField(
                    keyboardType:
                        const TextInputType.numberWithOptions(decimal: true),
                    decoration:
                        const InputDecoration(labelText: 'น้ำหนัก (กิโลกรัม)'),
                    controller: _weightController,
                  ),
                  ElevatedButton(
                      onPressed: _calculate, child: const Text('คำนวณ')),
                  const SizedBox(
                    height: 30,
                  ),
                  Text(
                    _bmi == null ? 'ไม่มีข้อมูล' : _bmi!.toStringAsFixed(2),
                    style: const TextStyle(fontSize: 50),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    _message,
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 20),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
