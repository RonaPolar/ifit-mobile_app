import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:ifit/common/utils/app_styles.dart';
import 'package:ifit/models/client.dart';
import 'package:ifit/views/widgets/container/big.dart';
import 'package:ifit/models/meal.dart';
import 'package:ifit/models/workout.dart';
import 'package:ifit/service/client.dart';
import 'package:ifit/views/screens/clients_main_screens/home_screens/components/bmi.dart';
import 'package:ifit/views/screens/clients_main_screens/home_screens/components/welcome_back.dart';
import 'package:ifit/views/screens/clients_main_screens/program_tracker_screens/meal_screens/meal_details.dart';
import 'package:ifit/views/screens/clients_main_screens/program_tracker_screens/meal_screens/meal_tracker.dart';
import 'package:ifit/views/screens/clients_main_screens/program_tracker_screens/workout_screens/workout_details.dart';
import 'package:ifit/views/screens/clients_main_screens/program_tracker_screens/workout_screens/workout_tracker.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    required this.clientModel,
    required this.workoutPlanList,
    required this.workoutMealList,
    required this.clientWorkoutPlan,
    required this.clientWorkoutMeal,
    super.key,
  });

  final ClientModel clientModel;
  final List<List<WorkoutPlan>> workoutPlanList;
  final List<List<WorkoutMeal>> workoutMealList;
  final List<WorkoutPlan> clientWorkoutPlan;
  final List<WorkoutMeal> clientWorkoutMeal;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    // Fetch data based on the provided UID when the widget initializes
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final ClientProvider clientProvider = Provider.of<ClientProvider>(context, listen: false);
      clientProvider.getBmi(client: widget.clientModel);
    });
  }


  @override
  Widget build(BuildContext context) {
    final ClientProvider clientProvider =  Provider.of<ClientProvider>(context);
    final ClientModel client = widget.clientModel;

    return SafeArea(
      child: Scaffold(
        backgroundColor: Styles.bgColor,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                WelcomeBackWidget(
                  name: client.name,
                  id: widget.clientModel.uid,
                ),
                const Gap(20),
                const BMIWidget(),
                const Gap(15),
                /// TODO: REVERT IT ONCE OKAY
                // Container(
                //   padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                //   decoration: BoxDecoration(
                //     color: Styles.secondColor.withOpacity(0.2),
                //     borderRadius: BorderRadius.circular(15),
                //   ),
                //   child: Row(
                //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //     children: [
                //       Text('Today Target',
                //         style: Styles.text15bold.copyWith(
                //           color: Colors.black,
                //         ),
                //       ),
                //       SizedBox(
                //         width: 80,
                //         height: 30,
                //         child: MainButton(
                //           title: "Check",
                //           onPressed: () {
                //             Navigator.of(context).push(MaterialPageRoute(
                //               builder: (context) => const ActivityTracker()));
                //           },
                //           textStyle: Styles.seeMore.copyWith(
                //             color: Colors.white,
                //           ),
                //         ),
                //       ),
                //     ],
                //   ),
                // ),
                const Gap(20),
                Text('Activity Today', style: Styles.title),
                const Gap(10),
                // ActivityTodayWidget(schedArr: schedArr),
                const Gap(20),
                _buildWorkoutRecommendation(clientProvider),
                const Gap(15),
                _buildMealRecommendation(clientProvider),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildWorkoutRecommendation(ClientProvider clientProvider) {

    final List<WorkoutPlan> combinedWorkoutPlan = widget.workoutPlanList.expand((element) => element).toList();
    final ClientGoalModel clientGoal = widget.clientModel.clientGoalModel!;

    Map<String, int> goalValues = {
      "Loss Weight": 0,
      "Body Toning": 1,
      "Gain Muscles": 2,
    };

    Map<String, int> difficultyValues = {
      "Beginner": 0,
      "Intermediate": 1,
      "Expert": 2,
    };

    combinedWorkoutPlan.sort((a,b) {
      // goal, difficulty, body list

      int goalDifferenceA = (goalValues[a.purpose]! - goalValues[clientGoal.fitnessGoals]!).abs();
      int goalDifferenceB = (goalValues[b.purpose]! - goalValues[clientGoal.fitnessGoals]!).abs();

      int difficultyValuesA = (difficultyValues[a.difficulty]! - difficultyValues[clientGoal.level]!).abs();
      int difficultyValuesB = (difficultyValues[b.difficulty]! - difficultyValues[clientGoal.level]!).abs();

      int totalDifferenceA = goalDifferenceA + difficultyValuesA;
      int totalDifferenceB = goalDifferenceB + difficultyValuesB;

      return totalDifferenceA.compareTo(totalDifferenceB);
    });

    final List<WorkoutPlan> notDeleted = combinedWorkoutPlan.where((element) {
      return !element.isDeleted!;
    }).toList();


    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Workout Recommendation", style: Styles.title),
            TextButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(
                    builder: (context) => WorkoutTrackerScreen(
                      workoutPlanList: combinedWorkoutPlan,
                      clientWorkoutPlan: widget.clientWorkoutPlan,
                    )));
              },
              child: Text("See More", style: Styles.seeMore),
            )
          ],
        ),
        SizedBox(
          height: 200,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: notDeleted.length > 5 ? 5 : notDeleted.length,
            itemBuilder: (context, index) {
              final WorkoutPlan workoutPlan = notDeleted[index];
              
              return InkWell(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(
                    builder: (context) => WorkoutDetails(
                      dObj: workoutPlan,
                      id: widget.clientModel.uid,
                      clientWorkoutPlan: notDeleted[index],
                    ),
                  ));
                },
                child: BigContainer(
                  image: workoutPlan.workoutPicture,
                  title: workoutPlan.planName,
                  bottomText:
                  "${workoutPlan.minutes} minutes | ${workoutPlan.calories} kcal",
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildMealRecommendation(ClientProvider clientProvider) {
    final List<WorkoutMeal> combinedWorkoutMeal = widget.workoutMealList.expand((element) => element).toList();
    final ClientGoalModel clientGoal = widget.clientModel.clientGoalModel!;

    Map<String, int> goalValues = {
      "Loss Weight": 0,
      "Body Toning": 1,
      "Gain Muscles": 2,
    };

    Map<String, int> difficultyValues = {
      "Beginner": 0,
      "Intermediate": 1,
      "Expert": 2,
    };

    if (combinedWorkoutMeal.length != 1) {
      combinedWorkoutMeal.sort((a,b) {
        // goal, difficulty, body list

        int goalDifferenceA = (goalValues[a.purpose]! - goalValues[clientGoal.fitnessGoals]!).abs();
        int goalDifferenceB = (goalValues[b.purpose]! - goalValues[clientGoal.fitnessGoals]!).abs();

        // int difficultyValuesA = (difficultyValues[a.difficulty]! - difficultyValues[clientGoal.level]!).abs();
        // int difficultyValuesB = (difficultyValues[b.difficulty]! - difficultyValues[clientGoal.level]!).abs();

        return goalDifferenceA.compareTo(goalDifferenceB);
      });
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Meal Recommendation", style: Styles.title),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MealTrackerScreen(
                      workoutMealList: combinedWorkoutMeal,
                      clientWorkoutMeal: widget.clientWorkoutMeal,
                    )),
                );
              },
              child: Text("See More", style: Styles.seeMore),
            )
          ],
        ),
        SizedBox(
          height: 200,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: combinedWorkoutMeal.length > 5 ? 5 : combinedWorkoutMeal.length,
            itemBuilder: (context, index) {
              final WorkoutMeal mObj = combinedWorkoutMeal[index];
              return InkWell(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(
                      builder: (context) => MealDetails(
                        workoutMeal: mObj,
                        id: widget.clientModel.uid,
                      )),
                  );
                },
                child: BigContainer(
                  image: mObj.foodPhoto,
                  title: mObj.foodPlanName,
                  bottomText:
                  "${mObj.purpose} | ${mObj.calories} kcal",
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
