import 'package:flutter/material.dart';
import 'package:ifit/common/utils/app_styles.dart';
import 'package:ifit/models/meal.dart';
import 'package:ifit/models/workout.dart';
import 'package:ifit/views/widgets/container/square.dart';
import 'package:ifit/models/expert.dart';
import 'package:ifit/views/screens/clients_main_screens/discover_screens/expert_screens/expert_profile.dart';

class ExpertListWidget extends StatelessWidget {
  const ExpertListWidget({
    required this.discoverExperts,
    required this.combinedList,
    required this.workoutMeals,
    required this.workoutPlans,
    super.key,
  });

  final List<ExpertModel> discoverExperts;
  final List<List<WorkoutPlan>> workoutPlans;
  final List<List<WorkoutMeal>> workoutMeals;
  final List combinedList;

  @override
  Widget build(BuildContext context) {

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal:15),
          child: Text("Experts",
            style: Styles.title
          ),
        ),
        GridView.builder(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, // Adjust the number of columns as per your design
          ),
          itemCount: discoverExperts.length,
          itemBuilder: (context, index) {
            ExpertModel exObj = discoverExperts[index];
            return InkWell(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) => ExpertProfile(
                    exObj: exObj,
                    workoutMeals: workoutMeals[index],
                    workoutPlans: workoutPlans[index],
                  )),
                );
              },
              child: SquareContainer(
                image: exObj.professionId,
                title: exObj.name,
                bottomText: "${exObj.profession} | ${exObj.rating} stars",
              ),
            );
          },
        )
      ],
    );
  }
}
