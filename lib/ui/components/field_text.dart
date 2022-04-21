import 'package:flutter/material.dart';

class FieldText extends StatelessWidget {
  final TextEditingController controller;
  final TextInputType? keyboard;
  final String? label;
  final String? prefixText;

  const FieldText(
      {required this.controller,
      this.keyboard,
      this.label,
      this.prefixText,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(16, 8, 16, 8),
      child: TextField(
        controller: controller,
        keyboardType: keyboard ?? TextInputType.text,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          labelText: label,
          prefixText: prefixText,
        ),
      ),
    );
  }
}
