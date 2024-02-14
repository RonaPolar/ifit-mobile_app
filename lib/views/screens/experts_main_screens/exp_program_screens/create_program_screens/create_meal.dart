import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:fluentui_icons/fluentui_icons.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:ifit/common/utils/app_styles.dart';
import 'package:ifit/common/widgets/confirmation_dialog.dart';
import 'package:ifit/common/widgets/main_button.dart';
import 'package:ifit/common/widgets/text_field_container.dart';
import 'package:ifit/views/screens/account_login_reg/register/client_registration/register_part2.dart';
import 'package:ifit/views/screens/experts_main_screens/exp_bottom_bar.dart';
import 'package:image_picker/image_picker.dart';

class CreateMeal extends StatefulWidget {
  const CreateMeal({super.key});

  @override
  State<CreateMeal> createState() => _CreateMealState();
}

class _CreateMealState extends State<CreateMeal> {
  String? selectedValue;
  String? selectedFoodCategory;
  String? selectedFoodPurpose;

  List<TextEditingController> allItemsControllers = [];
  List<TextEditingController> allStepssControllers = [];

  final TextEditingController workoutPlanName = TextEditingController();
  final TextEditingController workoutDescriptions = TextEditingController();
  final TextEditingController workoutFats = TextEditingController();
  final TextEditingController workoutSugar = TextEditingController();
  final TextEditingController workoutprotein = TextEditingController();
  final TextEditingController workoutCalories = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  XFile? foodpicture;
  String downloadURL = '';

  final ImagePicker picker = ImagePicker();

  //we can upload image from camera or from gallery based on parameter
  Future getImage(ImageSource source) async {
    var img = await picker.pickImage(source: source);

    setState(() {
      foodpicture = img;
    });

    print(img!.path);
  }

  void myAlert() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            title: const Text('Please choose media to select'),
            content: SizedBox(
              height: MediaQuery.of(context).size.height / 6,
              child: Column(
                children: [
                  ElevatedButton(
                    //if user click this button, user can upload image from gallery
                    onPressed: () {
                      Navigator.pop(context);
                      getImage(ImageSource.gallery);
                    },
                    child: const Row(
                      children: [
                        Icon(Icons.image),
                        Text('From Gallery'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
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
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const ExpPrograms()));
                    },
                  );
                });
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
          'Create Meal Plan',
          style: Styles.headline20,
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              shrinkWrap: true,
              padding: const EdgeInsets.all(15),
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RegisterDropDown(
                      hintText: 'Food Category',
                      icon: FluentSystemIcons.ic_fluent_food_regular,
                      items: const [
                        DropdownMenuItem<String>(
                          value: "Breakfast",
                          child: Text("Breakfast"),
                        ),
                        DropdownMenuItem<String>(
                          value: "Lunch",
                          child: Text("Lunch"),
                        ),
                        DropdownMenuItem<String>(
                          value: "Dinner",
                          child: Text("Dinner"),
                        ),
                        DropdownMenuItem<String>(
                          value: "Snacks",
                          child: Text("Snacks"),
                        ),
                        DropdownMenuItem<String>(
                          value: "Drinks",
                          child: Text("Drinks"),
                        ),
                      ],
                      onChanged: (value) {
                        setState(() {
                          selectedFoodCategory = value;
                        });
                      },
                      selectedValue: selectedFoodCategory,
                    ),
                    const Gap(10),
                    RegisterDropDown(
                      hintText: 'Purpose',
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
                          selectedFoodPurpose = value;
                        });
                      },
                      selectedValue: selectedFoodPurpose,
                    ),
                    const Gap(10),
                    TextfieldContainer(
                        controller: workoutPlanName,
                        hitText: 'Food Plan Name',
                        icon: FluentSystemIcons.ic_fluent_food_regular,
                        obscureText: false),
                    const Gap(10),
                    SizedBox(
                      height: 100,
                      child: TextfieldContainer(
                          controller: workoutDescriptions,
                          hitText: "Descriptions",
                          obscureText: false),
                    ),
                    const Gap(10),
                    Row(
                      children: [
                        Text(
                          'Food Picture',
                          style: Styles.title,
                        ),
                        const Gap(10),
                        SizedBox(
                            height: 25,
                            width: 100,
                            child: MainButton(
                                title: 'Upload',
                                textStyle:
                                    Styles.title.copyWith(color: Colors.white),
                                onPressed: () {
                                  myAlert();
                                })),
                        const Gap(15),
                      ],
                    ),
                    const Gap(15),
                    Container(
                      alignment: Alignment.center,
                      child: foodpicture != null
                          ? Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Image.file(
                                  //to show image, you type like this.
                                  File(foodpicture!.path),
                                  fit: BoxFit.cover,
                                  width: 100,
                                  height: 100,
                                ),
                              ),
                            )
                          : const Text(
                              "No Image",
                              style: TextStyle(fontSize: 20),
                            ),
                    ),
                    const Gap(20),
                    Text(
                      "Nutritions",
                      style: Styles.title,
                    ),
                    const Gap(5),
                    TextfieldContainer(
                        controller: workoutCalories,
                        hitText: 'Calories',
                        imagePath: "assets/icons/calories.png",
                        obscureText: false),
                    const Gap(10),
                    TextfieldContainer(
                        controller: workoutFats,
                        hitText: 'Fats',
                        imagePath: "assets/icons/fat.png",
                        obscureText: false),
                    const Gap(10),
                    TextfieldContainer(
                        controller: workoutSugar,
                        hitText: 'Sugar',
                        imagePath: "assets/icons/sugar.png",
                        obscureText: false),
                    const Gap(10),
                    TextfieldContainer(
                        controller: workoutprotein,
                        hitText: 'Protein',
                        imagePath: "assets/icons/protein.png",
                        obscureText: false),
                    const Gap(20),
                    Text(
                      "Ingrediets Needed",
                      style: Styles.title,
                    ),
                    const Gap(5),
                    Column(
                      children: [
                        Row(
                          children: [
                            IconButton(
                                onPressed: () {
                                  setState(() {
                                    allItemsControllers.removeLast();
                                  });
                                },
                                icon: const Icon(Icons.remove)),
                            const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text("Ingredients"),
                            ),
                            IconButton(
                                onPressed: () {
                                  setState(() {
                                    allItemsControllers
                                        .add(TextEditingController());
                                  });
                                },
                                icon: const Icon(Icons.add))
                          ],
                        ),
                        // Use ListView.builder to dynamically generate TextfieldContainer widgets
                        ListView.builder(
                          shrinkWrap: true,
                          itemCount: allItemsControllers.length,
                          itemBuilder: (context, index) {
                            return Column(
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 8.0),
                                  child: TextfieldContainer(
                                    controller: allItemsControllers[index],
                                    hitText: 'Equipment with Measurement',
                                    icon: Icons.fitness_center_outlined,
                                    obscureText: false,
                                  ),
                                )
                              ],
                            );
                          },
                        ),
                      ],
                    ),
                    const Gap(20),
                    Text(
                      "Step by Step Preparations",
                      style: Styles.title,
                    ),
                    const Gap(5),
                    Column(
                      children: [
                        Row(
                          children: [
                            IconButton(
                                onPressed: () {
                                  setState(() {
                                    allStepssControllers.removeLast();
                                  });
                                },
                                icon: const Icon(Icons.remove)),
                            const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text("Steps"),
                            ),
                            IconButton(
                                onPressed: () {
                                  setState(() {
                                    allStepssControllers
                                        .add(TextEditingController());
                                  });
                                },
                                icon: const Icon(Icons.add))
                          ],
                        ),
                        // Use ListView.builder to dynamically generate TextfieldContainer widgets
                        ListView.builder(
                          shrinkWrap: true,
                          itemCount: allStepssControllers.length,
                          itemBuilder: (context, index) {
                            return Column(
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 8.0),
                                  child: TextfieldContainer(
                                    controller: allStepssControllers[index],
                                    hitText:
                                        'Input the Next Step to the Preparation',
                                    icon: Icons.fitness_center_outlined,
                                    obscureText: false,
                                  ),
                                )
                              ],
                            );
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
            padding:
                const EdgeInsets.only(right: 20, left: 20, bottom: 30, top: 20),
            child: Column(
              children: [
                MainButton(
                  title: 'Done',
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return ConfirmationDialog(
                            question: "Are you sure to create?",
                            onYesPressed: () async {
                              var equipments = <String>[];
                              if (allItemsControllers.isNotEmpty) {
                                for (final item in allItemsControllers) {
                                  equipments.add(item.text);
                                }
                              }

                              var steps = <String>[];
                              if (allStepssControllers.isNotEmpty) {
                                for (final item in allStepssControllers) {
                                  steps.add(item.text);
                                }
                              }

                              final path = 'foodpicture';
                              final file = File(foodpicture!.path);

                              final ref = FirebaseStorage.instance
                                  .ref()
                                  .child(path)
                                  .child(foodpicture!.name);
                              await ref.putFile(file);

                              downloadURL = await ref.getDownloadURL();

                              setState(() {
                                downloadURL = downloadURL;
                              });

                              FirebaseFirestore.instance
                                  .collection('workoutMeal') //collection
                                  .doc() //document name
                                  .set(WorkoutData(
                                    selectedFoodCategory,
                                    selectedFoodPurpose,
                                    workoutPlanName.text,
                                    workoutDescriptions.text,
                                    workoutCalories.text,
                                    workoutFats.text,
                                    workoutSugar.text,
                                    workoutprotein.text,
                                    equipments,
                                    steps,
                                    downloadURL,
                                  ).toMap())
                                  .then((value) => Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const ExpPrograms())));
                              ;
                            },
                          );
                        });
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

//Button for Add and Subtract
class AddsubButton extends StatefulWidget {
  final String title;
  final Widget add;
  final Widget subtract;
  final VoidCallback? onSubtract;
  const AddsubButton({
    super.key,
    required this.title,
    required this.add,
    required this.subtract,
    this.onSubtract,
  });

  @override
  State<AddsubButton> createState() => _AddsubButtonState();
}

class _AddsubButtonState extends State<AddsubButton> {
  List<Widget> steps = [];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            IconButton(
              icon: const Icon(Icons.remove),
              onPressed: () {
                setState(() {
                  if (steps.isNotEmpty) {
                    steps.removeLast();
                  }
                  if (steps.isEmpty) {
                    steps.removeAt(0);
                  }
                  if (widget.onSubtract != null) {
                    widget.onSubtract!();
                  }
                });
              },
            ),
            Text(widget.title, style: Styles.text15bold),
            IconButton(
              icon: const Icon(Icons.add),
              onPressed: () {
                setState(() {
                  steps.add(
                    Column(
                      children: [const Gap(5), widget.add],
                    ),
                  );
                });
              },
            ),
          ],
        ),
        const Gap(5),
        Column(
          children: [...steps],
        ),
      ],
    );
  }
}

class WorkoutData {
  String? workoutCategory;
  String? workoutPurpose;
  String? workoutPlanName;
  String? workoutDescriptions;
  String? workoutCalories;
  String? workoutFats;
  String? workoutSugar;
  String? workoutprotein;
  List<String>? equipments;
  List<String>? steps;
  String? downloadURL;

  WorkoutData(
    this.workoutCategory,
    this.workoutPurpose,
    this.workoutPlanName,
    this.workoutDescriptions,
    this.workoutFats,
    this.workoutSugar,
    this.workoutprotein,
    this.workoutCalories,
    this.equipments,
    this.steps,
    this.downloadURL,
  );

  Map<String, dynamic> toMap() {
    return {
      'workoutCategory': workoutCategory ?? "",
      'workoutPurpose': workoutPurpose ?? "",
      'workoutPlanName': workoutPlanName ?? "",
      'workoutDescriptions': workoutDescriptions ?? "",
      'workoutFats': workoutFats ?? "",
      'workoutSugar': workoutSugar ?? "",
      'workoutprotein': workoutprotein ?? "",
      'workoutCalories': workoutCalories ?? 0.0,
      'equipments': equipments ?? [],
      'steps': steps ?? [],
      'foodpicture': downloadURL ?? 0.0,
    };
  }
}
