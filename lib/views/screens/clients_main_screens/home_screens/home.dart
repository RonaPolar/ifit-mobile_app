import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:ifit/common/constant/string.dart';
import 'package:ifit/common/utils/app_styles.dart';
import 'package:ifit/models/client.dart';
import 'package:ifit/views/widgets/container/big.dart';
import 'package:ifit/models/meal.dart';
import 'package:ifit/models/schedule.dart';
import 'package:ifit/models/workout.dart';
import 'package:ifit/service/client.dart';
import 'package:ifit/views/screens/clients_main_screens/home_screens/components/activity.dart';
import 'package:ifit/views/screens/clients_main_screens/home_screens/components/bmi.dart';
import 'package:ifit/views/screens/clients_main_screens/home_screens/components/welcome_back.dart';
import 'package:ifit/views/screens/clients_main_screens/program_tracker_screens/meal_screens/meal_details.dart';
import 'package:ifit/views/screens/clients_main_screens/program_tracker_screens/meal_screens/meal_tracker.dart';
import 'package:ifit/views/screens/clients_main_screens/program_tracker_screens/workout_screens/workout_details.dart';
import 'package:ifit/views/screens/clients_main_screens/program_tracker_screens/workout_screens/workout_tracker.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    required this.clientModel,
    required this.workoutPlanList,
    required this.workoutMealList,
    super.key,
  });

  final ClientModel clientModel;
  final List<List<WorkoutPlan>> workoutPlanList;
  final List<List<WorkoutMeal>> workoutMealList;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Schedule> schedArr = [
    Schedule(title: "7pm - 8pm", subtitle: "Stretching"),
    Schedule(title: "5pm - 6:30pm", subtitle: "Full Body"),
    Schedule(title: "8am - 9pm", subtitle: "Abdominal"),
    Schedule(title: "7:30am - 7:50am", subtitle: "Stretching"),
    Schedule(title: "6:30am - 7am", subtitle: "Meal"),
  ];

  List<Workout> recommendWorkout = [];
  List<Meal> recommendMeal = [];

  @override
  void initState() {
    super.initState();
    // Fetch data based on the provided UID when the widget initializes
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final ClientProvider clientProvider = Provider.of<ClientProvider>(context, listen: false);
      clientProvider.getBmi(client: widget.clientModel);
      getStaticData();
    });

  }

  Future<void> getStaticData() async {
    final String workout = await rootBundle.loadString(JsonFile.workout);
    final String meal = await rootBundle.loadString(JsonFile.meal);

    setState(() {
      recommendWorkout = (jsonDecode(workout)["workout"] as List).map((e) => Workout.fromJson(e)).toList();
      recommendMeal = (jsonDecode(meal)["meal"] as List).map((e) => Meal.fromJson(e)).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    final ClientProvider clientProvider =  Provider.of<ClientProvider>(context);
    final ClientModel client = widget.clientModel;

    return SafeArea(
      child: Scaffold(
        backgroundColor: Styles.bgColor,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                WelcomeBackWidget(
                  name: client.name,
                ),
                const Gap(20),
                BMIWidget(bmi: clientProvider.bmi),
                const Gap(15),
                /// TODO: REVERT IT ONCE OKAY
                // Container(
                //   padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                //   decoration: BoxDecoration(
                //     color: Styles.secondColor.withOpacity(0.2),
                //     borderRadius: BorderRadius.circular(15),
                //   ),
                //   child: Row(
                //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //     children: [
                //       Text('Today Target',
                //         style: Styles.text15bold.copyWith(
                //           color: Colors.black,
                //         ),
                //       ),
                //       SizedBox(
                //         width: 80,
                //         height: 30,
                //         child: MainButton(
                //           title: "Check",
                //           onPressed: () {
                //             Navigator.of(context).push(MaterialPageRoute(
                //               builder: (context) => const ActivityTracker()));
                //           },
                //           textStyle: Styles.seeMore.copyWith(
                //             color: Colors.white,
                //           ),
                //         ),
                //       ),
                //     ],
                //   ),
                // ),
                const Gap(20),
                Text('Activity Today', style: Styles.title),
                const Gap(10),
                ActivityTodayWidget(schedArr: schedArr),
                const Gap(20),
                _buildWorkoutRecommendation(clientProvider),
                const Gap(15),
                _buildMealRecommendation(clientProvider),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildWorkoutRecommendation(ClientProvider clientProvider) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Workout Recommendation", style: Styles.title),
            TextButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(
                    builder: (context) => const WorkoutTrackerScreen()),
                );
              },
              child: Text("See More", style: Styles.seeMore),
            )
          ],
        ),
        Row(
          children: widget.workoutPlanList.map((data) {
            return Expanded(
              child: SizedBox(
                height: 200,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    final WorkoutPlan workoutPlan = data[index];
                    return InkWell(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(
                            builder: (context) => WorkoutDetails(dObj: workoutPlan)));
                      },
                      child: BigContainer(
                        image: workoutPlan.workoutPicture,
                        title: workoutPlan.planName,
                        bottomText:
                        "${workoutPlan.minutes} minutes | ${workoutPlan.calories} kcal",
                      ),
                    );
                  },
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildMealRecommendation(ClientProvider clientProvider) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Meal Recommendation", style: Styles.title),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const MealTrackerScreen()),
                );
              },
              child: Text("See More", style: Styles.seeMore),
            )
          ],
        ),
        Row(
          children: widget.workoutMealList.map((data) {
            return Expanded(
              child: SizedBox(
                height: 200,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    final WorkoutMeal mObj = data[index];
                    return InkWell(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(
                            builder: (context) => MealDetails(dObj: mObj)),
                        );
                      },
                      child: BigContainer(
                        image: mObj.foodPhoto,
                        title: mObj.foodPlanName,
                        bottomText:
                        "${mObj.purpose} | ${mObj.calories} kcal",
                      ),
                    );
                  },
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
