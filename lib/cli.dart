import 'dart:convert';
import 'dart:io';

const codeLength = 4;

String generateCode() {
  final nums = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]..shuffle();
  return nums.take(codeLength).map((n) => n.toString()).join("");
}

main() {
  final code = generateCode();
  var attempt = 1;
  while (true) {
    stdout.write("> ");
    final guess = stdin.readLineSync(encoding: utf8);
    if (guess == null) {
      print("You have to guess something");
      continue;
    }
    if (!RegExp("^\\d+\$").hasMatch(guess)) {
      print("Only digits please");
      continue;
    }
    if (guess.length != codeLength) {
      print("Length of guess has to be $codeLength");
      continue;
    }
    if (guess.split("").toSet().length != codeLength) {
      print("All numbers have to be unique.");
      continue;
    }
    if (guess == code) break;
    final (bulls, cows) = guess.split("").indexed.fold((0, 0), (pair, item) {
      final (i, c) = item;
      var (bulls, cows) = pair;
      if (code[i] == c) return (bulls + 1, cows);
      if (code.contains(c)) return (bulls, cows + 1);
      return (bulls, cows);
    });
    print("That guess gave you $bulls bulls and $cows cows.");
    attempt++;
  }
  print("Yay! You guessed it in the $attempt attempt!");
}
