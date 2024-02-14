import 'package:fluentui_icons/fluentui_icons.dart';
import 'package:flutter/material.dart';
import 'package:ifit/common/utils/app_styles.dart';
import 'package:ifit/common/widgets/more_icon.dart';

class ActivityTracker extends StatefulWidget {
  const ActivityTracker({super.key});

  @override
  State<ActivityTracker> createState() => _ActivityTrackerState();
}

class _ActivityTrackerState extends State<ActivityTracker> {
  int touchedIndex = -1;

  List actHistoryArr = [
    {
      "image": "assets/images/meal/nigiri.png",
      "title": "Eat lunch",
      "time": "About 1 minutes ago"
    },
    {
      "image": "assets/icons/Lower-Weights.png",
      "title": "You have finished the Lowerbody Weights",
      "time": "About 3 hours ago"
    },
    {
      "image": "assets/images/meal/salad.png",
      "title": "Eat dinner",
      "time": "About 3 hours ago"
    },
    {
      "image": "assets/icons/workout-pic.png",
      "title": "You have completed the 15 days Full Bo...",
      "time": "29 May"
    },
    {
      "image": "assets/images/meal/pancake.png",
      "title": "You added Pancake to your desserts",
      "time": "8 April"
    },
    {
      "image": "assets/icons/Ab-workout.png",
      "title": "You removed Ab Workout to your Favorites",
      "time": "8 April"
    },
  ];

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
              Navigator.pop(context);
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
                FluentSystemIcons.ic_fluent_chevron_left_filled,
                size: 20,
                color: Colors.black,
              ),
            ),
          ),
          title: Text(
            'Activity History',
            style: Styles.headline20,
          ),
        ),
        body: ListView(
          children: [
            Container(
              padding: const EdgeInsets.all(15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ListView.builder(
                    // WorkoutRowContainer Content
                    padding: EdgeInsets.zero,
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: actHistoryArr.length,
                    itemBuilder: (context, index) {
                      var actObj = actHistoryArr[index];
                      return ActivityHistoryRow(actObj: actObj);
                    },
                  ),

                ], //Main Children
              ),
            ),
          ],
        ));
  }
}



class ActivityHistoryRow extends StatelessWidget {
  final Map actObj;
  const ActivityHistoryRow({super.key, required this.actObj});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(30),
            child: Image.asset(
              actObj["image"].toString(),
              width: 40,
              height: 40,
              fit: BoxFit.contain,
            ),
          ),
          const SizedBox(
            width: 15,
          ),
          Expanded(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                actObj["title"].toString(),
                style: Styles.text12
                    .copyWith(fontWeight: FontWeight.bold),
              ),
              Text(
                actObj["time"].toString(),
                style: const TextStyle(
                  fontSize: 12,
                  color: Colors.grey,
                ),
              ),
            ],
          )),
          const MoreIcon(
            options: ['Remove'],
            iconData: FluentSystemIcons.ic_fluent_more_vertical_filled,
          )
        ],
      ),
    );
  }
}

