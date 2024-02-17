import 'package:flutter/material.dart';
import 'package:ifit/models/client.dart';
import 'package:ifit/models/expert.dart';
import 'package:ifit/models/meal.dart';
import 'package:ifit/models/workout.dart';
import 'package:ifit/service/client.dart';
import 'package:ifit/views/screens/clients_main_screens/discover_screens/discover.dart';
import 'package:ifit/views/screens/clients_main_screens/home_screens/home.dart';
import 'package:ifit/views/screens/clients_main_screens/profile_screens/profile.dart';
import 'package:ifit/views/screens/clients_main_screens/program_tracker_screens/program_tracker.dart';
import 'package:ifit/views/screens/wrappers/expert_list.dart';
import 'package:ifit/views/screens/wrappers/workout_meal.dart';
import 'package:ifit/views/screens/wrappers/workout_plan.dart';
import 'package:provider/provider.dart';

class ClientAuthWrapper extends StatefulWidget {
  const ClientAuthWrapper({
    required this.uid,
    required this.index,
    super.key,
  });

  final String uid;
  final int index;

  @override
  State<ClientAuthWrapper> createState() => _ClientAuthWrapperState();
}

class _ClientAuthWrapperState extends State<ClientAuthWrapper> {

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final ClientProvider client = Provider.of<ClientProvider>(context, listen: false);
      client.updateClientStream(uid: widget.uid);
    });
  }


  List<Widget> bodyList({
    required ClientModel clientModel,
    required List<List<WorkoutPlan>> workoutPlan,
    required List<List<WorkoutMeal>> workoutMeal,
    required List<ExpertModel> expertModel,
  }) {
    return [
      HomeScreen(
        clientModel: clientModel,
        workoutPlanList: workoutPlan,
        workoutMealList: workoutMeal,
      ),
      DiscoverScreen(
        clientModel: clientModel,
        workoutMealList: workoutMeal,
        workoutPlanList: workoutPlan,
        expertList: expertModel,
      ),
      ProgramTrackerScreen(
        workoutMeals: workoutMeal,
        workoutPlans: workoutPlan,
      ),
      ProfileScreen(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final ClientProvider client = Provider.of<ClientProvider>(context);


    return StreamBuilder<ClientModel>(
      stream: client.clientStream,
      builder: (context, snapshot) {

        if (snapshot.hasData) {
          final client = snapshot.data!;

          return WorkoutPlanWrapper(
            child: (data) {
              final List<List<WorkoutPlan>> workoutPlan = data;

              return WorkoutMealWrapper(
                child: (data) {
                  final List<List<WorkoutMeal>> workoutMeal = data;

                  return ExpertListWrapper(
                    child: (data) {
                      final List<ExpertModel> expertModel = data.where((element) => element.verified == true).toList();

                      return bodyList(
                        clientModel: client,
                        workoutPlan: workoutPlan,
                        workoutMeal: workoutMeal,
                        expertModel: expertModel
                      )[widget.index];
                    }

                  );
                }
              );
            }
          );
        } else if (snapshot.hasError) {
          return Center(
            child: Text("Something went wrong: ${snapshot.error}"),
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
