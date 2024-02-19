import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:ifit/common/utils/app_styles.dart';

class BigContainer extends StatefulWidget {
  final String image;
  final String title;
  final String bottomText;
  final Color? textColor;
  final Color? containerColor;
  final Color? viewColor;

  const BigContainer({super.key,
    required this.image,
    required this.title,
    required this.bottomText,
    this.containerColor,
    this.viewColor, this.textColor});

  @override
  State<BigContainer> createState() => _BigContainerState();
}

class _BigContainerState extends State<BigContainer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(5),
      width: 160,
      decoration: BoxDecoration(
        color: widget.containerColor ?? Styles.secondColor.withOpacity(0.4),
        borderRadius: BorderRadius.circular(25),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.network(widget.image,
            width: 80,
            height: 80,
            fit: BoxFit.contain,
            errorBuilder: (context, exception, stackTrace) {
              return const Icon(Icons.question_mark_rounded);
            },
          ),
          const Gap(5),
          Expanded(
            child: Text(widget.title,
              textAlign: TextAlign.center,
              style: Styles.seeMore.copyWith(
                color: widget.textColor ?? Colors.black,
              ),
            ),
          ),
          Text(widget.bottomText,
            textAlign: TextAlign.center,
            style: Styles.normal.copyWith(
              fontSize: 12,
              color: widget.textColor ?? Colors.black,
            ),
          ),
          const Gap(12),
          Text(
            "View",
            style: Styles.seeMore.copyWith(
              fontWeight: FontWeight.bold,
              color: widget.viewColor ?? Colors.red,
            ),
          ),
        ],
      ),
    );
  }
}