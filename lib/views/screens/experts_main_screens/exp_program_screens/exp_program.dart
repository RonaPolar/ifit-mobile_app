import 'package:fl_chart/fl_chart.dart';
import 'package:fluentui_icons/fluentui_icons.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:ifit/common/utils/app_styles.dart';
import 'package:ifit/models/client.dart';
import 'package:ifit/models/expert.dart';
import 'package:ifit/models/meal.dart';
import 'package:ifit/models/workout.dart';
import 'package:ifit/service/auth.dart';
import 'package:ifit/service/functions/dialog.dart';
import 'package:ifit/views/screens/Experts_main_screens/exp_program_screens/create_program_screens/create_meal.dart';
import 'package:ifit/views/screens/Experts_main_screens/exp_program_screens/create_program_screens/create_work.dart';
import 'package:ifit/views/screens/Experts_main_screens/exp_discover_screens/my_programs/exp_my_programs.dart';
import 'package:ifit/views/screens/experts_main_screens/exp_discover_screens/components/meal_details.dart';
import 'package:ifit/views/screens/experts_main_screens/exp_discover_screens/components/workout_details.dart';
import 'package:ifit/views/screens/experts_main_screens/exp_program_screens/category.dart';
import 'package:ifit/views/widgets/program_widgets.dart';
import 'package:provider/provider.dart';

class ExpProgramScreen extends StatefulWidget {
  const ExpProgramScreen({
    required this.expertModel,
    required this.clientList,
    required this.workoutPlanList,
    required this.workoutMealList,
    super.key,
  });

  final ExpertModel expertModel;
  final List<ClientModel> clientList;
  final List<WorkoutPlan> workoutPlanList;
  final List<WorkoutMeal> workoutMealList;

  @override
  State<ExpProgramScreen> createState() => _ExpProgramScreenState();
}

class _ExpProgramScreenState extends State<ExpProgramScreen> {

  
  @override
  Widget build(BuildContext context) {
    final ExpertModel expert = widget.expertModel;
    final DialogService dialog = DialogService();
    final Auth auth = Provider.of<Auth>(context);

    final List combinedList = [...widget.workoutMealList, ...widget.workoutPlanList];



    return Scaffold(
      backgroundColor: Styles.bgColor,
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: Text(
          'Program Progress',
          style: Styles.headline20,
        ),
        actions: [
          InkWell(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => ExpCreatedProgram(
                    workoutMealList: widget.workoutMealList,
                    workoutPlanList: widget.workoutPlanList,
                  )));
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
                FluentSystemIcons.ic_fluent_person_regular,
                size: 20,
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                children: [
                  Center(
                    child: CircleAvatar(
                      radius: MediaQuery.of(context).size.width * 0.25,
                      child: Text("${widget.clientList.length} total clients",
                        style: Styles.headline25,
                      ),
                    ),
                  ),
                ],
              ),
        
              const Gap(20),
              Text(
                "Workout Plans Created",
                style: Styles.title,
              ),
              ListView.builder(
                padding: EdgeInsets.zero,
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: widget.workoutPlanList.length,
                itemBuilder: (context, index) {
                  var item = widget.workoutPlanList[index];
        
                  return InkWell(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(
                        builder: (context) => ExpertWorkoutDetails(
                          dObj: item,
                          clientWorkoutPlan: item,
                        ),
                      ));
                    },
                    child: ProgramRow(
                      image: item.workoutPicture,
                      title: item.planName,
                      bottomText: "${item.minutes} minutes | ${item.calories} Calories",
                      showToggleSwitch: false,
                      )
                    );
                },
              ),
        
              const Gap(20),
              Text(
                "Workout Meals Created",
                style: Styles.title,
              ),
              ListView.builder(
                padding: EdgeInsets.zero,
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: widget.workoutMealList.length,
                itemBuilder: (context, index) {
                  var item = widget.workoutMealList[index];
        
                  return InkWell(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(
                            builder: (context) => ExpertMealDetails(
                              workoutMeal: item,
                            )),
                        );
                      },
                      child: ProgramRow(
                        image: item.foodPhoto,
                        title: item.foodPlanName,
                        bottomText: "${item.purpose} | ${item.calories} Calories",
                        showToggleSwitch: false,
                      )
                  );
                },
              ),
              Text(
                "Category",
                style: Styles.title,
              ),
              ListView.builder(
                padding: EdgeInsets.zero,
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: auth.fitnessGoalList.length,
                itemBuilder: (context, index) {
                  final String item = auth.fitnessGoalList[index];
                  final List<String> imageList = [
                    "assets/icons/workout-pic.png",
                    "assets/icons/Upper-Weights.png",
                    "assets/icons/Ab-workout.png",
                  ];

                  List programList() {
                    return combinedList.where((element) {
                      if (element is WorkoutPlan) {
                        return element.purpose == item;
                      } else if (element is WorkoutMeal) {
                        return element.purpose == item;
                      } else {
                        return false;
                      }
                    }).toList();
                  }

                  print(programList());
        
                  return InkWell(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(
                            builder: (context) =>
                              ExpertCategoryScreen(
                                combinedList: programList(),
                                category: item,
                              ),
                          ),
                        );
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 12.0),
                        margin: const EdgeInsets.symmetric(vertical: 4.0),
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        child: ListTile(
                          title: Text(item,
                            style: Styles.title,
                          ),
                          subtitle: Text("${programList().length} programs",
                            style: Styles.normal.copyWith(
                              color: Colors.white,
                            ),
                          ),
                          trailing: CircleAvatar(
                            radius: 40,
                            backgroundColor: Colors.white,
                            child: Image.asset(
                              imageList[index],
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                  );
                },
              ),
            ],
          ),
        ),
      ),

      floatingActionButton: FloatingActionButton(
        backgroundColor: Styles.primaryColor,
        onPressed: () {
          dialog.showCreateProgram(context,
            createWorkout: () => Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => CreateWorkout(id: expert.uid))),
            createMeal: () => Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => CreateMeal(id: expert.uid))),
          );
        },
        child: const Icon(Icons.add, color: Colors.white, size: 28),
      ),
    );
  }
}
