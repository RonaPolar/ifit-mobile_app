import 'package:flutter/material.dart';
import 'package:ifit/models/expert.dart';
import 'package:ifit/models/meal.dart';
import 'package:ifit/models/workout.dart';
import 'package:ifit/service/Expert.dart';
import 'package:ifit/views/screens/Experts_main_screens/exp_discover_screens/exp_discover.dart';
import 'package:ifit/views/screens/Experts_main_screens/exp_home_screens/exp_home.dart';
import 'package:ifit/views/widgets/body/stream.dart';
import 'package:provider/provider.dart';

import '../Experts_main_screens/exp_program_screens/exp_program.dart';
import '../experts_main_screens/exp_profile_screens/exp_profile.dart';

class ExpertAuthWrapper extends StatefulWidget {
  const ExpertAuthWrapper({
    required this.uid,
    required this.index,
    super.key,
  });

  final String uid;
  final int index;

  @override
  State<ExpertAuthWrapper> createState() => _ExpertAuthWrapperState();
}

class _ExpertAuthWrapperState extends State<ExpertAuthWrapper> {

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final ExpertProvider expertProvider = Provider.of<ExpertProvider>(context, listen: false);
      expertProvider.updateExpertStream(uid: widget.uid);
      expertProvider.updateWorkoutMealListStream(uid: widget.uid);
      expertProvider.updateWorkoutPlanListStream(uid: widget.uid);
    });
  }

  List<Widget> bodyList({
    required ExpertModel expertModel,
    required List<WorkoutPlan> workoutPlan,
    required List<WorkoutMeal> workoutMeal,
  }) {
    return [
      ExpHomeScreen(
        expertModel: expertModel,
        workoutMealList: workoutMeal,
        workoutPlanList: workoutPlan,
      ),
      ExpDiscoverScreen(),
      ExpProgramScreen(expertModel: expertModel),
      ExpProfileScreen(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final ExpertProvider expertProvider = Provider.of<ExpertProvider>(context);

    return StreamWrapper<ExpertModel>(
      stream: expertProvider.expertStream,
      child: (data) {
        final ExpertModel expertModel = data!;

        return StreamWrapper<List<WorkoutPlan>>(
          stream: expertProvider.workoutPlanListStream,
          child: (data) {
            final List<WorkoutPlan> workoutPlan = data!;


            return StreamWrapper<List<WorkoutMeal>>(
              stream: expertProvider.workoutMealListStream,
              child: (data) {
                final List<WorkoutMeal> workoutMeal = data!;

                return bodyList(
                  expertModel: expertModel,
                  workoutPlan: workoutPlan,
                  workoutMeal: workoutMeal
                )[widget.index];
              }
            );
          }
        );
      },
    );
  }
}
