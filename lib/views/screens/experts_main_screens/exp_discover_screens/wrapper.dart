import 'package:flutter/material.dart';
import 'package:ifit/models/expert.dart';
import 'package:ifit/models/meal.dart';
import 'package:ifit/models/workout.dart';
import 'package:ifit/service/client.dart';
import 'package:ifit/views/screens/experts_main_screens/exp_discover_screens/exp_discover.dart';
import 'package:ifit/views/widgets/body/stream.dart';
import 'package:provider/provider.dart';

class ExpDiscoverWrapperScreen extends StatefulWidget {
  const ExpDiscoverWrapperScreen({super.key,
  });

  @override
  State<ExpDiscoverWrapperScreen> createState() => _ExpDiscoverWrapperScreenState();
}

class _ExpDiscoverWrapperScreenState extends State<ExpDiscoverWrapperScreen> {

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final ClientProvider clientProvider = Provider.of<ClientProvider>(context, listen: false);
      clientProvider.updateWorkoutMealListStream();
      clientProvider.updateWorkoutPlanListStream();
      clientProvider.updateExpertListStream();
    });
  }

  @override
  Widget build(BuildContext context) {
    final ClientProvider clientProvider = Provider.of<ClientProvider>(context);


    return Scaffold(
      body: StreamWrapper<List<List<WorkoutPlan>>>(
        stream: clientProvider.workoutPlanListStream,
        child: (data) {
          final List<List<WorkoutPlan>> workoutPlanList = data!;

          return StreamWrapper<List<List<WorkoutMeal>>>(
            stream: clientProvider.workoutMealListStream,
            child: (data) {
              final List<List<WorkoutMeal>> workoutMealList = data!;

              return StreamWrapper<List<ExpertModel>>(
                stream: clientProvider.expertListStream,
                child: (data) {
                  final List<ExpertModel> expertList = data!;

                  return ExpDiscoverScreen(
                    workoutPlanList: workoutPlanList,
                    workoutMealList: workoutMealList,
                    expertList: expertList,
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
