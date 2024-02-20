import 'dart:math';

import 'package:flutter/material.dart';
import 'package:ifit/common/utils/app_styles.dart';
import 'package:ifit/models/client.dart';
import 'package:ifit/views/screens/clients_main_screens/program_tracker_screens/meal_screens/meal_details.dart';
import 'package:ifit/views/screens/clients_main_screens/program_tracker_screens/workout_screens/workout_details.dart';
import 'package:ifit/views/widgets/container/little.dart';
import 'package:ifit/models/meal.dart';
import 'package:ifit/models/workout.dart';

class NewArrivalWidget extends StatelessWidget {
  const NewArrivalWidget({
    required this.combinedList,
    required this.clientModel,
    super.key,
  });

  final List combinedList;
  final ClientModel clientModel;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal:7),
          child: Text("New Arrival",
              style: Styles.title
          ),
        ),
        SizedBox(
          height: 130,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: combinedList.length,
            itemBuilder: (context, index) {
              combinedList.shuffle(Random());
              dynamic item = combinedList[index];


              if (item is WorkoutPlan) {
                // It's a workout item
                return LittleContainer(
                  containerColor: Styles.secondColor.withOpacity(0.6),
                  image: item.workoutPicture,
                  title: item.planName,
                  bottomText: "${item.minutes} minutes | ${item.calories} kcal",
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(
                      builder: (context) => WorkoutDetails(
                        dObj: item,
                        id: clientModel.uid,
                        clientWorkoutPlan: item,
                      ),
                    ));
                  },
                );
              } else {

                final mealItem = item as WorkoutMeal;
                // It's a meal item
                return LittleContainer(
                  containerColor: Styles.secondColor.withOpacity(0.6),
                  image: mealItem.foodPhoto,
                  title: mealItem.foodPlanName,
                  bottomText: "${item.purpose} | ${item.calories} kcal",
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(
                        builder: (context) => MealDetails(
                          workoutMeal: mealItem,
                          id: clientModel.uid,
                        )),
                    );
                  },
                );
              }
            },
          ),
        ),
      ],
    );
  }
}
