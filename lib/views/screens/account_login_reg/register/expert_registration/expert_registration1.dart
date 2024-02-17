import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluentui_icons/fluentui_icons.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:ifit/common/utils/app_styles.dart';
import 'package:ifit/views/widgets/button/main_button.dart';
import 'package:ifit/views/widgets/date/date_picker.dart';
import 'package:ifit/views/widgets/text_field/text_field_container.dart';
import 'package:ifit/service/auth.dart';
import 'package:ifit/views/screens/account_login_reg/register/Expert_registration/Expert_reg_success.dart';
import 'package:ifit/views/screens/account_login_reg/register/client_registration/register_part2.dart';
import 'package:provider/provider.dart';

class ExpertRegistration1 extends StatefulWidget {
  const ExpertRegistration1({super.key});

  @override
  State<ExpertRegistration1> createState() => _ExpertRegistration1State();
}

class _ExpertRegistration1State extends State<ExpertRegistration1> {
  final user = FirebaseAuth.instance.currentUser;
  final GlobalKey<FormState> formKey = GlobalKey();


  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    final Auth auth = Provider.of<Auth>(context);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Styles.bgColor,
      body: SafeArea(
        child: Form(
          key: formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _buildFormFields(auth),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: MainButton(
                    title: 'Next',
                    onPressed: () async {
                      if (formKey.currentState!.validate()) {
                        await auth.next(uid: user!.uid).then((value) {
                          Navigator.pushReplacement(context,
                            MaterialPageRoute(builder: (context) =>
                            const ExpertSuccessRegistration()),
                          );
                        });
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFormFields(Auth auth) {
    return Container(
      padding: const EdgeInsets.only(right: 20, left: 20, top: 10),
      child: Column(
        children: [
          Text('Let\'s complete your profile',
            style: Styles.headline25,
          ),
          Text('It will help us to the verification about you',
            style: Styles.text15normal,
          ),
          const Gap(30),
          RegisterDropDown(
            hintText: 'Gender',
            icon: FluentSystemIcons.ic_fluent_people_regular,
            items: auth.genderList.map((data) {
              return DropdownMenuItem<String>(
                value: data,
                child: Text(data),
              );
            }).toList(),
            onChanged: (value) {
              setState(() {
                auth.gender = value;
              });
            },
            selectedValue: auth.gender,
          ),
          const Gap(15),
          DatePickerField(
            onDateSelected: auth.updateDateOfBirth,
            hintText: 'Date of Birth',
          ),
          const Gap(15),
          TextFieldContainer(
            controller: Auth.phone,
            hintText: 'Number',
            icon: FluentSystemIcons.ic_fluent_book_number_regular,
            validator: (val) {
              if (val == null || val.isEmpty) {
                return "This field is required";
              }
              return null;
            },
          ),
          const Gap(15),
          TextFieldContainer(
            controller: Auth.profession,
            hintText: 'Profession',
            icon: FluentSystemIcons.ic_fluent_person_accounts_regular,
            validator: (val) {
              if (val == null || val.isEmpty) {
                return "This field is required";
              }
              return null;
            },
          ),
          const Gap(15),
          TextFieldContainer(
            controller: Auth.description,
            hintText: 'Description',
            icon: FluentSystemIcons.ic_fluent_text_description_filled,
            validator: (val) {
              if (val == null || val.isEmpty) {
                return "This field is required";
              }
              return null;
            },
          ),
          const Gap(15),
          Row(
            children: [
              Text('Profession ID',
                style: Styles.title,
              ),
              const Gap(10),
              SizedBox(
                height: 25,
                width: 100,
                child: MainButton(
                  title: 'Upload',
                  textStyle: Styles.title.copyWith(color: Colors.white),
                  onPressed: () {
                    auth.uploadProfessionId(context);
                  },
                ),
              )
            ],
          ),
          const Gap(15),

          auth.professionId != null
              ? Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.file(
                //to show image, you type like this.
                File(auth.professionId!.path),
                fit: BoxFit.cover,
                width: 100,
                height: 100,
              ),
            ),
          )
              : const Text(
            "No Image",
            style: TextStyle(fontSize: 20),
          ),
          const Gap(15),
          Row(
            children: [
              Text('Proof of Field of Study',
                style: Styles.title,
              ),
              const Gap(10),
              SizedBox(
                height: 25,
                width: 100,
                child: MainButton(
                  title: 'Upload',
                  textStyle: Styles.title.copyWith(color: Colors.white),
                  onPressed: () {
                    auth.uploadProofOfStudy(context);
                  },
                ),
              )
            ],
          ),
          const Gap(15),
          auth.proofOfStudy != null
              ? Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.file(
                      //to show image, you type like this.
                      File(auth.proofOfStudy!.path),
                      fit: BoxFit.cover,
                      width: 100,
                      height: 100,
                    ),
                  ),
                )
              : const Text(
            "No Image",
            style: TextStyle(fontSize: 20),
          ),
          const Gap(10),
          // Align(
          //   // make a condition that make if any of it wasnt filled it will display "Enter _____"
          //   alignment: Alignment.bottomLeft,
          //   child: Text(
          //     'You must upload documents needed',
          //     style: Styles.text15normal.copyWith(
          //       color: Colors.red,
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }
}
