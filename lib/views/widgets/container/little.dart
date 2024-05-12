import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:ifit/common/utils/app_styles.dart';

class LittleContainer extends StatelessWidget {
  final String image;
  final String title;
  final String bottomText;
  final Color? textColor;
  final Color? containerColor;
  final Function() onTap;

  const LittleContainer({super.key,
    required this.image,
    required this.title,
    required this.bottomText,
    this.textColor,
    this.containerColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20.0),
      child: Container(
        margin: const EdgeInsets.all(5),
        width: 120,
        decoration: BoxDecoration(
          color: containerColor ?? Styles.secondColor.withOpacity(0.4),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.network(image,
              width: 60,
              height: 60,
              fit: BoxFit.contain,
              errorBuilder: (context, object, stackTrace) {
                return const Icon(Icons.question_mark_rounded);
              },
            ),
            const Gap(5),
            Text(title,
              textAlign: TextAlign.center,
              style: Styles.normal.copyWith(
                fontSize: 11,
                fontWeight: FontWeight.bold,
                color: textColor ?? Colors.black,
              ),
            ),
            Text(
              bottomText,
              textAlign: TextAlign.center,
              style: Styles.normal.copyWith(
                fontSize: 10,
                color: textColor ?? Colors.black,
              ),
            ),

          ],
        ),
      ),
    );
  }
}
