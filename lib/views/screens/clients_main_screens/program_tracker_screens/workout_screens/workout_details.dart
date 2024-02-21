import 'package:fluentui_icons/fluentui_icons.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:ifit/common/utils/app_styles.dart';
import 'package:ifit/service/client.dart';
import 'package:ifit/service/workout.dart';
import 'package:ifit/views/screens/clients_main_screens/profile_screens/expert_profile_screen.dart';
import 'package:ifit/views/screens/clients_main_screens/program_tracker_screens/workout_screens/components/exercise_row.dart';
import 'package:ifit/views/screens/clients_main_screens/program_tracker_screens/workout_screens/start_workout/countdown.dart';
import 'package:ifit/views/widgets/button/favorites_button.dart';
import 'package:ifit/views/widgets/button/main_button.dart';
import 'package:ifit/views/widgets/icon_text_icon.dart';
import 'package:ifit/models/workout.dart';
import 'package:ifit/views/screens/clients_main_screens/program_tracker_screens/program_schedule/add_schedule.dart';
import 'package:ifit/views/screens/clients_main_screens/program_tracker_screens/workout_screens/workout_exercises_steps.dart';
import 'package:provider/provider.dart';
import 'package:readmore/readmore.dart';

class WorkoutDetails extends StatefulWidget {
  const WorkoutDetails({
    required this.id,
    required this.dObj,
    this.clientWorkoutPlan,
    super.key,
  });

  final String id;
  final WorkoutPlan dObj;
  final WorkoutPlan? clientWorkoutPlan;

  @override
  State<WorkoutDetails> createState() => _WorkoutDetailsState();
}

class _WorkoutDetailsState extends State<WorkoutDetails> {

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      final ClientProvider clientProvider = Provider.of<ClientProvider>(context, listen: false);
      clientProvider.getWorkoutPlanExisting(
        workoutPlan: widget.dObj,
        id: widget.id,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final WorkoutPlan workoutPlan = widget.dObj;
    final ClientProvider clientProvider = Provider.of<ClientProvider>(context);
    final WorkoutProvider workoutProvider = Provider.of<WorkoutProvider>(context);

    return Container(
      color: Colors.red,
      child: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            SliverAppBar(
              backgroundColor: Colors.transparent,
              centerTitle: true,
              elevation: 0,
              expandedHeight: 300,
              leading: InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Container(
                  margin: const EdgeInsets.all(12),
                  height: 30,
                  width: 30,
                  alignment: Alignment.center,
                  child: const Icon(
                    FluentSystemIcons.ic_fluent_chevron_left_filled,
                    size: 20,
                    color: Colors.black,
                  ),
                ),
              ),

              flexibleSpace: Container(
                padding: const EdgeInsets.only(top: 80, bottom: 10),
                width: double.maxFinite,
                child: Image.network(workoutPlan.workoutPicture,
                  errorBuilder: (context, exception, stackTrace) {
                    return const Icon(Icons.question_mark_rounded);
                  },
                ),
              ),
            ),
          ];
        },
        body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          decoration: BoxDecoration(
            color: Styles.bgColor,
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(25), topRight: Radius.circular(25),
            ),
          ),
          child: Scaffold(
            backgroundColor: Colors.transparent,
            body: SingleChildScrollView(
              child: Column(
                children: [
                  const Gap(10),
                  Container(
                    width: 50,
                    height: 4,
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(3),
                    ),
                  ),
                  const Gap(20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  workoutPlan.planName,
                                  style: Styles.text18.copyWith(
                                      fontWeight: FontWeight.w700),
                                ),
                                RichText(
                                  text: TextSpan(
                                    children: [
                                     TextSpan(
                                        text: 'by ',
                                        style: Styles.text12
                                      ),
                                      TextSpan(
                                        text: workoutPlan.expertName,
                                        style: Styles.text12.copyWith(
                                          color: Colors.blue,
                                        ),

                                        recognizer: TapGestureRecognizer()
                                          ..onTap = () {
                                             Navigator.push(context,
                                                MaterialPageRoute(
                                                  builder: (context) => ExpertProfile(
                                                    expertId: widget.id,
                                                  ),
                                                ),
                                             );
                                          },
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Visibility(
                            visible: clientProvider.workoutPlanExisting,
                            child: FavoriteButton(
                              onPressed: () async {
                                await workoutProvider.updateAddToFavorite(
                                  id: widget.id,
                                  workoutPlan: widget.dObj,
                                );
                              },
                              favorite: widget.clientWorkoutPlan == null
                                ? widget.dObj.isFavorite
                                : widget.clientWorkoutPlan!.isFavorite,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const Gap(15),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Descriptions',
                        style:  Styles.text18.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const Gap(10),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 10,
                              ),
                              decoration: BoxDecoration(
                                color: Styles.secondColor.withOpacity(0.3),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Row(
                                children: [
                                  const Icon(Icons.star_sharp,
                                    color: Colors.red,
                                  ),
                                  Text("${workoutPlan.rating} stars"),
                                ],
                              ),
                            ),
                            const Gap(5),
                            Container(
                              padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 10),
                              decoration: BoxDecoration(
                                color: Styles.secondColor.withOpacity(0.3),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Row(
                                children: [
                                  const Icon(Icons.accessibility_new_sharp,
                                    color: Colors.red,
                                  ),
                                  Text("${workoutPlan.exercise.sets} "),
                                ],
                              ),
                            ),
                            const Gap(5),
                            Container(
                              padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 10),
                              decoration: BoxDecoration(
                                color: Styles.secondColor.withOpacity(0.3),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Row(
                                children: [
                                  const Icon(Icons.timer, color: Colors.red,),
                                  Text("${workoutPlan.daysOfThePlan} days"),
                                ],
                              ),
                            ),
                            const Gap(5),
                            Container(
                              padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 10),
                              decoration: BoxDecoration(
                                color: Styles.secondColor.withOpacity(0.3),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Row(
                                children: [
                                  const Icon(Icons.timer, color: Colors.red,),
                                  Text("${workoutPlan.minutes} mins"),
                                ],
                              ),
                            ),
                            const Gap(5),
                            Container(
                              padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 10),
                              decoration: BoxDecoration(
                                color: Styles.secondColor.withOpacity(0.3),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Row(
                                children: [
                                  const Icon(Icons.local_fire_department_sharp,
                                    color: Colors.red,
                                  ),
                                  Text("${workoutPlan.calories} calories"),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Gap(10),
                      ReadMoreText(widget.dObj.description,
                        style: Styles.seeMore.copyWith(
                          fontWeight: FontWeight.normal
                        ),
                        trimLines: 3,
                        colorClickableText: Colors.blue,
                        trimMode: TrimMode.Line,
                        trimCollapsedText: '  Show more',
                        trimExpandedText: ' Show less',
                        moreStyle:    Styles.seeMore.copyWith(
                            color: Colors.blue,
                        ),
                        lessStyle:  Styles.seeMore.copyWith(
                            color: Colors.blue,
                        ),
                      ),
                    ],
                  ),
                  const Gap(30),
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                    decoration: BoxDecoration(
                      color: Styles.secondColor.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: NextNavigation(
                      title: 'Schedule Workout',
                      iconData: FluentSystemIcons.ic_fluent_calendar_regular,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const AddSchedule(),
                          ),
                        );
                      },
                    ),
                  ),
                  const Gap(30),
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("You'll Need",
                            style: Styles.text18.copyWith(
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        Text(
                          "${workoutPlan.equipments.length} Items",
                          style: Styles.normal.copyWith(
                            fontWeight: FontWeight.w700),
                          )
                        ],
                      ),
                      const Gap(5),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: widget.dObj.equipments.map((exercise) {
                          return Text(exercise,
                            style: Styles.normal.copyWith(
                            ),
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                  const Gap(20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Exercises",
                        style:  Styles.text18.copyWith(
                            fontWeight: FontWeight.w700),
                      ),
                      Text(
                        "${workoutPlan.exercise.sets} Sets",
                        style:  Styles.normal.copyWith(
                            fontWeight: FontWeight.w700),
                      )
                    ],
                  ),
                  const Gap(10),
                  ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: workoutPlan.exercise.exercises.length,
                    itemBuilder: (context, index) {
                      final ExerciseElement exercise = workoutPlan.exercise.exercises[index];

                      return ExercisesRow(
                        exerciseElement: exercise,
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => WorkoutExercisesSteps(
                                eObj: exercise,
                                index: index,
                              )
                            ),
                          );
                        },
                      );
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Column(
                      children: [
                        MainButton(
                          title: !clientProvider.workoutPlanExisting
                            ? 'Start Now'
                            : "Continue",
                          onPressed: () async {
                            await clientProvider.addWorkoutPlan(
                              id: widget.id,
                              workoutPlan: workoutPlan,
                            ).then((value) {
                                Navigator.push(context,MaterialPageRoute(
                                  builder: (context) => CountdownTimerScreen(
                                    workoutPlan: workoutPlan,
                                    id: widget.id,
                                  ))
                              );
                            });
                          },
                        ),
                      ],
                    ),
                  ),

                ], //Main children
              ),
            ),
          ),
        ), //Main top
      ),
    );
  }
}

