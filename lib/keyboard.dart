import 'package:bulls_and_cows/number_button.dart';
import 'package:bulls_and_cows/return_button.dart';
import 'package:flutter/material.dart';

class Keyboard extends StatelessWidget {
  final void Function(int? i) onPress;
  final void Function() onReturn;
  final int? guess;

  const Keyboard({super.key, required this.onPress, this.guess, required this.onReturn});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text("${guess ?? ''}", style: Theme.of(context).textTheme.headlineMedium),
        Row(
          children: [
            NumberButton(onPressed: onPress, number: 7),
            NumberButton(onPressed: onPress, number: 8),
            NumberButton(onPressed: onPress, number: 9),
          ],
        ),
        Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          NumberButton(onPressed: onPress, number: 4),
          NumberButton(onPressed: onPress, number: 5),
          NumberButton(onPressed: onPress, number: 6),
        ]),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            NumberButton(onPressed: onPress, number: 1),
            NumberButton(onPressed: onPress, number: 2),
            NumberButton(onPressed: onPress, number: 3),
          ],
        ),
        Row(
          children: [
            NumberButton(onPressed: onPress, number: 0),
            ReturnButton(onPressed: onReturn),
          ],
        )
      ],
    );
  }
}
