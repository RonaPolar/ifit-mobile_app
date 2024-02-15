import 'package:flutter/material.dart';

class CustomRadioButton extends StatelessWidget {
  const CustomRadioButton({
    required this.value,
    required this.groupValue,
    required this.onChanged,
    required this.title,
    super.key,
  });

  final String value;
  final String groupValue;
  final Function(String?)? onChanged;
  final String title;

  @override
  Widget build(BuildContext context) {
    return RadioListTile(
      title: Text(title),
      controlAffinity: ListTileControlAffinity.trailing,
      value: value,
      groupValue: groupValue,
      onChanged: onChanged,
    );
  }
}
