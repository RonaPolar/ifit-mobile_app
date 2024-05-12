import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:ifit/common/utils/app_styles.dart';
import 'package:ifit/models/expert.dart';
import 'package:ifit/models/meal.dart';
import 'package:ifit/models/workout.dart';

class ProgramCreatedWidget extends StatelessWidget {
  const ProgramCreatedWidget({
    required this.expertModel,
    required this.workoutPlanList,
    required this.workoutMealList,
    super.key,
  });

  final List<WorkoutPlan> workoutPlanList;
  final List<WorkoutMeal> workoutMealList;
  final ExpertModel expertModel;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text('Program Created', style: Styles.title),
        const Gap(10),
        Row(
          children: [
            Expanded(
              child: Container(
                width: double.maxFinite,
                height: 100,
                padding: const EdgeInsets.symmetric(
                  vertical: 15,
                  horizontal: 15,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: const [
                    BoxShadow(color: Colors.black26, blurRadius: 2),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Workouts', style: Styles.title),
                    const Gap(5),
                    Text("${workoutPlanList.length}",
                      style: Styles.normal.copyWith(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Styles.secondColor,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const Gap(15),
            Expanded(
              child: Container(
                width: double.maxFinite,
                height: 100,
                padding: const EdgeInsets.symmetric(
                  vertical: 15,
                  horizontal: 15,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: const [
                    BoxShadow(color: Colors.black26, blurRadius: 2),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Meals', style: Styles.title),
                    const Gap(5),
                    Text("${workoutMealList.length}",
                      style: Styles.normal.copyWith(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Styles.secondColor,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
