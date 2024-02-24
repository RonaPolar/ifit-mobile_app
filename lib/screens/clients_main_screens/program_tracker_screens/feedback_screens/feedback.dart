import 'package:fluentui_icons/fluentui_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:gap/gap.dart';
import 'package:ifit/common/utils/app_styles.dart';
import 'package:ifit/common/widgets/main_button.dart';
import 'package:ifit/common/widgets/text_field_container.dart';
import 'package:ifit/screens/account-login&reg/register/client_registration/register_part2.dart';
import 'package:ifit/screens/account-login&reg/register/client_registration/register_part3.dart';

class FeedbackForm extends StatefulWidget {
  const FeedbackForm({super.key});

  @override
  State<FeedbackForm> createState() => _FeedbackFormState();
}

class _FeedbackFormState extends State<FeedbackForm> {
  String? selectedWorkoutCategory;
  String? selectedWorkoutDifficulty;
  String? selectedWorkoutPurpose;
  String? selectedValue;
  final weightController = TextEditingController();
  final heightController = TextEditingController();
  
  @override
  Widget build(BuildContext context) {
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
                                child: TextfieldContainer(
                                    keyboardType: TextInputType.number,
                                    controller: weightController,
                                    hitText: 'Weight',
                                    icon: FluentSystemIcons
                                        .ic_fluent_data_funnel_regular,
                                    obscureText: false),
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
                                child: TextfieldContainer(
                                    keyboardType: TextInputType.number,
                                    controller: heightController,
                                    hitText: 'Height',
                                    icon: FluentSystemIcons
                                        .ic_fluent_arrow_sort_regular,
                                    obscureText: false),
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
                            onRatingUpdate: (rating) {
                                print(rating);
                            }, 
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
                            items: const [
                              DropdownMenuItem<String>(
                                value: "Beginner",
                                child: Text("Beginner"),
                              ),
                              DropdownMenuItem<String>(
                                value: "Intermediate",
                                child: Text("Intermediate"),
                              ),
                              DropdownMenuItem<String>(
                                value: "Expert",
                                child: Text("Expert"),
                              ),
                            ],
                            onChanged: (value) {
                              setState(() {
                                selectedWorkoutDifficulty = value;
                              });
                            },
                            selectedValue: selectedWorkoutDifficulty,
                          ),
                          const Gap(15),
                          Text(
                            'What fitness goals do you want to achieve next?',
                            style: Styles.text15bold,
                          ),
                          RegisterDropDown(
                            hintText: 'Purpose', // hint will be from what they put to registration
                            icon: Icons.fitness_center_outlined,
                            items: const [
                              DropdownMenuItem<String>(
                                value: "Lose Weight",
                                child: Text("Lose Weight"),
                              ),
                              DropdownMenuItem<String>(
                                value: "Gain Muscles",
                                child: Text("Gain Muscles"),
                              ),
                              DropdownMenuItem<String>(
                                value: "Body Toning",
                                child: Text("Body Toning"),
                              ),
                            ],
                            onChanged: (value) {
                              setState(() {
                                selectedWorkoutPurpose = value;
                              });
                            },
                            selectedValue: selectedWorkoutPurpose,
                          ),                          
                          const Gap(15),
                          CheckBoxList(questionText: '   What next specific body part do you want for it?',
                            choices: const ['Upper Body', 'Shoulders' , 'Arms', 'Biceps', 'Triceps', 'Forearms', 'Chest' , 'Upper Back', 'Lower Back' , 'Abdominals', 'Lower Body', 'Glutes', 'Legs', 'Quadriceps', 'Hamstrings', 'Calves', 'Full Body'], onSelectionChanged: (List<bool> value) {  }, 
                          ),
                          const Gap(15),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.only(
                    right: 20, left: 20, bottom: 30, top: 20),
                child: Column(
                  children: [
                    MainButton(
                      title: 'Update',
                      onPressed: () {
                         
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
