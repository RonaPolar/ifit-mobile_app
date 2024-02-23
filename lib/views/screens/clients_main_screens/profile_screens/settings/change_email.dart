import 'package:fluentui_icons/fluentui_icons.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:ifit/common/utils/app_styles.dart';
import 'package:ifit/service/auth.dart';
import 'package:ifit/views/widgets/dialog/confirmation_dialog.dart';
import 'package:ifit/views/widgets/button/main_button.dart';
import 'package:ifit/views/widgets/text_field/text_field_container.dart';
import 'package:ifit/views/widgets/verification_text_box.dart';
import 'package:ifit/views/screens/clients_main_screens/profile_screens/settings/success_email.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';

class ChangeEmail extends StatefulWidget {
  const ChangeEmail({
    required this.id,
    super.key,
  });

  final String id;

  @override
  State<ChangeEmail> createState() => _ChangeEmailState();
}

class _ChangeEmailState extends State<ChangeEmail> {
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
        title: Text('Change Email',
        style: Styles.headline20,),
      ),
      body: ModalProgressHUD(
        inAsyncCall: auth.isLoading,
        child: Column(
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
                          const TextFieldContainer(
                            hintText: 'Enter your Password',
                            icon: FluentSystemIcons.ic_fluent_lock_regular,
                            obscureText: true,
                            maxLines: 1,
                          ),
                          const Gap(15),
                          TextFieldContainer(hintText: 'Current Email',
                            icon: FluentSystemIcons.ic_fluent_mail_regular,
                            controller: Auth.email,
                          ),
                          const Gap(15),
                          TextFieldContainer(hintText: 'New Email',
                            icon: FluentSystemIcons.ic_fluent_mail_regular,
                            controller: Auth.newEmail,
                          ),
                          const Gap(5),
                          // Align(
                          //   //make a condition that make if any of it wasnt filled it will display "Enter _____"
                          //   alignment: Alignment.bottomLeft,
                          //   child: Text(
                          //     'Wrong Password',
                          //     style: Styles.text15normal.copyWith(
                          //       color: Colors.red,
                          //     ),
                          //   ),
                          // ),
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
                title: "Confirm",
                onPressed: () {
                  showDialog(context: context,
                    builder: (BuildContext context) {
                      return ConfirmationDialog(
                        onYesPressed: () async {
                          await auth.updateEmail(widget.id).then((value) {
                            Navigator.pushReplacement(context,MaterialPageRoute(
                                builder: (context) => const SuccessEmail()));
                          });
                          // Navigator.pushReplacement(context,MaterialPageRoute(
                          //   builder: (context) => VerificationCodeScreen(
                          //     onConfirmPressed: () {
                          //       Navigator.pushReplacement(context,MaterialPageRoute(
                          //         builder: (context) => const SuccessEmail()));
                          //     },
                          //   )
                          // ),);
                        },
                      );
                    },
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}