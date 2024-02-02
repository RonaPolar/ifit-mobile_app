import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluentui_icons/fluentui_icons.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:ifit/common/utils/app_styles.dart';
import 'package:ifit/common/widgets/main_button.dart';
import 'package:ifit/common/widgets/text_field_container.dart';
import 'package:ifit/screens/account-login&reg/register/client_registration/register_part2.dart';
import 'package:ifit/screens/account-login&reg/register/expert_registration/expert_reg_success.dart';
import 'package:ifit/screens/account-login&reg/services.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

class ExpertRegistration1 extends StatefulWidget {
  const ExpertRegistration1({super.key});

  @override
  State<ExpertRegistration1> createState() => _ExpertRegistration1State();
}

class _ExpertRegistration1State extends State<ExpertRegistration1> {
  final user = FirebaseAuth.instance.currentUser;
  final TextEditingController birth_dateController = TextEditingController();
  final TextEditingController phone_numberController = TextEditingController();
  final TextEditingController professionController = TextEditingController();

  XFile? professionid;
  XFile? proofoffielofstudy;

  String downloadURL = '';
  String downloadURL2 = '';

  final ImagePicker picker = ImagePicker();

  //we can upload image from camera or from gallery based on parameter
  Future getImage(ImageSource source) async {
    var img = await picker.pickImage(source: source);

    setState(() {
      professionid = img;
    });

    print(img!.path);
  }

  Future getImage2(ImageSource source) async {
    var img = await picker.pickImage(source: source);

    setState(() {
      proofoffielofstudy = img;
    });

    print(img!.path);
  }

  void myAlert() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            title: const Text('Please choose media to select'),
            content: SizedBox(
              height: MediaQuery.of(context).size.height / 6,
              child: Column(
                children: [
                  ElevatedButton(
                    //if user click this button, user can upload image from gallery
                    onPressed: () {
                      Navigator.pop(context);
                      getImage(ImageSource.gallery);
                    },
                    child: const Row(
                      children: [
                        Icon(Icons.image),
                        Text('From Gallery'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  void myAlert2() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            title: const Text('Please choose media to select'),
            content: SizedBox(
              height: MediaQuery.of(context).size.height / 6,
              child: Column(
                children: [
                  ElevatedButton(
                    //if user click this button, user can upload image from gallery
                    onPressed: () {
                      Navigator.pop(context);
                      getImage2(ImageSource.gallery);
                    },
                    child: const Row(
                      children: [
                        Icon(Icons.image),
                        Text('From Gallery'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  String? selectedValue;

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
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
                          Text(
                            'Let\'s complete your profile',
                            style: Styles.headline25,
                          ),
                          Text(
                            'It will help us to the verification about you',
                            style: Styles.text15normal,
                          ),
                          const Gap(30),
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
                          TextfieldContainer(
                              controller: birth_dateController,
                              hitText: 'Date of Birth',
                              icon:
                                  FluentSystemIcons.ic_fluent_calendar_regular,
                              obscureText: false),
                          const Gap(15),
                          TextfieldContainer(
                              controller: phone_numberController,
                              hitText: 'Number',
                              icon: FluentSystemIcons
                                  .ic_fluent_book_number_regular,
                              obscureText: false),
                          const Gap(15),
                          TextfieldContainer(
                              controller: professionController,
                              hitText: 'Profession',
                              icon: FluentSystemIcons
                                  .ic_fluent_person_accounts_regular,
                              obscureText: false),
                          const Gap(15),
                          Row(
                            children: [
                              Text(
                                'Profession ID',
                                style: Styles.title,
                              ),
                              const Gap(10),
                              SizedBox(
                                  height: 25,
                                  width: 100,
                                  child: MainButton(
                                      title: 'Upload',
                                      textStyle: Styles.title
                                          .copyWith(color: Colors.white),
                                      onPressed: () {
                                        myAlert();
                                      }))
                            ],
                          ),
                          const Gap(15),
                          professionid != null
                              ? Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(8),
                                    child: Image.file(
                                      //to show image, you type like this.
                                      File(professionid!.path),
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
                              Text(
                                'Proof of Field of Study',
                                style: Styles.title,
                              ),
                              const Gap(10),
                              SizedBox(
                                  height: 25,
                                  width: 100,
                                  child: MainButton(
                                      title: 'Upload',
                                      textStyle: Styles.title
                                          .copyWith(color: Colors.white),
                                      onPressed: () {
                                        myAlert2();
                                      }))
                            ],
                          ),
                          const Gap(15),
                          proofoffielofstudy != null
                              ? Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(8),
                                    child: Image.file(
                                      //to show image, you type like this.
                                      File(proofoffielofstudy!.path),
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
                          Align(
                            //make a condition that make if any of it wasnt filled it will display "Enter _____"
                            alignment: Alignment.bottomLeft,
                            child: Text(
                              'You must upload documents needed',
                              style: Styles.text15normal.copyWith(
                                color: Colors.red,
                              ),
                            ),
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
                        final path = 'experts';
                        final file = File(professionid!.path);

                        final ref = FirebaseStorage.instance
                            .ref()
                            .child(path)
                            .child(professionid!.name);
                        await ref.putFile(file);

                        downloadURL = await ref.getDownloadURL();

                        setState(() {
                          downloadURL = downloadURL;
                        });

                        FirebaseFirestore.instance
                            .collection('experts')
                            .doc(user!.uid)
                            .update({
                          'profession_id': downloadURL,
                        });

                        final file2 = File(proofoffielofstudy!.path);

                        final ref2 = FirebaseStorage.instance
                            .ref()
                            .child(path)
                            .child(proofoffielofstudy!.name);

                        await ref2.putFile(file2);

                        downloadURL2 = await ref.getDownloadURL();

                        setState(() {
                          downloadURL2 =
                              downloadURL2; // Update downloadURL after getting the URL
                        });

                        FirebaseFirestore.instance
                            .collection('experts')
                            .doc(user!.uid)
                            .update({
                          'proof_of_field_of_study': downloadURL2,
                        });

                        Services()
                            .updateExpert(
                                user!.uid,
                                selectedValue,
                                birth_dateController.text,
                                phone_numberController.text,
                                professionController.text)
                            .then({
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const ExpertSuccessRegistration()),
                          )
                        });
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
