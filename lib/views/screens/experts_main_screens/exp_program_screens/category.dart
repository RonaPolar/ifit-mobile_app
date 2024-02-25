import 'package:flutter/material.dart';
import 'package:ifit/models/meal.dart';
import 'package:ifit/models/workout.dart';
import 'package:ifit/views/screens/experts_main_screens/exp_discover_screens/components/meal_details.dart';
import 'package:ifit/views/screens/experts_main_screens/exp_discover_screens/components/workout_details.dart';
import 'package:ifit/views/widgets/program_widgets.dart';

class ExpertCategoryScreen extends StatelessWidget {
  const ExpertCategoryScreen({
    required this.combinedList,
    required this.category,
    super.key,
  });

  final List<dynamic> combinedList;
  final String category;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(category),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              children: [
                ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: combinedList.length,
                  itemBuilder: (context, index) {
                    final item = combinedList[index];

                    if (item is WorkoutMeal) {
                      return InkWell(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(
                                builder: (context) => ExpertMealDetails(
                                  workoutMeal: item,
                                )),
                            );
                          },
                          child: ProgramRow(
                            image: item.foodPhoto,
                            title: item.foodPlanName,
                            bottomText: "${item.purpose} | ${item.calories} Calories",
                            showToggleSwitch: false,
                          )
                      );
                    } else {

                      final plan = item as WorkoutPlan;

                      return InkWell(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(
                            builder: (context) => ExpertWorkoutDetails(
                              dObj: plan,
                              clientWorkoutPlan: plan,
                            ),
                          ));
                        },
                        child: ProgramRow(
                          image: plan.workoutPicture,
                          title: plan.planName,
                          bottomText: "${plan.minutes} minutes | ${plan.calories} Calories",
                          showToggleSwitch: false,
                        )
                      );
                    }
                  }
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
