import 'package:flutter/material.dart';

class Result extends StatelessWidget {
  final int bulls;
  final int cows;

  const Result({super.key, required this.bulls, required this.cows});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: AspectRatio(
        aspectRatio: 1,
        child: Container(
          margin: const EdgeInsets.all(8),
          child: Center(
            child: Text("⚫️" * bulls + "️⚪️" * cows, style: Theme.of(context).textTheme.headlineSmall),
          ),
        ),
      ),
    );
  }
}
