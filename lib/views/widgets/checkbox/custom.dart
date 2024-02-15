import 'package:flutter/material.dart';
import 'package:ifit/common/utils/app_styles.dart';

class CustomCheckbox extends StatelessWidget {

  const CustomCheckbox({
    Key? key,
    required this.onSelectionChanged,
    required this.title,
    this.value = false,
  }) : super(key: key);

  final Function(bool?)? onSelectionChanged;
  final String title;
  final bool value;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        CheckboxListTile(
          activeColor: Styles.primaryColor, // Use your desired checkbox color
          title: Text(title,
            style: Styles.text15normal,
          ),
          dense: true,
          value: value,
          onChanged: onSelectionChanged,
        ),
      ],
    );
  }
}