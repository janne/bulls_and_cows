import 'package:bulls_and_cows/number.dart';
import 'package:bulls_and_cows/result.dart';
import 'package:flutter/material.dart';

class Input extends StatelessWidget {
  final (int?, int?, int?, int?) guess;
  final int selected;
  final Function(int i) onTap;

  const Input({super.key, required this.guess, required this.selected, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final (n1, n2, n3, n4) = guess;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Number(n1, onTap: () => onTap(0), selected: selected == 0),
        Number(n2, onTap: () => onTap(1), selected: selected == 1),
        Number(n3, onTap: () => onTap(2), selected: selected == 2),
        Number(n4, onTap: () => onTap(3), selected: selected == 3),
        const Result(bulls: 0, cows: 0),
      ],
    );
  }
}
