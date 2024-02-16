import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluentui_icons/fluentui_icons.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:ifit/common/utils/app_styles.dart';
import 'package:ifit/views/widgets/dialog/confirmation_dialog.dart';
import 'package:ifit/views/widgets/button/main_button.dart';
import 'package:ifit/views/widgets/text_field/text_field_container.dart';
import 'package:ifit/views/screens/account_login_reg/register/client_registration/register_part2.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _numberController = TextEditingController();
  TextEditingController _programController = TextEditingController();
  TextEditingController _birth_dateController = TextEditingController();
  String age = "";
  String height = "";
  String weight = "";
  String gender = "";
  String photo_url = "";

  @override
  void initState() {
    super.initState();
    // Fetch data based on the provided UID when the widget initializes
    fetchData();
  }

  Future<void> fetchData() async {
    try {
      final user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        QuerySnapshot querySnapshot = await FirebaseFirestore.instance
            .collection('clients')
            .where('email', isEqualTo: user.email)
            .get();

        if (querySnapshot.docs.isNotEmpty) {
          var userData =
              querySnapshot.docs.first.data() as Map<String, dynamic>?;

          if (userData != null) {
            setState(() {
              _nameController.text = userData['name'] ?? '';
              _emailController.text = userData['email'] ?? '';
              _numberController.text = userData['phone_number'] ?? '';
              _programController.text = userData['program'] ?? '';
              _birth_dateController.text = userData['birth_date'] ?? '';

              gender = userData['gender'] ?? '';
              height = userData['height'] ?? '';
              weight = userData['weight'] ?? '';
              photo_url = userData['photo_url'] ?? '';
              String birthdateString = userData['birth_date'] ?? '';
              DateTime birthdate = DateTime.parse(birthdateString);

              DateTime currentDate = DateTime.now();
              Duration difference = currentDate.difference(birthdate);

              age = (difference.inDays ~/ 365).toString();
            });
          } else {
            print('User data is null.');
          }
        } else {
          print('No user data found for this UID.');
        }
      } else {
        print('User is null.');
      }
    } catch (e) {
      print('Error fetching data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    String? selectedValue;

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
                                    photo_url,
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
                        TextFieldContainer(
                            controller: _nameController,
                            hintText: "Name",
                            icon: FluentSystemIcons.ic_fluent_edit_regular,
                            obscureText: false),
                        const Gap(15),
                        TextFieldContainer(
                            controller: _emailController,
                            hintText: "Email",
                            icon: FluentSystemIcons.ic_fluent_edit_regular,
                            obscureText: false),
                        const Gap(15),
                        TextFieldContainer(
                            controller: _numberController,
                            hintText: "Number",
                            icon: FluentSystemIcons.ic_fluent_edit_regular,
                            obscureText: false),
                        const Gap(15),
                        RegisterDropDown(
                          hintText: _programController.text,
                          icon: FluentSystemIcons.ic_fluent_edit_regular,
                          items: const [
                            DropdownMenuItem<String>(
                              value: "Loss Weight",
                              child: Text("Loss Weight Program"),
                            ),
                            DropdownMenuItem<String>(
                              value: "Body Toning",
                              child: Text("Body Toning Program"),
                            ),
                            DropdownMenuItem<String>(
                              value: "Gain Muscles",
                              child: Text("Gain Muscles Program"),
                            )
                          ],
                          onChanged: (value) {
                            setState(() {
                              selectedValue = value;
                            });
                          },
                          selectedValue: selectedValue,
                        ),
                        // TextfieldContainer(hitText: user[0]["program"].toString(),
                        //   icon: FluentSystemIcons.ic_fluent_edit_regular, obscureText: false),
                        const Gap(15),
                        TextFieldContainer(
                            controller: _birth_dateController,
                            hintText: "Birthdate",
                            icon: FluentSystemIcons.ic_fluent_edit_regular,
                            obscureText: false),

                        const Gap(15),
                        DisplayTextContainer(
                            hitText: age,
                            icon: FluentSystemIcons
                                .ic_fluent_person_accounts_regular,
                            obscureText: false),
                        const Gap(15),
                        DisplayTextContainer(
                            hitText: gender,
                            icon: FluentSystemIcons
                                .ic_fluent_person_accounts_regular,
                            obscureText: false),
                        const Gap(15),
                        DisplayTextContainer(
                            hitText: height,
                            icon: FluentSystemIcons
                                .ic_fluent_person_accounts_regular,
                            obscureText: false),
                        const Gap(15),
                        DisplayTextContainer(
                            hitText: weight,
                            icon: FluentSystemIcons
                                .ic_fluent_person_accounts_regular,
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
                            // Navigator.of(context).push(MaterialPageRoute(
                            //     builder: (context) => const ProfileNavBar()));
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
