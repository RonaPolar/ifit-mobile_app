import 'package:fluentui_icons/fluentui_icons.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:ifit/common/utils/app_styles.dart';
import 'package:ifit/models/client.dart';
import 'package:ifit/models/meal.dart';
import 'package:ifit/models/workout.dart';
import 'package:ifit/views/widgets/icon_text_icon.dart';
import 'package:ifit/views/widgets/button/main_button.dart';
import 'package:ifit/views/widgets/program_widgets.dart';
import 'package:ifit/views/screens/clients_main_screens/program_tracker_screens/meal_screens/meal_details.dart';
import 'package:ifit/views/screens/clients_main_screens/program_tracker_screens/meal_screens/meal_tracker.dart';
import 'package:ifit/views/screens/clients_main_screens/discover_screens/my_program/my_program.dart';
import 'package:ifit/views/screens/clients_main_screens/program_tracker_screens/rate_screens/my_rate.dart';
import 'package:ifit/views/screens/clients_main_screens/program_tracker_screens/program_schedule/program_schedule.dart';
import 'package:ifit/views/screens/clients_main_screens/program_tracker_screens/workout_screens/workout_tracker.dart';

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
  @override
  Widget build(BuildContext context) {
  List latestWorkoutArr = [
    {
      "name": "Full Body Exercises",
      "image": "assets/icons/workout-pic.png",
      "rate": "4.7",
      "kcal": "180",
      "days": "14",
      "duration": "30",
      "exercise": "10",
      "progress": 0.3,
    },
    {
      "name": "Upper Body Weights",
      "image": "assets/icons/Lower-Weights.png",
      "rate": "4.3",
      "kcal": "200",
      "duration": "30",
      "days": "10",
      "exercise": "11",
      "progress": 0.5,
    },
    {
      "name": "Upper Ab Exercises",
      "image": "assets/icons/Ab-workout.png",
      "rate": "4.5",
      "kcal": "300",
      "duration": "20",
      "days": "15",
      "exercise": "12",
      "progress": 0.6,
    },
  ];

    List latestMealArr = [
    {
      "name": "Blueberry Pancake",
      "image": "assets/images/meal/pancake.png",
      "rate": "4.9",
      "kcal": "190",
      "fats": "100",
      "proteins": "176",
      "sugar": "50",
      "categories": "Breakfast",
      "days": "21",
      "progress": 0.2,
    },
    {
      "name": "Salad",
      "image": "assets/images/meal/salad.png",
      "rate": "4.6",
      "kcal": "200",
      "fats": "100",
      "proteins": "300",
      "sugar": "50",
      "categories": "Lunch",
      "days": "15",
      "progress": 0.9,
    },
    {
      "name": "Salmon Nigiri",
      "image": "assets/images/meal/nigiri.png",
      "rate": "4.3",
      "kcal": "300",
      "fats": "170",
      "proteins": "400",
      "sugar": "79",
      "categories": "Dinner",
      "days": "14",
      "progress": 0.5,
    },
  ];

    return Scaffold(
      backgroundColor: Styles.bgColor,
      appBar: AppBar(
      backgroundColor: Colors.white,
      centerTitle: true,
      elevation: 0,
      automaticallyImplyLeading: false,
      title: Text('Program Tracker',
        style: Styles.headline20,
      ),
      actions: [
          InkWell(
            onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const OngoingPrograms()),
              );
            },
            child: Container(
              margin: const EdgeInsets.all(12),
              height: 30,
              width: 30,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Icon(FluentSystemIcons.ic_fluent_person_regular,
                size: 20,
                color: Colors.black,
              ),
            ),
          ),
        ],
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

            Container(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                    color: Colors.grey.shade500,
                  ),
                  bottom: BorderSide(
                    color: Colors.grey.shade500,
                  ),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButtonText(
                    iconData: FluentSystemIcons.ic_fluent_timer_filled,
                    title: 'Ongoing',
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const OngoingPrograms()));
                    },
                  ),
                  IconButtonText(
                    iconData: FluentSystemIcons.ic_fluent_heart_filled,
                    title: 'Favorites',
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const FavoritesProgram()));
                    },
                  ),
                  IconButtonText(
                    iconData: FluentSystemIcons.ic_fluent_checkmark_circle_filled,
                    title: 'Finished',
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const FinishedProgram()));
                    },
                  ),
                  IconButtonText(
                    iconData: FluentSystemIcons.ic_fluent_star_filled,
                    title: 'Rate',
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const ToRateProgram()));
                    },
                  ),
                ],
              )
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
                          builder: (context) => const WorkoutTrackerScreen()));
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
                    itemCount: widget.workoutPlanList.length,
                    itemBuilder: (context, index) {
                      var wObj = widget.workoutPlanList[index];
                      return InkWell(
                        onTap: () {
                          // Navigator.push(context, MaterialPageRoute(
                          //     builder: (context) => WorkoutDetails(dObj: wObj)));
                          },
                          child: ProgramRow(
                            image: wObj.workoutPicture,
                            title: wObj.planName,
                            bottomText: "${wObj.minutes} minutes | ${wObj.calories} Calories",
                            progress: 12,
                            progressText: "${wObj.daysOfThePlan.day}",
                            showToggleSwitch: false,
                        ),
                      );
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
                          builder: (context) => const MealTrackerScreen()));
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
                          // Navigator.push(context, MaterialPageRoute(
                          //   builder: (context) => MealDetails(dObj: mObj)));
                        },
                        child: ProgramRow(image: mObj.foodPhoto,
                          title: mObj.foodPlanName,
                          bottomText: "${mObj.purpose} | ${mObj.calories} Calories",
                          progress: 12,
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