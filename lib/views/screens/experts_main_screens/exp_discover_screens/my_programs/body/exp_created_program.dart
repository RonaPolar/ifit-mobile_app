import 'package:flutter/material.dart';
import 'package:ifit/common/utils/app_styles.dart';
import 'package:ifit/models/meal.dart';
import 'package:ifit/models/workout.dart';
import 'package:ifit/service/workout.dart';
import 'package:ifit/views/widgets/button/main_button.dart';
import 'package:ifit/views/widgets/search.dart';
import 'package:provider/provider.dart';

class ExpCreatedProgramScreen extends StatefulWidget {
  const ExpCreatedProgramScreen({
    required this.workoutMealList,
    required this.workoutPlanList,
    super.key,
  });

  final List<WorkoutMeal> workoutMealList;
  final List<WorkoutPlan> workoutPlanList;

  @override
  State<ExpCreatedProgramScreen> createState() => _ExpCreatedProgramScreenState();
}

class _ExpCreatedProgramScreenState extends State<ExpCreatedProgramScreen> {


  @override
  Widget build(BuildContext context) {
    TextEditingController txtSearch = TextEditingController();
    final WorkoutProvider workoutProvider = Provider.of<WorkoutProvider>(context);
    List<dynamic> combinedList = [];

    final List<WorkoutPlan> createdWorkoutPlans = widget.workoutPlanList.where((element) {
      if (element.isDeleted != null) {
        return !element.isDeleted!;
      } else {
        return false;
      }
    }).toList();

    final List<WorkoutMeal> createdWorkoutMeals = widget.workoutMealList.where((element) {

      if (element.isDeleted != null) {
        return !element.isDeleted!;
      } else {
        return false;
      }
    }).toList();

    combinedList = [...createdWorkoutMeals, ...createdWorkoutPlans];

    return Scaffold(
      backgroundColor: Styles.bgColor,
      body: ListView(
        children: [
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical:10, horizontal: 5),
                child: Container(
                  height: 35,
                  width: double.maxFinite,
                  decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(10)),
                  alignment: Alignment.center,
                  child: SearchContainer(controller: txtSearch, hintText: "Search")
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: SizedBox(
                  child: ListView.builder(
                    padding: EdgeInsets.zero,
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: combinedList.length,
                    itemBuilder: (context, index) {
                      var item = combinedList[index];

                      if (item is WorkoutPlan) {
                        return InkWell(
                          onTap: () {
                            // Navigator.push(context,
                            //   MaterialPageRoute(
                            //       ViewWorkoutDetails(dObj: item),
                            //   ),
                            // );
                          },
                          child: CreatedRow(
                              image: item.workoutPicture,
                              title: item.planName,
                              bottomText: "${item.minutes} minutes | ${item.calories} Calories",
                              onPressed: () async {
                                await workoutProvider.updateExpertProgram(
                                  isWorkoutPlan: true,
                                  id: item.id,
                                  expertId: item.expertId,
                                  deleteProgram: true,
                                ).then((value) {
                                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                                    content: Text("Deleted Workout Plan!"),
                                  ));
                                  Navigator.of(context).pop();
                                });
                              },
                            )
                          );
                      } else {
                        // It's a meal item

                        final meal = item as WorkoutMeal;
                        return InkWell(
                          onTap: () {
                            // Navigator.push(context,
                            //   MaterialPageRoute(
                            //       ViewMealDetails(dObj: item),
                            //   ),
                            // );
                          },
                          child: CreatedRow(
                            image: meal.foodPhoto,
                            title: meal.foodPlanName,
                            bottomText: "${meal.purpose} | ${meal.calories} Calories",
                            onPressed: () async {
                              await workoutProvider.updateExpertProgram(
                                isWorkoutPlan: false,
                                id: meal.id,
                                expertId: meal.expertId,
                                deleteProgram: true,
                              ).then((value) {
                                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                                  content: Text("Deleted Workout Meal!"),
                                ));
                                Navigator.of(context).pop();
                              });
                            },
                          ),
                        );
                      }
                    },
                  ),
                ),
              ),
            ],
          )
        ]
      )
    );
  }
}


class CreatedRow extends StatelessWidget {
  final String image;
  final String title;
  final String bottomText;
  final Function() onPressed;


  const CreatedRow({
    super.key,
    required this.image,
    required this.title,
    required this.bottomText,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {

    final WorkoutProvider workoutProvider = Provider.of<WorkoutProvider>(context);

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 2),
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
      decoration: BoxDecoration(
        color: Styles.bgColor,
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [BoxShadow(color: Colors.black26, blurRadius: 2)],
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(30),
            child: Container(
              width: 60,
              height: 60,
              color: Styles.secondColor.withOpacity(0.6),
              child: Image.network(image,
                fit: BoxFit.contain,
              ),
            ),
          ),
          const SizedBox(
            width: 15,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: Styles.text15bold),
                Text(
                  bottomText,
                  style: Styles.normal.copyWith(
                    fontSize: 12,
                  ),
                ),
                const SizedBox(
                  height: 4,
                ),
              ],
            ),
          ),
          SizedBox(
            height: 30,
            width: 88,
            child: MainButton(
              title: "Delete",
              textStyle: Styles.seeMore.copyWith(
                color: Colors.white,
              ),
              buttonColor: Styles.secondColor,
              onPressed: onPressed,
            ),
          )
        ],
      ),
    );
  }
}