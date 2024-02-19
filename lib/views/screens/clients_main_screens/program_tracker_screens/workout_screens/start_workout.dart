import 'dart:async';

import 'package:fluentui_icons/fluentui_icons.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:ifit/common/utils/app_styles.dart';
import 'package:ifit/models/workout.dart';
import 'package:ifit/service/workout.dart';
import 'package:ifit/views/screens/clients_main_screens/program_tracker_screens/workout_screens/components/timeline.dart';
import 'package:ifit/views/screens/clients_main_screens/program_tracker_screens/workout_screens/components/video.dart';
import 'package:ifit/views/widgets/dialog/confirmation_dialog.dart';
import 'package:ifit/views/widgets/button/main_button.dart';
import 'package:provider/provider.dart';

class StartWorkout extends StatefulWidget {
  const StartWorkout({
    required this.workoutPlan,
    required this.id,
    super.key,
  });

  final WorkoutPlan workoutPlan;
  final String id;

  @override
  State<StartWorkout> createState() => _StartWorkoutState();
}

class _StartWorkoutState extends State<StartWorkout> {
  bool isPlaying = true;
  late Timer timer;
  late int time;
  bool doneCountdown = false;
  String countdownText = "";

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final WorkoutProvider workoutProvider = Provider.of<WorkoutProvider>(context, listen: false);
    });

    int countdown = 3;

    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      switch (countdown) {
        case 3:
          setState(() {
            countdownText = "Ready";
          });
        case 2:
          setState(() {
            countdownText = "Set";
          });
        case 1:
          setState(() {
            countdownText = "Go";
          });
      }
      countdown--;
    });

    time = int.parse(widget.workoutPlan.exercise.exercises[0].exerciseDuration.time);

    Future.delayed(const Duration(seconds: 4), () {
      setState(() {
        doneCountdown = true;
      });

      timer = Timer.periodic(const Duration(seconds: 1), (timer) {
        if (time != 0 && isPlaying) {
          setState(() {
            time--;
          });
        }
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    timer.cancel();
  }

  @override
  Widget build(BuildContext context) {

    final WorkoutProvider workoutProvider = Provider.of<WorkoutProvider>(context);
    final List<ExerciseElement> exercises = widget.workoutPlan.exercise.exercises;
    final int index = workoutProvider.workoutIndex;

    return Scaffold(
      backgroundColor: Styles.bgColor,
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        elevation: 0,
        title: Text("Set: ${workoutProvider.setFinished}"),
        leading: InkWell(
          onTap: () {
            showDialog(context: context,
              builder: (BuildContext context) {
                return ConfirmationDialog(
                  question: "Are you sure to Quit?",
                  onYesPressed: () {
                    workoutProvider.clearExerciseForm();
                    Navigator.of(context)..pop()..pop();
                  },
                );
              },
            );
          },
          child: Container(
            margin: const EdgeInsets.all(12),
            height: 30,
            width: 30,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(
              Icons.close,
              size: 20,
              color: Colors.black,
            ),
          ),
        ),
      ),
      body: Stack(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildTimer(workoutProvider),
                const Gap(30),
                ExerciseVideoWidget(
                  urlVideo: exercises[index].url,
                ),
                const Gap(20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(exercises[index].title,
                      style: Styles.text18.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const Gap(2),
                    ListView.builder(
                      padding: EdgeInsets.zero,
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: exercises.length,
                      itemBuilder: (context, index) {
                        final String step = exercises[index].steps[index];
                        return ExerStepsDottedLine(
                          index: index,
                          step: step,
                          isLast: step == exercises[index].steps.last,
                        );
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
          Visibility(
            visible: !doneCountdown,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.8),
              ),
              child: Center(
                child: Text(countdownText,
                  style: const TextStyle(
                    fontSize: 75.0,
                    color: Colors.red,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTimer(WorkoutProvider workoutProvider) {

    final List<ExerciseElement> exercises = widget.workoutPlan.exercise.exercises;
    final int index = workoutProvider.workoutIndex;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal:20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                icon: !isPlaying
                    ? const Icon(FluentSystemIcons.ic_fluent_play_filled)
                    : const Icon(FluentSystemIcons.ic_fluent_pause_filled),
                onPressed: () {
                  setState(() {
                    isPlaying = !isPlaying;
                  });
                },
              ),
              Text("$time",
                style: Styles.normal.copyWith(
                    color: Colors.black,
                    fontSize: 18
                ),
              ),
              IconButton(
                icon: const Icon(FluentSystemIcons.ic_fluent_arrow_repeat_all_filled),
                onPressed: () {
                  setState(() {
                    time = int.parse(exercises[index].exerciseDuration.time);
                  });
                },
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 120,
                height: 35,
                child: MainButton(
                  title: "Skip",
                  textStyle: Styles.text18.copyWith(
                    color: Colors.white,
                  ),
                  onPressed: () {
                    workoutProvider.updateSkipWorkout(
                      exerciseList: exercises,
                    );
                  },
                ),
              ),
              const Gap(5),
              SizedBox(
                width: 120,
                height: 35,
                child: MainButton(
                  title: "Done",
                  textStyle: Styles.text18.copyWith(color: Colors.white),
                  onPressed: () async {
                    await workoutProvider.updateDoneWorkout(
                      exerciseList: exercises,
                      workoutId: widget.workoutPlan.id,
                      id: widget.id,
                      set: widget.workoutPlan.exercise.sets,
                    ).then((value) {
                      if (workoutProvider.setFinished == widget.workoutPlan.exercise.sets) {
                        Navigator.of(context).pop();
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) => StartWorkout(
                            workoutPlan: widget.workoutPlan,
                            id: widget.id,
                          ),
                        ));
                      } else {
                        Navigator.of(context).pop();
                      }
                    });
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
