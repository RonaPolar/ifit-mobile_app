import 'package:flutter/material.dart';
import 'package:ifit/models/meal.dart';
import 'package:ifit/service/client.dart';
import 'package:provider/provider.dart';

class WorkoutMealWrapper extends StatefulWidget {
  const WorkoutMealWrapper({
    required this.child,
    super.key,
  });

  final Widget Function(List<List<WorkoutMeal>> workoutPlan) child;

  @override
  State<WorkoutMealWrapper> createState() => _WorkoutMealWrapperState();
}

class _WorkoutMealWrapperState extends State<WorkoutMealWrapper> {


  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final ClientProvider clientProvider = Provider.of<ClientProvider>(context, listen: false);
      clientProvider.updateWorkoutMealListStream();
    });
  }

  @override
  Widget build(BuildContext context) {
    final ClientProvider clientProvider = Provider.of<ClientProvider>(context);

    return StreamBuilder<List<List<WorkoutMeal>>>(
      stream: clientProvider.workoutMealListStream,
      builder: (context, snapshot) {

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
