import 'package:fluentui_icons/fluentui_icons.dart';
import 'package:flutter/material.dart';
import 'package:ifit/common/utils/app_styles.dart';
import 'package:ifit/models/meal.dart';
import 'package:ifit/models/workout.dart';
import 'package:ifit/service/Expert.dart';
import 'package:ifit/service/client.dart';
import 'package:ifit/service/functions/dialog.dart';
import 'package:ifit/service/workout.dart';
import 'package:ifit/views/screens/clients_main_screens/program_tracker_screens/workout_screens/workout_details.dart';
import 'package:ifit/views/widgets/body/stream.dart';
import 'package:ifit/views/widgets/button/main_button.dart';
import 'package:ifit/views/widgets/button/ongoing_row.dart';
import 'package:provider/provider.dart';

class StatusProgramScreen extends StatefulWidget {
  const StatusProgramScreen({
    required this.id,
    super.key,
  });

  final String id;

  @override
  State<StatusProgramScreen> createState() => _StatusProgramScreenState();
}

class _StatusProgramScreenState extends State<StatusProgramScreen> {

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final ClientProvider clientProvider = Provider.of<ClientProvider>(context, listen: false);
      clientProvider.updateClientWorkoutMealListStream(uid: widget.id);
      clientProvider.updateClientWorkoutPlanListStream(uid: widget.id);
    });
  }

  @override
  Widget build(BuildContext context) {
    final ClientProvider clientProvider = Provider.of<ClientProvider>(context);

    final WorkoutProvider workoutProvider = Provider.of<WorkoutProvider>(context);
    final ExpertProvider expertProvider = Provider.of<ExpertProvider>(context);
    final DialogService dialog = DialogService();

    return Scaffold(
        backgroundColor: Styles.bgColor,
        appBar: AppBar(
          title: const Text("Ongoing Programs"),
          centerTitle: true,
        ),
        body: StreamWrapper<List<WorkoutPlan>>(
          stream: expertProvider.workoutPlanListStream,
          child: (data) {
            final List<WorkoutPlan> workoutPlans = data!;

            return StreamWrapper<List<WorkoutMeal>>(
              stream: expertProvider.workoutMealListStream,
              child: (data) {
                final List<WorkoutMeal> workoutMeals = data!;

                return Column(
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
                    workoutPlans.isEmpty
                        ? _buildEmptyData()
                        : _buildOngoingData(workoutProvider, workoutPlans)
                  ],
                );
              }
            );
          }
        )
    );
  }

  Widget _buildEmptyData() {
    return const Center(
      child: Text("No ongoing programs available."),
    );
  }

  Widget _buildOngoingData(WorkoutProvider workoutProvider,
      List<WorkoutPlan> workoutPlans) {
    final DialogService dialog = DialogService();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: SizedBox(
        child: ListView.builder(
          padding: EdgeInsets.zero,
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: workoutPlans.length,
          itemBuilder: (context, index) {
            final WorkoutPlan item = workoutPlans[index];

            return InkWell(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) =>
                      WorkoutDetails(
                        dObj: item,
                        id: widget.id,
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
                              id: widget.id,
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
