import 'package:flutter/material.dart';
import 'package:ifit/common/utils/app_styles.dart';
import 'package:ifit/views/widgets/container/little.dart';
import 'package:ifit/models/meal.dart';
import 'package:ifit/models/workout.dart';

class NewArrivalWidget extends StatelessWidget {
  const NewArrivalWidget({
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
              dynamic item = combinedList[index];

              if (item is Workout) {
                // It's a workout item
                return InkWell(
                  onTap: () {
                    // Navigator.push(context,
                    //   MaterialPageRoute(
                    //     builder: (context) => WorkoutDetails(dObj: item),
                    //   ),
                    // );
                  },
                  child: LittleContainer(
                    containerColor: Styles.secondColor.withOpacity(0.6),
                    image: item.image,
                    title: item.name,
                    bottomText: "${item.duration} minutes | ${item.kcal} kcal",
                  ),
                );
              } else {

                final mealItem = item as Meal;
                // It's a meal item
                return InkWell(
                  onTap: () {
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //     builder: (context) => MealDetails(dObj: item),
                    //   ),
                    // );
                  },
                  child: LittleContainer(
                    containerColor: Styles.secondColor.withOpacity(0.6),
                    image: mealItem.image,
                    title: mealItem.name,
                    bottomText: "${item.categories} | ${item.kcal} kcal",
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
