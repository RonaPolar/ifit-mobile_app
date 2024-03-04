import 'package:flutter/material.dart';
import 'package:ifit/common/utils/app_styles.dart';
import 'package:ifit/models/workout.dart';
import 'package:ifit/service/workout.dart';
import 'package:ifit/views/screens/clients_main_screens/program_tracker_screens/workout_screens/workout_details.dart';
import 'package:ifit/views/widgets/button/main_button.dart';
import 'package:provider/provider.dart';

class CancelledProgramScreen extends StatefulWidget {
  const CancelledProgramScreen({
    super.key,
    required this.workoutPlanList,
    required this.id,
    required this.scaffoldKey,
  });

  final List<WorkoutPlan> workoutPlanList;
  final String id;
  final GlobalKey<ScaffoldState> scaffoldKey;

  @override
  State<CancelledProgramScreen> createState() => _CancelledProgramScreenState();
}

class _CancelledProgramScreenState extends State<CancelledProgramScreen> {

  @override
  Widget build(BuildContext context) {
    final WorkoutProvider workoutProvider = Provider.of<WorkoutProvider>(context);

    return Scaffold(
      backgroundColor: Styles.bgColor,
      appBar: AppBar(
        title: Text("Cancelled Programs"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: SizedBox(
              child: ListView.builder(
                padding: EdgeInsets.zero,
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: widget.workoutPlanList.length,
                itemBuilder: (context, index) {
                  final WorkoutPlan item = widget.workoutPlanList[index];
                    return InkWell(
                      onTap: () {
                        Navigator.push(context,
                          MaterialPageRoute(
                            builder: (context) =>
                              WorkoutDetails(
                                dObj: item,
                                id: widget.id,
                              ),
                          ),
                        );
                      },
                      child: CancelledRow(
                        image: item.workoutPicture,
                        title: item.planName,
                        bottomText: "${item.minutes} minutes | ${item.calories} Calories",
                        onPressed: () async {
                          await workoutProvider.cancelWorkout(
                            id: widget.id,
                            workoutPlan: item,
                          ).then((value) {
                            Navigator.of(widget.scaffoldKey.currentContext!).pop();
                            ScaffoldMessenger.of(widget.scaffoldKey.currentContext!).showSnackBar(SnackBar(
                                content: Text("Restored: ${item.planName}")));

                          });
                        },
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      )
    );
  }
}



class CancelledRow extends StatefulWidget {
  final String image;
  final String title;
  final String bottomText;
  final Function() onPressed;

  const CancelledRow({
    super.key,
    required this.image,
    required this.title,
    required this.bottomText,
    required this.onPressed,
  });

  @override
  State<CancelledRow> createState() => _CancelledRowState();
}

class _CancelledRowState extends State<CancelledRow> {
  @override
  Widget build(BuildContext context) {

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 2),
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
      decoration: BoxDecoration(
        color: Styles.bgColor,
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [BoxShadow(color: Colors.black26, blurRadius: 2)],
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(30),
            child: Container(
              width: 60,
              height: 60,
              color: Styles.secondColor.withOpacity(0.6),
              child: Image.network(widget.image,
                fit: BoxFit.contain,
              ),
            ),
          ),
          const SizedBox(
            width: 15,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(widget.title, style: Styles.text15bold),
                Text(
                  widget.bottomText,
                  style: Styles.normal.copyWith(
                    fontSize: 12,
                  ),
                ),
                const SizedBox(
                  height: 4,
                ),
                // Removed the progress bar code here
              ],
            ),
          ),
          SizedBox(
            height: 40,
            width: 80,
            child: MainButton(
              title: "Start Again",
              textStyle: Styles.seeMore.copyWith(
              color: Colors.white,
            ),
              buttonColor: Styles.secondColor,
              onPressed: widget.onPressed,
            ),
          )
        ],
      ),
    );
  }
}
