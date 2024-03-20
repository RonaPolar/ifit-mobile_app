
import 'package:fluentui_icons/fluentui_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:ifit/common/utils/app_styles.dart';
import 'package:ifit/common/utils/common_utils.dart';
import 'package:ifit/models/meal.dart';
import 'package:ifit/models/workout.dart';
import 'package:ifit/service/notification.dart';
import 'package:ifit/views/screens/account_login_reg/register/client_registration/register_part2.dart';
import 'package:ifit/views/widgets/button/main_button.dart';
import 'package:provider/provider.dart';


class AddSchedule extends StatefulWidget {
  const AddSchedule({
    required this.workoutThing,
    super.key,
  });

  final dynamic workoutThing;

  @override
  State<AddSchedule> createState() => _AddScheduleState();
}

class _AddScheduleState extends State<AddSchedule> {

  String programName() {
    if (widget.workoutThing is WorkoutPlan) {
      final item = widget.workoutThing as WorkoutPlan;
      return item.planName;
    } else if (widget.workoutThing is WorkoutMeal) {
      final item = widget.workoutThing as WorkoutMeal;
      return item.foodPlanName;
    }
    return "";
  }

  num dateFinished() {
    if (widget.workoutThing is WorkoutPlan) {
      final item = widget.workoutThing as WorkoutPlan;
      return item.dayCountFinished;
    }
    return 0;
  }

  num daysOfThePlan() {
    if (widget.workoutThing is WorkoutPlan) {
      final item = widget.workoutThing as WorkoutPlan;
      return num.parse(item.daysOfThePlan);
    }
    return 0;
  }

  final List<String> scheduleList = [
    "Daily",
    "Every Monday",
    "Every Tuesday",
    "Every Wednesday",
    "Every Thursday",
    "Every Friday",
    "Every Saturday",
    "Every Sunday",
  ];

  @override
  Widget build(BuildContext context) {
    final DateTime now = DateTime.now();
    final FirebaseNotif firebaseNotif = Provider.of<FirebaseNotif>(context);

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
              Icons.close,
              size: 20,
              color: Colors.black,
            ),
          ),
        ),
        title: Text(
          'Add Schedule',
          style: Styles.headline20,
        ),
      ),
      body: Scaffold(
        backgroundColor: Styles.bgColor,
        body: Container(
          padding: const EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: 
                  ListView(
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.calendar_month_outlined,
                            color: Styles.fadeTextColor,
                            size: 25,
                          ),
                          const Gap(5),
                          Text(
                            dateToString(now, formatStr: "E, dd MMMM yyyy"),
                            style: Styles.normal.copyWith(
                              fontSize: 18
                              ),
                          )
                        ],
                      ),
                   
            
                  const Gap(30),
                  Text(
                    'Time',
                    style: Styles.title
                  ),
                  SizedBox(
                    height: 85,
                    child: CupertinoDatePicker(
                      onDateTimeChanged: firebaseNotif.updateTime,
                      initialDateTime: DateTime.now(),
                      use24hFormat: true,
                      minuteInterval: 1,
                      mode: CupertinoDatePickerMode.time,
                    ),
                  ),
                  const SizedBox(height: 30.0),
                  RegisterDropDown(
                    hintText: 'Schedule',
                    icon: FluentSystemIcons.ic_fluent_access_time_filled,
                    items: scheduleList.map((data) {
                      return  DropdownMenuItem<String>(
                        value: data,
                        child: Text(data),
                      );
                    }).toList(),
                    onChanged: firebaseNotif.updateSchedule,
                    selectedValue: firebaseNotif.schedule,
                  ),
                  const Gap(15),
                  // Container(
                  //   padding: const EdgeInsets.symmetric(
                  //       vertical: 15, horizontal: 20),
                  //   decoration: BoxDecoration(
                  //     color: Colors.grey.withOpacity(0.2),
                  //     borderRadius: BorderRadius.circular(15),
                  //   ),
                  //   child: NextNavigation(
                  //     title: "Select Days",
                  //     iconData: Icons.calendar_today_outlined,
                  //     onTap: () {
                  //
                  //     }),
                  // ),
                  const Gap(30),
                  Text('Program Details',
                    style: Styles.title
                  ),
                  const Gap(15),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 15, horizontal: 20),
                    decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.work),
                        const SizedBox(width: 4.0),
                        Text(programName()),
                      ],
                    ),
                  ),
                 ],
                ),
              ),
              MainButton(
                title: 'Cancel Notification',
                onPressed: () {
                  FirebaseNotif.cancelAll();
                  Navigator.of(context).pop();
                  firebaseNotif.clearSchedule();
                },
              ),
              const Gap(20.0),
              MainButton(
                title: 'Save',
                onPressed: () {
                  firebaseNotif.showScheduledNotification(
                    title: programName(),
                    body: "Let's workout!", payload: programName(),
                    dateFinished: dateFinished().toInt(),
                    daysOfThePlan: daysOfThePlan().toInt(),
                    day: scheduleList.indexOf(firebaseNotif.schedule!),
                  );
                  Navigator.of(context).pop();
                  firebaseNotif.clearSchedule();
                },
              ),
            ], //main Children
          ),
        ),
      ),
    );
  }
}
