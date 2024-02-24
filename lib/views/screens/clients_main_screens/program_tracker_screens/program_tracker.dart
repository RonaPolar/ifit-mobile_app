import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:ifit/common/utils/app_styles.dart';
import 'package:ifit/models/client.dart';
import 'package:ifit/models/meal.dart';
import 'package:ifit/models/workout.dart';
import 'package:ifit/views/screens/clients_main_screens/program_tracker_screens/components/status.dart';
import 'package:ifit/views/widgets/button/main_button.dart';
import 'package:ifit/views/widgets/program_widgets.dart';
import 'package:ifit/views/screens/clients_main_screens/program_tracker_screens/meal_screens/meal_details.dart';
import 'package:ifit/views/screens/clients_main_screens/program_tracker_screens/meal_screens/meal_tracker.dart';
import 'package:ifit/views/screens/clients_main_screens/program_tracker_screens/program_schedule/program_schedule.dart';
import 'package:ifit/views/screens/clients_main_screens/program_tracker_screens/workout_screens/workout_tracker.dart';

import 'workout_screens/workout_details.dart';

class ProgramTrackerScreen extends StatefulWidget {
  const ProgramTrackerScreen({
    required this.clientModel,
    required this.workoutPlanList,
    required this.workoutMealList,
    super.key,
  });

  final ClientModel clientModel;
  final List<WorkoutPlan> workoutPlanList;
  final List<WorkoutMeal> workoutMealList;


  @override
  State<ProgramTrackerScreen> createState() => _ProgramTrackerScreenState();
}

class _ProgramTrackerScreenState extends State<ProgramTrackerScreen> {

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();


  @override
  Widget build(BuildContext context) {
    final List<WorkoutPlan> completedWorkoutPlan = widget.workoutPlanList.where((element) {

      if (element.dayCountFinished != null) {
        final bool isCompleted = int.parse(element.daysOfThePlan) > int.parse(element.dayCountFinished.toString());

        return isCompleted || element.isCancelled;
      } else {
        return !element.isCancelled;
      }
    }).toList();

    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Styles.bgColor,
      appBar: AppBar(
      backgroundColor: Colors.white,
      centerTitle: true,
      elevation: 0,
      automaticallyImplyLeading: false,
      title: Text('Program Tracker',
          style: Styles.headline20,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(15),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                decoration: BoxDecoration(
                  color: Styles.secondColor.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Daily Schedule',
                      style: Styles.text15bold
                    ),
                    SizedBox(
                      width: 80,
                      height: 30,
                        child: MainButton(
                          title: "Check",
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => const MealSched()),
                            );
                          },
                          textStyle: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
              ),
            ),

            ProgramStatusWidget(
              workoutMealList: widget.workoutMealList,
              workoutPlanList: widget.workoutPlanList,
              clientModel: widget.clientModel,
              scaffoldKey: scaffoldKey,
            ),


            const Gap(10),
            Container(
              padding: const EdgeInsets.all(15),
              child: Column(
                children: [
                  Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Workout Tracker",
                      style: Styles.title
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) => WorkoutTrackerScreen(
                            workoutPlanList: widget.workoutPlanList,
                          )));
                      },
                      child: Text("See More",
                          style: Styles.seeMore
                        ),
                      )
                    ],
                  ),
                  ListView.builder(
                    padding: EdgeInsets.zero,
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: completedWorkoutPlan.length,
                    itemBuilder: (context, index) {
                      var wObj = completedWorkoutPlan[index];

                      return InkWell(
                        onTap: () {
                            Navigator.push(context, MaterialPageRoute(
                              builder: (context) => WorkoutDetails(
                                dObj: wObj,
                                id: widget.clientModel.uid,
                              ),
                            ));
                          },
                          child: ProgramRow(
                            image: wObj.workoutPicture,
                            title: wObj.planName,
                            bottomText: "${wObj.minutes} minutes | ${wObj.calories} Calories",
                            progress: wObj.dayCountFinished == null
                                ? 0
                                : 1 - ((int.parse(wObj.daysOfThePlan)
                                - wObj.dayCountFinished!) / double.parse(wObj.daysOfThePlan)),
                            progressText: wObj.daysOfThePlan,
                            showToggleSwitch: false,
                        ),
                      );
                      // return OngoingRow(
                      //   image: item.workoutPicture,
                      //   title: item.planName,
                      //   bottomText: "${item.minutes} minutes | ${item.calories} Calories",
                      //   progress: item.dayCountFinished == null
                      //       ? 0
                      //       : (int.parse(item.daysOfThePlan) - item.dayCountFinished!) * 0.01,
                      //   progressText: item.daysOfThePlan,
                      //   icon: FluentSystemIcons.ic_fluent_more_vertical_regular,
                      //   showToggleSwitch: false,
                      //   onPressed: () async {
                      //   },
                      //   leading: SizedBox(
                      //     height: 30,
                      //     width: 78,
                      //     child: MainButton(
                      //       title: "${widget.workoutPlanList[index].isCancelled}",
                      //       textStyle: Styles.seeMore.copyWith(
                      //         color: Colors.white,),
                      //       buttonColor: Styles.secondColor,
                      //       onPressed: () {
                      //         dialog.confirmationDialog(context,
                      //             onPressed: () async {
                      //               await workoutProvider.cancelWorkout(
                      //                 id: widget.clientModel.uid,
                      //                 workoutPlan: item,
                      //               );
                      //             }
                      //         );
                      //       },
                      //     ),
                      //   ),
                      // );
                    },
                  ),



                  const Gap(10),
                  Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Meal Tracker",
                      style: Styles.title
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) => MealTrackerScreen(
                            workoutMealList: widget.workoutMealList,
                          )));
                      },
                      child: Text("See More",
                          style: Styles.seeMore
                        ),
                      )
                    ],
                  ),
                  ListView.builder(
                    padding: EdgeInsets.zero,
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: widget.workoutMealList.length,
                    itemBuilder: (context, index) {
                      var mObj = widget.workoutMealList[index];
                      return InkWell(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(
                            builder: (context) => MealDetails(
                              workoutMeal: mObj,
                              id: widget.clientModel.uid,
                            ),
                          ));
                        },
                        child: ProgramRow(image: mObj.foodPhoto,
                          title: mObj.foodPlanName,
                          bottomText: "${mObj.purpose} | ${mObj.calories} Calories",
                          showToggleSwitch: false,
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],  //main Children
        ),
      ),
    );
  }
}