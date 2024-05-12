import 'package:fluentui_icons/fluentui_icons.dart';
import 'package:flutter/material.dart';
import 'package:ifit/common/utils/app_styles.dart';
import 'package:ifit/models/workout.dart';
import 'package:ifit/service/client.dart';
import 'package:ifit/service/functions/dialog.dart';
import 'package:ifit/service/workout.dart';
import 'package:ifit/views/screens/clients_main_screens/program_tracker_screens/workout_screens/workout_details.dart';
import 'package:ifit/views/widgets/body/stream.dart';
import 'package:ifit/views/widgets/button/main_button.dart';
import 'package:ifit/views/widgets/button/ongoing_row.dart';
import 'package:provider/provider.dart';

class OngoingProgramScreen extends StatefulWidget {
  const OngoingProgramScreen({
    required this.workoutPlanList,
    required this.id,
    required this.scaffoldKey,
    super.key,
  });

  final List<WorkoutPlan> workoutPlanList;
  final String id;
  final GlobalKey<ScaffoldState> scaffoldKey;

  @override
  State<OngoingProgramScreen> createState() => _OngoingProgramScreenState();
}

class _OngoingProgramScreenState extends State<OngoingProgramScreen> {

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      final ClientProvider clientProvider = Provider.of<ClientProvider>(context, listen: false);
      clientProvider.updateClientWorkoutPlanListStream(uid: widget.id);
    });
  }

  @override
  Widget build(BuildContext context) {

    final WorkoutProvider workoutProvider = Provider.of<WorkoutProvider>(context);
    final ClientProvider clientProvider = Provider.of<ClientProvider>(context);

    return Scaffold(
      backgroundColor: Styles.bgColor,
      appBar: AppBar(
        title: const Text("Ongoing Programs"),
        centerTitle: true,
      ),
      body: StreamWrapper<List<WorkoutPlan>>(
        stream: clientProvider.clientWorkoutPlanListStream,
        child: (data) {

          final List<WorkoutPlan> ongoingWorkoutPlan = data!.where((element) {
            final bool isCompleted = (int.parse(element.daysOfThePlan) <= element.dayCountFinished);

            return !element.isCancelled && !isCompleted;
          }).toList();

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
              widget.workoutPlanList.isEmpty
                  ? _buildEmptyData()
                  : _buildOngoingData(workoutProvider, ongoingWorkoutPlan)
            ],
          );
        }
      ),
    );
  }

  Widget _buildEmptyData() {
    return const Center(
      child: Text("No ongoing programs available."),
    );
  }

  Widget _buildOngoingData(WorkoutProvider workoutProvider, List<WorkoutPlan> workoutPlan) {
    final DialogService dialog = DialogService();


    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: SizedBox(
        child: ListView.builder(
          padding: EdgeInsets.zero,
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: workoutPlan.length,
          itemBuilder: (context, index) {
            final WorkoutPlan item = workoutPlan[index];

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
                progress: 1 - ((int.parse(item.daysOfThePlan)
                    - item.dayCountFinished) / double.parse(item.daysOfThePlan)),
                progressText: item.daysOfThePlan,
                icon: FluentSystemIcons.ic_fluent_more_vertical_regular,
                showToggleSwitch: false,
                onPressed: () async {},
                leading: SizedBox(
                  height: 30,
                  width: 78,
                  child: MainButton(
                    title: "Cancel",
                    textStyle: Styles.seeMore.copyWith(
                      color: Colors.white,
                    ),
                    buttonColor: Styles.secondColor,
                    onPressed: () {
                      dialog.confirmationDialog(widget.scaffoldKey.currentContext!,
                          onPressed: () async {
                            await workoutProvider.cancelWorkout(
                              id: widget.id,
                              workoutPlan: item,
                            ).then((value) {
                              Navigator.of(widget.scaffoldKey.currentContext!).pop();
                              ScaffoldMessenger.of(widget.scaffoldKey.currentContext!).showSnackBar(SnackBar(
                                content: Text("Cancelled: ${item.planName}")));
                            });
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
