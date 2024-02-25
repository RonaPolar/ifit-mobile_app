import 'package:fluentui_icons/fluentui_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:gap/gap.dart';
import 'package:ifit/common/utils/app_styles.dart';
import 'package:ifit/models/workout.dart';
import 'package:ifit/service/auth.dart';
import 'package:ifit/views/screens/account_login_reg/register/client_registration/register_part2.dart';
import 'package:ifit/views/widgets/button/main_button.dart';
import 'package:ifit/views/widgets/checkbox/custom.dart';
import 'package:ifit/views/widgets/text_field/text_field_container.dart';
import 'package:provider/provider.dart';

class FeedbackFormScreen extends StatefulWidget {
  const FeedbackFormScreen({
    required this.id,
    required this.workoutPlan,
    super.key,
  });

  final String id;
  final WorkoutPlan workoutPlan;

  @override
  State<FeedbackFormScreen> createState() => _FeedbackFormScreenState();
}

class _FeedbackFormScreenState extends State<FeedbackFormScreen> {

  @override
  Widget build(BuildContext context) {
    final Auth auth = Provider.of<Auth>(context);

    return Scaffold(
      backgroundColor: Styles.bgColor,
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        elevation: 0,
        title: Text(
          "Feedback Form",
          style: Styles.headline20,
        ),
      ),
      body: Center(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: [
              Expanded(
                child: ListView(
                  shrinkWrap: true,
                  children: [
                    Container(
                      padding:
                          const EdgeInsets.symmetric(horizontal:20),
                      child: Column(
                        children: [
                          Text(
                            'Input your current',
                            style: Styles.text15bold,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: TextFieldContainer(
                                    keyboardType: TextInputType.number,
                                    controller: Auth.weight,
                                    hintText: 'Weight',
                                    icon: FluentSystemIcons
                                        .ic_fluent_data_funnel_regular,
                                ),
                              ),
                              const Gap(5),
                              Container(
                                width: 50,
                                height: 50,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                    color: Styles.primaryColor,
                                    borderRadius: BorderRadius.circular(15)),
                                child: const Text('KG',
                                    style: TextStyle(
                                      color: Colors.white,
                                    )),
                              )
                            ],
                          ),
                          const Gap(15),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: TextFieldContainer(
                                  keyboardType: TextInputType.number,
                                  controller: Auth.height,
                                  hintText: 'Height',
                                  icon: FluentSystemIcons
                                      .ic_fluent_arrow_sort_regular,
                                ),
                              ),
                              const Gap(5),
                              Container(
                                width: 50,
                                height: 50,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                    color: Styles.primaryColor,
                                    borderRadius: BorderRadius.circular(15)),
                                child: const Text('CM',
                                    style: TextStyle(
                                      color: Colors.white,
                                    )),
                              )
                            ],
                          ),
                          const Gap(20),
                          Text(
                            'Rate the Program',
                            style: Styles.text15bold,
                          ),
                          RatingBar.builder(
                            initialRating: 0,
                            minRating: 1,
                            direction: Axis.horizontal,
                            glowColor: Colors.orangeAccent,
                            // borderColor: Colors.amber.withAlpha(50),
                            allowHalfRating: true,
                            itemCount: 5,
                            itemPadding: const EdgeInsets.symmetric(horizontal: 4),
                            itemBuilder: (context, _) => const Icon(Icons.star, color: Colors.orange,),
                            onRatingUpdate: auth.updateRating,
                          ),
                          const SizedBox(height: 24.0),

                          Text(
                            'Rate the Expert',
                            style: Styles.text15bold,
                          ),
                          RatingBar.builder(
                            initialRating: 0,
                            minRating: 1,
                            direction: Axis.horizontal,
                            glowColor: Colors.orangeAccent,
                            // borderColor: Colors.amber.withAlpha(50),
                            allowHalfRating: true,
                            itemCount: 5,
                            itemPadding: const EdgeInsets.symmetric(horizontal: 4),
                            itemBuilder: (context, _) => const Icon(Icons.star, color: Colors.orange,),
                            onRatingUpdate: auth.updateExpertRating,
                          ),

                          const Gap(30),
                          Text(
                            'What\'s your NEXT goal?',
                            style: Styles.headline20,
                          ),
                          Text(
                            'It will help us to choose a best program for you',
                            style: Styles.text15normal,
                          ),
                          const Gap(20),
                          Text(
                            'In the next program, do you consider yourself as?',
                            style: Styles.text15bold,
                          ),
                          RegisterDropDown(
                            hintText: 'Difficulty', // hint will be from what they put to registration
                            icon: Icons.fitness_center_outlined,
                            items: auth.goalDifficultyList.map((data) {
                              return DropdownMenuItem<String>(
                                value: data,
                                child: Text(data),
                              );
                            }).toList(),
                            onChanged: auth.updateGoalDifficulty,
                            selectedValue: auth.goalDifficulty,
                          ),
                          const Gap(15),
                          Text(
                            'What fitness goals do you want to achieve next?',
                            style: Styles.text15bold,
                          ),
                          RegisterDropDown(
                            hintText: 'Purpose', // hint will be from what they put to registration
                            icon: Icons.fitness_center_outlined,
                            items: auth.fitnessGoalList.map((data) {
                              return DropdownMenuItem<String>(
                                value: data,
                                child: Text(data),
                              );
                            }).toList(),
                            onChanged: auth.updateFitnessGoal,
                            selectedValue: auth.fitnessGoal,
                          ),
                          const Gap(15),
                          Text("What next specific body part do you want for it?",
                            style: Styles.text15bold,
                          ),
                          Column(
                            children: auth.specificBodyList.map((data) {
                              return CustomCheckbox(
                                title: data,
                                onSelectionChanged: (val) {
                                  auth.updateSpecificBody(data);
                                },
                                value: auth.specificBody.contains(data),
                              );
                            }).toList(),
                          ),
                          const Gap(15),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    MainButton(
                      title: 'Update',
                      onPressed: () async {
                        Future.wait([
                          auth.updateAddExpertRating(workoutPlan: widget.workoutPlan),
                          auth.updateAddRating(id: widget.id, workoutPlan: widget.workoutPlan),
                          auth.updateProfileAssessment(id: widget.id),
                        ]).then((value) {
                          Navigator.of(context).pop();
                          auth.clearFeedbackForm();
                        });
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
