import 'package:fluentui_icons/fluentui_icons.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:ifit/common/utils/app_styles.dart';
import 'package:ifit/models/expert.dart';
import 'package:ifit/models/meal.dart';
import 'package:ifit/models/workout.dart';
import 'package:ifit/service/Expert.dart';
import 'package:ifit/views/widgets/dialog/confirmation_dialog.dart';
import 'package:ifit/views/widgets/button/main_button.dart';
import 'package:ifit/views/widgets/icon_text_icon.dart';
import 'package:ifit/views/widgets/toggle_switch.dart';
import 'package:ifit/views/screens/account_login_reg/login.dart';
import 'package:ifit/views/screens/clients_main_screens/profile_screens/about.dart';
import 'package:ifit/views/screens/clients_main_screens/profile_screens/privacy_policy.dart';
import 'package:ifit/views/screens/clients_main_screens/profile_screens/profile.dart';
import 'package:ifit/views/screens/Experts_main_screens/exp_home_screens/exp_activity.dart';
import 'package:ifit/views/screens/Experts_main_screens/exp_profile_screens/settings/edit_profile.dart';
import 'package:ifit/views/screens/Experts_main_screens/exp_profile_screens/settings/settings.dart';
import 'package:provider/provider.dart';

class ExpProfileScreen extends StatelessWidget {
  const ExpProfileScreen({
    required this.expertModel,
    required this.workoutMealList,
    required this.workoutPlanList,

    super.key,
  });

  final List<WorkoutPlan> workoutPlanList;
  final List<WorkoutMeal> workoutMealList;
  final ExpertModel expertModel;

  @override
  Widget build(BuildContext context) {

    final ExpertProvider expert = Provider.of<ExpertProvider>(context);

    return Scaffold(
      backgroundColor: Styles.bgColor,
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        automaticallyImplyLeading: false,
        elevation: 0,
        title: Text(
          'Profile',
          style: Styles.headline20,
        ),
      ),
      body: ListView(
        children: [
          Container(
            padding: const EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  children: [
                    Row(
                      children: [
                        InkWell(
                          onTap: () async {
                            await expert.uploadPhotoProfile(context,
                              id: expertModel.uid,
                            );
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              border: Border.all(
                                color: Styles
                                    .primaryColor, // Replace with your desired border color
                                width:
                                    2.0, // Replace with your desired border width
                              ),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(30),
                              child: SizedBox(
                                width: 50,
                                height: 50,
                                child: Image.network(expertModel.professionId,
                                  fit: BoxFit.fill,
                                  errorBuilder: (context, object, stackTrace) {
                                    return const Icon(Icons.question_mark_rounded);
                                  },
                                ),
                              ),
                            ),
                          ),
                        ),
                        const Gap(10),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(expertModel.name, style: Styles.title),
                              const Gap(5),
                              Text(expertModel.profession, style: Styles.text15normal)
                            ],
                          ),
                        ),
                        SizedBox(
                            width: 80,
                            height: 30,
                            child: MainButton(
                              title: "Edit",
                              onPressed: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => EditProfile(
                                      expertModel: expertModel,
                                    )));
                              },
                              textStyle: Styles.seeMore.copyWith(
                                color: Colors.white,
                              ),
                            )),
                      ],
                    ),
                    const Gap(10),
                    Row(
                      children: [
                        Expanded(
                          child: ProfileCell(
                            value: "${expertModel.rating}",
                            title: 'Star Rate',
                          ),
                        ),
                        const Gap(10),
                        Expanded(
                          child: ProfileCell(
                            value: "${workoutMealList.length}",
                            title: 'Meals',
                          ),
                        ),
                        const Gap(10),
                        Expanded(
                          child: ProfileCell(
                            value: "${workoutPlanList.length}",
                            title: 'Workouts',
                          ),
                        ),
                      ],
                    ),
                    const Gap(15),
                    Container(
                      height: 140,
                      padding: const EdgeInsets.symmetric(
                          vertical: 15, horizontal: 15),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15),
                          boxShadow: const [
                            BoxShadow(color: Colors.black26, blurRadius: 2)
                          ]),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Account", style: Styles.title),
                          const Gap(1),
                          NextNavigation(
                            iconData:
                                FluentSystemIcons.ic_fluent_history_regular,
                            title: 'Activity History',
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) =>
                                      const ExpActivityHistory()));
                            },
                          ),
                          NextNavigation(
                            iconData:
                                FluentSystemIcons.ic_fluent_activity_regular,
                            title: 'Program Progress',
                            onTap: () {
                              // Navigator.of(context).push(MaterialPageRoute(
                              //     builder: (context) => const ExpProgramScreen()));
                            },
                          ),
                        ],
                      ),
                    ),
                    const Gap(20),
                    Container(
                      height: 110,
                      padding: const EdgeInsets.symmetric(
                          vertical: 15, horizontal: 15),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15),
                          boxShadow: const [
                            BoxShadow(color: Colors.black26, blurRadius: 2)
                          ]),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Notifications", style: Styles.title),
                          const Gap(1),
                          Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const Icon(
                                  FluentSystemIcons.ic_fluent_alert_regular,
                                ),
                                const SizedBox(
                                  width: 15,
                                ),
                                Expanded(
                                  child: Text(
                                    "Pop-up Notification",
                                    style: Styles.text12.copyWith(fontSize: 16),
                                  ),
                                ),
                                const ToggleSwitch()
                              ]),
                        ],
                      ),
                    ),
                    const Gap(20),
                    Container(
                      height: 250,
                      padding: const EdgeInsets.symmetric(
                          vertical: 15, horizontal: 15),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15),
                          boxShadow: const [
                            BoxShadow(color: Colors.black26, blurRadius: 2)
                          ]),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Other", style: Styles.title),
                          const Gap(1),
                          NextNavigation(
                            iconData: FluentSystemIcons.ic_fluent_info_regular,
                            title: 'About',
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => const About()));
                            },
                          ),
                          NextNavigation(
                            iconData: FluentSystemIcons.ic_fluent_mail_regular,
                            title: 'Contact Us',
                            onTap: () {
                              // Navigator.of(context).push(MaterialPageRoute(
                              //   builder: (context) => const ContactUs()));
                            },
                          ),
                          NextNavigation(
                            iconData:
                                FluentSystemIcons.ic_fluent_shield_regular,
                            title: 'Privacy Policy',
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) =>
                                      const PrivacyPolicyScreen()));
                            },
                          ),
                          NextNavigation(
                            iconData:
                                FluentSystemIcons.ic_fluent_settings_regular,
                            title: 'Settings',
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => Settings(
                                  id: expertModel.uid,
                                  expertModel: expertModel,
                              )));
                            },
                          ),
                          NextNavigation(
                            iconData: Icons.logout_outlined,
                            title: 'Log Out',
                            onTap: () {
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return ConfirmationDialog(
                                      onYesPressed: () {
                                        Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    const LogIn()));
                                      },
                                    );
                                  });
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ], //main Children
            ),
          ),
        ],
      ),
    );
  }
}
