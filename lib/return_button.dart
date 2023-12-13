import 'package:flutter/material.dart';

class ReturnButton extends StatelessWidget {
  final void Function() onPressed;

  const ReturnButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkResponse(
        onTapDown: (_) => onPressed(),
        child: Container(
          alignment: Alignment.center,
          margin: const EdgeInsets.all(8),
          padding: const EdgeInsets.symmetric(vertical: 4),
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                blurRadius: 1,
                offset: const Offset(0, 1),
              ),
            ],
            color: Colors.grey[200],
            borderRadius: const BorderRadius.all(Radius.circular(24)),
          ),
          child: Text("Enter", style: Theme.of(context).textTheme.headlineMedium),
        ),
      ),
    );
  }
}
