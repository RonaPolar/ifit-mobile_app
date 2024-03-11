import 'package:fluentui_icons/fluentui_icons.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:ifit/common/utils/app_styles.dart';
import 'package:ifit/service/client.dart';
import 'package:ifit/views/screens/Experts_main_screens/exp_discover_screens/view_screens/meal_screen.dart/view_meal.dart';
import 'package:ifit/views/screens/clients_main_screens/profile_screens/expert_profile_screen.dart';
import 'package:ifit/views/widgets/button/favorites_button.dart';
import 'package:ifit/views/widgets/icon_text_icon.dart';
import 'package:ifit/models/meal.dart';
import 'package:ifit/views/screens/clients_main_screens/program_tracker_screens/program_schedule/add_schedule.dart';
import 'package:provider/provider.dart';
import 'package:readmore/readmore.dart';

class ExpertMealDetails extends StatefulWidget {
  
  const ExpertMealDetails({
    required this.workoutMeal,
    // required this.expertMealList,
    // required this.expertPlanList,
    // required this.expertModel,
    super.key,
  });

  final WorkoutMeal workoutMeal;
  // final List<WorkoutMeal> expertMealList;
  // final List<WorkoutPlan> expertPlanList;
  // final ExpertModel expertModel;

  @override
  State<ExpertMealDetails> createState() => _ExpertMealDetailsState();
}

class _ExpertMealDetailsState extends State<ExpertMealDetails> {

  @override
  Widget build(BuildContext context) {

    final ClientProvider clientProvider = Provider.of<ClientProvider>(context);

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
                child: Image.network(widget.workoutMeal.foodPhoto),
              ),
            ),
          ];
        },
        body: Container(
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
                        borderRadius: BorderRadius.circular(3)),
                  ),

                  const Gap(20),
                  _buildMealDescription(clientProvider),
                  
                  const Gap(15),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: Text('Nutritions',
                        style:  Styles.text18.copyWith(
                            fontWeight: FontWeight.w700),
                        ),
                      ),
                      const Gap(10),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                              decoration: BoxDecoration(
                                color: Styles.secondColor.withOpacity(0.3),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Row(
                                children: [
                                  const Icon(Icons.star_sharp, color: Colors.red,),
                                  Text("${widget.workoutMeal.rating} stars"),
                                ],
                              ),
                            ),
                            const Gap(5), 
                            NutritionDescriptions(
                              imagePath: "assets/icons/calories.png", 
                              label: "${widget.workoutMeal.calories} calories"),
                            const Gap(5),  
                            NutritionDescriptions(
                              imagePath: "assets/icons/fat.png", 
                              label: "${widget.workoutMeal.fats} fats"),
                            const Gap(5),
                            NutritionDescriptions(
                              imagePath: "assets/icons/sugar.png", 
                              label: "${widget.workoutMeal.sugar} sugar"),
                            const Gap(5),
                            NutritionDescriptions(
                              imagePath: "assets/icons/protein.png", 
                              label: "${widget.workoutMeal.protein} proteins"),
                          ],
                        ),
                      ),
                      const Gap(20),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Descriptions',
                              style:  Styles.text18.copyWith(
                                  fontWeight: FontWeight.w700),
                              ),
                            const Gap(10),
                            ReadMoreText(widget.workoutMeal.description,
                              style: Styles.seeMore.copyWith(
                                fontWeight: FontWeight.normal
                              ),
                              trimLines: 3,
                              colorClickableText: Colors.blue,
                              trimMode: TrimMode.Line,
                              trimCollapsedText: '  Show more',
                              trimExpandedText: ' Show less',
                              moreStyle:  Styles.seeMore.copyWith(
                                  color: Colors.blue,
                              ),
                              lessStyle:  Styles.seeMore.copyWith(
                                  color: Colors.blue,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  
                  const Gap(30),
                  // Padding(
                  //   padding: const EdgeInsets.symmetric(horizontal:15),
                  //   child: Container(
                  //     padding: const EdgeInsets.symmetric(
                  //         vertical: 15, horizontal: 20),
                  //     decoration: BoxDecoration(
                  //       color: Styles.secondColor.withOpacity(0.3),
                  //       borderRadius: BorderRadius.circular(15),
                  //     ),
                  //     child: NextNavigation(
                  //         title: 'Schedule Meal',
                  //         iconData: FluentSystemIcons.ic_fluent_calendar_regular,
                  //         onTap: () {
                  //           Navigator.push(context, MaterialPageRoute(
                  //             builder: (context) => const AddSchedule()),
                  //           );
                  //         },
                  //     ),
                  //   ),
                  // ),


                  const Gap(30),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal:15),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "You'll Need",
                              style:  Styles.text18.copyWith(
                                  fontWeight: FontWeight.w700),
                            ),
                            Text(
                              "${widget.workoutMeal.ingredients.length} Items",
                              style: Styles.normal.copyWith(
                                  fontWeight: FontWeight.w700),
                            )
                          ],
                        ),
                        const Gap(5),
                        ListView.builder(
                          padding: EdgeInsets.zero,
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: widget.workoutMeal.ingredients.length,
                          itemBuilder: (context, index) {
                            final String yObj = widget.workoutMeal.ingredients[index];
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(yObj,
                                  style: Styles.normal.copyWith(
                                    ),
                                ),
                              ],
                            );
                          },
                        ),
                      ],
                    ),
                  ),

                  const Gap(20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Step by Step",
                              style:  Styles.text18.copyWith(
                                  fontWeight: FontWeight.w700),
                            ),
                          ],
                        ),
                        const Gap(10),
                        // ListView.builder(
                        //   padding: EdgeInsets.zero,
                        //   physics: const NeverScrollableScrollPhysics(),
                        //   shrinkWrap: true,
                        //   itemCount: widget.dObj.stepPrep.length,
                        //   itemBuilder: (context, index) {
                        //     final String sObj = widget.dObj.stepPrep[index];
                        //     // return MealStepsDottedLine(
                        //     //   sObj: sObj,
                        //     //   isLast: stepArr.last == sObj,
                        //     //   index: index,
                        //     // );
                        //   },
                        // ),

                        Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Visibility(
                              visible: clientProvider.startMealDone,
                              child: Container(
                                padding: const EdgeInsets.all(6.0),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12.0),
                                ),
                                child: Text("Preparing...",
                                  style: Styles.title,
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                            const Gap(12.0),
                            // MainButton(
                            //   title: clientProvider.startMealDone
                            //       ? "Done"
                            //       : !clientProvider.workoutMealExisting
                            //           ? 'Start Now'
                            //           : "Start Again",
                            //   onPressed: () async {
                            //     // await clientProvider.addWorkoutMealPlan(
                            //     //   id: widget.id,
                            //     //   workoutMeal: widget.workoutMeal,
                            //     // ).then((value) {
                            //     //   if (clientProvider.startMealDone) {
                            //     //     Navigator.of(context).pop();
                            //     //     clientProvider.startMeal(false);
                            //     //   } else {
                            //     //     clientProvider.startMeal(true);
                            //     //   }
                            //     //
                            //     // });
                            //   },
                            // ),
                            const Gap(14.0),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMealDescription(ClientProvider clientProvider) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.workoutMeal.foodPlanName,
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
                          text: widget.workoutMeal.expertName,
                          style: Styles.text12.copyWith(
                            color: Colors.blue,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.push(context,
                                 MaterialPageRoute(
                                   builder: (context) => ExpertProfile(
                                     expertId: widget.workoutMeal.expertId,
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
                child: FavoriteButton(
                  onPressed: () {},
                  favorite: widget.workoutMeal.isFavorite,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}




