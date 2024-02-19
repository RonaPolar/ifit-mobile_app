import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:ifit/common/constant/string.dart';
import 'package:ifit/common/utils/app_styles.dart';
import 'package:ifit/models/client.dart';
import 'package:ifit/models/expert.dart';
import 'package:ifit/models/meal.dart';
import 'package:ifit/models/workout.dart';
import 'package:ifit/views/screens/clients_main_screens/discover_screens/components/expert_list.dart';
import 'package:ifit/views/screens/clients_main_screens/discover_screens/components/new_arrival.dart';
import 'package:ifit/views/screens/clients_main_screens/discover_screens/components/popular.dart';

class DiscoverScreen extends StatefulWidget {
  const DiscoverScreen({
    required this.clientModel,
    required this.workoutPlanList,
    required this.workoutMealList,
    required this.expertList,
    super.key,
  });

  final ClientModel clientModel;
  final List<List<WorkoutPlan>> workoutPlanList;
  final List<List<WorkoutMeal>> workoutMealList;
  final List<ExpertModel> expertList;

  @override
  State<DiscoverScreen> createState() => _DiscoverScreenState();
}

class _DiscoverScreenState extends State<DiscoverScreen> {
  TextEditingController txtSearch = TextEditingController();

  List<Expert> discoverExperts = [];
  List<Workout> popularWorkout = [];
  List<Meal> popularMeal = [];

  @override
  void initState() {
    super.initState();
    getStaticData();
  }

  Future<void> getStaticData() async {
    final String expert = await rootBundle.loadString(JsonFile.expert);
    final String meal = await rootBundle.loadString(JsonFile.meal);
    final String workout = await rootBundle.loadString(JsonFile.workout);

    setState(() {
      discoverExperts = (jsonDecode(expert)["expert"] as List).map((e) => Expert.fromJson(e)).toList();
      popularWorkout = (jsonDecode(workout)["popularWorkout"] as List).map((e) => Workout.fromJson(e)).toList();
      popularMeal = (jsonDecode(meal)["popularMeal"] as List).map((e) => Meal.fromJson(e)).toList();
    });
  }


  @override
  Widget build(BuildContext context) {
    List<dynamic> newArrivalCombination = [];
    List<dynamic> popularCombination = [];
    List<dynamic> combinedList = [];

    final List<WorkoutMeal> newArrivalMeal = widget.workoutMealList.expand((element) => element).toList();
    final List<WorkoutMeal> popularMeal = widget.workoutMealList.expand((element) => element).toList();
    final List<WorkoutPlan> newArrivalPlan = widget.workoutPlanList.expand((element) => element).toList();
    final List<WorkoutPlan> popularPlan = widget.workoutPlanList.expand((element) => element).toList();

    newArrivalMeal.sort((a, b) => a.dateCreated.compareTo(b.dateCreated));
    newArrivalPlan.sort((a, b) => a.dateCreated.compareTo(b.dateCreated));

    popularMeal.sort((a, b) => a.rating.compareTo(b.rating));
    popularPlan.sort((a, b) => a.rating.compareTo(b.rating));

    newArrivalCombination = [...newArrivalMeal, ...newArrivalPlan];
    popularCombination = [...popularMeal, ...popularPlan];

    combinedList = [...newArrivalPlan, ...newArrivalMeal];

    return Scaffold(
      backgroundColor: Styles.bgColor,
      // appBar: AppBar(
      //   backgroundColor: Colors.white,
      //   centerTitle: true,
      //   elevation: 0,
      //   leading: InkWell(
      //     onTap: () {
      //       // Navigator.of(context).push(
      //       //   MaterialPageRoute(
      //       //   builder: (context) => const HomeNavBar()));
      //       },
      //       child: Container(
      //         margin: const EdgeInsets.all(12),
      //           height: 30,
      //           width: 30,
      //         alignment: Alignment.center,
      //         decoration: BoxDecoration(
      //             color: Colors.grey.shade200,
      //             borderRadius: BorderRadius.circular(10)),
      //         child: const Icon(
      //           FluentSystemIcons.ic_fluent_chevron_left_filled,
      //           size: 20,
      //           color: Colors.black,
      //         ),
      //       ),
      //   ),
      //   title: Container(
      //     width: double.maxFinite,
      //     decoration: BoxDecoration(
      //       color: Colors.grey.shade200,
      //       borderRadius: BorderRadius.circular(10)),
      //     child: SearchContainer(
      //       controller: txtSearch, hintText: "Search",
      //     )
      //   ),
      //   actions: [
      //     InkWell(
      //       onTap: () {
      //       Navigator.of(context).push(
      //           MaterialPageRoute(
      //           builder: (context) => const OngoingPrograms()));
      //       },
      //       child: Container(
      //         margin: const EdgeInsets.symmetric(horizontal:15, vertical: 10),
      //         height: 35,
      //         width: 35,
      //         alignment: Alignment.center,
      //         decoration: BoxDecoration(
      //             color: Colors.grey.shade200,
      //             borderRadius: BorderRadius.circular(10)),
      //         child: const Icon(FluentSystemIcons.ic_fluent_person_regular,
      //           size: 20,
      //           color: Colors.black,
      //         ),
      //       ),
      //     ),
      //   ],
      // ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top:15, right:15, left:15),
                  child: Text("Daily Discover",
                    style: Styles.title
                  ),
                ),
                const Gap(10),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    padding: const EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(
                        color: Colors.black,
                        width: 3
                      )
                    ),
                    child: Column(
                      children: [
                        NewArrivalWidget(
                          combinedList: newArrivalCombination,
                        ),
                        const Gap(10),
                        PopularWidget(
                          combinedList: popularCombination,
                        ),
                      ],
                    ),
                  ),
                ),
                const Gap(15),
                ExpertListWidget(
                  discoverExperts: widget.expertList,
                  combinedList: combinedList,
                  workoutMeals: widget.workoutMealList,
                  workoutPlans: widget.workoutPlanList,
                ),
                const Gap(10)
              ],//main Children
            ),
          ),
        ),
      ),
    );
  }
}