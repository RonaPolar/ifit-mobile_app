import 'package:fluentui_icons/fluentui_icons.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:ifit/common/utils/app_styles.dart';
import 'package:ifit/service/auth.dart';
import 'package:ifit/views/screens/account_login_reg/password/pass_success.dart';
import 'package:ifit/views/widgets/dialog/confirmation_dialog.dart';
import 'package:ifit/views/widgets/button/main_button.dart';
import 'package:ifit/views/widgets/text_field/text_field_container.dart';
import 'package:ifit/views/widgets/verification_text_box.dart';
import 'package:provider/provider.dart';

class ExpertChangePass extends StatefulWidget {
  const ExpertChangePass({
    super.key,
    required this.id,
  });

  final String id;

  @override
  State<ExpertChangePass> createState() => _ExpertChangePassState();
}

class _ExpertChangePassState extends State<ExpertChangePass> {
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
        title: Text('Change Password',
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
                          "Please enter your password to confirm identity",
                          style: Styles.title
                        ),
                        const Gap(20),
                        TextFieldContainer(
                          controller: Auth.password,
                          hintText: 'Current Password',
                          icon: FluentSystemIcons.ic_fluent_lock_regular,
                          obscureText: true,
                          maxLines: 1,
                        ),
                        const Gap(15),
                        TextFieldContainer(
                          controller: Auth.newPassword,
                          hintText: 'New Password',
                          icon: FluentSystemIcons.ic_fluent_mail_regular,
                          obscureText: true,
                          maxLines: 1,
                        ),
                        const Gap(15),
                        TextFieldContainer(
                          controller: Auth.confirmPassword,
                          hintText: 'Confirm Password',
                          icon: FluentSystemIcons.ic_fluent_mail_regular,
                          obscureText: true,
                          maxLines: 1,
                        ),
                        const Gap(5),
                      ],
                    ),
                    
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15),
            child: MainButton(title: "Confirm", onPressed: (){
              showDialog(context: context,
                builder: (BuildContext context) {
                  return ConfirmationDialog(
                    onYesPressed: () async {

                      Navigator.pushReplacement(context, MaterialPageRoute(
                        builder: (context) => VerificationCodeScreen(
                          onConfirmPressed: () async {
                            await auth.updatePassword(widget.id).then((value) {
                              Navigator.of(context).pop();
                              Navigator.pushReplacement(context, MaterialPageRoute(
                                  builder: (
                                      context) => const SuccessPassword()));
                            });
                          }),
                        ),
                      );
                    },
                  );});
            }),
          )
        ],
      ),
    );
  }
}