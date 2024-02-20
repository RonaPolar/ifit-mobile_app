import 'package:fluentui_icons/fluentui_icons.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:ifit/common/utils/app_styles.dart';
import 'package:ifit/models/client.dart';
import 'package:ifit/models/expert.dart';
import 'package:ifit/models/meal.dart';
import 'package:ifit/models/workout.dart';
import 'package:ifit/service/Expert.dart';
import 'package:ifit/views/screens/experts_main_screens/exp_home_screens/components/program_created.dart';
import 'package:ifit/views/screens/experts_main_screens/exp_home_screens/components/rating.dart';
import 'package:ifit/views/widgets/icon_text_icon.dart';
import 'package:ifit/views/screens/Experts_main_screens/exp_home_screens/exp_notifications.dart';
import 'package:provider/provider.dart';

class ExpHomeScreen extends StatefulWidget {
  const ExpHomeScreen({
    required this.expertModel,
    required this.workoutPlanList,
    required this.workoutMealList,
    required this.clientList,
    super.key,
  });

  final ExpertModel expertModel;
  final List<WorkoutPlan> workoutPlanList;
  final List<WorkoutMeal> workoutMealList;
  final List<ClientModel> clientList;

  @override
  State<ExpHomeScreen> createState() => _ExpHomeScreenState();
}

class _ExpHomeScreenState extends State<ExpHomeScreen> {

  @override
  Widget build(BuildContext context) {
    final ExpertProvider expertProvider = Provider.of<ExpertProvider>(context);

    final ExpertModel expert = widget.expertModel;

    return Scaffold(
      backgroundColor: Styles.bgColor,
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(15),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Welcome Back,',
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

                const Gap(20),
                ProgramCreatedWidget(
                  expertModel: expert,
                  workoutMealList: widget.workoutMealList,
                  workoutPlanList: widget.workoutPlanList,
                ),
                const Gap(20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // NextNavigation(
                    //   title: 'Program Clients',
                    //   titleTextStyle: Styles.title,
                    //   onTap: () {
                    //     // Navigator.of(context).push(MaterialPageRoute(
                    //     //     builder: (context) => const ExpProgramScreen()));
                    //   },
                    // ),
                    Text("Overall clients",
                      style: Styles.title,
                    ),
                    Center(
                      child: CircleAvatar(
                        radius: MediaQuery.of(context).size.width * 0.3,
                        child: Text("${widget.clientList.length} total clients",
                          style: Styles.headline25,
                        ),
                      ),
                    ),

                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
