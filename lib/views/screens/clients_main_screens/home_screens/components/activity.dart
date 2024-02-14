import 'package:dotted_dashed_line/dotted_dashed_line.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:ifit/common/utils/app_styles.dart';
import 'package:ifit/common/widgets/icon_text_icon.dart';
import 'package:ifit/models/schedule.dart';
import 'package:ifit/views/screens/clients_main_screens/program_tracker_screens/program_schedule/program_schedule.dart';
import 'package:simple_animation_progress_bar/simple_animation_progress_bar.dart';

class ActivityTodayWidget extends StatelessWidget {
  const ActivityTodayWidget({
    required this.schedArr,
    super.key,
  });

  final List<Schedule> schedArr;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          //Schedule Container
          child: Container(
            height: 315,
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
              boxShadow: const [
                BoxShadow(color: Colors.black26, blurRadius: 2)
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                NextNavigation(
                  title: 'Schedule',
                  nextIconColor: Styles.fadeTextColor,
                  titleTextStyle: Styles.text15bold.copyWith(
                    color: Styles.fadeTextColor,
                  ),
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const MealSched(),
                    ));
                  },
                ),
                Text(
                  "Monday",
                  style: Styles.seeMore.copyWith(
                    color: Styles.secondColor.withOpacity(0.5),
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const Gap(5),
                Row(
                  //text at Schedule
                  children: [
                    SimpleAnimationProgressBar(
                      height: 235,
                      width: 20,
                      backgroundColor: Colors.grey.shade200,
                      foregrondColor: Colors.white,
                      ratio: 0.8, //1 is 100%
                      direction: Axis.vertical,
                      curve: Curves.fastLinearToSlowEaseIn,
                      duration: const Duration(seconds: 3),
                      borderRadius: BorderRadius.circular(15),
                      gradientColor: LinearGradient(
                        colors: [
                          Styles.secondColor.withOpacity(0.5),
                          Styles.secondColor
                        ],
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter),
                    ),
                    const Gap(10),
                    _buildGraph(),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildGraph() {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Gap(2),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: schedArr.map((Schedule wObj) {
              //schedule content
              final isLast = wObj == schedArr.last;

              return Row(
                crossAxisAlignment:
                CrossAxisAlignment.start,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: 10,
                        height: 10,
                        decoration: BoxDecoration(
                          color: Styles.secondColor.withOpacity(0.5),
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                      Visibility(
                        visible: !isLast,
                        child: DottedDashedLine(
                          height: 40,
                          width: 0,
                          dashColor: Styles.secondColor.withOpacity(0.5),
                          axis: Axis.vertical,
                        ),
                      )
                    ],
                  ),
                  const Gap(5), //gap between text and line
                  Column(
                    mainAxisAlignment:
                    MainAxisAlignment.start,
                    crossAxisAlignment:
                    CrossAxisAlignment.start,
                    children: [
                      //waterArry
                      Text(
                        wObj.title.toString(),
                        style: Styles.normal.copyWith(
                          fontSize: 12,
                          color: Styles.fadeTextColor,
                        ),
                      ),
                      Text(
                        wObj.subtitle.toString(),
                        style: Styles.normal.copyWith(
                          fontSize: 12,
                          color: Styles.secondColor.withOpacity(0.5),
                        ),
                      ),
                    ],
                  )
                ],
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
