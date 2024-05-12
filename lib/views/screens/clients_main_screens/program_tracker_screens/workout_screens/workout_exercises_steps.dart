import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:ifit/common/utils/app_styles.dart';
import 'package:ifit/models/workout.dart';
import 'package:ifit/views/screens/clients_main_screens/program_tracker_screens/workout_screens/components/timeline.dart';
import 'package:ifit/views/screens/clients_main_screens/program_tracker_screens/workout_screens/components/video.dart';
import 'package:readmore/readmore.dart';

class WorkoutExercisesSteps extends StatefulWidget {
  const WorkoutExercisesSteps({
    super.key,
    required this.eObj,
    required this.index,
  });

  final ExerciseElement eObj;
  final int index;

  @override
  State<WorkoutExercisesSteps> createState() => _WorkoutExercisesStepsState();
}

class _WorkoutExercisesStepsState extends State<WorkoutExercisesSteps> {

  @override
  Widget build(BuildContext context) {

    final ExerciseDuration duration = widget.eObj.exerciseDuration;

    return Scaffold(
      backgroundColor: Styles.bgColor,
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        elevation: 0,
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Container(
            margin: const EdgeInsets.all(12),
            height: 30,
            width: 30,
            alignment: Alignment.center,
            decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(10)),
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
                ExerciseVideoWidget(
                  urlVideo: widget.eObj.url,
                ),
                const Gap(20),
                Text(
                  widget.eObj.title.toString(),
                  style: Styles.text18.copyWith(
                      fontWeight: FontWeight.w700),
                ),
                const Gap(2),
                Text("${duration.time} ${duration.type ? "x" : "seconds"} ",
                  style: Styles.normal.copyWith(
                  ),
                ),
                const Gap(20),
                Text('Descriptions',
                  style: Styles.text18.copyWith(
                      fontWeight: FontWeight.w700),
                ),
                const Gap(10),
                ReadMoreText(widget.eObj.description,
                  style: Styles.seeMore.copyWith(
                    fontWeight: FontWeight.normal
                  ),
                  trimLines: 3,
                  colorClickableText: Colors.blue,
                  trimMode: TrimMode.Line,
                  trimCollapsedText: '  Show more',
                  trimExpandedText: ' Show less',
                  moreStyle: Styles.seeMore.copyWith(
                      color: Colors.blue,
                  ),
                  lessStyle: Styles.seeMore.copyWith(
                      color: Colors.blue,
                  ),
                ),
                const Gap(20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('How To Do It',
                      style: Styles.text18.copyWith(
                          fontWeight: FontWeight.w700),
                    ),
                    Text(
                      "${widget.eObj.steps.length} Steps",
                      style: Styles.normal.copyWith(
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),

                const Gap(10),
                ListView.builder(
                    padding: EdgeInsets.zero,
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: widget.eObj.steps.length,
                    itemBuilder: (context, index) {
                      var sObj = widget.eObj.steps[index];
                      return ExerStepsDottedLine(
                        index: index,
                        step: sObj,
                        isLast: widget.eObj.steps.last == sObj,
                      );
                    },
                ),
                
              ],  //Main Children
            ),
          ),
        ],
      ),
    );
  }
}




