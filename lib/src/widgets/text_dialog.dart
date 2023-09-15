import 'package:flutter/material.dart';

class TextDialog extends StatelessWidget {
  const TextDialog({
    Key? key,
    required this.controller,
    required this.fontSize,
    required this.onFinished,
    this.onSubmitted,
    required this.color,
  }) : super(key: key);
  final TextEditingController controller;
  final double fontSize;
  final VoidCallback onFinished;
  final Function(String text)? onSubmitted;
  final Color color;
  static void show(BuildContext context, TextEditingController controller,
      double fontSize, Color color,
      {required ValueChanged<BuildContext> onFinished, onSubmitted}) {
    showDialog(
        context: context,
        barrierDismissible: true,
        builder: (context) {
          return TextDialog(
            controller: controller,
            fontSize: fontSize,
            onFinished: () => onFinished(context),
            onSubmitted: (s) => onSubmitted(s),
            color: color,
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: Center(
        child: TextField(
          controller: controller,
          autofocus: true,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontSize: fontSize,
                color: color,
              )?? TextStyle(
                fontSize: fontSize,
                color: color,
              ),
          textAlign: TextAlign.center,
          decoration: const InputDecoration(
            border: InputBorder.none,
          ),
          onTapOutside: (e) {
            onFinished();
          },
          onEditingComplete: onFinished,
          onSubmitted: (s) {
            onSubmitted!(s);
          },
        ),
      ),
    );
  }
}
