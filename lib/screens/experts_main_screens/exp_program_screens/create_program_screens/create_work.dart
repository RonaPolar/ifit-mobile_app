import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluentui_icons/fluentui_icons.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:ifit/common/utils/app_styles.dart';
import 'package:ifit/common/widgets/confirmation_dialog.dart';
import 'package:ifit/common/widgets/main_button.dart';
import 'package:ifit/common/widgets/text_field_container.dart';
import 'package:ifit/screens/account-login&reg/register/client_registration/register_part2.dart';
import 'package:ifit/screens/experts_main_screens/exp_bottom_bar.dart';
import 'package:ifit/screens/experts_main_screens/exp_program_screens/create_program_screens/create_meal.dart';
import 'package:ifit/screens/experts_main_screens/exp_program_screens/create_program_screens/create_work_next.dart';
import 'package:random_string/random_string.dart';

class CreateWorkout extends StatefulWidget {
  const CreateWorkout({super.key});

  @override
  State<CreateWorkout> createState() => _CreateWorkoutState();
}

class _CreateWorkoutState extends State<CreateWorkout> {
  String customDocId = "";

  Future<String> generateUniqueDocId() async {
    // Reference to your Firestore collection
    CollectionReference<Map<String, dynamic>> collection =
        FirebaseFirestore.instance.collection('your_collection');

    QuerySnapshot<Map<String, dynamic>>
        snapshot; // Declare snapshot outside the loop

    // Generate a unique ID (e.g., using a random string)
    do {
      customDocId =
          randomAlphaNumeric(20); // Change the length according to your needs

      // Check if the generated ID is already in use
      snapshot =
          await collection.where('workoutPlans', isEqualTo: customDocId).get();

      // If the ID is already in use, generate a new one
    } while (snapshot.docs.isNotEmpty);

    return customDocId;
  }

  late TextEditingController _listallitemscontroller;
  List<String> allItems = [];
  List<TextEditingController> allItemsControllers = [];

  @override
  void initState() {
    super.initState();
    // Initialize a new controller for each TextfieldContainer
    allItemsControllers = List.generate(1, (index) => TextEditingController());

    _listallitemscontroller = TextEditingController();

    generateUniqueDocId();
  }

  @override
  void dispose() {
    _listallitemscontroller.dispose();
    super.dispose();
  }

  void displayItems() {
    setState(() {
      _listallitemscontroller.text =
          '[${allItems.map((item) => "'$item'").join(',')}]';
    });
  }

  String? selectedWorkoutCategory;
  String? selectedWorkoutDifficulty;
  String? selectedWorkoutPurpose;
  String? selectedValue;

  final TextEditingController workoutPlanName = TextEditingController();
  final TextEditingController workoutDescriptions = TextEditingController();
  final TextEditingController workoutDaysOfThePlan = TextEditingController();
  final TextEditingController workoutMinutesitTakestoDo =
      TextEditingController();
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
                    Text('${customDocId}'),
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
                        child: BigTextField(
                          controller: workoutDescriptions,
                          hintText: "Descriptions",
                        ),
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
                    AddsubButton(
                      title: 'Items',
                      add: Column(
                        children: [
                          // Use ListView.builder to dynamically generate TextfieldContainer widgets
                          ListView.builder(
                            shrinkWrap: true,
                            itemCount: allItemsControllers.length,
                            itemBuilder: (context, index) {
                              // Create a new TextEditingController for each TextfieldContainer
                              TextEditingController controller =
                                  TextEditingController();
                              allItemsControllers.add(controller);

                              return Column(
                                children: [
                                  TextfieldContainer(
                                    controller: controller,
                                    hitText: 'Equipment with Quantity',
                                    icon: Icons.fitness_center_outlined,
                                    obscureText: false,
                                    onItemAdded: (newItem) {},
                                  )
                                ],
                              );
                            },
                          ),
                        ],
                      ),
                      subtract: Column(),
                      onSubtract: () {
                        allItems.clear();
                        allItemsControllers.removeLast();
                        for (int i = 0; i < allItemsControllers.length; i++) {
                          String newItem = allItemsControllers[i].text;

                          if (newItem != "") {
                            allItems.add(newItem);
                          }
                        }
                        print(allItems);
                      },
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
                    AddsubButton(
                      title: 'Sets',
                      add: Column(
                        children: [
                          const Gap(5),
                          Text(
                            'Input the Exercises to the Set and Click Continue',
                            style: Styles.text15bold,
                          ),
                          const Gap(5),
                          TextfieldContainer(
                            hitText: 'Exercise',
                            icon: Icons.fitness_center_outlined,
                            rightIcon: SizedBox(
                                width: 100,
                                child: MainButton(
                                    title: 'Continue',
                                    textStyle: Styles.text15bold
                                        .copyWith(color: Colors.white),
                                    onPressed: () {
                                      // Navigator.pushReplacement(
                                      //     context,
                                      //     MaterialPageRoute(
                                      //         builder: (context) =>
                                      //             const CreateWorkoutNext()));

                                      showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return Container(
                                              child: Column(
                                                children: [],
                                              ),
                                            );
                                          });
                                    })),
                            obscureText: false,
                            onItemAdded: (newItem) {},
                          ),
                          AddsubButton(
                            title: 'Exercise',
                            add: TextfieldContainer(
                              hitText: 'Exercise',
                              icon: Icons.fitness_center_outlined,
                              rightIcon: SizedBox(
                                  width: 100,
                                  child: MainButton(
                                      title: 'Continue',
                                      textStyle: Styles.text15bold
                                          .copyWith(color: Colors.white),
                                      onPressed: () {
                                        // Navigator.pushReplacement(
                                        //     context,
                                        //     MaterialPageRoute(
                                        //         builder: (context) =>
                                        //             const CreateWorkoutNext()));
                                      })),
                              obscureText: false,
                              onItemAdded: (newItem) {},
                            ),
                            subtract: Column(),
                          ),
                        ],
                      ),
                      subtract: Column(),
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
                    // if (allItems.isEmpty) {
                    //   allItems.removeAt(0);
                    // } else {
                    //   allItems.removeAt(0);
                    // }

                    for (int i = 0; i < allItemsControllers.length; i++) {
                      String newItem = allItemsControllers[i].text;

                      if (newItem != "") {
                        allItems.add(newItem);
                      }
                    }

                    displayItems();

                    FirebaseFirestore.instance
                        .collection('workoutPlans')
                        .doc('UfT2T8SHa0IwVUijW7tS')
                        .set({
                      'workoutCategory': selectedWorkoutCategory,
                      'workoutPurpose': selectedWorkoutPurpose,
                      'workoutDifficulty': selectedWorkoutDifficulty,
                      'workoutPlanName': workoutPlanName.text,
                      'workoutDescriptions': workoutDescriptions.text,
                      'workoutDaysOfThePlan': workoutDaysOfThePlan.text,
                      'workoutMinutesitTakestoDo':
                          workoutMinutesitTakestoDo.text,
                      'workoutCalories': workoutCalories.text,
                      'equipments': FieldValue.arrayUnion(allItems),
                    });
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const ExpPrograms()));
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
