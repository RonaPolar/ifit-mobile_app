import 'package:dotted_dashed_line/dotted_dashed_line.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:ifit/common/utils/app_styles.dart';

class ExerStepsDottedLine extends StatelessWidget {
  const ExerStepsDottedLine({
    super.key,
    required this.step,
    required this.index,
    this.isLast = false,
  });

  final String step;
  final bool isLast;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 25,
          child: Text("${index + 1}",
            style: Styles.normal.copyWith(
              color: Styles.secondColor,
            ),
          ),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 18,
              height: 18,
              decoration: BoxDecoration(
                color: Styles.secondColor.withOpacity(0.5),
                borderRadius: BorderRadius.circular(9),
              ),
              alignment: Alignment.center,
              child: Container(
                width: 16,
                height: 16,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.white, width: 3),
                  borderRadius: BorderRadius.circular(8),
                ),) ,
            ),
            if (!isLast)
              DottedDashedLine(
                  height: 70,
                  width: 0,
                  dashColor: Styles.secondColor.withOpacity(0.5),
                  axis: Axis.vertical)
          ],
        ),
        const Gap(5), //gap between text and line
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //waterArry
              // Text(
              //   sObj["title"].toString(),
              //   style: Styles.text12.copyWith(
              //     fontSize: 14,
              //   ),
              // ),
              Text(step,
                style: Styles.seeMore.copyWith(
                    fontWeight: FontWeight.normal),
              ),
              const Gap(5),
            ],
          ),
        )
      ],
    );
  }
}