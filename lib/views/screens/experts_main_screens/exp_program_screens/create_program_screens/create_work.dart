import 'dart:io';

import 'package:fluentui_icons/fluentui_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:ifit/common/utils/app_styles.dart';
import 'package:ifit/models/workout.dart';
import 'package:ifit/service/Expert.dart';
import 'package:ifit/views/screens/experts_main_screens/exp_program_screens/create_program_screens/components/add_exercise.dart';
import 'package:ifit/views/widgets/dialog/confirmation_dialog.dart';
import 'package:ifit/views/widgets/button/main_button.dart';
import 'package:ifit/views/screens/account_login_reg/register/client_registration/register_part2.dart';
import 'package:ifit/views/widgets/text_field/text_field_container.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';

class CreateWorkout extends StatefulWidget {
  const CreateWorkout({
    required this.id,
    super.key,
  });

  final String id;

  @override
  State<CreateWorkout> createState() => _CreateWorkoutState();
}

class _CreateWorkoutState extends State<CreateWorkout> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();

  @override
  Widget build(BuildContext context) {

    final ExpertProvider expertProvider = Provider.of<ExpertProvider>(context);

    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Styles.bgColor,
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        elevation: 0,
        leading: InkWell(
          onTap: () {
            showDialog(
              context: context,
              builder: (context) {
                return ConfirmationDialog(
                  question: "Are you sure to Quit?",
                  onYesPressed: () {
                    Navigator.of(context)..pop()
                      ..pop()
                      ..pop();
                    expertProvider.clearWorkoutPlanForm();
                  }
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
                borderRadius: BorderRadius.circular(10)),
            child: const Icon(
              Icons.close,
              size: 20,
              color: Colors.black,
            ),
          ),
        ),
        title: Text(
          'Create Workout Plan',
          style: Styles.headline20,
        ),
      ),
      body: ModalProgressHUD(
        inAsyncCall: expertProvider.isLoading,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(widget.id),
                    RegisterDropDown(
                      hintText: 'Category',
                      icon: Icons.fitness_center_outlined,
                      items: expertProvider.workoutCategoryList.map((data) {
                        return DropdownMenuItem<String>(
                          value: data,
                          child: Text(data),
                        );
                      }).toList(),
                      onChanged: (value) {
                        expertProvider.updateWorkoutCategory(value!);
                      },
                      selectedValue: expertProvider.workoutCategory,
                    ),
                    const Gap(10),
                    RegisterDropDown(
                      hintText: 'Purpose',
                      icon: Icons.fitness_center_outlined,
                      items: expertProvider.workoutPurposeList.map((data) {
                        return DropdownMenuItem<String>(
                          value: data,
                          child: Text(data),
                        );
                      }).toList(),
                      onChanged: (value) {
                        expertProvider.updateWorkoutPurpose(value!);
                      },
                      selectedValue: expertProvider.workoutPurpose,
                    ),
                    const Gap(10),
                    RegisterDropDown(
                      hintText: 'Difficulty',
                      icon: Icons.fitness_center_outlined,
                      items: expertProvider.workoutDifficultyList.map((data) {
                        return DropdownMenuItem<String>(
                          value: data,
                          child: Text(data),
                        );
                      }).toList(),
                      onChanged: (value) {
                        expertProvider.updateWorkoutDifficulty(value!);
                      },
                      selectedValue: expertProvider.workoutDifficulty,
                    ),
                    const Gap(10),
                    TextFieldContainer(
                      controller: ExpertProvider.planName,
                      hintText: 'Plan Name',
                      icon: Icons.fitness_center_outlined,
                    ),
                    const Gap(10),
                    SizedBox(
                      height: 100,
                      child: TextFieldContainer(
                        controller: ExpertProvider.workoutDescription,
                        hintText: "Description",
                        icon: Icons.description,
                      ),
                    ),
                    const Gap(10),
                    Row(
                      children: [
                        Text('Workout Picture',
                          style: Styles.title,
                        ),
                        const Gap(10),
                        SizedBox(
                          height: 25,
                          width: 100,
                          child: MainButton(
                            title: 'Upload',
                            textStyle: Styles.title.copyWith(color: Colors.white),
                            onPressed: () {
                              expertProvider.uploadWorkoutPicture(context);
                            },
                          ),
                        ),

                      ],
                    ),
                    const Gap(10),
                    Visibility(
                      visible: expertProvider.workoutPicture != null,
                      child: Image.file(File(expertProvider.workoutPicture?.path ?? ""),
                        fit: BoxFit.cover,
                        width: 100,
                        height: 100,
                      ),
                    ),

                    const Gap(10),
                    TextFieldContainer(
                      controller: ExpertProvider.daysOfThePlan,
                      hintText: 'Days of the plan',
                      icon: FluentSystemIcons.ic_fluent_timer_regular,
                      obscureText: false,
                    ),
                    const Gap(10),
                    TextFieldContainer(
                      controller: ExpertProvider.minutes,
                      hintText: 'Minutes it Takes to Do',
                      icon: FluentSystemIcons.ic_fluent_timer_regular,
                      obscureText: false,
                      keyboardType: TextInputType.number,
                    ),
                    const Gap(10),
                    TextFieldContainer(
                      controller: ExpertProvider.calories,
                      hintText: 'Calories',
                      imagePath: "assets/icons/calories.png",
                      obscureText: false,
                      keyboardType: TextInputType.number,
                    ),
                    const Gap(20),
                  ],
                ),
                _buildEquipmentsNeeded(expertProvider),
                _buildExercises(expertProvider),
                Container(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      MainButton(
                        title: 'Done',
                        onPressed: () async {
                          await expertProvider.addWorkoutPlan(
                            id: widget.id,
                          ).then((value) {
                            expertProvider.clearWorkoutPlanForm();
                            Navigator.of(context)..pop()..pop();
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
      ),
    );
  }

  Widget _buildEquipmentsNeeded(ExpertProvider expertProvider) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Equipments Needed",
              style: Styles.title,
            ),
            Row(
              children: [
                IconButton(
                    onPressed: () {
                      expertProvider.updateEquipmentsText(false);
                    },
                    icon: const Icon(Icons.remove)),
                const Text("Items"),
                IconButton(
                  onPressed: () {
                    expertProvider.updateEquipmentsText(true);
                  },
                  icon: const Icon(Icons.add),
                )
              ],
            ),
          ],
        ),
        const Gap(5),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: expertProvider.equipmentsText.length,
          itemBuilder: (context, index) {
            final TextEditingController equipment = expertProvider.equipmentsText[index];
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 5.0),
                  child: TextFieldContainer(
                    controller: equipment,
                    hintText: 'Equipment with Quantity',
                    icon: Icons.fitness_center_outlined,
                    obscureText: false,
                  ),
                )
              ],
            );
          },
        ),
      ],
    );
  }

  Widget _buildExercises(ExpertProvider expertProvider) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Gap(20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Exercises",
              style: Styles.title,
            ),
            Row(
              children: [
                IconButton(
                  onPressed: () {
                    expertProvider.updateSets(false);
                  },
                  icon: const Icon(Icons.remove),
                ),
                Text("Sets: ${expertProvider.sets}"),
                IconButton(
                  onPressed: () {
                    expertProvider.updateSets(true);
                  },
                  icon: const Icon(Icons.add),
                )
              ],
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            IconButton(
              onPressed: () {
                expertProvider.removeExercise();
              },
              icon: const Icon(Icons.remove),
            ),
            const Text("New Exercise"),
            IconButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const AddExerciseScreen()));
              },
              icon: const Icon(Icons.add),
            )
          ],
        ),
        Column(
          children: [
            ListView.builder(
              shrinkWrap: true,
              itemCount: expertProvider.exerciseList.length,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                final ExerciseElement exercise = expertProvider.exerciseList[index];

                return InkWell(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => AddExerciseScreen(
                          exerciseElement: exercise,
                          index: index,
                        )));
                  },
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Exercise: ${exercise.title}"),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ],
    );
  }

}

