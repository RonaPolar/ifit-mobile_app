import 'package:fluentui_icons/fluentui_icons.dart';
import 'package:flutter/material.dart';
import 'package:ifit/models/client.dart';
import 'package:ifit/models/meal.dart';
import 'package:ifit/models/workout.dart';
import 'package:ifit/views/screens/clients_main_screens/program_tracker_screens/components/status/favorites_program.dart';
import 'package:ifit/views/screens/clients_main_screens/program_tracker_screens/components/status/finished_program.dart';
import 'package:ifit/views/screens/clients_main_screens/program_tracker_screens/components/status/ongoing_program.dart';
import 'package:ifit/views/screens/clients_main_screens/program_tracker_screens/rate_screens/my_rate.dart';
import 'package:ifit/views/widgets/icon_text_icon.dart';

enum ProgramStatus {ongoing, favorites, finished}

class ProgramStatusWidget extends StatelessWidget {
  const ProgramStatusWidget({
    required this.workoutMealList,
    required this.workoutPlanList,
    required this.clientModel,
    super.key,
  });

  final List<WorkoutMeal> workoutMealList;
  final List<WorkoutPlan> workoutPlanList;
  final ClientModel clientModel;

  @override
  Widget build(BuildContext context) {

    List<dynamic> combinedList = [...workoutPlanList, ...workoutMealList];

    final List<WorkoutPlan> cancelledWorkoutPlan = workoutPlanList.where((element) {
      return !element.isCancelled;
    }).toList();

    final List<dynamic> favoriteCombinedPlan = combinedList.where((element) {
      if (element is WorkoutPlan) {
        return element.isFavorite;
      } else {
        return (element as WorkoutMeal).isFavorite;
      }
    }).toList();

    final List<WorkoutPlan> finishedWorkoutPlan = workoutPlanList.where((element) {
      return (int.parse(element.daysOfThePlan) == element.dayCountFinished);
    }).toList();

    return Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(
              color: Colors.grey.shade500,
            ),
            bottom: BorderSide(
              color: Colors.grey.shade500,
            ),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButtonText(
              iconData: FluentSystemIcons.ic_fluent_timer_filled,
              title: 'Ongoing',
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => OngoingProgramScreen(
                      workoutPlanList: cancelledWorkoutPlan,
                      id: clientModel.uid,
                    )));
              },
            ),
            IconButtonText(
              iconData: FluentSystemIcons.ic_fluent_heart_filled,
              title: 'Favorites',
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => FavoriteProgramScreen(
                    combinedList: favoriteCombinedPlan,
                    id: clientModel.uid,
                  ),
                ));
              },
            ),
            IconButtonText(
              iconData: FluentSystemIcons.ic_fluent_checkmark_circle_filled,
              title: 'Finished',
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => FinishedProgramScreen(
                    workoutPlan: finishedWorkoutPlan,
                    id: clientModel.uid,
                  ),
                ));
              },
            ),
            IconButtonText(
              iconData: FluentSystemIcons.ic_fluent_star_filled,
              title: 'Rate',
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const ToRateProgram()));
              },
            ),
          ],
        )
    );
  }
}
