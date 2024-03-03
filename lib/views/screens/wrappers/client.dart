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
import 'package:ifit/views/widgets/body/stream.dart';
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
      client.updateWorkoutMealListStream();
      client.updateWorkoutPlanListStream();
      client.updateExpertListStream();
      client.updateClientWorkoutMealListStream(uid: widget.uid);
      client.updateClientWorkoutPlanListStream(uid: widget.uid);
    });
  }

  List<Widget> bodyList({
    required ClientModel clientModel,
    required List<List<WorkoutPlan>> workoutPlan,
    required List<List<WorkoutMeal>> workoutMeal,
    required List<ExpertModel> expertModel,
    required List<WorkoutPlan> clientWorkoutPlan,
    required List<WorkoutMeal> clientWorkoutMeal,
  }) {
    return [
      HomeScreen(
        clientModel: clientModel,
        workoutPlanList: workoutPlan,
        workoutMealList: workoutMeal,
        clientWorkoutPlan: clientWorkoutPlan,
      ),
      DiscoverScreen(
        clientModel: clientModel,
        workoutMealList: workoutMeal,
        workoutPlanList: workoutPlan,
        expertList: expertModel,
      ),
      ProgramTrackerScreen(
        clientModel: clientModel,
        workoutMealList: clientWorkoutMeal,
        workoutPlanList: clientWorkoutPlan,
      ),
      ProfileScreen(
        clientModel: clientModel,
        clientWorkoutPlan: clientWorkoutPlan,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final ClientProvider client = Provider.of<ClientProvider>(context);


    return StreamWrapper<ClientModel>(
      stream: client.clientStream,
      child: (data) {
        final ClientModel clientModel = data!;

        return StreamWrapper<List<List<WorkoutPlan>>>(
          stream: client.workoutPlanListStream,
          child: (data) {
            final List<List<WorkoutPlan>> workoutPlan = data!;

            return StreamWrapper<List<List<WorkoutMeal>>>(
              stream: client.workoutMealListStream,
              child: (data) {
                final List<List<WorkoutMeal>> workoutMeal = data!;

                return StreamWrapper<List<ExpertModel>>(
                  stream: client.expertListStream,
                  child: (data) {
                    final List<ExpertModel> expertModel = data!;

                    return StreamWrapper<List<WorkoutPlan>>(
                      stream: client.clientWorkoutPlanListStream,
                      child: (data) {

                        final List<WorkoutPlan> clientWorkoutPlan = data!;

                        return StreamWrapper<List<WorkoutMeal>>(
                          stream: client.clientWorkoutMealListStream,
                          child: (data) {

                            final List<WorkoutMeal> clientWorkoutMeal = data!;

                            return bodyList(
                              clientModel: clientModel,
                              workoutPlan: workoutPlan,
                              workoutMeal: workoutMeal,
                              expertModel: expertModel,
                              clientWorkoutMeal: clientWorkoutMeal,
                              clientWorkoutPlan: clientWorkoutPlan,
                            )[widget.index];
                          }
                        );
                      }
                    );
                  }
                );
              }
            );
          },
        );
      },
    );
  }
}
