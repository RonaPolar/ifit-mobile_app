import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluentui_icons/fluentui_icons.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:ifit/common/utils/app_styles.dart';
import 'package:ifit/models/expert.dart';
import 'package:ifit/service/auth.dart';
import 'package:ifit/views/widgets/dialog/confirmation_dialog.dart';
import 'package:ifit/views/widgets/button/main_button.dart';
import 'package:ifit/views/widgets/text_field/text_field_container.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({
    required this.expertModel,
    super.key,
  });

  final ExpertModel expertModel;

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {

  @override
  void initState() {
    super.initState();
    getData();
  }

  void getData() {
    final ExpertModel expertModel = widget.expertModel;
    setState(() {
      Auth.name.text = expertModel.name;
      Auth.email.text = expertModel.email;
      Auth.profession.text = expertModel.profession;
      Auth.birthday.text = expertModel.birthDate;
      Auth.phone.text = expertModel.phoneNumber;
      // Auth.birthday.text = expertModel.birthDate;
    });
  }

  final GlobalKey<FormState> formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {

    final Auth auth = Provider.of<Auth>(context);

    return Scaffold(
      backgroundColor: Styles.bgColor,
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(15),
        child: MainButton(
          title: "Update Changes",
          onPressed: () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return ConfirmationDialog(
                  onYesPressed: () async {
                    if (formKey.currentState!.validate())  {
                      await auth.editWorkoutProfile(widget.expertModel.uid).then((value) {
                        Navigator.of(context)..pop()..pop();
                      });
                    }
                  },
                );
              },
            );
          },
        ),
      ),
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        elevation: 0,
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Container(
            margin: const EdgeInsets.all(12),
            height: 30,
            width: 30,
            alignment: Alignment.center,
            decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(10)),
            child: const Icon(
              FluentSystemIcons.ic_fluent_chevron_left_filled,
              size: 20,
              color: Colors.black,
            ),
          ),
        ),
        title: Text(
          'Edit Profile',
          style: Styles.headline20,
        ),
      ),
      body: ModalProgressHUD(
        inAsyncCall: auth.isLoading,
        child: Form(
          key: formKey,
          child: Column(
            children: [
              SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Column(
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Gap(20),
                          // Container(
                          //   decoration: BoxDecoration(
                          //     borderRadius: BorderRadius.circular(30),
                          //     border: Border.all(
                          //       color: Styles.primaryColor,
                          //       width: 2.0,
                          //     ),
                          //   ),
                          //   child: Stack(
                          //     children: [
                          //       ClipRRect(
                          //         borderRadius: BorderRadius.circular(30),
                          //         child: SizedBox(
                          //           height: 100,
                          //           child: Image.network(
                          //             profession_id,
                          //             fit: BoxFit.fill,
                          //             errorBuilder: (context, error, stackTrace) {
                          //               return Text('Image Error: $error');
                          //             },
                          //           ),
                          //           // Replace with your placeholder widget or image
                          //         ),
                          //       ),
                          //       Positioned(
                          //         bottom: -2,
                          //         right: -2,
                          //         child: IconButton(
                          //           icon: Icon(
                          //             FluentSystemIcons.ic_fluent_camera_filled,
                          //             color: Styles.primaryColor,
                          //             size: 30,
                          //           ),
                          //           onPressed: () {
                          //             // Handle camera button press
                          //           },
                          //         ),
                          //       ),
                          //     ],
                          //   ),
                          // ),
                          const Gap(15),
                          TextFieldContainer(
                            controller: Auth.name,
                            hintText: 'Name',
                            icon: FluentSystemIcons.ic_fluent_edit_regular,
                            validator: (val) {
                              if (val == null || val.isEmpty) {
                                return "This field is required";
                              } else {
                                return null;
                              }
                            },
                          ),

                          const Gap(15),
                          TextFieldContainer(
                            controller: Auth.email,
                            hintText: 'email',
                            icon: FluentSystemIcons.ic_fluent_mail_regular,
                            validator: (val) {
                              if (val == null || val.isEmpty) {
                                return "This field is required";
                              } else {
                                return null;
                              }
                            },
                          ),
                          const Gap(15),
                          TextFieldContainer(
                            controller: Auth.phone,
                            hintText: 'Number',
                            icon: FluentSystemIcons.ic_fluent_edit_regular,
                            validator: (val) {
                              if (val == null || val.isEmpty) {
                                return "This field is required";
                              } else {
                                return null;
                              }
                            },
                          ),
                          const Gap(15),
                          TextFieldContainer(
                            controller: Auth.profession,
                            hintText: 'profession',
                            icon: FluentSystemIcons.ic_fluent_person_accounts_regular,
                            validator: (val) {
                              if (val == null || val.isEmpty) {
                                return "This field is required";
                              } else {
                                return null;
                              }
                            },
                          ),
                          const Gap(15),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
