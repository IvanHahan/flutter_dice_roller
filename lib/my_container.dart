import 'package:flutter/material.dart';
import 'package:flutter_application_1/dice_roller.dart';

const alignmentBegin = Alignment.topLeft;
const alignmentEnd = Alignment.bottomRight;

class MyContainer extends StatelessWidget {
  const MyContainer({super.key, required this.gradientColors});

  const MyContainer.yellowGreen({super.key})
      : gradientColors = const [Colors.yellow, Colors.green];

  final List<Color> gradientColors;

  @override
  Widget build(context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
            colors: gradientColors, begin: alignmentBegin, end: alignmentEnd),
      ),
      child: const Center(
        child: DiceRoller(),
      ),
    );
  }
}
