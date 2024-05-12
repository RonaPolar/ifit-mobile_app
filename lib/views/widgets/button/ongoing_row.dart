import 'package:fluentui_icons/fluentui_icons.dart';
import 'package:flutter/material.dart';
import 'package:ifit/common/utils/app_styles.dart';
import 'package:simple_animation_progress_bar/simple_animation_progress_bar.dart';

class OngoingRow extends StatefulWidget {

  const OngoingRow({
    super.key,
    this.progress, // Provide a default value of null
    this.icon = FluentSystemIcons.ic_fluent_chevron_right_filled, // Provide a default icon
    this.showToggleSwitch = true,
    required this.image,
    required this.title,
    required this.bottomText,
    required this.onPressed,
    this.progressText, // Provide a default value to show the ToggleSwitch
    this.leading,
  });

  final String image;
  final String title;
  final String bottomText;
  final double? progress;
  final String? progressText;
  final IconData icon;
  final bool showToggleSwitch;
  final Function() onPressed;
  final Widget? leading;

  @override
  State<OngoingRow> createState() => _OngoingRowState();
}

class _OngoingRowState extends State<OngoingRow> {
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
                const SizedBox(
                  height: 4,
                ),
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

          widget.leading == null ? const SizedBox() : widget.leading!,
        ],
      ),
    );
  }
}