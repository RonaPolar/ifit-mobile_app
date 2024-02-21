import 'package:flutter/material.dart';
import 'package:ifit/common/utils/app_styles.dart';
import 'package:ifit/models/client.dart';
import 'package:ifit/models/meal.dart';
import 'package:ifit/models/workout.dart';
import 'package:ifit/views/screens/clients_main_screens/profile_screens/expert_profile_screen.dart';
import 'package:ifit/views/widgets/container/square.dart';
import 'package:ifit/models/expert.dart';

class ExpertListWidget extends StatelessWidget {
  const ExpertListWidget({
    required this.discoverExperts,
    required this.workoutPlan,
    required this.workoutMeal,
    required this.clientModel,
    super.key,
  });

  final List<ExpertModel> discoverExperts;
  final List<List<WorkoutPlan>> workoutPlan;
  final List<List<WorkoutMeal>> workoutMeal;
  final ClientModel clientModel;

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
                    expertId: exObj.uid,
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
