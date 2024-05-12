
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

class _StartWorkoutState extends State<StartWorkout> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<int> _animation;
  bool flag = false;
  String currentUrl = "";

  @override
  void initState() {
    super.initState();

    final WorkoutProvider workoutProvider = Provider.of<WorkoutProvider>(context, listen: false);

    final exerciseDuration = widget.workoutPlan.exercise.exercises[workoutProvider.workoutIndex].exerciseDuration;
    final time = exerciseDuration.time;
    final isCounting = exerciseDuration.type;

    currentUrl = widget.workoutPlan.exercise.exercises[workoutProvider.workoutIndex].url;

    _controller = AnimationController(
      duration: Duration(seconds: int.parse(time)),
      vsync: this,
    );

    if (!isCounting) {
      _controller.reverse(from: double.parse(time));
    }

    _animation = IntTween(
      begin: 0,
      end: int.parse(time),
    ).animate(_controller);

    _controller.addStatusListener((status) {

      if (status == AnimationStatus.dismissed && !workoutProvider.restart && !flag) {
        flag = true;

        workoutProvider.updateDoneWorkout(
          workoutPlan: widget.workoutPlan,
          id: widget.id,
          context: scaffoldKey.currentContext!,
          skip: false,
        ).then((value) {
          final exerciseDuration = widget.workoutPlan.exercise.exercises[workoutProvider.workoutIndex].exerciseDuration;
          final isCounting = exerciseDuration.type;

          if (!isCounting) {
            _controller.reset();
            _controller.reverse(from: double.parse(time));
          } else {
            _controller.stop();
          }

        });
      }

      if (status == AnimationStatus.completed) {
        flag = false;
      }
    });

    _controller.addListener(() {
      if (isCounting) {
        _controller.stop();
      }
    });
  }

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    final WorkoutProvider workoutProvider = Provider.of<WorkoutProvider>(context);
    final List<ExerciseElement> exercises = widget.workoutPlan.exercise.exercises;
    final int index = workoutProvider.workoutIndex;

    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Styles.bgColor,
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        elevation: 0,
        title: Text("Set: ${workoutProvider.setFinished + 1}"),
        leading: InkWell(
          onTap: () {
            showDialog(context: context,
              builder: (BuildContext context) {
                return ConfirmationDialog(
                  question: "Are you sure to Quit?",
                  onYesPressed: () {
                    workoutProvider.clearExerciseForm(
                      workoutPlan: widget.workoutPlan,
                    );
                    Navigator.of(context)..pop()..pop()..pop();
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
      body: SingleChildScrollView(
        child: AnimatedBuilder(
          animation: _animation,
          builder: (context, child) {

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildTimer(workoutProvider),
                const Gap(30),
                ExerciseVideoWidget(
                  urlVideo: currentUrl,
                  key: GlobalKey(),
                ),
                const Gap(20),
                Padding(
                  padding: const EdgeInsets.all(14.0),
                  child: Column(
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
                        itemCount: exercises[index].steps.length,
                        itemBuilder: (context, aIndex) {
                          final String step = exercises[index].steps[aIndex];
                          return ExerStepsDottedLine(
                            index: aIndex,
                            step: step,
                            isLast: step == exercises[index].steps.last,
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ],
            );
          }
        ),
      ),
    );
  }

  Widget _buildTimer(WorkoutProvider workoutProvider) {

    final List<ExerciseElement> exercises = widget.workoutPlan.exercise.exercises;
    final int index = workoutProvider.workoutIndex;
    final isCounting = exercises[index].exerciseDuration.type;
    final time = exercises[index].exerciseDuration.time;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal:20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Visibility(
                visible: !exercises[index].exerciseDuration.type,
                child: IconButton(
                  icon: workoutProvider.isPause
                      ? const Icon(FluentSystemIcons.ic_fluent_play_filled)
                      : const Icon(FluentSystemIcons.ic_fluent_pause_filled),
                  onPressed: () {
                    workoutProvider.pauseTimer();

                    if (workoutProvider.isPause) {
                      _controller.stop();
                    } else {
                      _controller.reverse();
                    }
                  },
                ),
              ),
              Text("${isCounting ? "${time}x" : _animation.value}",
                style: Styles.normal.copyWith(
                    color: Colors.black,
                    fontSize: 18
                ),
              ),
              Visibility(
                visible: !exercises[index].exerciseDuration.type,
                child: IconButton(
                  icon: const Icon(FluentSystemIcons.ic_fluent_arrow_repeat_all_filled),
                  onPressed: () {
                    workoutProvider.updateRestart(true);
                    _controller.reset();
                    _controller.reverse(from: double.parse(time));
                    workoutProvider.updateRestart(false);
                  },
                ),
              ),
            ],
          ),
        ),
        const Gap(4.0),
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
                  onPressed: () async {
                    await workoutProvider.updateDoneWorkout(
                      id: widget.id,
                      workoutPlan: widget.workoutPlan,
                      context: scaffoldKey.currentContext!,
                      skip: true,
                    ).then((value) {
                      setState(() {
                        flag = true;
                      });
                      setState(() {
                        currentUrl = widget.workoutPlan.exercise.exercises[workoutProvider.workoutIndex].url;
                      });
                      _controller.reset();
                      _controller.reverse(from: double.parse(time));
                    });
                  },
                ),
              ),
              const Gap(5),
              Visibility(
                visible: exercises[index].exerciseDuration.type,
                child: SizedBox(
                  width: 120,
                  height: 35,
                  child: MainButton(
                    title: "Done",
                    textStyle: Styles.text18.copyWith(color: Colors.white),
                    onPressed: () async {
                      await workoutProvider.updateDoneWorkout(
                        id: widget.id,
                        workoutPlan: widget.workoutPlan,
                        context: scaffoldKey.currentContext!,
                        skip: false,
                      ).then((value) {
                        setState(() {
                          flag = true;
                        });

                        setState(() {
                          currentUrl = widget.workoutPlan.exercise.exercises[workoutProvider.workoutIndex].url;
                        });
                        _controller.reset();
                        _controller.reverse(from: double.parse(time));
                      });


                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
