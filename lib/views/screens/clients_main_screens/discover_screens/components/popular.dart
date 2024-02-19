import 'package:flutter/material.dart';
import 'package:ifit/common/utils/app_styles.dart';
import 'package:ifit/views/widgets/container/little.dart';
import 'package:ifit/models/meal.dart';
import 'package:ifit/models/workout.dart';

class PopularWidget extends StatelessWidget {
  const PopularWidget({
    required this.combinedList,
    super.key,
  });

  final List combinedList;

  @override
  Widget build(BuildContext context) {

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 7),
          child: Text(
            "Popular",
            style: Styles.title,
          ),
        ),
        SizedBox(
          height: 130,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: combinedList.length,
            itemBuilder: (context, index) {
              var item = combinedList[index];

              if (item is WorkoutPlan) {
                // It's a workout item
                return InkWell(

                  child: LittleContainer(
                    containerColor: Styles.secondColor.withOpacity(0.6),
                    image: item.workoutPicture,
                    title: item.planName,
                    bottomText: "${item.minutes} minutes | ${item.calories} kcal",
                    onTap: () {
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //     builder: (context) => WorkoutDetails(dObj: item),
                      //   ),
                      // );
                    },
                  ),
                );
              } else {
                // It's a meal item

                final mealItem = item as WorkoutMeal;
                return InkWell(

                  child: LittleContainer(
                    containerColor: Styles.secondColor.withOpacity(0.6),
                    image: mealItem.foodPhoto,
                    title: mealItem.foodPlanName,
                    bottomText: "${item.purpose} | ${item.calories} kcal",
                    onTap: () {
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //     builder: (context) => MealDetails(dObj: item),
                      //   ),
                      // );
                    },
                  ),
                );
              }
            },
          ),
        ),
      ],
    );
  }
}
