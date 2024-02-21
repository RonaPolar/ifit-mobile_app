import 'package:flutter/material.dart';
import 'package:ifit/common/utils/app_styles.dart';
import 'package:ifit/models/workout.dart';
import 'package:ifit/views/screens/clients_main_screens/program_tracker_screens/workout_screens/workout_details.dart';
import 'package:ifit/views/widgets/program_widgets.dart';

class FinishedProgramScreen extends StatelessWidget {
  const FinishedProgramScreen({
    required this.workoutPlan,
    required this.id,
    super.key,
  });

  final List<WorkoutPlan> workoutPlan;
  final String id;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Styles.bgColor,
        appBar: AppBar(
          title: Text("Finished Programs"),
          centerTitle: true,
        ),
      body: Column(
        children: [
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
          workoutPlan.isEmpty
              ? _buildEmptyData()
              : _buildFinishedData()
        ],
      )
    );
  }

  Widget _buildEmptyData() {
    return const Center(
      child: Text("No finished programs available."),
    );
  }

  Widget _buildFinishedData() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: SizedBox(
        child: ListView.builder(
          padding: EdgeInsets.zero,
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: workoutPlan.length,
          itemBuilder: (context, index) {
            var item = workoutPlan[index];

            return InkWell(
              onTap: () {
                Navigator.push(context,
                  MaterialPageRoute(
                    builder: (context) =>
                        WorkoutDetails(
                          dObj: item,
                          id: id,
                        ),
                  ),
                );
              },
              child: ProgramRow(
                image: item.workoutPicture,
                title: item.planName,
                bottomText: "${item.minutes} minutes | ${item.calories} Calories",
                showToggleSwitch: false,
              ),
            );
          },
        ),
      ),
    );
  }
}