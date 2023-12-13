import 'package:bulls_and_cows/guess.dart';
import 'package:bulls_and_cows/input.dart';
import 'package:bulls_and_cows/keyboard.dart';
import 'package:flutter/material.dart';

class Game extends StatefulWidget {
  const Game({super.key});

  @override
  State<Game> createState() => _GameState();
}

typedef GuessResult = ({(int, int, int, int) guess, int bulls, int cows});

class _GameState extends State<Game> {
  var selected = 0;
  (int?, int?, int?, int?) guess = (null, null, null, null);
  List<GuessResult> results = [];
  late (int, int, int, int) code;

  @override
  initState() {
    super.initState();
    code = _generateCode();
  }

  onSelect(int i) {
    setState(() => selected = i);
  }

  (int, int, int, int) _generateCode() {
    final nums = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]..shuffle();
    return (nums[0], nums[1], nums[2], nums[3]);
  }

  void _onKeyboardPress(int? i) {
    final (a, b, c, d) = guess;
    final (aa, bb, cc, dd) = (a == i ? null : a, b == i ? null : b, c == i ? null : c, d == i ? null : d);
    setState(() {
      guess = switch (selected) {
        0 => (i, bb, cc, dd),
        1 => (aa, i, cc, dd),
        2 => (aa, bb, i, dd),
        3 => (aa, bb, cc, i),
        _ => (aa, bb, cc, dd),
      };
      selected = (selected + 1) % 4;
    });
  }

  void _onReturn() {
    final (a, b, c, d) = guess;
    final guessList = [a, b, c, d];
    if (guessList.any((e) => e == null)) return;

    final (x, y, z, q) = code;
    final codeList = [x, y, z, q];

    final (bulls, cows) = guessList.indexed.fold((0, 0), (pair, item) {
      final (i, c) = item;
      var (bulls, cows) = pair;
      if (codeList[i] == c) return (bulls + 1, cows);
      if (codeList.contains(c)) return (bulls, cows + 1);
      return (bulls, cows);
    });
    setState(() {
      results.add((guess: guess as (int, int, int, int), bulls: bulls, cows: cows));
      guess = (null, null, null, null);
    });
  }

  void _newGame() {
    setState(() {
      results = [];
      guess = (null, null, null, null);
      selected = 0;
      code = _generateCode();
    });
  }

  @override
  Widget build(BuildContext context) {
    final won = results.isNotEmpty && results.last.guess == code;
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            if (!won)
              Input(
                selected: selected,
                onTap: onSelect,
                guess: guess,
              ),
            Expanded(
              child: ListView(
                children: [
                  Column(
                    children: results.reversed.map((r) => Guess(r.guess, bulls: r.bulls, cows: r.cows)).toList(),
                  ),
                ],
              ),
            ),
            if (won) ElevatedButton(onPressed: _newGame, child: const Text("New game")),
            if (!won)
              Keyboard(
                onPress: _onKeyboardPress,
                onReturn: _onReturn,
              ),
          ],
        ),
      ),
    );
  }
}
