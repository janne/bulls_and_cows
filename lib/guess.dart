import 'package:bulls_and_cows/number.dart';
import 'package:bulls_and_cows/result.dart';
import 'package:flutter/material.dart';

class Guess extends StatelessWidget {
  final (int, int, int, int) guess;
  final int bulls;
  final int cows;

  const Guess(this.guess, {super.key, required this.bulls, required this.cows});

  @override
  Widget build(BuildContext context) {
    final (n1, n2, n3, n4) = guess;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Number(n1, disabled: true),
        Number(n2, disabled: true),
        Number(n3, disabled: true),
        Number(n4, disabled: true),
        Result(bulls: bulls, cows: cows),
      ],
    );
  }
}
