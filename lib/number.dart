import 'package:flutter/material.dart';

class Number extends StatelessWidget {
  final int? num;
  final Function()? onTap;
  final bool selected;
  final bool disabled;

  const Number(this.num, {super.key, this.onTap, this.selected = false, this.disabled = false});

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme.headlineLarge!;
    return Expanded(
      child: AspectRatio(
        aspectRatio: 1,
        child: InkWell(
          onTap: onTap,
          child: Container(
            margin: const EdgeInsets.all(8),
            decoration: BoxDecoration(
                border: Border.all(color: disabled ? Colors.grey : Colors.black),
                borderRadius: const BorderRadius.all(Radius.circular(8)),
                color: selected ? Colors.grey[300] : null),
            child: Center(
              child: num == null
                  ? Container()
                  : Text(
                      num.toString(),
                      style: disabled ? textStyle.copyWith(color: Colors.grey) : textStyle,
                    ),
            ),
          ),
        ),
      ),
    );
  }
}
