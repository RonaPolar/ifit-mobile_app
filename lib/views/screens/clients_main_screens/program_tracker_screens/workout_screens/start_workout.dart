import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:ifit/common/utils/app_styles.dart';
import 'package:ifit/models/workout.dart';
import 'package:ifit/views/screens/clients_main_screens/program_tracker_screens/workout_screens/components/timeline.dart';
import 'package:ifit/views/screens/clients_main_screens/program_tracker_screens/workout_screens/components/video.dart';
import 'package:ifit/views/widgets/dialog/confirmation_dialog.dart';
import 'package:ifit/views/widgets/button/main_button.dart';

class StartWorkout extends StatefulWidget {
  const StartWorkout({
    required this.exercise,
    super.key,
  });

  final Exercise exercise;

  @override
  State<StartWorkout> createState() => _StartWorkoutState();
}

class _StartWorkoutState extends State<StartWorkout> {
  bool isPlaying = false;
  int index = 0;

  @override
  Widget build(BuildContext context) {
    print(widget.exercise.exercises[1]);

    return Scaffold(
      backgroundColor: Styles.bgColor,
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        elevation: 0,
        leading: InkWell(
          onTap: () {
            showDialog(context: context,
              builder: (BuildContext context) {
                return ConfirmationDialog(
                  question: "Are you sure to Quit?",
                  onYesPressed: () {
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
      body: ListView(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Padding(
                //   padding: const EdgeInsets.symmetric(horizontal:20),
                //   child: Row(
                //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //     children: [
                //       IconButton(
                //         icon: isPlaying
                //           ? const Icon(FluentSystemIcons.ic_fluent_play_filled)
                //           : const Icon(FluentSystemIcons.ic_fluent_pause_filled),
                //         onPressed: () {
                //           setState(() {
                //             isPlaying = !isPlaying;
                //             // Add your logic for play/pause functionality here
                //           });
                //         },
                //       ),
                //       Text("asdsa",
                //         style: Styles.normal.copyWith(
                //           color: Colors.black,
                //           fontSize: 18
                //         ),
                //       ),
                //       IconButton(icon: const Icon(FluentSystemIcons.ic_fluent_arrow_repeat_all_filled),
                //       onPressed: (){
                //
                //         },
                //       ),
                //     ],
                //   ),
                // ),
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
                            setState(() {
                              index++;
                            });
                          },
                        ),
                      ),
                      const Gap(5),
                      //Comes only when the Exercise is not TIME
                      // SizedBox(      
                      //   width: 120,
                      //   height: 35,
                      //   child: MainButton(title: "Done", 
                      //     textStyle: Styles.text18.copyWith(color: Colors.white), 
                      //     onPressed: () { },)),
                    ],
                  ),
                ),
                const Gap(30),
                ExerciseVideoWidget(
                  urlVideo: widget.exercise.exercises[index].url,
                ),
                const Gap(20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.exercise.exercises[index].title,
                      style: Styles.text18.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const Gap(2),
                    ListView.builder(
                      padding: EdgeInsets.zero,
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: widget.exercise.exercises.length,
                      itemBuilder: (context, index) {
                        final String step = widget.exercise.exercises[this.index].steps[index];
                        return ExerStepsDottedLine(
                          index: index,
                          step: step,
                          isLast: step == widget.exercise.exercises[this.index].steps.last,
                        );
                      },
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
