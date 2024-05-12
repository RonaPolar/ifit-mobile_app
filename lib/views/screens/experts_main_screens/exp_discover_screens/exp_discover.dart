import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:ifit/common/utils/app_styles.dart';
import 'package:ifit/models/expert.dart';
import 'package:ifit/models/meal.dart';
import 'package:ifit/models/workout.dart';
import 'package:ifit/views/screens/experts_main_screens/exp_discover_screens/components/expert_list.dart';
import 'package:ifit/views/screens/experts_main_screens/exp_discover_screens/components/new_arrival.dart';
import 'package:ifit/views/screens/experts_main_screens/exp_discover_screens/components/popular.dart';
import 'package:ifit/views/widgets/button/main_button.dart';

class ExpDiscoverScreen extends StatefulWidget {
  const ExpDiscoverScreen({
    required this.workoutPlanList,
    required this.workoutMealList,
    required this.expertList,
    super.key,
  });

  final List<List<WorkoutPlan>> workoutPlanList;
  final List<List<WorkoutMeal>> workoutMealList;
  final List<ExpertModel> expertList;

  @override
  State<ExpDiscoverScreen> createState() => _ExpDiscoverScreenState();
}

class _ExpDiscoverScreenState extends State<ExpDiscoverScreen> {

  bool isMeal = true;
  bool isPlan = true;

  @override
  Widget build(BuildContext context) {

    final List<WorkoutMeal> newArrivalMeal = widget.workoutMealList.expand((element) => element).toList();
    final List<WorkoutMeal> popularMeal = widget.workoutMealList.expand((element) => element).toList();
    final List<WorkoutPlan> newArrivalPlan = widget.workoutPlanList.expand((element) => element).toList();
    final List<WorkoutPlan> popularPlan = widget.workoutPlanList.expand((element) => element).toList();

    newArrivalMeal.sort((a, b) => a.dateCreated.compareTo(b.dateCreated));
    newArrivalPlan.sort((a, b) => a.dateCreated.compareTo(b.dateCreated));

    popularMeal.sort((a, b) => a.rating!.compareTo(b.rating!));
    popularPlan.sort((a, b) => a.rating!.compareTo(b.rating!));

    // newArrivalCombination =  [...newArrivalMeal, ...newArrivalPlan];

    List newArrivalCombination() {
      if (isMeal && isPlan) {
        return [...newArrivalPlan, ...newArrivalMeal];
      } else if (isPlan) {
        return newArrivalPlan;
      } else if (isMeal) {
        return newArrivalMeal;
      } else {
        return [];
      }
    }

    List popularCombination() {
      if (isMeal && isPlan) {
        return [...popularPlan, ...popularMeal];
      } else if (isPlan) {
        return popularPlan;
      } else if (isMeal) {
        return popularMeal;
      } else {
        return [];
      }
    }

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
                  child: Row(
                    children: [
                      Expanded(
                        child: Text("Daily Discover",
                            style: Styles.title
                        ),
                      ),
                      Expanded(
                        child: SizedBox(
                          height: 30,
                          child: Row(
                            children: [
                              Expanded(
                                child: MainButton(
                                  title: "Meal",
                                  onPressed: () {
                                    setState(() {
                                      isMeal = !isMeal;
                                    });
                                  },
                                  buttonColor: isMeal
                                      ? Colors.red
                                      : Colors.grey,
                                ),
                              ),
                              const SizedBox(width: 4.0),
                              Expanded(
                                child: MainButton(
                                  title: "Plan",
                                  onPressed: () {
                                    setState(() {
                                      isPlan = !isPlan;
                                    });
                                  },
                                  buttonColor: isPlan
                                    ? Colors.red
                                    : Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
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
                        ExpertNewArrivalWidget(
                          combinedList: newArrivalCombination(),
                        ),
                        const Gap(10),
                        ExpertPopularWidget(
                          combinedList: popularCombination(),
                        ),
                      ],
                    ),
                  ),
                ),
                const Gap(15),
                ExpertExpertListWidget(
                  discoverExperts: widget.expertList,
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