import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluentui_icons/fluentui_icons.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:ifit/common/utils/app_styles.dart';
import 'package:ifit/service/Expert.dart';
import 'package:ifit/views/widgets/dialog/confirmation_dialog.dart';
import 'package:ifit/views/widgets/button/main_button.dart';
import 'package:ifit/views/screens/account_login_reg/register/client_registration/register_part2.dart';
import 'package:ifit/views/widgets/text_field/text_field_container.dart';
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
  final customDocId =
      FirebaseFirestore.instance.collection("workoutPlan").doc();

  // Future<String> generateUniqueDocId() async {
  //   // Reference to your Firestore collection
  //   CollectionReference<Map<String, dynamic>> collection =
  //       FirebaseFirestore.instance.collection('your_collection');
  //
  //   QuerySnapshot<Map<String, dynamic>>
  //       snapshot; // Declare snapshot outside the loop
  //
  //   // Generate a unique ID (e.g., using a random string)
  //   do {
  //     customDocId =
  //         randomAlphaNumeric(20); // Change the length according to your needs
  //
  //     // Check if the generated ID is already in use
  //     snapshot = await collection.where('workoutPlans', isEqualTo: customDocId).get();
  //
  //     // If the ID is already in use, generate a new one
  //   } while (snapshot.docs.isNotEmpty);
  //
  //   return customDocId;
  // }

  // late TextEditingController _listallitemscontroller;
  // List<String> allItems = [];
  List<TextEditingController> allItemsControllers = [];
  List<ExcerciseInstructions> exerciseinstructions_list = [];

  @override
  void initState() {
    super.initState();
    // Initialize a new controller for each TextfieldContainer
    // allItemsControllers = List.generate(1, (index) => TextEditingController());

    // _listallitemscontroller = TextEditingController();
  }

  @override
  void dispose() {
    // _listallitemscontroller.dispose();
    super.dispose();
  }

  // void displayItems() {
  //   setState(() {
  //     _listallitemscontroller.text =
  //         '[${allItems.map((item) => "'$item'").join(',')}]';
  //   });
  // }

  String? selectedWorkoutCategory;
  String? selectedWorkoutDifficulty;
  String? selectedWorkoutPurpose;
  String? selectedValue;

  final TextEditingController workoutPlanName = TextEditingController();
  final TextEditingController workoutDescriptions = TextEditingController();
  final TextEditingController workoutDaysOfThePlan = TextEditingController();
  final TextEditingController workoutMinutesitTakestoDo = TextEditingController();
  final TextEditingController workoutCalories = TextEditingController();

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
              builder: (context) {
                return ConfirmationDialog(
                  question: "Are you sure to Quit?",
                  onYesPressed: () {
                    Navigator.of(context)..pop()
                      ..pop()
                      ..pop();
                  }
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
          'Create Workout Plan',
          style: Styles.headline20,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(customDocId.id),
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
                      controller: ExpertProvider.description,
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
                          onPressed: () {},
                        ),
                      )
                    ],
                  ),
                  const Gap(10),
                  TextFieldContainer(
                    controller: ExpertProvider.daysOfThePlan,
                    hintText: 'Days of the Plan',
                    icon: FluentSystemIcons.ic_fluent_calendar_regular,
                    obscureText: false,
                  ),
                  const Gap(10),
                  TextFieldContainer(
                    controller: ExpertProvider.minutes,
                    hintText: 'Minutes it Takes to Do',
                    icon: FluentSystemIcons.ic_fluent_timer_regular,
                    obscureText: false,
                  ),
                  const Gap(10),
                  TextFieldContainer(
                    controller: ExpertProvider.calories,
                    hintText: 'Calories',
                    imagePath: "assets/icons/calories.png",
                    obscureText: false,
                  ),
                  const Gap(20),

                ],
              ),
              Column(
                children: [
                  Text(
                    "Equipments Needed",
                    style: Styles.title,
                  ),
                  const Gap(5),
                  TextFieldContainer(
                    hintText: 'Equipment with Quantity',
                    icon: Icons.fitness_center_outlined,
                    obscureText: false,

                  ),
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
                            child: Text("Items"),
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
                                child: TextFieldContainer(
                                  controller: allItemsControllers[index],
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
                  ),
                  const Gap(20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Exercises",
                        style: Styles.title,
                      ),
                      Text("Indicate how many sets",
                          style: Styles.text15normal),
                    ],
                  ),
                  Column(
                    children: [
                      Row(
                        children: [
                          IconButton(
                              onPressed: () {
                                setState(() {
                                  exerciseinstructions_list.removeLast();
                                });
                              },
                              icon: const Icon(Icons.remove)),
                          const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text("New Exercise"),
                          ),
                          IconButton(
                              onPressed: () {
                                setState(() {
                                  exerciseinstructions_list
                                      .add(ExcerciseInstructions());
                                });
                              },
                              icon: const Icon(Icons.add))
                        ],
                      ),
                      // Use ListView.builder to dynamically generate TextfieldContainer widgets
                      ListView.builder(
                        controller: ScrollController(),
                        shrinkWrap: true,
                        itemCount: exerciseinstructions_list.length,
                        itemBuilder: (context, index) {
                          const names = ["Name", "Description", "Countings"];
                          var controllers = [
                            TextEditingController(
                                text: exerciseinstructions_list[index].name),
                            TextEditingController(
                                text: exerciseinstructions_list[index].descriptions),
                            TextEditingController(
                                text: exerciseinstructions_list[index]
                                    .countings
                                    .toString()),
                          ];
                          var keytypes = [
                            TextInputType.name,
                            TextInputType.text,
                            TextInputType.number,
                          ];
                          var steps = <TextEditingController>[
                            ...exerciseinstructions_list[index]
                                .instructions
                                .map((e) => TextEditingController(text: e))
                          ];

                          return GestureDetector(
                            onTap: () {
                              showDialog(
                                  context: context,
                                  barrierDismissible: false,
                                  builder: (builder) {
                                    var SCSVscroller = ScrollController();
                                    return StatefulBuilder(
                                        builder: (context, thissetState) {
                                          return AlertDialog(
                                            title: const Text("Edit Exercise"),
                                            content: SizedBox(
                                              width: double.maxFinite,
                                              height: double.maxFinite,
                                              child: SingleChildScrollView(
                                                  controller: SCSVscroller,
                                                  child: Column(
                                                    mainAxisSize:
                                                    MainAxisSize.max,
                                                    children: [
                                                      GestureDetector(
                                                        onTap: () async {
                                                          // FilePickerResult? result = await FilePicker.platform.pickFiles();
                                                          //
                                                          // if (result != null) {
                                                          //   File file = File(result.files.single.path!);
                                                          // } else {
                                                          //
                                                          // }
                                                        },
                                                        child: Card(
                                                            child: Padding(
                                                              padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                              child: Container(
                                                                  width: double
                                                                      .maxFinite,
                                                                  child: Text(
                                                                      "Video file picker")),
                                                            )),
                                                      ),
                                                      ListView.builder(
                                                          shrinkWrap: true,
                                                          itemCount: names.length,
                                                          itemBuilder:
                                                              (context, index) {
                                                            return Padding(
                                                              padding:
                                                              const EdgeInsets
                                                                  .symmetric(
                                                                  vertical:
                                                                  8.0),
                                                              child: Column(
                                                                crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                                children: [
                                                                  Text(names[
                                                                  index]),
                                                                  TextField(
                                                                      controller:
                                                                      controllers[
                                                                      index],
                                                                      keyboardType:
                                                                      keytypes[
                                                                      index])
                                                                ],
                                                              ),
                                                            );
                                                          }),
                                                      Row(
                                                        mainAxisSize:
                                                        MainAxisSize.min,
                                                        children: [
                                                          IconButton(
                                                              onPressed: () {
                                                                thissetState(() {
                                                                  steps
                                                                      .removeLast();
                                                                });
                                                              },
                                                              icon: const Icon(
                                                                  Icons.remove)),
                                                          const Padding(
                                                            padding:
                                                            EdgeInsets.all(
                                                                8.0),
                                                            child: Text("Steps"),
                                                          ),
                                                          IconButton(
                                                              onPressed: () {
                                                                SCSVscroller.animateTo(
                                                                    SCSVscroller
                                                                        .position
                                                                        .maxScrollExtent,
                                                                    duration: const Duration(
                                                                        milliseconds:
                                                                        500),
                                                                    curve: Curves
                                                                        .easeIn);
                                                                thissetState(() {
                                                                  steps.add(
                                                                      TextEditingController());
                                                                });
                                                              },
                                                              icon: const Icon(
                                                                  Icons.add)),
                                                        ],
                                                      ),
                                                      ListView.builder(
                                                          shrinkWrap: true,
                                                          controller:
                                                          ScrollController(),
                                                          itemCount: steps.length,
                                                          itemBuilder:
                                                              (context, index) {
                                                            return Padding(
                                                              padding:
                                                              const EdgeInsets
                                                                  .symmetric(
                                                                  vertical:
                                                                  8.0),
                                                              child: Card(
                                                                child: Column(
                                                                  crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                                  children: [
                                                                    Text(
                                                                        "step ${index + 1}"),
                                                                    TextField(
                                                                      controller:
                                                                      steps[
                                                                      index],
                                                                      textInputAction:
                                                                      TextInputAction
                                                                          .next,
                                                                    )
                                                                  ],
                                                                ),
                                                              ),
                                                            );
                                                          }),
                                                    ],
                                                  )),
                                            ),
                                            actions: [
                                              TextButton(
                                                  onPressed: () {
                                                    setState(() {
                                                      exerciseinstructions_list[
                                                      index] =
                                                          ExcerciseInstructions()
                                                              .fill(
                                                              controllers[0]
                                                                  .text,
                                                              "null",
                                                              int.parse(
                                                                  controllers[
                                                                  2]
                                                                      .text),
                                                              controllers[1]
                                                                  .text,
                                                              steps
                                                                  .map((e) =>
                                                              e.text)
                                                                  .toList());
                                                    });
                                                    Navigator.pop(context);
                                                  },
                                                  child: const Text("OK"))
                                            ],
                                          );
                                        });
                                  });
                            },
                            child: Card(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment:
                                  CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                        "Workout name: ${exerciseinstructions_list[index].name}"),
                                    Text(
                                        "Steps: ${exerciseinstructions_list[index].instructions.length}"),
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
              ),
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
                          Navigator.of(context)..pop()..pop();

                        });
                        // var equipments = <String>[];
                        // if (allItemsControllers.isNotEmpty) {
                        //   for (final item in allItemsControllers) {
                        //     equipments.add(item.text);
                        //   }
                        // }
                        // FirebaseFirestore.instance
                        //     .collection('workoutPlans') //collection
                        //     .doc() //document name
                        //     .set(WorkoutData(
                        //         selectedWorkoutCategory,
                        //         selectedWorkoutPurpose,
                        //         selectedWorkoutDifficulty,
                        //         workoutPlanName.text,
                        //         workoutDescriptions.text,
                        //         workoutDaysOfThePlan.text,
                        //         workoutDaysOfThePlan.text,
                        //         workoutCalories.text,
                        //         equipments, [
                        //       ...exerciseinstructions_list.map((e) => e.toMap())
                        //     ]).toMap());

                        // Navigator.push(
                        //     context,
                        //     MaterialPageRoute(
                        //         builder: (context) => const ExpPrograms()));
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

class WorkoutData {
  String? workoutCategory;
  String? workoutPurpose;
  String? workoutDifficulty;
  String? workoutPlanName;
  String? workoutDescriptions;
  String? workoutDaysOfThePlan;
  String? workoutMinutesitTakestoDo;
  String? workoutCalories;
  List<String>? equipments;
  List<Map<String, dynamic>>? exerciseInstructions;

  WorkoutData(
      this.workoutCategory,
      this.workoutPurpose,
      this.workoutDifficulty,
      this.workoutPlanName,
      this.workoutDescriptions,
      this.workoutDaysOfThePlan,
      this.workoutMinutesitTakestoDo,
      this.workoutCalories,
      this.equipments,
      this.exerciseInstructions);

  Map<String, dynamic> toMap() {
    return {
      'workoutCategory': workoutCategory ?? "",
      'workoutPurpose': workoutPurpose ?? "",
      'workoutDifficulty': workoutDifficulty ?? "",
      'workoutPlanName': workoutPlanName ?? "",
      'workoutDescriptions': workoutDescriptions ?? "",
      'workoutDaysOfThePlan': workoutDaysOfThePlan ?? "",
      'workoutMinutesitTakestoDo': workoutMinutesitTakestoDo ?? 0.0,
      'workoutCalories': workoutCalories ?? 0.0,
      'equipments': equipments ?? [],
      "exerciseInstructions": exerciseInstructions ?? {}
    };
  }
}

class ExcerciseInstructions {
  String name = "";
  String videolink = "";
  int countings = 0;
  String descriptions = "";
  List<String> instructions = [];

  ExcerciseInstructions() {
    name = "";
    videolink = "";
    countings = 0;
    descriptions = "";
    instructions = [];
  }

  ExcerciseInstructions fill(String name, String videolink, int countings,
      String descriptions, List<String> instructions) {
    this.name = name;
    this.instructions = instructions;
    this.descriptions = descriptions;
    this.countings = countings;
    this.videolink = videolink;
    return this;
  }

  Map<String, dynamic> toMap() {
    return {
      "name": name,
      "videolink": videolink,
      "countings": countings,
      "descriptions": descriptions,
      "instructions": instructions
    };
  }
}

class BigTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;

  const BigTextField(
      {super.key, required this.controller, required this.hintText});

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        border: InputBorder.none,
        hintText: hintText,
      ),
      maxLines: 5,
    );
  }
}



class DisplayTextContainer extends StatefulWidget {
  final String hitText;
  final IconData icon;
  final Widget? rightIcon;
  final EdgeInsets? margin;

  const DisplayTextContainer({
    Key? key,
    required this.hitText,
    required this.icon,
    this.rightIcon,
    this.margin,
    required bool obscureText,
  }) : super(key: key);

  @override
  State<DisplayTextContainer> createState() => _DisplayTextContainerState();
}

class _DisplayTextContainerState extends State<DisplayTextContainer> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
