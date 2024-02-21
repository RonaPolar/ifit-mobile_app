import 'package:fluentui_icons/fluentui_icons.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:ifit/common/utils/app_styles.dart';
import 'package:ifit/service/auth.dart';
import 'package:ifit/service/package.dart';
import 'package:ifit/views/widgets/button/main_button.dart';
import 'package:ifit/views/widgets/text_field/text_field_container.dart';
import 'package:ifit/views/screens/account_login_reg/register/register.dart';
import 'package:ifit/views/screens/clients_main_screens/main_bottom_bar.dart';
import 'package:ifit/views/screens/Experts_main_screens/exp_bottom_bar.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
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

  final bool _isInvalidCredentials = false;
  final GlobalKey<FormState> formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {

    final IFitPackage package = Provider.of<IFitPackage>(context);
    final Auth auth = Provider.of<Auth>(context);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Styles.bgColor,
      body: Form(
        key: formKey,
        child: ModalProgressHUD(
          inAsyncCall: auth.isLoading,
          child: SafeArea(
            child: LayoutBuilder(
              builder: (context, constraint) {
                return Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      minHeight: constraint.maxHeight,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: _buildTop(),
                        ),
                        _buildBottom(package),
                      ],
                    ),
                  ),
                );
              }
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTop() {
    return Column(
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
          validator: (val) {
            if (val == null || val.isEmpty) {
              return "This field is required";
            } else {
              return null;
            }
          },
        ),
        const Gap(5),
      ],
    );
  }

  Widget _buildBottom(IFitPackage package) {

    final Auth auth = Provider.of<Auth>(context);

    void loginUser() async {
      if (formKey.currentState!.validate()) {
        await auth.login().then((_) {
          bool isExpert = auth.userType == "Expert";

          Navigator.pushReplacement(context,
            MaterialPageRoute(
              builder: (context) => isExpert
                ? const ExpBottomBar()
                : const MainBottomBar(),
            ),
          );
        });
      }
    }

    return Column(
      children: [
        const Gap(16.0),
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
        Text("Build version: ${package.info.buildNumber}"),
      ],
    );
  }
}
