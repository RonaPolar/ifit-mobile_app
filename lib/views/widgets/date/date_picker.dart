import 'package:flutter/material.dart';
import 'package:ifit/common/utils/app_styles.dart';
import 'package:intl/intl.dart';

class DatePickerField extends StatefulWidget {
  final ValueChanged<DateTime?> onDateSelected;

  const DatePickerField({super.key, required this.onDateSelected});

  @override
  _DatePickerFieldState createState() => _DatePickerFieldState();
}

class _DatePickerFieldState extends State<DatePickerField> {
  final TextEditingController _controller = TextEditingController();
  final DateFormat _dateFormat = DateFormat('yyyy-MM-dd');
  DateTime? _selectedDate;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Styles.boxtextField,
        borderRadius: BorderRadius.circular(15),
      ),
      child: TextFormField(
        controller: _controller,
        decoration: InputDecoration(
          labelText: 'Date of Birth',
          contentPadding: const EdgeInsets.only(top: 15),
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
          prefixIcon: const Icon(Icons.calendar_today),
          hintText: "date",
          hintStyle: TextStyle(
            color: Styles.fadeTextColor,
          ),
        ),
        readOnly: true,
        onTap: () async {
          final date = await showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(1900),
            lastDate: DateTime.now(),
          );
          if (date != null) {
            _selectedDate = date;
            _controller.text = _dateFormat.format(date);
            widget.onDateSelected(_selectedDate);
          }
        },
      ),
    );
  }
}
