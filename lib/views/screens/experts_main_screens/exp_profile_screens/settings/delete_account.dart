import 'package:fluentui_icons/fluentui_icons.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:ifit/common/utils/app_styles.dart';
import 'package:ifit/service/auth.dart';
import 'package:ifit/views/screens/account_login_reg/login.dart';
import 'package:ifit/views/widgets/dialog/confirmation_dialog.dart';
import 'package:ifit/views/widgets/button/main_button.dart';
import 'package:ifit/views/widgets/text_field/text_field_container.dart';
import 'package:provider/provider.dart';

class ExpertDeleteAccount extends StatefulWidget {
  const ExpertDeleteAccount({super.key});

  @override
  State<ExpertDeleteAccount> createState() => _ExpertDeleteAccountState();
}

class _ExpertDeleteAccountState extends State<ExpertDeleteAccount> {
  @override
  Widget build(BuildContext context) {
    final Auth auth = Provider.of<Auth>(context);

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
        title: Text('Gallery',
        style: Styles.headline20,),
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
                        Text(
                          "Please enter your email and password to confirm identity",
                          style: Styles.title
                        ),
                        const Gap(20),
                        TextFieldContainer(
                          controller: Auth.email,
                          hintText: 'Enter your Email',
                          icon: FluentSystemIcons.ic_fluent_mail_add_filled,
                        ),
                        const Gap(20),
                        TextFieldContainer(
                          controller: Auth.password,
                          hintText: 'Enter your Password',
                          icon: FluentSystemIcons.ic_fluent_lock_regular,
                          obscureText: true,
                          maxLines: 1,
                        ),
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
              title: "Delete Account",
              onPressed: () {
              showDialog(context: context,
                builder: (BuildContext context) {
                  return ConfirmationDialog(
                    onYesPressed: () async {
                      Navigator.of(context).pop();
                      await auth.deleteAccount(isClient: false).then((value) {
                        Navigator.of(context).popUntil((route) => route.isFirst);
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (context) => const LogIn()));
                      });
                    },
                  );});
            }),
          )
        ],
      ),
    );
  }
}