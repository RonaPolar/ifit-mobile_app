import 'package:flutter/material.dart';
import 'package:ifit/models/meal.dart';
import 'package:ifit/views/screens/experts_main_screens/exp_discover_screens/components/meal_details.dart';
import 'package:ifit/views/widgets/program_widgets.dart';

class ClientMealCategoryScreen extends StatelessWidget {
  const ClientMealCategoryScreen({
    required this.workoutMealList,
    required this.category,
    super.key,
  });

  final List<WorkoutMeal> workoutMealList;
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
                    itemCount: workoutMealList.length,
                    itemBuilder: (context, index) {
                      final plan = workoutMealList[index];

                      return InkWell(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(
                              builder: (context) => ExpertMealDetails(
                                workoutMeal: plan,
                              ),
                            ));
                          },
                          child: ProgramRow(
                            image: plan.foodPhoto,
                            title: plan.foodPlanName,
                            bottomText: "${plan.calories} Calories",
                            showToggleSwitch: false,
                          )
                      );
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
