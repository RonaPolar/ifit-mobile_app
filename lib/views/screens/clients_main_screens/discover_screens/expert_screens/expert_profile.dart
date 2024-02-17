import 'dart:math';

import 'package:fluentui_icons/fluentui_icons.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:ifit/common/utils/app_styles.dart';
import 'package:ifit/views/widgets/button/main_button.dart';
import 'package:ifit/views/widgets/container/big.dart';
import 'package:ifit/models/expert.dart';
import 'package:ifit/models/meal.dart';
import 'package:ifit/models/workout.dart';
import 'package:readmore/readmore.dart';
import 'package:url_launcher/url_launcher.dart';

class ExpertProfile extends StatefulWidget {
  const ExpertProfile({
    required this.exObj,
    required this.workoutMeals,
    required this.workoutPlans,
    super.key,
  });

  final ExpertModel exObj;
  final List<WorkoutMeal> workoutMeals;
  final List<WorkoutPlan> workoutPlans;

  @override
  State<ExpertProfile> createState() => _ExpertProfileState();
}

class _ExpertProfileState extends State<ExpertProfile> {
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

  List popularWorkoutArr = [
    {
      "name": "Full Body Exercises",
      "image": "assets/icons/workout-pic.png",
      "schedule": "Monday",
      "categories": "Full Body",
      "time": "9:00am",
      "kcal": "320",
      "exercise": "10",
      "duration": "30",
    },
    {
      "name": "Upper Body Weights",
      "image": "assets/icons/Lower-Weights.png",
      "schedule": "Monday",
      "categories": "Upper Body",
      "time": "10:00am",
      "kcal": "210",
      "exercise": "10",
      "duration": "30",
    },
    {
      "name": "Ab Exercises",
      "image": "assets/icons/Ab-workout.png",
      "schedule": "Monday",
      "categories": "Abdominal",
      "time": "4:00pm",
      "kcal": "260",
      "exercise": "10",
      "duration": "30",
    },
  ];

  List popularMealArr = [
    {
      "name": "Blueberry Pancake",
      "image": "assets/images/meal/pancake.png",
      "kcal": "190",
      "fats": "199",
      "proteins": "305",
      "sugar": "150",
      "categories": "Breakfast",
    },
    {
      "name": "Salad",
      "image": "assets/images/meal/salad.png",
      "kcal": "200",
      "fats": "100",
      "proteins": "300",
      "sugar": "50",
      "categories": "Lunch",
    },
    {
      "name": "Salmon Nigiri",
      "image": "assets/images/meal/nigiri.png",
      "kcal": "300",
      "fats": "250",
      "proteins": "310",
      "sugar": "100",
      "categories": "Dinner",
    },
  ];
  
  bool isFollowing = false;


  @override
  Widget build(BuildContext context) {
    String buttonText = isFollowing ? 'Following' : 'Follow';
    List<dynamic> combinedList = [...widget.workoutPlans, ...widget.workoutMeals];
    combinedList.shuffle(Random());

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
                child: Image.network(widget.exObj.professionId,
                  errorBuilder: (context, object, stackTrace,) {
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
              topLeft: Radius.circular(25),
              topRight: Radius.circular(25),
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
                              Text(widget.exObj.name,
                                style: Styles.text18.copyWith(
                                    fontWeight: FontWeight.w700,
                                ),
                              ),
                              RichText(
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                      text: widget.exObj.profession,
                                      style: Styles.text12.copyWith(
                                        color: Colors.blue,
                                      ),
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () {
                                          
                                        },
                                    ),
                                  ],
                                ),
                              ),  
                            ],
                          ),
                          SizedBox(
                            height: 30,
                            width: 100,
                            child: MainButton(title: buttonText,
                              textStyle: Styles.seeMore.copyWith(color: Colors.white), 
                              onPressed: (){
                                // setState(() {
                                //     isFollowing = !isFollowing;
                                //   });
                              }),
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
                                  Text("${widget.exObj.rating} stars"),
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
                                  const Icon(Icons.fastfood_rounded, color: Colors.red,),
                                  Text("${widget.workoutMeals.length} Meals Created"),
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
                                  Text("${widget.workoutPlans.length} Workouts Created"),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Gap(10),
                      ReadMoreText(widget.exObj.description,
                        style: Styles.seeMore.copyWith(
                          fontWeight: FontWeight.normal
                        ),
                        trimLines: 3,
                        colorClickableText: Colors.blue,
                        trimMode: TrimMode.Line,
                        trimCollapsedText: '  Show more',
                        trimExpandedText: ' Show less',
                        moreStyle:  Styles.seeMore.copyWith(
                            color: Colors.blue),
                        lessStyle:  Styles.seeMore.copyWith(
                            color: Colors.blue),
                        ),
                      ],
                    ),
                  const Gap(20),
                  Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Programs Created",
                        style: Styles.title
                      ),
                      GridView.builder(
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                        ),
                        itemCount: combinedList.length,
                        itemBuilder: (context, index) {
                          final dynamic item = combinedList[index];

                          if (item is WorkoutPlan) {
                            // It's a workout item
                            return InkWell(
                              onTap: () {
                                // Navigator.push(
                                //   context,
                                //   MaterialPageRoute(
                                //     builder: (context) => WorkoutDetails(dObj: item),
                                //   ),
                                // );
                              },
                              child: BigContainer(
                                containerColor: Styles.secondColor.withOpacity(0.5),
                                image: item.workoutPicture,
                                title: item.planName,
                                bottomText: "${item.minutes} minutes | ${item.calories} kcal",
                                viewColor: Colors.grey.shade200,
                              ),
                            );
                          } else {
                            // It's a meal item
                            final mealItem = item as WorkoutMeal;
                            return InkWell(
                              onTap: () {
                                // Navigator.push(
                                //   context,
                                //   MaterialPageRoute(
                                //     builder: (context) => MealDetails(dObj: item),
                                //   ),
                                // );
                              },
                              child: BigContainer(
                                containerColor: Styles.secondColor.withOpacity(0.5),
                                image: mealItem.foodPhoto,
                                title: mealItem.foodPlanName,
                                bottomText: "${mealItem.purpose} | ${mealItem.calories} kcal",
                                viewColor: Colors.grey.shade200,
                              ),
                            );
                          }
                        },
                      ),
                    ],
                  ),              


                  Container(
                    padding: const EdgeInsets.only(top: 5,
                        bottom: 20),
                    child: Column(
                      children: [
                        MainButton(
                          title: 'Contact Now',
                          onPressed: () {
                            sendEmail("pajunar0@gmail.com");
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

  void sendEmail(String email) async {
    final Uri params = Uri(
      scheme: "mailto",
      path: email,
      query: "subject=Test%20Email&body=This is a test.",
    );

    if (await canLaunchUrl(params)) {
      debugPrint("Going to email");
      // await launchUrl(params);
      Uri uri = Uri.parse("mailto:pajunar0@gmail.com?subject=This is test. &body=Hello");
      await launchUrl(uri);
    }
  }
}
