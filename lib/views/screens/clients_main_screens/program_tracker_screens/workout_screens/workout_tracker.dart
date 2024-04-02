import 'package:fluentui_icons/fluentui_icons.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:ifit/common/utils/app_styles.dart';
import 'package:ifit/models/workout.dart';
import 'package:ifit/service/auth.dart';
import 'package:ifit/views/screens/clients_main_screens/program_tracker_screens/workout_screens/client_plan_category.dart';
import 'package:ifit/views/widgets/program_widgets.dart';
import 'package:provider/provider.dart';

class WorkoutTrackerScreen extends StatefulWidget {

  const WorkoutTrackerScreen({super.key,
    required this.workoutPlanList,
    required this.clientWorkoutPlan,
  });

  final List<WorkoutPlan> workoutPlanList;
  final List<WorkoutPlan> clientWorkoutPlan;

  @override
  State<WorkoutTrackerScreen> createState() => _WorkoutTrackerScreenState();
}

class _WorkoutTrackerScreenState extends State<WorkoutTrackerScreen> {
  @override
  Widget build(BuildContext context) {

    final Auth auth = Provider.of<Auth>(context);

    num totalCalories = 0;

  for (var data in widget.clientWorkoutPlan) {

    final perDayCalories = data.dayCountFinished * double.parse(data.calories);
    totalCalories += perDayCalories;
  }

    return Scaffold(
      backgroundColor: Styles.bgColor,
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        elevation: 0,
        leading: InkWell(
          onTap: () {
            Navigator.of(context).pop();
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
          'Workout Tracker',
          style: Styles.headline20),
      ),

        body:ListView(
          children: [
            Container(
              padding: const EdgeInsets.all(15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        color: Styles.secondColor, // You might want to specify a color or other decorations.
                      ),
                      height: 200,
                      width: 200,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("$totalCalories kcal",
                            style: Styles.normal.copyWith(
                              fontSize: 25, fontWeight: FontWeight.w500, color: Colors.white)),
                          const Gap(20),
                          Text("Overall Calorie Loss", 
                            style: Styles.title),
                        ],
                      ),
                    ),
                  ),
                  const Gap(20),
                  Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                     Text(
                      "Upcoming Workout Schedule",
                      style: Styles.title
                    ),
                    // TextButton(
                    //   onPressed: () {
                    //     Navigator.of(context).push(
                    //       MaterialPageRoute(
                    //       builder: (context) => const WorkoutSched()));
                    //   },
                    //   child: Text(
                    //     "See More",
                    //     style: Styles.seeMore),
                    //   )
                    ],
                  ),
                  ListView.builder( //WorkoutRowContainer Content
                    padding: EdgeInsets.zero,
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: auth.fitnessGoalList.length,
                    itemBuilder: (context, index) {

                      final String item = auth.fitnessGoalList[index];
                      final List<WorkoutPlan> categoryList = widget.workoutPlanList.where((element) {
                        return element.purpose == auth.fitnessGoalList[index];
                      }).toList();

                      return What2Container(
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(
                            builder: (context) =>
                                ClientPlanCategoryScreen(
                                  workoutPlanList: categoryList,
                                  category: item,
                                ),
                              ),
                            );
                          },
                        fitnessGoal: auth.fitnessGoalList[index],
                        categoryList: categoryList,
                        imageList: [
                          "assets/icons/workout-pic.png",
                          "assets/icons/Ab-workout.png",
                          "assets/icons/Upper-Weights.png",
                        ][index],
                      );
                    },
                  ),
                ],  //Main children
              ),
            ),
          ],
        ),  //Main top
      );
  }
}