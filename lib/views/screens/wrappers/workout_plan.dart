import 'package:flutter/material.dart';
import 'package:ifit/models/workout.dart';
import 'package:ifit/service/client.dart';
import 'package:provider/provider.dart';

class WorkoutPlanWrapper extends StatefulWidget {
  const WorkoutPlanWrapper({
    required this.child,
    super.key,
  });

  final Widget Function(List<List<WorkoutPlan>> workoutPlan) child;

  @override
  State<WorkoutPlanWrapper> createState() => _WorkoutPlanWrapperState();
}

class _WorkoutPlanWrapperState extends State<WorkoutPlanWrapper> {


  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final ClientProvider clientProvider = Provider.of<ClientProvider>(context, listen: false);
      clientProvider.updateWorkoutPlanListStream();
    });
  }

  @override
  Widget build(BuildContext context) {
    final ClientProvider clientProvider = Provider.of<ClientProvider>(context);

    return StreamBuilder<List<List<WorkoutPlan>>>(
      stream: clientProvider.workoutPlanListStream,
      builder: (context, snapshot) {

        print(snapshot.data);

        if (snapshot.hasData) {
          final data = snapshot.data!;

          return widget.child(data);
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
