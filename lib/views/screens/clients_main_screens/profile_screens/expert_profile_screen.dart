import 'dart:math';

import 'package:fluentui_icons/fluentui_icons.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:ifit/common/utils/app_styles.dart';
import 'package:ifit/models/expert.dart';
import 'package:ifit/service/Expert.dart';
import 'package:ifit/views/screens/clients_main_screens/program_tracker_screens/meal_screens/meal_details.dart';
import 'package:ifit/views/screens/clients_main_screens/program_tracker_screens/workout_screens/workout_details.dart';
import 'package:ifit/views/widgets/body/stream.dart';
import 'package:ifit/views/widgets/button/main_button.dart';
import 'package:ifit/views/widgets/container/big.dart';
import 'package:ifit/models/meal.dart';
import 'package:ifit/models/workout.dart';
import 'package:provider/provider.dart';
import 'package:readmore/readmore.dart';
import 'package:url_launcher/url_launcher.dart';

class ExpertProfile extends StatefulWidget {
  const ExpertProfile({
    required this.expertId,
    super.key,
  });

  final String expertId;

  @override
  State<ExpertProfile> createState() => _ExpertProfileState();
}

class _ExpertProfileState extends State<ExpertProfile> {
  bool isFollowing = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final ExpertProvider expertProvider = Provider.of<ExpertProvider>(context, listen: false);
      expertProvider.updateExpertStream(uid: widget.expertId);
      expertProvider.updateWorkoutMealListStream(uid: widget.expertId);
      expertProvider.updateWorkoutPlanListStream(uid: widget.expertId);
    });
  }

  @override
  Widget build(BuildContext context) {
    final ExpertProvider expertProvider = Provider.of<ExpertProvider>(context);
    List<dynamic> combinedList = [];
    String buttonText = isFollowing ? 'Following' : 'Follow';

    return Scaffold(
      body: StreamWrapper<ExpertModel>(
        stream: expertProvider.expertStream,
        child: (data) {
          final ExpertModel expertModel = data!;

          return StreamWrapper<List<WorkoutPlan>>(
            stream: expertProvider.workoutPlanListStream,
            child: (data) {
              final List<WorkoutPlan> workoutPlans = data!;

              return StreamWrapper<List<WorkoutMeal>>(
                stream: expertProvider.workoutMealListStream,
                child: (data) {
                  final List<WorkoutMeal> workoutMeals = data!;

                  if (workoutMeals.isNotEmpty && workoutPlans.isNotEmpty) {
                    combinedList = [...workoutPlans, ...workoutMeals];
                  } else if (workoutPlans.isNotEmpty) {
                    combinedList = workoutPlans;
                  } else if (workoutMeals.isNotEmpty) {
                    combinedList = workoutMeals;
                  }
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
                              child: Image.network(expertModel.professionId,
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
                                            Text(expertModel.name,
                                              style: Styles.text18.copyWith(
                                                fontWeight: FontWeight.w700,
                                              ),
                                            ),
                                            RichText(
                                              text: TextSpan(
                                                children: [
                                                  TextSpan(
                                                    text: expertModel.profession,
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
                                                Text("${expertModel.rating} stars"),
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
                                                Text("${workoutMeals.length} Meals Created"),
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
                                                Text("${workoutPlans.length} Workouts Created"),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const Gap(10),
                                    ReadMoreText(expertModel.description,
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
                                              Navigator.push(context, MaterialPageRoute(
                                                builder: (context) => WorkoutDetails(
                                                  dObj: item,
                                                  id: expertModel.uid,
                                                  clientWorkoutPlan: item,
                                                ),
                                              ));
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
                                              Navigator.push(context, MaterialPageRoute(
                                                  builder: (context) => MealDetails(
                                                    workoutMeal: mealItem,
                                                    id: expertModel.uid,
                                                  )),
                                              );
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
                                          sendEmail(expertModel.email);
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
              );
            }
          );
        }
      ),
    );
  }

  void sendEmail(String email) async {

    final String url = "mailto:$email";
    final Uri uri = Uri.parse(url);

    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      throw "Cant open email app";
    }
  }
}
