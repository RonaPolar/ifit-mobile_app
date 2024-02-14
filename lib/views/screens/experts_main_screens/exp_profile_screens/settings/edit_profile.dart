import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluentui_icons/fluentui_icons.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:ifit/common/utils/app_styles.dart';
import 'package:ifit/common/widgets/confirmation_dialog.dart';
import 'package:ifit/common/widgets/main_button.dart';
import 'package:ifit/common/widgets/text_field_container.dart';
import 'package:ifit/views/screens/experts_main_screens/exp_bottom_bar.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _phone_numberController = TextEditingController();
  TextEditingController _professionController = TextEditingController();
  TextEditingController _birth_dateController = TextEditingController();
  TextEditingController _genderController = TextEditingController();
  String age = "";
  String profession_id = "";

  @override
  void initState() {
    super.initState();
    // Fetch data based on the provided UID when the widget initializes
    fetchData();
  }

  Future<void> fetchData() async {
    try {
      var user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        QuerySnapshot querySnapshot = await FirebaseFirestore.instance
            .collection('experts')
            .where('email', isEqualTo: user.email)
            .get();

        if (querySnapshot.docs.isNotEmpty) {
          var userData =
              querySnapshot.docs.first.data() as Map<String, dynamic>?;

          if (userData != null) {
            // Use the outer 'name' variable
            setState(() {
              _nameController.text = userData['name'] ?? '';
              _emailController.text = userData['email'] ?? '';
              _phone_numberController.text = userData['phone_number'] ?? '';
              _professionController.text = userData['profession'] ?? '';
              _birth_dateController.text = userData['birth_date'] ?? '';
              _genderController.text = userData['gender'] ?? '';
              profession_id = userData['profession_id'] ?? '';

              String birthdateString = userData['birth_date'] ?? '';
              DateTime birthdate = DateTime.parse(birthdateString);

              DateTime currentDate = DateTime.now();
              Duration difference = currentDate.difference(birthdate);

              age = (difference.inDays ~/ 365).toString();
            });
          }
        }
      }
    } catch (e) {
      print('Error fetching data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Styles.bgColor,
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
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: Column(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Profile Details", style: Styles.title),
                        const Gap(20),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            border: Border.all(
                              color: Styles.primaryColor,
                              width: 2.0,
                            ),
                          ),
                          child: Stack(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(30),
                                child: SizedBox(
                                  height: 100,
                                  child: Image.network(
                                    profession_id,
                                    fit: BoxFit.fill,
                                    errorBuilder: (context, error, stackTrace) {
                                      return Text('Image Error: $error');
                                    },
                                  ),
                                  // Replace with your placeholder widget or image
                                ),
                              ),
                              Positioned(
                                bottom: -2,
                                right: -2,
                                child: IconButton(
                                  icon: Icon(
                                    FluentSystemIcons.ic_fluent_camera_filled,
                                    color: Styles.primaryColor,
                                    size: 30,
                                  ),
                                  onPressed: () {
                                    // Handle camera button press
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                        const Gap(15),
                        TextfieldContainer(
                            controller: _nameController,
                            hitText: 'name',
                            icon: FluentSystemIcons.ic_fluent_edit_regular,
                            obscureText: false),
                        const Gap(15),
                        TextfieldContainer(
                            controller: _emailController,
                            hitText: 'email',
                            icon: FluentSystemIcons.ic_fluent_mail_regular,
                            obscureText: false),
                        const Gap(15),
                        TextfieldContainer(
                            controller: _phone_numberController,
                            hitText: 'Number',
                            icon: FluentSystemIcons.ic_fluent_edit_regular,
                            obscureText: false),
                        const Gap(15),
                        TextfieldContainer(
                            controller: _professionController,
                            hitText: 'profession',
                            icon: FluentSystemIcons
                                .ic_fluent_person_accounts_regular,
                            obscureText: false),
                        const Gap(15),
                        TextfieldContainer(
                            controller: _birth_dateController,
                            hitText: 'birthdate',
                            icon: FluentSystemIcons.ic_fluent_edit_regular,
                            obscureText: false),
                        const Gap(15),
                        DisplayTextContainer(
                            hitText: '${age}',
                            icon: FluentSystemIcons.ic_fluent_person_regular,
                            obscureText: false),
                        const Gap(15),
                        TextfieldContainer(
                            controller: _genderController,
                            hitText: 'gender',
                            icon: FluentSystemIcons.ic_fluent_people_regular,
                            obscureText: false),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15),
            child: MainButton(
                title: "Update Changes",
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return ConfirmationDialog(
                          onYesPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => const ExpProfile()));
                          },
                        );
                      });
                }),
          )
        ],
      ),
    );
  }
}
