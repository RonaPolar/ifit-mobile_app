import 'package:fluentui_icons/fluentui_icons.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:ifit/common/utils/app_styles.dart';
import 'package:ifit/models/expert.dart';
import 'package:ifit/views/screens/experts_main_screens/exp_home_screens/components/program_created.dart';
import 'package:ifit/views/screens/experts_main_screens/exp_home_screens/components/rating.dart';
import 'package:ifit/views/widgets/icon_text_icon.dart';
import 'package:ifit/views/widgets/button/main_button.dart';
import 'package:ifit/views/screens/Experts_main_screens/exp_home_screens/exp_activity.dart';
import 'package:ifit/views/screens/Experts_main_screens/exp_home_screens/exp_notifications.dart';
import 'package:ifit/views/screens/Experts_main_screens/exp_program_screens/exp_program.dart';

class ExpHomeScreen extends StatefulWidget {
  const ExpHomeScreen({
    required this.expertModel,
    super.key,
  });

  final ExpertModel expertModel;

  @override
  State<ExpHomeScreen> createState() => _ExpHomeScreenState();
}

class _ExpHomeScreenState extends State<ExpHomeScreen> {

  @override
  Widget build(BuildContext context) {

    final ExpertModel expert = widget.expertModel;

    return Scaffold(
      backgroundColor: Styles.bgColor,
      body: ListView(
        children: [
          Container(
            padding: const EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Welcome Back,',
                          style: Styles.text15normal,
                        ),
                        Text(
                          expert.name,
                          style: Styles.headline20,
                        ),
                      ],
                    ),
                    IconButton(
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => const ExpNotifications()));
                        },
                        icon: const Icon(
                            FluentSystemIcons.ic_fluent_alert_regular))
                  ],
                ),
                const Gap(20),
                ExpertRatingWidget(expertModel: expert),
                const Gap(15),
                Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                  decoration: BoxDecoration(
                    color: Styles.secondColor.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Activity Tracker',
                        style: Styles.text15bold.copyWith(
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(
                          width: 80,
                          height: 30,
                          child: MainButton(
                            title: "Check",
                            onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) =>
                                      const ExpActivityHistory()));
                            },
                            textStyle: Styles.seeMore.copyWith(
                              color: Colors.white,
                            ),
                          )),
                    ],
                  ),
                ),
                const Gap(20),
                ProgramCreatedWidget(expertModel: expert),
                const Gap(20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    NextNavigation(
                      title: 'Program Clients',
                      titleTextStyle: Styles.title,
                      onTap: () {
                        // Navigator.of(context).push(MaterialPageRoute(
                        //     builder: (context) => const ExpProgramScreen()));
                      },
                    ),
                    Container(
                      padding: const EdgeInsets.only(top: 10),
                      height: 190,
                      width: double.maxFinite,
                      alignment: Alignment.center,
                      child: ExpClientsChart(),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
