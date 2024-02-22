import 'package:fluentui_icons/fluentui_icons.dart';
import 'package:flutter/material.dart';
import 'package:ifit/common/utils/app_styles.dart';
import 'package:ifit/models/workout.dart';
import 'package:ifit/service/functions/dialog.dart';
import 'package:ifit/service/workout.dart';
import 'package:ifit/views/screens/clients_main_screens/program_tracker_screens/workout_screens/workout_details.dart';
import 'package:ifit/views/widgets/button/main_button.dart';
import 'package:ifit/views/widgets/button/ongoing_row.dart';
import 'package:provider/provider.dart';

class OngoingProgramScreen extends StatelessWidget {
  const OngoingProgramScreen({
    required this.workoutPlanList,
    required this.id,
    super.key,
  });

  final List<WorkoutPlan> workoutPlanList;
  final String id;

  @override
  Widget build(BuildContext context) {

    final WorkoutProvider workoutProvider = Provider.of<WorkoutProvider>(context);
    final DialogService dialog = DialogService();

    return Scaffold(
      backgroundColor: Styles.bgColor,
      appBar: AppBar(
        title: const Text("Ongoing Programs"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          /// TODO: REVERT SEARCH TEXTFIELD
          // Padding(
          //   padding: const EdgeInsets.symmetric(vertical:10, horizontal: 5),
          //   child: Container(
          //     height: 35,
          //     width: double.maxFinite,
          //     decoration: BoxDecoration(
          //         color: Colors.grey.shade200,
          //         borderRadius: BorderRadius.circular(10)),
          //     alignment: Alignment.center,
          //     child: SearchContainer(controller: txtSearch, hintText: "Search")
          //   ),
          // ),
          workoutPlanList.isEmpty
              ? _buildEmptyData()
              : _buildOngoingData(workoutProvider)
        ],
      )
    );
  }

  Widget _buildEmptyData() {
    return const Center(
      child: Text("No ongoing programs available."),
    );
  }

  Widget _buildOngoingData(WorkoutProvider workoutProvider) {
    final DialogService dialog = DialogService();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: SizedBox(
        child: ListView.builder(
          padding: EdgeInsets.zero,
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: workoutPlanList.length,
          itemBuilder: (context, index) {
            final WorkoutPlan item = workoutPlanList[index];

            return InkWell(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(
                    builder: (context) =>
                      WorkoutDetails(
                        dObj: item,
                        id: id,
                    ),
                  ),
                );
              },
              child: OngoingRow(
                image: item.workoutPicture,
                title: item.planName,
                bottomText: "${item.minutes} minutes | ${item.calories} Calories",
                progress: item.dayCountFinished == null
                    ? 0
                    : (int.parse(item.daysOfThePlan) - item.dayCountFinished!) * 0.01,
                progressText: item.daysOfThePlan,
                icon: FluentSystemIcons.ic_fluent_more_vertical_regular,
                showToggleSwitch: false,
                onPressed: () async {
                },
                leading: SizedBox(
                  height: 30,
                  width: 78,
                  child: MainButton(
                    title: "Cancel",
                    textStyle: Styles.seeMore.copyWith(
                      color: Colors.white,),
                    buttonColor: Styles.secondColor,
                    onPressed: () {
                      dialog.confirmationDialog(context,
                          onPressed: () async {
                            await workoutProvider.cancelWorkout(
                              id: id,
                              workoutPlan: item,
                            );
                          }
                      );
                    },
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
