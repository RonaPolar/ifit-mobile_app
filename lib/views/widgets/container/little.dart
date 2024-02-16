import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:ifit/common/utils/app_styles.dart';

class LittleContainer extends StatefulWidget {
  final String image;
  final String title;
  final String bottomText;
  final Color? textColor;
  final Color? containerColor;

  const LittleContainer({super.key,
    required this.image,
    required this.title,
    required this.bottomText,
    this.textColor,
    this.containerColor});

  @override
  State<LittleContainer> createState() => _LittleContainerState();
}

class _LittleContainerState extends State<LittleContainer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(5),
      width: 120,
      decoration: BoxDecoration(
          color: widget.containerColor ?? Styles.secondColor.withOpacity(0.4),
          borderRadius: BorderRadius.circular(20)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            widget.image,
            width: 60,
            height: 60,
            fit: BoxFit.contain,
          ),
          const Gap(5),
          Text(
            widget.title,
            style: Styles.normal.copyWith(
              fontSize: 11,
              fontWeight: FontWeight.bold,
              color: widget.textColor ?? Colors.black,
            ),
          ),
          Text(
            widget.bottomText,
            style: Styles.normal.copyWith(
              fontSize: 10,
              color: widget.textColor ?? Colors.black,
            ),
          ),

        ],
      ),
    );
  }
}
