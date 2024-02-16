import 'package:fluentui_icons/fluentui_icons.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:ifit/common/utils/app_styles.dart';
import 'package:ifit/views/screens/clients_main_screens/program_tracker_screens/workout_screens/components/exercise_row.dart';
import 'package:ifit/views/widgets/button/favorites_button.dart';
import 'package:ifit/views/widgets/button/main_button.dart';
import 'package:ifit/views/widgets/icon_text_icon.dart';
import 'package:ifit/models/workout.dart';
import 'package:ifit/views/screens/clients_main_screens/discover_screens/Expert_screens/Expert_profile.dart';
import 'package:ifit/views/screens/clients_main_screens/program_tracker_screens/program_schedule/add_schedule.dart';
import 'package:ifit/views/screens/clients_main_screens/program_tracker_screens/workout_screens/start_workout.dart';
import 'package:ifit/views/screens/clients_main_screens/program_tracker_screens/workout_screens/workout_exercises_steps.dart';
import 'package:readmore/readmore.dart';

class WorkoutDetails extends StatefulWidget {

  const WorkoutDetails({
    required this.dObj,
    super.key,
  });

  final WorkoutPlan dObj;


  @override
  State<WorkoutDetails> createState() => _WorkoutDetailsState();
}

class _WorkoutDetailsState extends State<WorkoutDetails> {
  List itemsArr = [
    {
      "item": "1x of 6lbs Kettlebell",
    },
    {
      "item": "Skipping Rope",
    },
    {
      "item": "2x of 18lbs Dumbbell",
    },
  ];

    List exercisesArr = [
    {
      "name": "Set 1",
      "set": [
        {"image": "assets/images/exercises/WarmUp.png", "title": "Stretching", "value": "05:00"},
        {
          "image": "assets/images/exercises/JumpingJack.png",
          "title": "Jumping Jack",
          "value": "12x"
        },
        {"image": "assets/images/exercises/Skipping.png", "title": "Skipping", "value": "15x"},
        {"image": "assets/images/exercises/Squats.png", "title": "Squats", "value": "20x"},
        {
          "image": "assets/images/exercises/ArmRaises.png",
          "title": "Arm Raises",
          "value": "00:53"
        },
        {
          "image": "assets/images/exercises/RestandDrink.png",
          "title": "Rest and Drink",
          "value": "02:00"
        },
      ],
    },
    {
      "name": "Set 2",
      "set": [
        {"image": "assets/images/exercises/WarmUp.png", "title": "Warm Up", "value": "05:00"},
          {
            "image": "assets/images/exercises/JumpingJack.png",
            "title": "Jumping Jack",
            "value": "12x"
          },
          {"image": "assets/images/exercises/Skipping.png", "title": "Skipping", "value": "15x"},
          {"image": "assets/images/exercises/Squats.png", "title": "Squats", "value": "20x"},
          {
            "image": "assets/images/exercises/ArmRaises.png",
            "title": "Arm Raises",
            "value": "00:53"
          },
          {
            "image": "assets/images/exercises/RestandDrink.png",
            "title": "Rest and Drink",
            "value": "02:00"
          },
      ],
    },
      {
      "name": "Set 3",
      "set": [
        {"image": "assets/images/exercises/WarmUp.png", 
          "title": "Warm Up", 
          "value": "05:00"
        },
        {"image": "assets/images/exercises/JumpingJack.png",
          "title": "Jumping Jack",
          "value": "12x"
        },
        {"image": "assets/images/exercises/Skipping.png", 
          "title": "Skipping", 
          "value": "15x"
        },
        {"image": "assets/images/exercises/Squats.png", 
          "title": "Squats", 
          "value": "20x"},
        {"image": "assets/images/exercises/ArmRaises.png",
          "title": "Arm Raises",
          "value": "00:53"
        },
        {"image": "assets/images/exercises/RestandDrink.png",
          "title": "Rest and Drink",
          "value": "02:00"
        },
      ],
    }
  ];

  List discoverExperts = [
    {
      "name": "Dr. Otto Octavius",
      "image": "assets/images/Experts/Expert1.png",
      "profession": "Physician",
      "rate": "4.5",
      "mealCreated": "2",
      "workoutCreated": "3",
      "descriptions": "Hello! I completed my course in 2017 and have 5 years of experience working as Physician. If you like my programs I created, you can visit me at Manila Center at Makati City.",
    },
    
  ];


  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.red,
      child: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            SliverAppBar(
              backgroundColor: Colors.transparent,
              centerTitle: true,
              // pinned: true,
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
                child: Image.network(widget.dObj.workoutPicture,
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
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.dObj.planName.toString(),
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
                                      text: widget.dObj.expertName,
                                      style: Styles.text12.copyWith(
                                        color: Colors.blue,
                                      ),
                                      
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () {
                                        /// TODO: ADD TO FAVORITES
                                           var exObj = discoverExperts[0];
                                           Navigator.push(context,
                                              MaterialPageRoute(
                                                builder: (context) => ExpertProfile(exObj: exObj,
                                                  combinedList: [],
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
                          Container(
                              padding: EdgeInsets.zero,
                              child: const FavoriteButton()),
                        ],
                      ),
                      
                    ],
                  ),
                  const Gap(15),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                      'Descriptions',
                      style:  Styles.text18.copyWith(
                          fontWeight: FontWeight.w700),
                      ),
                      const Gap(10),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                                padding: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 10),
                                decoration: BoxDecoration(
                                  color: Styles.secondColor.withOpacity(0.3),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Row(
                                  children: [
                                    const Icon(Icons.star_sharp, color: Colors.red,),
                                    Text("${widget.dObj.rating.toString()} stars"),
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
                                  const Icon(Icons.accessibility_new_sharp, color: Colors.red,),
                                  Text("${widget.dObj.exercise.sets} "),
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
                                  Text("${widget.dObj.daysOfThePlan.day} days"),
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
                                  Text("${widget.dObj.minutes} mins"),
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
                                  const Icon(Icons.local_fire_department_sharp, color: Colors.red,),
                                  Text("${widget.dObj.calories} calories"),
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
                    padding: const EdgeInsets.symmetric(
                        vertical: 15, horizontal: 20),
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
                              builder: (context) => AddSchedule(date: DateTime.now()),
                            ),
                          );
                        }),
                  ),


                  const Gap(30),
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "You'll Need",
                            style: Styles.text18.copyWith(
                                fontWeight: FontWeight.w700),
                          ),
                          Text(
                            "${widget.dObj.equipments.length} Items",
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
                        "${widget.dObj.exercise.sets} Sets",
                        style:  Styles.normal.copyWith(
                            fontWeight: FontWeight.w700),
                      )
                    ],
                  ),
                  const Gap(10),
                  ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: widget.dObj.exercise.exercises.length,
                    itemBuilder: (context, index) {

                      var sObj = widget.dObj.exercise.exercises[index];
                      return ExercisesRow(
                        exerciseElement: sObj,
                        onPressed: (obj) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => WorkoutExercisesSteps(eObj: obj)
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
                          title: 'Start Now',
                          onPressed: () {
                            Navigator.push(context,MaterialPageRoute(
                                builder: (context) => StartWorkout(
                                  exercise: widget.dObj.exercise,
                                ),
                              ),
                            );
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


//Workout Exercises

