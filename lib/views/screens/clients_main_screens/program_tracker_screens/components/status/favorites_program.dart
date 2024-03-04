import 'package:fluentui_icons/fluentui_icons.dart';
import 'package:flutter/material.dart';
import 'package:ifit/common/utils/app_styles.dart';
import 'package:ifit/models/meal.dart';
import 'package:ifit/models/workout.dart';
import 'package:ifit/service/client.dart';
import 'package:ifit/service/functions/dialog.dart';
import 'package:ifit/service/workout.dart';
import 'package:ifit/views/screens/clients_main_screens/program_tracker_screens/meal_screens/meal_details.dart';
import 'package:ifit/views/screens/clients_main_screens/program_tracker_screens/workout_screens/workout_details.dart';
import 'package:ifit/views/widgets/body/stream.dart';
import 'package:ifit/views/widgets/button/ongoing_row.dart';
import 'package:provider/provider.dart';

class FavoriteProgramScreen extends StatefulWidget {
  const FavoriteProgramScreen({
    required this.combinedList,
    required this.id,
    super.key,
  });

  final List<dynamic> combinedList;
  final String id;

  @override
  State<FavoriteProgramScreen> createState() => _FavoriteProgramScreenState();
}

class _FavoriteProgramScreenState extends State<FavoriteProgramScreen> {

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
        title: Text("Favorite Programs"),
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
            widget.combinedList.isEmpty
            ? _buildEmptyData()
                : _buildFavoriteData(workoutProvider),
            ],
          ),
      );
    }

  Widget _buildEmptyData() {
    return const Center(
      child: Text("No favorites programs available."),
    );
  }

  Widget _buildFavoriteData(WorkoutProvider workoutProvider) {
    final DialogService dialog = DialogService();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: SizedBox(
        child: ListView.builder(
          padding: EdgeInsets.zero,
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: widget.combinedList.length,
          itemBuilder: (context, index) {
            final dynamic item = widget.combinedList[index];

            if (item is WorkoutPlan) {
              return InkWell(
                onTap: () {
                  Navigator.push(context,
                    MaterialPageRoute(
                        builder: (context) => WorkoutDetails(
                          dObj: item,
                          id: widget.id,
                        )
                    ),
                  );
                },
                child: OngoingRow(
                  image: item.workoutPicture,
                  title: item.planName,
                  bottomText: "${item.minutes} minutes | ${item.calories} Calories",
                  progressText: item.daysOfThePlan,
                  icon: FluentSystemIcons.ic_fluent_more_vertical_regular,
                  showToggleSwitch: false,
                  onPressed: () async {
                    dialog.confirmationDialog(context,
                        onPressed: () {
                          workoutProvider.cancelWorkout(
                            id: widget.id,
                            workoutPlan: item,
                          );
                        }
                    );
                  },
                  leading: const CircleAvatar(
                    radius: 25,
                    backgroundColor: Colors.red,
                    child: Icon(Icons.favorite,
                      color: Colors.white,
                    ),
                  ),
                ),
              );
            } else {
              final meal = item as WorkoutMeal;

              return InkWell(
                onTap: () {
                  Navigator.push(context,
                    MaterialPageRoute(
                      builder: (context) => MealDetails(
                        workoutMeal: meal,
                        id: widget.id,
                      ),
                    ),
                  );
                },
                child: OngoingRow(
                  image: item.foodPhoto,
                  title: item.foodPlanName,
                  bottomText: "${item.calories} Calories",
                  icon: FluentSystemIcons.ic_fluent_more_vertical_regular,
                  showToggleSwitch: false,
                  onPressed: () async {
                  },
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
