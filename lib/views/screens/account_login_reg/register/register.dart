import 'package:fluentui_icons/fluentui_icons.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:ifit/common/utils/api_connect.dart';
import 'package:ifit/common/utils/app_styles.dart';
import 'package:ifit/service/client.dart';
import 'package:ifit/views/widgets/button/main_button.dart';
import 'package:ifit/service/auth.dart';
import 'package:ifit/views/screens/account_login_reg/login.dart';
import 'package:ifit/views/screens/account_login_reg/register/client_registration/register_part2.dart';
import 'package:ifit/views/screens/account_login_reg/register/Expert_registration/Expert_registration1.dart';
import 'package:ifit/views/screens/account_login_reg/register/popup_privacy_terms.dart';
import 'package:ifit/views/widgets/text_field/text_field_container.dart';
import 'package:get_storage/get_storage.dart';
import 'package:ifit/views/widgets/verification_text_box.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  bool _isPasswordVisible = false; // Track password visibility
  bool _isCheck = false; // Track check box
  String? selectedValue = "Client";
  String? destinationScreen = "ClientRegistration";
  String validatorError = "";

  final ApiConnect apiConnect = Get.find();

  // Function to show the Privacy Policy dialog
  void _showPrivacyPolicyDialog() {
    CustomDialogs.showPrivacyPolicyDialog(context);
  }

  // Function to show the Terms of Use dialog
  void _showTermsOfUseDialog() {
    CustomDialogs.showTermsOfUseDialog(context);
  }

  void _showTypesOfUserDialog() {
    CustomDialogs.showTypesOfUserDialog(context);
  }

  final GlobalKey<FormState> formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    final box = GetStorage();
    final Auth auth = Provider.of<Auth>(context);

    bool isValidEmail(String email) {
      RegExp emailRegex = RegExp(r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$');
      return emailRegex.hasMatch(email);
    }

    // returns true if all fields are filled and valid
    Future<void> validateAndSendEmail() async {
      // // check if all fields are filled
      // if (Auth.email.text == "" ||
      //     Auth.password.text == "" ||
      //     Auth.firstName.text == "" ||
      //     Auth.lastName.text == "" ||
      //     selectedValue == null
      // ) {
      //   debugPrint("on register user");
      //   setState(() {
      //     validatorError = "Please fill all the fields";
      //   });
      //   ScaffoldMessenger.of(context)
      //       .showSnackBar(SnackBar(content: Text(validatorError)));
      //   return false;

      //   // check if email is valid
      // } else if (isValidEmail(Auth.email.text) == false) {
      //   debugPrint("Invalid email");
      //   setState(() {
      //     validatorError = "Please enter a valid email";
      //   });
      //   ScaffoldMessenger.of(context)
      //       .showSnackBar(SnackBar(content: Text(validatorError)));

      //   return false;

      //   // else send email to user
      // } else if (!_isCheck) {
      //   setState(() {
      //     validatorError = "Please accept our terms and conditions";
      //   });
      //   ScaffoldMessenger.of(context)
      //       .showSnackBar(SnackBar(content: Text(validatorError)));
      //   return false;
      // } else {
      //   print("Sending email to user");
      //   var userEmail = {
      //     'email': Auth.email.text,
      //   };

      var res = await apiConnect.sendEmailToUser({
        "email": Auth.email.text,
      });

      if (res.statusCode != 200) {
        setState(() {
          validatorError = "Invalid email, please try again";
        });
      }

      box.write('Remail', Auth.email.text);
      box.write('Rpassword', Auth.password.text);
      box.write('Rfirst_name', Auth.firstName.text);
      box.write('Rlast_name', Auth.lastName.text);
    }

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Styles.bgColor,
      body: ModalProgressHUD(
        inAsyncCall: auth.isLoading,
        child: Form(
          key: formKey,
          child: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        Text(
                          'Hey there,',
                          style: Styles.text18,
                        ),
                        Text(
                          'Create an Account',
                          style: Styles.headline25,
                        ),
                        const Gap(30),
                        TextFieldContainer(
                          hintText: 'First Name',
                          icon: FluentSystemIcons.ic_fluent_person_regular,
                          controller: Auth.firstName,
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
                          hintText: 'Last Name',
                          icon: FluentSystemIcons.ic_fluent_person_regular,
                          controller: Auth.lastName,
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
                          hintText: 'Email',
                          icon: FluentSystemIcons.ic_fluent_mail_regular,
                          obscureText: false,
                          controller: Auth.email,
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
                          //password eye icon
                          hintText: 'Password',
                          icon: FluentSystemIcons.ic_fluent_lock_regular,
                          controller: Auth.password,
                          obscureText: !_isPasswordVisible,
                          maxLines: _isPasswordVisible ? null : 1,
                          rightIcon: IconButton(
                            icon: _isPasswordVisible ? const Icon(Icons.visibility) : const Icon(Icons.visibility_off),
                            onPressed: () {
                              setState(() {
                                _isPasswordVisible = !_isPasswordVisible;
                              });
                            },
                          ),
                          validator: (val) {
                            if (val == null || val.isEmpty) {
                              return "This field is required";
                            } else if (val.length < 6) {
                              return "Password should be greater than 6.";
                            } else {
                              return null;
                            }
                          },
                        ),
                        const Gap(15),
                        Align(
                          alignment: Alignment.bottomLeft,
                          child: Text.rich(
                            TextSpan(
                              text: 'Click here to learn about ',
                              children: [
                                TextSpan(
                                  text: 'Type of User',
                                  style: TextStyle(
                                    color: Styles.textColor,
                                    decoration: TextDecoration.underline,
                                  ),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      _showTypesOfUserDialog(); // Show Privacy Policy dialog
                                    },
                                ),
                              ],
                            ),
                            style: TextStyle(color: Styles.fadeTextColor),
                          ),
                        ),
                        const Gap(5),
                        RegisterDropDown(
                          hintText: 'Type of User',
                          icon: FluentSystemIcons.ic_fluent_people_regular,
                          items: auth.userTypeList.map((data) {
                            return DropdownMenuItem<String>(
                              value: data,
                              child: Text(data),
                            );
                          }).toList(),
                          onChanged: (value) {
                            auth.updateRegisterUserType(value!);
                            // setState(() {
                            //   selectedValue = value;
                            //   box.write('Rtype', value);
                            //   if (value == "Client") {
                            //     destinationScreen = "ClientRegistration";
                            //   } else if (value == "Expert") {
                            //     destinationScreen = "ExpertRegistration";
                            //   }
                            // });
                          },
                          selectedValue: auth.registerUserType,
                        ),
                        const Gap(5),
                        Row(
                          children: [
                            IconButton(
                              onPressed: () {
                                setState(() {
                                  _isCheck = !_isCheck;
                                });
                              },
                              icon: _isCheck
                                  ? const Icon(FluentSystemIcons.ic_fluent_checkbox_checked_regular)
                                  : const Icon(FluentSystemIcons.ic_fluent_checkbox_unchecked_regular),
                              color: Styles.fadeTextColor,
                            ),
                            Expanded(
                              child: Text.rich(
                                TextSpan(
                                  text: 'By continuing you accept our ',
                                  children: [
                                    TextSpan(
                                      text: 'Privacy Policy',
                                      style: TextStyle(
                                        color: Styles.textColor,
                                        decoration: TextDecoration.underline,
                                      ),
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () {
                                          _showPrivacyPolicyDialog(); // Show Privacy Policy dialog
                                        },
                                    ),
                                    const TextSpan(text: ' and '),
                                    TextSpan(
                                      text: 'Terms of Use',
                                      style: TextStyle(
                                        color: Styles.textColor,
                                        decoration: TextDecoration.underline,
                                      ),
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () {
                                          _showTermsOfUseDialog(); // Show Terms of Use dialog
                                        },
                                    ),
                                  ],
                                ),
                                style: TextStyle(color: Styles.fadeTextColor),
                              ),
                            ),
                          ],
                        ),
                        const Gap(10),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(right: 20, left: 20, bottom: 5, top: 20),
                    child: Column(
                      children: [
                        MainButton(
                            title: 'Register',
                            onPressed: () async {
                              if (formKey.currentState!.validate()) {
                                await validateAndSendEmail().then((value) {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => VerificationCodeScreen(
                                        onConfirmPressed: () async {
                                          if (auth.registerUserType == "Client") {
                                            await auth.createUser().then((String? id) {
                                              Navigator.pushReplacement(
                                                context,
                                                MaterialPageRoute(builder: (context) => RegisterPart2(id: id!)),
                                              );
                                            });
                                          } else if (auth.registerUserType == "Expert") {
                                            await auth.createUser().then((value) {
                                              Navigator.pushReplacement(
                                                context,
                                                MaterialPageRoute(builder: (context) => const ExpertRegistration1()),
                                              );
                                            });
                                          }
                                        },
                                      ),
                                    ),
                                  );
                                });
                                // }
                                // Navigator.push(
                                //   context,
                                //   MaterialPageRoute(
                                //     builder: (context) =>
                                //         VerificationCodeScreen(
                                //       onConfirmPressed: () async {
                                //         if (auth.registerUserType == "Client") {
                                //           await auth
                                //               .createUser()
                                //               .then((String? id) {
                                //             Navigator.pushReplacement(
                                //               context,
                                //               MaterialPageRoute(
                                //                   builder: (context) =>
                                //                       RegisterPart2(id: id!)),
                                //             );
                                //           });
                                //         } else if (auth.registerUserType ==
                                //             "Expert") {
                                //           await auth.createUser().then((value) {
                                //             Navigator.pushReplacement(
                                //               context,
                                //               MaterialPageRoute(
                                //                   builder: (context) =>
                                //                       const ExpertRegistration1()),
                                //             );
                                //           });
                                //         }
                                //       },
                                //     ),
                                //   ),
                                // );
                                // ignore: use_build_context_synchronously
                              }
                            }),
                        const Gap(10),
                        Row(
                          children: [
                            Expanded(
                              child: Container(
                                height: 1,
                                color: Styles.textColor,
                              ),
                            ),
                            Text(
                              ' Or ',
                              style: Styles.text18,
                            ),
                            Expanded(
                              child: Container(
                                height: 1,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                        TextButton(
                          onPressed: () {
                            // Navigate to the login screen here
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => const LogIn(),
                              ),
                            );
                          },
                          child: RichText(
                            text: TextSpan(
                              style: Styles.text18,
                              children: <TextSpan>[
                                const TextSpan(
                                  text: 'Already have an Account? ',
                                ),
                                TextSpan(
                                  text: 'Login',
                                  style: Styles.title.copyWith(
                                    decoration: TextDecoration.underline,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
