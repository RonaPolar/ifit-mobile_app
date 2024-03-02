import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:ifit/common/utils/app_styles.dart';
import 'package:ifit/models/client.dart';
import 'package:ifit/models/expert.dart';
import 'package:ifit/models/meal.dart';
import 'package:ifit/models/workout.dart';
import 'package:ifit/views/screens/clients_main_screens/discover_screens/components/expert_list.dart';
import 'package:ifit/views/screens/clients_main_screens/discover_screens/components/new_arrival.dart';
import 'package:ifit/views/screens/clients_main_screens/discover_screens/components/popular.dart';

class DiscoverScreen extends StatelessWidget {
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
  Widget build(BuildContext context) {
    List<dynamic> newArrivalCombination = [];
    List<dynamic> popularCombination = [];

    final List<WorkoutMeal> newArrivalMeal = workoutMealList.expand((element) => element).toList();
    final List<WorkoutMeal> popularMeal = workoutMealList.expand((element) => element).toList();
    final List<WorkoutPlan> newArrivalPlan = workoutPlanList.expand((element) => element).toList();
    final List<WorkoutPlan> popularPlan = workoutPlanList.expand((element) => element).toList();

    newArrivalMeal.sort((a, b) => a.dateCreated.compareTo(b.dateCreated));
    newArrivalPlan.sort((a, b) => a.dateCreated.compareTo(b.dateCreated));

    popularMeal.sort((a, b) => a.rating!.compareTo(b.rating!));
    popularPlan.sort((a, b) => a.rating!.compareTo(b.rating!));

    newArrivalCombination = [...newArrivalMeal, ...newArrivalPlan];
    popularCombination = [...popularMeal, ...popularPlan];

    return Scaffold(
      backgroundColor: Styles.bgColor,
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
                          clientModel: clientModel,
                        ),
                        const Gap(10),
                        PopularWidget(
                          combinedList: popularCombination,
                          clientModel: clientModel,
                        ),
                      ],
                    ),
                  ),
                ),
                const Gap(15),
                ExpertListWidget(
                  discoverExperts: expertList,
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