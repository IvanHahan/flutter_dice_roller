import 'package:flutter/material.dart';
import 'dart:math';


class DiceRoller extends StatefulWidget {

  const DiceRoller({super.key});

  @override
  State<DiceRoller> createState() {
    return _DiceRollerState();
  }

}

class _DiceRollerState extends State<DiceRoller> {

  var diceRollNumber = Random().nextInt(6) + 1;

  void rollDice() {
    setState(() {
      diceRollNumber = Random().nextInt(6) + 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset('assets\\images\\dice-$diceRollNumber.png'),
            const SizedBox(height: 50,),
            TextButton(
              onPressed: rollDice,
              style: TextButton.styleFrom(
                foregroundColor: Colors.white,
                textStyle: const TextStyle(fontSize: 28),
              ),
              child: const Text('Roll the dice'),
            ),
          ],
        );
  }
}