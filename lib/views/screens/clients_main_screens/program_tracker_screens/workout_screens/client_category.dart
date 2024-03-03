import 'package:flutter/material.dart';
import 'package:ifit/models/workout.dart';
import 'package:ifit/views/screens/experts_main_screens/exp_discover_screens/components/workout_details.dart';
import 'package:ifit/views/widgets/program_widgets.dart';

class ClientCategoryScreen extends StatelessWidget {
  const ClientCategoryScreen({
    required this.workoutPlanList,
    required this.category,
    super.key,
  });

  final List<WorkoutPlan> workoutPlanList;
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
                    itemCount: workoutPlanList.length,
                    itemBuilder: (context, index) {
                      final plan = workoutPlanList[index];

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
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
