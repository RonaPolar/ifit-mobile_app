import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:ifit/common/utils/app_styles.dart';

class SquareContainer extends StatefulWidget {
  final String image;
  final String title;
  final String bottomText;
  final Color? textColor;
  final Color? containerColor;

  const SquareContainer({super.key,
    required this.image,
    required this.title,
    required this.bottomText,
    this.textColor,
    this.containerColor});

  @override
  State<SquareContainer> createState() => _SquareContainerState();
}

class _SquareContainerState extends State<SquareContainer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(5),
      width: 160,
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        boxShadow: const [BoxShadow(color: Colors.black26, blurRadius: 2)],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            widget.image,
            width: double.maxFinite,
            height: 100,
            fit: BoxFit.contain,
          ),
          const Gap(5),
          Text(
            widget.title,
            style: Styles.normal.copyWith(
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
