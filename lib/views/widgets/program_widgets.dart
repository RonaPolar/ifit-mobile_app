import 'package:fluentui_icons/fluentui_icons.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:ifit/common/utils/app_styles.dart';
import 'package:ifit/models/workout.dart';
import 'package:ifit/views/widgets/button/main_button.dart';
import 'package:ifit/views/widgets/toggle_switch.dart';
import 'package:simple_animation_progress_bar/simple_animation_progress_bar.dart';


//What To Eat and Train Next - Category
class What2Container extends StatefulWidget {
  final Function() onPressed;
  final String fitnessGoal;
  final List<WorkoutPlan> categoryList;
  final String imageList;

  const What2Container({
    super.key,
    required this.onPressed,
    required this.fitnessGoal,
    required this.categoryList,
    required this.imageList,
  });

  @override
  State<What2Container> createState() => _What2ContainerState();
}

class _What2ContainerState extends State<What2Container> {



  @override
  Widget build(BuildContext context) {
    final String name = widget.fitnessGoal;
    final int workoutNumber = widget.categoryList.length;

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 2),
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
      decoration: BoxDecoration(
        color: Styles.secondColor.withOpacity(0.6),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: Styles.text15bold
                ),
                Text(
                  "$workoutNumber Programs",
                  style: Styles.normal.copyWith(
                    fontSize: 12,
                  ),
                ),
                const Gap(10),
                SizedBox(
                    width: 110,
                    height: 30,
                      child: MainButton(
                        title: "View More",
                        buttonColor: Styles.primaryColor,
                        onPressed: widget.onPressed,
                      textStyle: Styles.seeMore.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    )),  
              ],
            ),
          ),
          Stack(
            alignment: Alignment.center,
            children: [
              Image.asset(widget.imageList,
                width: 80,
                height: 100,
                fit: BoxFit.contain,
              ),
            ],
          ),
        ],
        
      ),
    );
  }
}


class ProgramRow extends StatefulWidget {
  final String image;
  final String title;
  final String bottomText;
  final double? progress;
  final String? progressText;
  final IconData icon;
  final bool showToggleSwitch;

  const ProgramRow({
    super.key,
    this.progress, // Provide a default value of null
    this.icon = FluentSystemIcons.ic_fluent_chevron_right_filled, // Provide a default icon
    this.showToggleSwitch = true,
    required this.image,
    required this.title,
    required this.bottomText,
    this.progressText, // Provide a default value to show the ToggleSwitch
  });

  @override
  State<ProgramRow> createState() => _ProgramRowState();
}

class _ProgramRowState extends State<ProgramRow> {
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
                errorBuilder: (context, object, stackTrace) {
                  return const Icon(Icons.question_mark_rounded);
                },
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
                const SizedBox(height: 4),
                if (widget.progress != null &&
                    widget.progressText !=
                        null) // Conditionally render the progress bar
                  Row(
                    children: [
                      SimpleAnimationProgressBar(
                        height: 15,
                        width: 150,
                        backgroundColor: Colors.grey.shade200,
                        foregrondColor: Styles.secondColor,
                        ratio: widget.progress!,
                        direction: Axis.horizontal,
                        curve: Curves.fastLinearToSlowEaseIn,
                        duration: const Duration(seconds: 3),
                        borderRadius: BorderRadius.circular(7.5),
                        gradientColor: LinearGradient(
                          colors: Styles.gradientColor,
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                        ),
                      ),
                      const Gap(4.0),
                      Text(
                        "${widget.progressText!} days", // Display the duration here
                        style: Styles.normal.copyWith(
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
              ],
            ),
          ),
          if (widget.showToggleSwitch) // Conditionally render the ToggleSwitch
            const ToggleSwitch(),
          if (!widget.showToggleSwitch) // Conditionally render the default icon
            Icon(
              widget.icon,
              size: 30,
              color: Styles.secondColor,
            ),
        ],
      ),
    );
  }
}











