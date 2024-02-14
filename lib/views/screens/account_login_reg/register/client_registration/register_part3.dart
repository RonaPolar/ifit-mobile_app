import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:ifit/common/utils/app_styles.dart';
import 'package:ifit/common/widgets/main_button.dart';
import 'package:ifit/views/screens/account_login_reg/register/client_registration/client_reg_success.dart';
import 'package:ifit/common/utils/api_connect.dart';

class RegisterPart3 extends StatefulWidget {
  const RegisterPart3({super.key});

  @override
  State<RegisterPart3> createState() => _RegisterPart3State();
}

class _RegisterPart3State extends State<RegisterPart3> {
  String? selectedValue;
  List<bool> list1 = [false, false, false];
  List<bool> list2 = [false, false, false];
  List<bool> list3 = [false, false, false, false];
  List<bool> list4 = [false, false, false];
  List<bool> list5 = [false, false, false];
  List<bool> list6 = [false, false, false, false];
  List<bool> list7 = [false, false, false, false];

  String validatorError = "";

  @override
  Widget build(BuildContext context) {
    final ApiConnect apiConnect = Get.find();
    final box = GetStorage();

    Future<bool> registerUser() async {
      var userData = {
        'password': box.read("Rpassword"),
        'user': {
          'name': box.read("Rfirst_name") + box.read("Rlast_name"),
          'email': box.read("Remail"),
          'phone_number': box.read("Rphone_number"),
          'photo_url':
              'https://firebasestorage.googleapis.com/v0/b/ifit-api.appspot.com/o/profile_pic.png?alt=media&token=0a84aa95-bf8d-41d4-b66d-000cfc34978b',
          'birth_date': box.read("RdateOfBirth"),
          'gender': ("Rgender"),
          'user_type': 'client',
          'weight': box.read("Rweight"),
          'height': box.read("Rheight"),
        }
      };

      var res = await apiConnect.registerUser(userData);

      if (res.statusCode == 201) {
        return true;
      } else {
        return false;
      }
    }

    return Scaffold(
      backgroundColor: Styles.bgColor,
      body: Center(
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
                          const EdgeInsets.only(right: 20, left: 20, top: 20),
                      child: Column(
                        children: [
                          Text(
                            'What\'s your goal?',
                            style: Styles.headline25,
                          ),
                          Text(
                            'It will help us to choose a best program for you',
                            style: Styles.text15normal,
                          ),
                          const Gap(30),
                          (validatorError == ""
                              ? const SizedBox()
                              : Text(validatorError,
                                  style: const TextStyle(color: Colors.red))),
                          CheckBoxList(
                            questionText:
                                'In fitness, do you consider yourself as?',
                            choices: const ['Beginner', 'Intermediate', 'Expert'],
                            onSelectionChanged: (value) {
                              list1 = value;
                            },
                          ),
                          const Gap(15),
                          CheckBoxList(
                            questionText:
                                'What fitness goals do you want to achieve?',
                            choices: const [
                              'Loss Weight',
                              'Body Toning',
                              'Gain Muscles'
                            ],
                            onSelectionChanged: (value) {
                              list2 = value;
                            },
                          ),
                          const Gap(15),
                          CheckBoxList(
                            questionText:
                                'What specific body part do you want for it?',
                            choices: const [
                              'Upper body',
                              'Abdominal',
                              'Lower body',
                              'Full body'
                            ],
                            onSelectionChanged: (value) {
                              list3 = value;
                            },
                          ),
                          const Gap(15),
                          CheckBoxList(
                            questionText:
                                'How do you want to attain these goals?',
                            choices: const [
                              'Body exercises',
                              'Lifting weights',
                              'Food restrictions'
                            ],
                            onSelectionChanged: (value) {
                              list4 = value;
                            },
                          ),
                          const Gap(15),
                          CheckBoxList(
                            questionText:
                                'How many minutes/hours do you exercise?',
                            choices: const [
                              'Less than 30 minutes',
                              'An hour',
                              'More than an hour'
                            ],
                            onSelectionChanged: (value) {
                              list5 = value;
                            },
                          ),
                          const Gap(15),
                          CheckBoxList(
                            questionText:
                                'How many times in a week do you exercise?',
                            choices: const [
                              'None',
                              'Once a week',
                              'Twice a week',
                              '3-4 times a week',
                              'More than'
                            ],
                            onSelectionChanged: (value) {
                              list6 = value;
                            },
                          ),
                          const Gap(15),
                          CheckBoxList(
                            questionText:
                                'Do you have a body or health complications that need to be considered upon the process?',
                            choices: const [
                              'None',
                              'Injuries',
                              'Breathing complications(ex: Asthma)',
                              'Cardiovascular diseases'
                            ],
                            onSelectionChanged: (value) {
                              list7 = value;
                            },
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
                      title: 'Confirm',
                      onPressed: () async {
                        List<List<bool>> allLists = [
                          list1,
                          list2,
                          list3,
                          list4,
                          list5,
                          list6,
                          list7
                        ];

                        // Check if each list has at least one true value
                        // success registration
                        if (allLists
                            .every((list) => list.any((item) => item))) {
                          //register the user
                          if (await registerUser()) {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    const ClientSuccessRegistration(),
                              ),
                            );
                          }
                        } else {
                          setState(() {
                            validatorError =
                                "Please check at least one checkbox in each list";
                          });
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

class CheckBoxList extends StatefulWidget {
  final List<String> choices;
  final String questionText;
  final ValueChanged<List<bool>> onSelectionChanged;

  const CheckBoxList({
    Key? key,
    required this.choices,
    required this.questionText,
    required this.onSelectionChanged,
  }) : super(key: key);

  @override
  State<CheckBoxList> createState() => _CheckBoxListState();
}

class _CheckBoxListState extends State<CheckBoxList> {
  List<bool> isCheckedList = [];

  @override
  void initState() {
    super.initState();
    isCheckedList =
        List<bool>.generate(widget.choices.length, (index) => false);
  }

  @override
  void didUpdateWidget(CheckBoxList oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.choices.length != oldWidget.choices.length) {
      // The number of choices has changed, regenerate isCheckedList
      isCheckedList =
          List<bool>.generate(widget.choices.length, (index) => false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(widget.questionText, style: Styles.text15bold),
        for (int index = 0; index < widget.choices.length; index++)
          CheckboxListTile(
            activeColor: Styles.primaryColor, // Use your desired checkbox color
            title: Text(
              widget.choices[index],
              style: Styles.text15normal,
            ),
            dense: true,
            value: isCheckedList[index],

            onChanged: (bool? value) {
              setState(() {
                isCheckedList[index] = value!;
              });
              widget.onSelectionChanged(isCheckedList);
            },
          ),
      ],
    );
  }
}
