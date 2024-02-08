import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:fluentui_icons/fluentui_icons.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:ifit/common/utils/app_styles.dart';
import 'package:ifit/common/widgets/confirmation_dialog.dart';
import 'package:ifit/common/widgets/main_button.dart';
import 'package:ifit/screens/account-login&reg/register/client_registration/register_part2.dart';
import 'package:ifit/screens/experts_main_screens/exp_bottom_bar.dart';

class CreateWorkout extends StatefulWidget {
  const CreateWorkout({super.key});

  @override
  State<CreateWorkout> createState() => _CreateWorkoutState();
}

class _CreateWorkoutState extends State<CreateWorkout> {
  final customDocId = FirebaseFirestore.instance.collection("workoutPlan")
      .doc();

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
          'Create Workout Plan',
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
                    Text(customDocId.id),
                    RegisterDropDown(
                      hintText: 'Category',
                      icon: Icons.fitness_center_outlined,
                      items: const [
                        DropdownMenuItem<String>(
                          value: "Upper Body",
                          child: Text("Upper Body"),
                        ),
                        DropdownMenuItem<String>(
                          value: "Abdominal",
                          child: Text("Abdominal"),
                        ),
                        DropdownMenuItem<String>(
                          value: "Lower Body",
                          child: Text("Lower Body"),
                        ),
                        DropdownMenuItem<String>(
                          value: "Full Body",
                          child: Text("Full Body"),
                        ),
                      ],
                      onChanged: (value) {
                        setState(() {
                          selectedWorkoutCategory = value;
                        });
                      },
                      selectedValue: selectedWorkoutCategory,
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
                          selectedWorkoutPurpose = value;
                        });
                      },
                      selectedValue: selectedWorkoutPurpose,
                    ),
                    const Gap(10),
                    RegisterDropDown(
                      hintText: 'Difficulty',
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
                    const Gap(10),
                    TextfieldContainer(
                      controller: workoutPlanName,
                      hitText: 'Plan Name',
                      icon: Icons.fitness_center_outlined,
                      obscureText: false,
                      onItemAdded: (newItem) {},
                    ),
                    const Gap(10),
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.grey.shade200,
                          borderRadius: BorderRadius.circular(20)),
                      child: SizedBox(
                        height: 100,
                        child: TextField(
                          controller: workoutDescriptions,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "Description",
                          ),
                          maxLines: 5,
                        )
                        ),
                      ),
                    const Gap(10),
                    Row(
                      children: [
                        Text(
                          'Workout Picture',
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
                                onPressed: () {}))
                      ],
                    ),
                    const Gap(10),
                    TextfieldContainer(
                      controller: workoutDaysOfThePlan,
                      hitText: 'Days of the Plan',
                      icon: FluentSystemIcons.ic_fluent_calendar_regular,
                      obscureText: false,
                      onItemAdded: (newItem) {},
                    ),
                    const Gap(10),
                    TextfieldContainer(
                      controller: workoutMinutesitTakestoDo,
                      hitText: 'Minutes it Takes to Do',
                      icon: FluentSystemIcons.ic_fluent_timer_regular,
                      obscureText: false,
                      onItemAdded: (newItem) {},
                    ),
                    const Gap(10),
                    TextfieldContainer(
                      controller: workoutCalories,
                      hitText: 'Calories',
                      imagePath: "assets/icons/calories.png",
                      obscureText: false,
                      onItemAdded: (newItem) {},
                    ),
                    const Gap(20),
                    Text(
                      "Equipments Needed",
                      style: Styles.title,
                    ),
                    const Gap(5),
                    // TextfieldContainer(
                    //   hitText: 'Equipment with Quantity',
                    //   icon: Icons.fitness_center_outlined,
                    //   obscureText: false,
                    //   onItemAdded: (newItem) {
                    //     allItems.add(newItem);
                    //   },
                    // ),
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
                                icon: Icon(Icons.remove)
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: const Text("Items"),
                            ),
                            IconButton(
                                onPressed: () {
                                  setState(() {
                                    allItemsControllers.add(
                                        TextEditingController());
                                  });
                                },
                                icon: Icon(Icons.add)
                            )
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
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 8.0),
                                  child: TextfieldContainer(
                                    controller: allItemsControllers[index],
                                    hitText: 'Equipment with Quantity',
                                    icon: Icons.fitness_center_outlined,
                                    obscureText: false,
                                    onItemAdded: (newItem) {},
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
                                icon: Icon(Icons.remove)
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: const Text("New Exercise"),
                            ),
                            IconButton(
                                onPressed: () {
                                  setState(() {
                                    exerciseinstructions_list.add(
                                        ExcerciseInstructions());
                                  });
                                },
                                icon: Icon(Icons.add)
                            )
                          ],
                        ),
                        // Use ListView.builder to dynamically generate TextfieldContainer widgets
                        ListView.builder(
                          controller: ScrollController(),
                          shrinkWrap: true,
                          itemCount: exerciseinstructions_list.length,
                          itemBuilder: (context, index) {
                            const names =["Name","Description","Countings"];
                            var controllers = [
                              TextEditingController(text: exerciseinstructions_list[index].name),
                              TextEditingController(text: exerciseinstructions_list[index].descriptions),
                              TextEditingController(text: exerciseinstructions_list[index].countings.toString()),
                            ];
                            var keytypes = [
                              TextInputType.name,
                              TextInputType.text,
                              TextInputType.number,
                            ];
                            var steps = <TextEditingController>[...exerciseinstructions_list[index].instructions.map((e) => TextEditingController(text: e))];

                            return GestureDetector(
                              onTap: (){
                                showDialog(
                                    context: context,
                                    barrierDismissible: false ,
                                    builder: (builder){
                                      var SCSVscroller = ScrollController();
                                      return StatefulBuilder(
                                          builder: (context, thissetState){
                                              return  AlertDialog(
                                                title: Text("Edit Exercise"),
                                                content: SizedBox(
                                                  width:  double.maxFinite,
                                                  height: double.maxFinite,
                                                  child: SingleChildScrollView(
                                                      controller: SCSVscroller,
                                                      child: Column(
                                                        mainAxisSize: MainAxisSize.max,
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

                                                              child : Padding(
                                                                padding: const EdgeInsets.all(8.0),
                                                                child: Container(
                                                                  width: double.maxFinite,
                                                                    child: Text("Video file picker")),
                                                              )
                                                            ),
                                                          ),
                                                          ListView.builder(
                                                              shrinkWrap: true,
                                                              itemCount: names.length,
                                                              itemBuilder: (context,index){
                                                                return Padding(
                                                                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                                                                  child: Column(
                                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                                    children: [
                                                                      Text(names[index]),
                                                                      TextField(
                                                                          controller: controllers[index],
                                                                          keyboardType: keytypes[index])
                                                                    ],
                                                                  ),
                                                                );
                                                              }
                                                          ),
                                                          Row(
                                                            mainAxisSize: MainAxisSize.min,
                                                            children: [
                                                              IconButton(
                                                                  onPressed: () {
                                                                    thissetState(() {
                                                                      steps.removeLast();
                                                                    });
                                                                  },
                                                                  icon: Icon(Icons.remove)
                                                              ),
                                                              Padding(
                                                                padding: const EdgeInsets.all(8.0),
                                                                child: const Text("Steps"),
                                                              ),
                                                              IconButton(
                                                                  onPressed: () {
                                                                    SCSVscroller.animateTo(SCSVscroller.position.maxScrollExtent, duration: Duration(milliseconds: 500), curve: Curves.easeIn);
                                                                    thissetState(() {
                                                                      steps.add(TextEditingController());
                                                                    });
                                                                  },
                                                                  icon: Icon(Icons.add)
                                                              ),
                                                            ],
                                                          ),
                                                          ListView.builder(
                                                              shrinkWrap: true,
                                                              controller: ScrollController(),
                                                              itemCount: steps.length,
                                                              itemBuilder: (context,index){
                                                                return Padding(
                                                                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                                                                  child: Card(
                                                                    child: Column(
                                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                                      children: [
                                                                        Text("step ${index + 1}"),
                                                                        TextField(
                                                                          controller: steps[index],
                                                                          textInputAction: TextInputAction.next,
                                                                        )
                                                                      ],
                                                                    ),
                                                                  ),
                                                                );
                                                              }
                                                          ),
                                                        ],
                                                      )
                                                  ),
                                                ),
                                                actions: [
                                                  TextButton(
                                                      onPressed: (){
                                                        setState(() {
                                                          exerciseinstructions_list[index] = ExcerciseInstructions().fill(
                                                              controllers[0].text,
                                                              "null",
                                                              int.parse(controllers[2].text),
                                                              controllers[1].text,
                                                              steps.map((e) => e.text).toList()
                                                          );
                                                        });
                                                        Navigator.pop(context);
                                                      },
                                                      child: Text("OK")
                                                  )
                                                ],
                                              );
                                          });
                                    });
                              },
                              child: Card(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text("Workout name: ${exerciseinstructions_list[index].name}"),
                                      Text("Steps: ${exerciseinstructions_list[index].instructions.length}"),
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
                    var equipments = <String>[];
                    if (allItemsControllers.isNotEmpty) {
                      for (final item in allItemsControllers) {
                        equipments.add(item.text);
                      }
                    }

                    FirebaseFirestore.instance
                        .collection('workoutPlans') //collection
                        .doc() //document name
                        .set(
                        WorkoutData(
                            selectedWorkoutCategory,
                            selectedWorkoutPurpose,
                            selectedWorkoutDifficulty,
                            workoutPlanName.text,
                            workoutDescriptions.text,
                            workoutDaysOfThePlan.text,
                            workoutDaysOfThePlan.text,
                            workoutCalories.text,
                            equipments,
                            [...exerciseinstructions_list.map((e) => e.toMap())]
                        ).toMap()
                    );

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

  WorkoutData(this.workoutCategory,
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

  ExcerciseInstructions fill(String name, String videolink, int countings, String descriptions,List<String> instructions) {
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

  BigTextField({required this.controller, required this.hintText});

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

class TextfieldContainer extends StatefulWidget {
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final String hitText;
  final IconData? icon;
  final String? imagePath;
  final Widget? rightIcon;
  final bool obscureText;
  final EdgeInsets? margin;

  const TextfieldContainer({
    Key? key,
    required this.hitText,
    this.icon,
    this.rightIcon,
    required this.obscureText,
    this.margin,
    this.controller,
    this.keyboardType,
    this.imagePath,
    required Null Function(dynamic newItem) onItemAdded,
  }) : super(key: key);

  @override
  State<TextfieldContainer> createState() => _TextfieldContainerState();
}

class _TextfieldContainerState extends State<TextfieldContainer> {
  @override
  Widget build(BuildContext context) {
    Widget? prefixIcon;
    if (widget.icon != null) {
      prefixIcon = Icon(widget.icon);
    } else if (widget.imagePath != null) {
      prefixIcon =
          Image.asset(widget.imagePath!, scale: 10, fit: BoxFit.scaleDown);
    }

    return Container(
      decoration: BoxDecoration(
        color: Styles.boxtextField,
        borderRadius: BorderRadius.circular(15),
      ),
      child: TextField(
        controller: widget.controller,
        keyboardType: widget.keyboardType,
        obscureText: widget.obscureText,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.only(top: 15),
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
          prefixIcon: prefixIcon,
          suffixIcon: widget.rightIcon,
          hintText: widget.hitText,
          hintStyle: TextStyle(
            color: Styles.fadeTextColor,
          ),
        ),
      ),
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
