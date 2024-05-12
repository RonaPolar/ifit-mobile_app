import 'package:flutter/material.dart';
import 'package:ifit/models/workout.dart';
import 'package:ifit/views/screens/clients_main_screens/program_tracker_screens/workout_screens/start_workout/start_workout.dart';

class CountdownTimerScreen extends StatefulWidget {
  const CountdownTimerScreen({
    required this.workoutPlan,
    required this.id,
    super.key,
  });

  final WorkoutPlan workoutPlan;
  final String id;


  @override
  State<CountdownTimerScreen> createState() => _CountdownTimerScreenState();
}

class _CountdownTimerScreenState extends State<CountdownTimerScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<int> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    );

    _controller.reverse(from: 3);

    _animation = IntTween(
      begin: 1,
      end: 3,
    ).animate(_controller);

    _controller.addListener(() {
      if (_controller.status == AnimationStatus.dismissed) {
        Navigator.push(context,MaterialPageRoute(
          builder: (context) => StartWorkout(
            workoutPlan: widget.workoutPlan,
            id: widget.id,
        )));
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedBuilder(
        animation: _animation,
        builder: (context, child) {
          String startIndicator = "";

          switch (_animation.value) {
            case 3:
              startIndicator = "Ready";
            case 2:
              startIndicator = "Set";
            case 1:
              startIndicator = "Go";
          }

          return Center(
            child: Text(startIndicator),
          );
        },
      ),
    );
  }
}
