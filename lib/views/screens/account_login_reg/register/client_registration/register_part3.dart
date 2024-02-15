import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:ifit/common/utils/app_styles.dart';
import 'package:ifit/service/auth.dart';
import 'package:ifit/views/widgets/button/main_button.dart';
import 'package:ifit/views/screens/account_login_reg/register/client_registration/client_reg_success.dart';
import 'package:ifit/common/utils/api_connect.dart';
import 'package:ifit/views/widgets/button/radio.dart';
import 'package:ifit/views/widgets/checkbox/custom.dart';
import 'package:provider/provider.dart';

class RegisterPart3 extends StatefulWidget {
  const RegisterPart3({
    required this.id,
    super.key,
  });

  final String id;

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
    final Auth auth = Provider.of<Auth>(context);

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
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Column(
                      children: [
                        Text('What\'s your goal?',
                          style: Styles.headline25,
                        ),
                        Text('It will help us to choose a best program for you',
                          style: Styles.text15normal,
                        ),
                      ],
                    ),

                    const Gap(30),
                    validatorError == ""
                        ? const SizedBox()
                        : Text(validatorError,
                            style: const TextStyle(color: Colors.red),
                    ),
                    // CustomCheckbox(
                    //   questionText:
                    //       'In fitness, do you consider yourself as?',
                    //   choices: const ['Beginner', 'Intermediate', 'Expert'],
                    //   onSelectionChanged: (value) {
                    //     list1 = value;
                    //   },
                    // ),
                    Text("In fitness, do you consider yourself as?",
                      style: Styles.text15bold,
                    ),
                    Column(
                      children: auth.goalDifficultyList.map((data) {
                        return CustomRadioButton(
                          value: data,
                          groupValue: auth.goalDifficulty ?? "",
                          onChanged: auth.updateGoalDifficulty,
                          title: data,
                        );
                      }).toList(),
                    ),
                    const Gap(15),
                    Text("What fitness goals do you want to achieve?",
                      style: Styles.text15bold,
                    ),
                    Column(
                      children: auth.fitnessGoalList.map((data) {
                        return CustomCheckbox(
                          title: data,
                          onSelectionChanged: (val) {
                            auth.updateFitnessGoal(data);
                          },
                          value: auth.fitnessGoal.contains(data),
                        );
                      }).toList(),
                    ),
                    const Gap(15),
                    Text("What specific body part do you want for it?",
                      style: Styles.text15bold,
                    ),
                    Column(
                      children: auth.specificBodyList.map((data) {
                        return CustomCheckbox(
                          title: data,
                          onSelectionChanged: (val) {
                            auth.updateSpecificBody(data);
                          },
                          value: auth.specificBody.contains(data),
                        );
                      }).toList(),
                    ),
                    const Gap(15),
                    Text("How do you want to attain these goals?",
                      style: Styles.text15bold,
                    ),
                    Column(
                      children: auth.goalPlanList.map((data) {
                        return CustomRadioButton(
                          value: data,
                          groupValue: auth.goalPlan ?? "",
                          onChanged: auth.updateGoalPlan,
                          title: data,
                        );
                      }).toList(),
                    ),
                    const Gap(15),
                    Text("How many minutes/hours do you exercise?",
                      style: Styles.text15bold,
                    ),
                    Column(
                      children: auth.goalDurationList.map((data) {
                        return CustomRadioButton(
                          value: data,
                          groupValue: auth.goalDuration ?? "",
                          onChanged: auth.updateGoalDuration,
                          title: data,
                        );
                      }).toList(),
                    ),
                    const Gap(15),
                    Text("How many times in a week do you exercise?",
                      style: Styles.text15bold,
                    ),
                    Column(
                      children: auth.goalInAWeekList.map((data) {
                        return CustomRadioButton(
                          value: data,
                          groupValue: auth.goalInAWeek ?? "",
                          onChanged: auth.updateGoalInAWeek,
                          title: data,
                        );
                      }).toList(),
                    ),
                    const Gap(15),
                    Text("Do you have a body or health complications that need to be considered upon the process?",
                      style: Styles.text15bold,
                    ),
                    Column(
                      children: auth.healthComplicationsList.map((data) {
                        return CustomRadioButton(
                          value: data,
                          groupValue: auth.healthComplication ?? "",
                          onChanged: auth.updateHealthComplication,
                          title: data,
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    MainButton(
                      title: 'Confirm',
                      onPressed: () async {
                        auth.updateClientGoalProfile(widget.id).then((value) {
                          Navigator.pushReplacement(context, MaterialPageRoute(
                            builder: (context) => const ClientSuccessRegistration()),
                          );
                        });
                        // List<List<bool>> allLists = [
                        //   list1,
                        //   list2,
                        //   list3,
                        //   list4,
                        //   list5,
                        //   list6,
                        //   list7
                        // ];
                        //
                        // // Check if each list has at least one true value
                        // // success registration
                        // if (allLists
                        //     .every((list) => list.any((item) => item))) {
                        //   //register the user
                        //   if (await registerUser()) {
                        //     Navigator.pushReplacement(
                        //       context,
                        //       MaterialPageRoute(
                        //         builder: (context) =>
                        //             const ClientSuccessRegistration(),
                        //       ),
                        //     );
                        //   }
                        // } else {
                        //   setState(() {
                        //     validatorError =
                        //         "Please check at least one checkbox in each list";
                        //   });
                        // }
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


