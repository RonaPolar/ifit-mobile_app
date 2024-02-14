import 'package:fluentui_icons/fluentui_icons.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get_storage/get_storage.dart';
import 'package:ifit/common/utils/app_styles.dart';
import 'package:ifit/common/widgets/main_button.dart';
import 'package:ifit/common/widgets/text_field_container.dart';
import 'package:ifit/views/screens/account_login_reg/register/client_registration/register_part3.dart';

import 'package:intl/intl.dart';

class RegisterPart2 extends StatefulWidget {
  const RegisterPart2({super.key});

  @override
  State<RegisterPart2> createState() => _RegisterPart2State();
}

class _RegisterPart2State extends State<RegisterPart2> {
  final numberController = TextEditingController();
  String? selectedValue; //gender
  DateTime? dateOfBirth;
  final weightController = TextEditingController();
  final heightController = TextEditingController();
  String validatorError = "";

  @override
  Widget build(BuildContext context) {
    //initialize storage for persistent storage
    final box = GetStorage();
    Future<bool> validateFields() async {
      // check if all fields are filled
      if (numberController.text == "" ||
          selectedValue == null ||
          dateOfBirth == null ||
          weightController.text == "" ||
          heightController.text == "") {
        setState(() {
          validatorError = "Please fill all the fields";
        });
        return false;

        // check if number is a valid ph number
      } else if (!RegExp(r'^63\d{10}$').hasMatch(numberController.text)) {
        setState(() {
          validatorError = "Number should be on 639*... PH format";
        });
        return false;
      } else {
        box.write('Rnumber', '+${numberController.text}');
        box.write('Rgender', selectedValue);
        box.write('RdateOfBirth', dateOfBirth.toString());
        box.write('Rweight', weightController.text);
        box.write('Rheight', heightController.text);

        return true;
      }
    }

    return Scaffold(
      backgroundColor: Styles.bgColor,
      body: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: [
              Expanded(
                child: ListView(
                  shrinkWrap: true,
                  children: [
                    Container(
                      padding:
                          const EdgeInsets.only(right: 20, left: 20, top: 10),
                      child: Column(
                        children: [
                          Image.asset(
                            "assets/images/complete-profile.png",
                            fit: BoxFit.fitHeight,
                          ),
                          const Gap(15),
                          Text(
                            'Let\'s complete your profile',
                            style: Styles.headline25,
                          ),
                          Text(
                            'It will help us to know more about you',
                            style: Styles.text15normal,
                          ),
                          const Gap(20),
                          (validatorError == ""
                              ? const SizedBox()
                              : Text(validatorError,
                                  style: const TextStyle(color: Colors.red))),

                          const Gap(10),
                          TextFieldContainer(
                              hitText: 'Number',
                              icon: FluentSystemIcons
                                  .ic_fluent_book_number_regular,
                              obscureText: false,
                              controller: numberController,
                              keyboardType: TextInputType.number),
                          const Gap(15),
                          RegisterDropDown(
                            hintText: 'Gender',
                            icon: FluentSystemIcons.ic_fluent_people_regular,
                            items: const [
                              DropdownMenuItem<String>(
                                value: "Male",
                                child: Text("Male"),
                              ),
                              DropdownMenuItem<String>(
                                value: "Female",
                                child: Text("Female"),
                              )
                            ],
                            onChanged: (value) {
                              setState(() {
                                selectedValue = value;
                              });
                            },
                            selectedValue: selectedValue,
                          ),
                          const Gap(15),
                          // const TextfieldContainer(hitText: 'Date of Birth', icon: FluentSystemIcons.ic_fluent_calendar_regular, obscureText: false),
                          DatepickerField(
                            onDateSelected: (date) {
                              // Do something with the selected date
                              setState(() {
                                dateOfBirth = date;
                              });
                            },
                          ),
                          const Gap(15),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: TextFieldContainer(
                                    keyboardType: TextInputType.number,
                                    controller: weightController,
                                    hitText: 'Your Weight',
                                    icon: FluentSystemIcons
                                        .ic_fluent_data_funnel_regular,
                                    obscureText: false),
                              ),
                              const Gap(5),
                              Container(
                                width: 50,
                                height: 50,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                    color: Styles.primaryColor,
                                    borderRadius: BorderRadius.circular(15)),
                                child: const Text('KG',
                                    style: TextStyle(
                                      color: Colors.white,
                                    )),
                              )
                            ],
                          ),
                          const Gap(15),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: TextFieldContainer(
                                    keyboardType: TextInputType.number,
                                    controller: heightController,
                                    hitText: 'Your Height',
                                    icon: FluentSystemIcons
                                        .ic_fluent_arrow_sort_regular,
                                    obscureText: false),
                              ),
                              const Gap(5),
                              Container(
                                width: 50,
                                height: 50,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                    color: Styles.primaryColor,
                                    borderRadius: BorderRadius.circular(15)),
                                child: const Text('CM',
                                    style: TextStyle(
                                      color: Colors.white,
                                    )),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.only(
                    right: 20, left: 20, bottom: 30, top: 20),
                child: Column(
                  children: [
                    MainButton(
                      title: 'Next',
                      onPressed: () async {
                        if (await validateFields()) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const RegisterPart3(),
                            ),
                          );
                        }
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class RegisterDropDown extends StatefulWidget {
  final List<DropdownMenuItem<String>> items;
  final String hintText;
  final IconData? icon;
  final void Function(String?) onChanged;
  final String? selectedValue;

  const RegisterDropDown({
    super.key,
    required this.items,
    required this.hintText,
    this.icon,
    required this.onChanged,
    this.selectedValue,
  });

  @override
  State<RegisterDropDown> createState() => _RegisterDropDownState();
}

class _RegisterDropDownState extends State<RegisterDropDown> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Styles.boxtextField,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        children: [
          Expanded(
            child: DropdownButtonFormField<String>(
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.only(top: 13, right: 10),
                border: InputBorder.none,
                prefixIcon: Icon(widget.icon),
              ),
              value: widget.selectedValue,
              items: widget.items,
              hint: Text(
                widget.hintText,
                style: TextStyle(color: Styles.fadeTextColor),
              ),
              onChanged: (newValue) {
                setState(() {
                  widget.onChanged(newValue);
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}

class DatepickerField extends StatefulWidget {
  final ValueChanged<DateTime?> onDateSelected;

  const DatepickerField({super.key, required this.onDateSelected});

  @override
  _DatepickerFieldState createState() => _DatepickerFieldState();
}

class _DatepickerFieldState extends State<DatepickerField> {
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
        ));
  }
}
