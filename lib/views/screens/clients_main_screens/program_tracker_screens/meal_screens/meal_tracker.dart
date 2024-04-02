import 'package:fluentui_icons/fluentui_icons.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:ifit/common/utils/app_styles.dart';
import 'package:ifit/models/meal.dart';
import 'package:ifit/service/auth.dart';
import 'package:ifit/views/screens/clients_main_screens/program_tracker_screens/meal_screens/components/meal_piechart.dart';
import 'package:ifit/views/screens/clients_main_screens/program_tracker_screens/workout_screens/client_meal_category.dart';
import 'package:ifit/views/screens/clients_main_screens/program_tracker_screens/workout_screens/client_plan_category.dart';
import 'package:ifit/views/widgets/program_widgets.dart';
import 'package:ifit/views/screens/clients_main_screens/program_tracker_screens/meal_screens/meal_category.dart';
import 'package:ifit/views/screens/clients_main_screens/program_tracker_screens/meal_screens/meal_details.dart';
import 'package:ifit/views/screens/clients_main_screens/program_tracker_screens/program_schedule/program_schedule.dart';
import 'package:provider/provider.dart';

class MealTrackerScreen extends StatefulWidget {

  const MealTrackerScreen({
    required this.workoutMealList,
    required this.clientWorkoutMeal,
    super.key,
  });

  final List<WorkoutMeal> workoutMealList;
  final List<WorkoutMeal> clientWorkoutMeal;

  @override
  State<MealTrackerScreen> createState() => _MealTrackerScreenState();
}

class _MealTrackerScreenState extends State<MealTrackerScreen> {

  
@override
  Widget build(BuildContext context) {
  final Auth auth = Provider.of<Auth>(context);

    return Scaffold(
      backgroundColor: Styles.bgColor,
      appBar: AppBar(
        backgroundColor: Styles.bgColor,
        centerTitle: true,
        elevation: 0,
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Container(
            margin: const EdgeInsets.all(12),
            height: 30,
            width: 30,
            alignment: Alignment.center,
            decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(10)),
            child: const Icon(
              FluentSystemIcons.ic_fluent_chevron_left_filled,
              size: 20,
              color: Colors.black,
            ),
          ),
        ),
        title: Text('Meal Tracker',
          style: Styles.headline20),
      ),

      body:ListView(
        children: [
          Container(
            padding: const EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 230,
                  width: double.maxFinite,
                  child: MealPieChart(
                    workoutMealList: widget.clientWorkoutMeal,
                  ),
                ),
                const Gap(20),
                Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                    Text("Upcoming Meal Schedule",
                    style: Styles.title
                  ),
                  // TextButton(
                  //   onPressed: () {
                  //     Navigator.of(context).push(
                  //       MaterialPageRoute(
                  //       builder: (context) => const MealSched()));
                  //   },
                  //   child: Text("See More",
                  //     style: Styles.seeMore
                  //     ),
                  //   )
                  ],
                ),
                ListView.builder( //WorkoutRowContainer Content
                  padding: EdgeInsets.zero,
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: auth.fitnessGoalList.length,
                  itemBuilder: (context, index) {

                    final String item = auth.fitnessGoalList[index];
                    final List<WorkoutMeal> categoryList = widget.workoutMealList.where((element) {
                      return element.purpose == auth.fitnessGoalList[index];
                    }).toList();

                    return What2Container(
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) =>
                              ClientMealCategoryScreen(
                                workoutMealList: categoryList,
                                category: item,
                              ),
                        ),
                        );
                      },
                      fitnessGoal: auth.fitnessGoalList[index],
                      categoryList: categoryList,
                      imageList: [
                        "assets/icons/workout-pic.png",
                        "assets/icons/Ab-workout.png",
                        "assets/icons/Upper-Weights.png",
                      ][index],
                    );
                  },
                ),
                // ListView.builder( //Meal Content
                //   padding: EdgeInsets.zero,
                //   physics: const NeverScrollableScrollPhysics(),
                //   shrinkWrap: true,
                //   itemCount: upcomingMealArr.length,
                //   itemBuilder: (context, index) {
                //     var mObj = upcomingMealArr[index];
                //     return InkWell(
                //         onTap: () {
                //           // Navigator.push(
                //           //   context,
                //           //   MaterialPageRoute(
                //           //     builder: (context) => MealDetails(dObj: mObj)),
                //           // );
                //         },
                //         child: ProgramRow(image: mObj["image"],
                //         title: mObj["name"],
                //         bottomText: "${mObj["schedule"]} | ${mObj["time"]}",
                //         showToggleSwitch: true,
                //       ));
                //   },
                // ),
      
                const Gap(20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Find Something to Eat and Drink",
                      style: Styles.title
                    ),
                  ],
                ),
                // ListView.builder(
                //   padding: EdgeInsets.zero,
                //   physics: const NeverScrollableScrollPhysics(),
                //   shrinkWrap: true,
                //   itemCount: what2EatArr.length,
                //   itemBuilder: (context, index) {
                //     var mObj = what2EatArr[index];
                //     return What2Container(wObj: mObj,
                //       onPressed: (obj) {
                //           Navigator.push(
                //             context,
                //             MaterialPageRoute(
                //               builder: (context) => MealCategory(mObj: mObj,)),
                //           );
                //         },
                //       );
                //   },
                // ),
              ],
            ),
          )
        ],
      ),  //Main top
    );
}
}