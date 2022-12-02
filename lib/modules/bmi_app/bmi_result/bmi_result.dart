import 'dart:math';

import 'package:flutter/material.dart';

class BmiResult extends StatelessWidget {
  final bool isMale;
  final int height;
  final int age;
  final double weight;
  final double result;

  BmiResult(
      {required this.isMale,
      required this.height,
      required this.age,
      required this.weight, required this.result});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Result'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Gender: ${isMale ? 'Male' : 'Female'}'),
            Text('Height: ${height}'),
            Text('Weight: ${weight}'),
            Text('Age: ${age}'),
            Text('BMI=${result}')

          ],
        ),
      ),
    );
  }
}
