import 'package:fluentui_icons/fluentui_icons.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:ifit/common/utils/app_styles.dart';
import 'package:ifit/service/auth.dart';
import 'package:ifit/views/widgets/button/main_button.dart';
import 'package:ifit/views/widgets/text_field/text_field_container.dart';
import 'package:ifit/views/screens/account_login_reg/register/register.dart';
import 'package:ifit/views/screens/clients_main_screens/main_bottom_bar.dart';
import 'package:ifit/views/screens/Experts_main_screens/exp_bottom_bar.dart';
import 'package:provider/provider.dart';

class LogIn extends StatefulWidget {
  const LogIn({super.key});

  @override
  State<LogIn> createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  bool _isPasswordVisible = false; // Track password visibility
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  bool _isInvalidCredentials = false;

  @override
  Widget build(BuildContext context) {
    final Auth auth = Provider.of<Auth>(context);

    void loginUser() async {
      await auth.login().then((_) {
        bool isExpert = auth.userType == "Expert";

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => isExpert
              ? const ExpBottomBar()
              : const MainBottomBar(),
          ),
        );
      });
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
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        children: [
                          Text('Hey there,',
                            style: Styles.text18,
                          ),
                          Text('Welcome Back',
                            style: Styles.headline25,
                          ),
                          const Gap(30),
                          TextFieldContainer(
                            hintText: 'Email',
                            icon: FluentSystemIcons.ic_fluent_mail_regular,
                            controller: Auth.email,
                          ),
                          const Gap(15),
                          TextFieldContainer(
                            //password eye icon
                            hintText: 'Password',
                            controller: Auth.password,
                            icon: FluentSystemIcons.ic_fluent_lock_regular,
                            obscureText: !_isPasswordVisible,
                            maxLines: _isPasswordVisible ? null : 1,
                            rightIcon: IconButton(
                              icon: _isPasswordVisible
                                  ? const Icon(Icons.visibility)
                                  : const Icon(Icons.visibility_off),
                              onPressed: () {
                                setState(() {
                                  _isPasswordVisible = !_isPasswordVisible;
                                });
                              },
                            ),
                          ),
                          const Gap(5),
                          (_isInvalidCredentials
                              ? Align(
                                  //make a condition that make if any of it wasnt filled it will display "Enter _____"
                                  alignment: Alignment.bottomCenter,
                                  child: Text(
                                    'Invalid Credentials',
                                    style: Styles.text15normal.copyWith(
                                      color: Colors.red,
                                    ),
                                  ),
                                )
                              : const SizedBox())
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.only(
                    right: 20, left: 20, bottom: 5, top: 20),
                child: Column(
                  children: [
                    MainButton(
                      title: 'Login',
                      onPressed: () {
                        loginUser();
                      },
                    ),
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
                            color: Styles.textColor,
                          ),
                        ),
                      ],
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => const Register(),
                          ),
                        );
                      },
                      child: RichText(
                        text: TextSpan(
                          style: Styles.text18,
                          children: <TextSpan>[
                            const TextSpan(
                              text: 'Don’t have an account yet? ',
                            ),
                            TextSpan(
                              text: 'Register',
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
    );
  }
}
