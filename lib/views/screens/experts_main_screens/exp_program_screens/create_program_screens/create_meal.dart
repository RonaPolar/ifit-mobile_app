import 'dart:io';

import 'package:fluentui_icons/fluentui_icons.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:ifit/common/utils/app_styles.dart';
import 'package:ifit/service/Expert.dart';
import 'package:ifit/views/widgets/dialog/confirmation_dialog.dart';
import 'package:ifit/views/widgets/button/main_button.dart';
import 'package:ifit/views/widgets/text_field/text_field_container.dart';
import 'package:ifit/views/screens/account_login_reg/register/client_registration/register_part2.dart';
import 'package:provider/provider.dart';

class CreateMeal extends StatefulWidget {
  const CreateMeal({
    required this.id,
    super.key,
  });

  final String id;

  @override
  State<CreateMeal> createState() => _CreateMealState();
}

class _CreateMealState extends State<CreateMeal> {
  @override
  Widget build(BuildContext context) {

    final ExpertProvider expertProvider = Provider.of<ExpertProvider>(context);

    return Scaffold(
      backgroundColor: Styles.bgColor,
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        elevation: 0,
        leading: InkWell(
          onTap: () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return ConfirmationDialog(
                  question: "Are you sure to Quit?",
                  onYesPressed: () {
                    Navigator.of(context)..pop()
                      ..pop()
                      ..pop();
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
        title: Text('Create Meal Plan',
          style: Styles.headline20,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              RegisterDropDown(
                hintText: 'Food Category',
                icon: FluentSystemIcons.ic_fluent_food_regular,
                items: expertProvider.foodCategoryList.map((data) {
                  return DropdownMenuItem<String>(
                    value: data,
                    child: Text(data),
                  );
                }).toList(),
                onChanged: expertProvider.updateFoodCategory,
                selectedValue: expertProvider.foodCategory,
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
                onChanged: expertProvider.updateWorkoutPurpose,
                selectedValue: expertProvider.workoutPurpose,
              ),
              const Gap(10),
              TextFieldContainer(
                controller: ExpertProvider.foodPlanName,
                hintText: 'Food Plan Name',
                icon: FluentSystemIcons.ic_fluent_food_regular,
              ),
              const Gap(10),
              SizedBox(
                height: 100,
                child: TextFieldContainer(
                  controller: ExpertProvider.foodDescription,
                  hintText: "Description",
                  icon: Icons.description,
                ),
              ),
              const Gap(10),
              Row(
                children: [
                  Text('Food Picture',
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
                        expertProvider.uploadWorkoutMeal(context);
                      },
                    ),
                  ),
                  const Gap(15),
                ],
              ),
              const Gap(15),
              Container(
                child: expertProvider.workoutMeal != null
                  ? Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.file(File(expertProvider.workoutMeal!.path),
                          fit: BoxFit.cover,
                          width: 100,
                          height: 100,
                        ),
                      ),
                    )
                  : const Text("No Image",
                      style: TextStyle(fontSize: 20),
                ),
              ),
              const Gap(20),
              Text("Nutritions",
                style: Styles.title,
              ),
              const Gap(5),
              TextFieldContainer(
                  controller: ExpertProvider.mealCalories,
                  hintText: 'Calories',
                  imagePath: "assets/icons/calories.png",
              ),
              const Gap(10),
              TextFieldContainer(
                  controller: ExpertProvider.mealFats,
                  hintText: 'Fats',
                  imagePath: "assets/icons/fat.png",
              ),
              const Gap(10),
              TextFieldContainer(
                  controller: ExpertProvider.mealSugar,
                  hintText: 'Sugar',
                  imagePath: "assets/icons/sugar.png",
              ),
              const Gap(10),
              TextFieldContainer(
                  controller: ExpertProvider.mealProtein,
                  hintText: 'Protein',
                  imagePath: "assets/icons/protein.png",
              ),
              const Gap(20),
              Text("Ingredients Needed",
                style: Styles.title,
              ),
              const Gap(5),
              _buildIngredients(expertProvider),
              const Gap(20),
              Text(
                "Step by Step Preparations",
                style: Styles.title,
              ),
              const Gap(5),
              _buildStepPreparations(expertProvider),
              Container(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    MainButton(
                      title: 'Done',
                      onPressed: () {
                        expertProvider.addWorkoutMeal(id: widget.id).then((value) {
                          Navigator.of(context)..pop()..pop();
                          expertProvider.clearWorkoutMealForm();
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

  Widget _buildIngredients(ExpertProvider expertProvider) {
    return Column(
      children: [
        Row(
          children: [
            IconButton(
              onPressed: () {
                expertProvider.updateIngredientsList(false);
              },
              icon: const Icon(Icons.remove),
            ),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text("Ingredients"),
            ),
            IconButton(
              onPressed: () {
                expertProvider.updateIngredientsList(true);
              },
              icon: const Icon(Icons.add),
            )
          ],
        ),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: expertProvider.ingredientsList.length,
          itemBuilder: (context, index) {
            return Column(
              children: [
                Padding(
                  padding:
                  const EdgeInsets.symmetric(vertical: 8.0),
                  child: TextFieldContainer(
                    controller: expertProvider.ingredientsList[index],
                    hintText: 'Equipment with Measurement',
                    icon: Icons.fastfood_rounded,
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

  Widget _buildStepPreparations(ExpertProvider expertProvider) {
    return Column(
      children: [
        Row(
          children: [
            IconButton(
              onPressed: () {
                expertProvider.updateMealPreparationsList(false);
              },
              icon: const Icon(Icons.remove),
            ),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text("Steps"),
            ),
            IconButton(
              onPressed: () {
                expertProvider.updateMealPreparationsList(true);
              },
              icon: const Icon(Icons.add),
            )
          ],
        ),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: expertProvider.mealPreparationsList.length,
          itemBuilder: (context, index) {
            return Column(
              children: [
                Padding(
                  padding:
                  const EdgeInsets.symmetric(vertical: 8.0),
                  child: TextFieldContainer(
                    controller: expertProvider.mealPreparationsList[index],
                    hintText: 'Input the Next Step to the Preparation',
                    icon: Icons.local_printshop_rounded,
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
}
