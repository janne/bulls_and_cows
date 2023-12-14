import 'package:bulls_and_cows/number_button.dart';
import 'package:bulls_and_cows/return_button.dart';
import 'package:flutter/material.dart';

class Keyboard extends StatelessWidget {
  final void Function(int? i) onPress;
  final void Function() onReturn;
  final Set<int> disabled;

  const Keyboard({super.key, required this.onPress, required this.onReturn, required this.disabled});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            NumberButton(onPressed: onPress, number: 7, disabled: disabled.contains(7)),
            NumberButton(onPressed: onPress, number: 8, disabled: disabled.contains(8)),
            NumberButton(onPressed: onPress, number: 9, disabled: disabled.contains(9)),
          ],
        ),
        Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          NumberButton(onPressed: onPress, number: 4, disabled: disabled.contains(4)),
          NumberButton(onPressed: onPress, number: 5, disabled: disabled.contains(5)),
          NumberButton(onPressed: onPress, number: 6, disabled: disabled.contains(6)),
        ]),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            NumberButton(onPressed: onPress, number: 1, disabled: disabled.contains(1)),
            NumberButton(onPressed: onPress, number: 2, disabled: disabled.contains(2)),
            NumberButton(onPressed: onPress, number: 3, disabled: disabled.contains(3)),
          ],
        ),
        Row(
          children: [
            NumberButton(onPressed: onPress, number: 0, disabled: disabled.contains(0)),
            ReturnButton(onPressed: onReturn),
          ],
        )
      ],
    );
  }
}
