import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:ifit/common/utils/app_styles.dart';

class NutritionDescriptions extends StatelessWidget {
  final String imagePath;
  final String label;

  const NutritionDescriptions({
    Key? key,
    required this.imagePath,
    required this.label,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      decoration: BoxDecoration(
        color: Styles.secondColor.withOpacity(0.3),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Image.asset(
            imagePath,
            scale: 10,
            fit: BoxFit.contain,
          ),
          const Gap(2),
          Text(label),
        ],
      ),
    );
  }
}