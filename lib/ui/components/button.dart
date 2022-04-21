import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  final String text;
  final VoidCallback pressed;
  const Button({required this.text, required this.pressed, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: pressed,
      child: Text(text),
      style: ButtonStyle(
          backgroundColor: MaterialStateProperty.resolveWith<Color>(
              (states) => Colors.green.shade700),
          shape: MaterialStateProperty.all(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30))),
          fixedSize: MaterialStateProperty.resolveWith<Size>(
              (states) => Size(20, 20))),
    );
  }
}
