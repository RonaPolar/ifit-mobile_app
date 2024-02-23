import 'package:flutter/material.dart';
import 'package:ifit/common/utils/app_styles.dart';
import 'package:ifit/models/meal.dart';
import 'package:ifit/models/workout.dart';
import 'package:ifit/service/workout.dart';
import 'package:ifit/views/widgets/button/main_button.dart';
import 'package:ifit/views/widgets/search.dart';
import 'package:provider/provider.dart';

class ExpDeletedProgramScreen extends StatefulWidget {
  const ExpDeletedProgramScreen({
    required this.workoutPlanList,
    required this.workoutMealList,
    super.key,
  });

  final List<WorkoutPlan> workoutPlanList;
  final List<WorkoutMeal> workoutMealList;

  @override
  State<ExpDeletedProgramScreen> createState() => _ExpDeletedProgramScreenState();
}

class _ExpDeletedProgramScreenState extends State<ExpDeletedProgramScreen> {
 List latestWorkoutArr = [
    {
      "name": "Full Body Exercises",
      "image": "assets/icons/workout-pic.png",
      "rate": "4.7",
      "kcal": "180",
      "days": "14",
      "duration": "30",
      "exercise": "10",
      "progress": 0.3,
    },
    {
      "name": "Upper Body Weights",
      "image": "assets/icons/Lower-Weights.png",
      "rate": "4.3",
      "kcal": "200",
      "duration": "30",
      "days": "10",
      "exercise": "11",
      "progress": 0.5,
    },
    {
      "name": "Upper Ab Exercises",
      "image": "assets/icons/Ab-workout.png",
      "rate": "4.5",
      "kcal": "300",
      "duration": "20",
      "days": "15",
      "exercise": "12",
      "progress": 0.6,
    },
  ];

    List latestMealArr = [
    {
      "name": "Blueberry Pancake",
      "image": "assets/images/meal/pancake.png",
      "rate": "4.9",
      "kcal": "190",
      "fats": "100",
      "proteins": "176",
      "sugar": "50",
      "categories": "Breakfast",
      "days": "15",
      "progress": 0.2,
    },
    {
      "name": "Salad",
      "image": "assets/images/meal/salad.png",
      "rate": "4.6",
      "kcal": "200",
      "fats": "100",
      "proteins": "300",
      "sugar": "50",
      "categories": "Lunch",
      "days": "15",
      "progress": 0.9,
    },
    {
      "name": "Salmon Nigiri",
      "image": "assets/images/meal/nigiri.png",
      "rate": "4.3",
      "kcal": "300",
      "fats": "170",
      "proteins": "400",
      "sugar": "79",
      "categories": "Dinner",
      "days": "15",
      "progress": 0.5,
    },
  ];


  @override
  Widget build(BuildContext context) {
    TextEditingController txtSearch = TextEditingController();
    List<dynamic> combinedList = [];

    final List<WorkoutPlan> createdWorkoutPlans = widget.workoutPlanList.where((element) {
      if (element.isDeleted != null) {
        return element.isDeleted!;
      } else {
        return false;
      }
    }).toList();

    final List<WorkoutMeal> createdWorkoutMeals = widget.workoutMealList.where((element) {

      if (element.isDeleted != null) {
        return element.isDeleted!;
      } else {
        return false;
      }
    }).toList();

    combinedList = [...createdWorkoutMeals, ...createdWorkoutPlans];

    final WorkoutProvider workoutProvider = Provider.of<WorkoutProvider>(context);

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
                        // It's a workout item
                        return InkWell(
                          onTap: () {
                            // Navigator.push(context,
                            //   MaterialPageRoute(
                            //     builder: (context) =>
                            //       ViewWorkoutDetails(dObj: item),
                            //   ),
                            // );
                          },
                          child: DeletedRow(
                              image: item.workoutPicture,
                              title: item.planName,
                              bottomText: "${item.minutes} minutes | ${item.calories} Calories",
                              onPressed: () async {
                                await workoutProvider.updateExpertProgram(
                                  isWorkoutPlan: true,
                                  id: item.id,
                                  expertId: item.expertId,
                                  deleteProgram: false,
                                ).then((value) {
                                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                                    content: Text("Restore Workout Meal!"),
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
                            //     builder: (context) =>
                            //       ViewMealDetails(dObj: item),
                            //   ),
                            // );
                          },
                          child: DeletedRow(
                            image: meal.foodPhoto,
                            title: meal.foodPlanName,
                            bottomText: "${meal.purpose} | ${meal.calories} Calories",
                            onPressed: () async {
                              await workoutProvider.updateExpertProgram(
                                isWorkoutPlan: false,
                                id: meal.id,
                                expertId: meal.expertId,
                                deleteProgram: false,
                              ).then((value) {
                                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                                  content: Text("Restore Workout Meal!"),
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


class DeletedRow extends StatefulWidget {
  final String image;
  final String title;
  final String bottomText;
  final Function() onPressed;


  const DeletedRow({
    super.key,
    required this.image,
    required this.title,
    required this.bottomText,
    required this.onPressed,
  });

  @override
  State<DeletedRow> createState() => _DeletedRowState();
}

class _DeletedRowState extends State<DeletedRow> {
  @override
  Widget build(BuildContext context) {


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
              child: Image.network(widget.image,
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
                Text(widget.title, style: Styles.text15bold),
                Text(
                  widget.bottomText,
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
                title: "Restore",
                textStyle: Styles.seeMore.copyWith(
                color: Colors.white,),
                buttonColor: Styles.secondColor,
                onPressed: widget.onPressed,
            ),
          )
        ],
      ),
    );
  }
}