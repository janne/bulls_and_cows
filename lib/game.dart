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
  late Set<(int, int, int, int)> alternatives;

  @override
  initState() {
    super.initState();
    code = _generateCode();
    alternatives = _generatePermutations();
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

  List<int> recToList((int, int, int, int) rec) {
    final (a, b, c, d) = rec;
    return [a, b, c, d];
  }

  (int, int) _getBullsAndCows((int, int, int, int) code) {
    final guessList = recToList(guess as (int, int, int, int));
    final codeList = recToList(code);
    return guessList.indexed.fold((0, 0), (pair, item) {
      final (i, c) = item;
      var (bulls, cows) = pair;
      if (codeList[i] == c) return (bulls + 1, cows);
      if (codeList.contains(c)) return (bulls, cows + 1);
      return (bulls, cows);
    });
  }

  void _onReturn() {
    final (a, b, c, d) = guess;
    if (a == null || b == null || c == null || d == null) return;
    final (bulls, cows) = _getBullsAndCows(code);
    _cleanAlternatives(bulls, cows);
    setState(() {
      results.add((guess: guess as (int, int, int, int), bulls: bulls, cows: cows));
      guess = (null, null, null, null);
    });
  }

  Set<(int, int, int, int)> _generatePermutations() {
    Set<(int, int, int, int)> result = {};
    List<int> usedNumbers = [];

    void generate(List<int> current) {
      if (current.length == 4) {
        result.add((current[0], current[1], current[2], current[3]));
        return;
      }

      for (int i = 0; i < 10; i++) {
        if (!usedNumbers.contains(i)) {
          usedNumbers.add(i);
          current.add(i);
          generate(current);
          current.removeLast();
          usedNumbers.removeLast();
        }
      }
    }

    generate([]);

    return result;
  }

  void _cleanAlternatives(int bulls, int cows) {
    setState(() {
      alternatives = alternatives.where((alt) => _getBullsAndCows(alt) == (bulls, cows)).toSet();
    });
  }

  void _newGame() {
    setState(() {
      results = [];
      guess = (null, null, null, null);
      selected = 0;
      code = _generateCode();
      alternatives = _generatePermutations();
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
            if (!won) Text("${alternatives.length} possible alternative${alternatives.length > 1 ? 's' : ''}"),
            if (!won)
              Keyboard(
                onPress: _onKeyboardPress,
                onReturn: _onReturn,
                disabled: _getDisabled(),
              ),
          ],
        ),
      ),
    );
  }

  Set<int> _getDisabled() => alternatives.fold({0, 1, 2, 3, 4, 5, 6, 7, 8, 9}, (disabled, alt) {
        final (a, b, c, d) = alt;
        disabled.removeAll({a, b, c, d});
        return disabled;
      });
}
