import 'package:flutter/material.dart';
import 'package:ifit/common/utils/app_styles.dart';
import 'package:ifit/models/workout.dart';

class ExercisesRow extends StatelessWidget {
  final ExerciseElement exerciseElement;
  final Function() onPressed;

  const ExercisesRow({
    Key? key,
    required this.exerciseElement,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ExerciseElement exercise = exerciseElement;

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // ClipRRect(
          //   borderRadius: BorderRadius.circular(5),
          //   child: Image.network(exercise.url,
          //     width: 60,
          //     height: 60,
          //     fit: BoxFit.cover,
          //   ),
          // ),
          const Icon(Icons.fitness_center),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(exercise.title,
                  style: Styles.text15bold,
                ),
                Text(exercise.description,
                  style: Styles.normal.copyWith(
                      fontSize: 12
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: onPressed,
            icon: const Icon(Icons.navigate_next),
          )
        ],
      ),
    );
    // if (eObjOrSObj.containsKey("image")) {
    //   // It's an exercise
    //   final eObj = eObjOrSObj as Map<String, dynamic>;
    //   return Container(
    //     margin: const EdgeInsets.symmetric(vertical: 8),
    //     child: Row(
    //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //       children: [
    //         ClipRRect(
    //           borderRadius: BorderRadius.circular(5),
    //           child: Image.asset(
    //             eObj["image"].toString(),
    //             width: 60,
    //             height: 60,
    //             fit: BoxFit.cover,
    //           ),
    //         ),
    //         const SizedBox(width: 15),
    //         Expanded(
    //           child: Column(
    //             crossAxisAlignment: CrossAxisAlignment.start,
    //             children: [
    //               Text(
    //                 eObj["title"].toString(),
    //                 style: Styles.text15bold,
    //               ),
    //               Text(
    //                 eObj["value"].toString(),
    //                 style: Styles.normal.copyWith(
    //                     fontSize: 12
    //                 ),
    //               ),
    //             ],
    //           ),
    //         ),
    //         IconButton(
    //           onPressed: () => onPressed(eObj),
    //           icon: const Icon(Icons.navigate_next),
    //         )
    //       ],
    //     ),
    //   );
    // } else if (eObjOrSObj.containsKey("set")) {
    //   // It's a set
    //   final sObj = eObjOrSObj as Map<String, dynamic>;
    //   final exercisesArr = sObj["set"] as List<Map<String, dynamic>>? ?? [];
    //
    //   return Column(
    //     crossAxisAlignment: CrossAxisAlignment.start,
    //     mainAxisSize: MainAxisSize.min,
    //     children: [
    //       const Gap(10),
    //       Text(
    //         sObj["name"].toString(),
    //         style: const TextStyle(
    //           color: Colors.black,
    //           fontSize: 16,
    //           fontWeight: FontWeight.bold,
    //         ),
    //       ),
    //       const SizedBox(height: 8),
    //       ListView.builder(
    //         padding: EdgeInsets.zero,
    //         physics: const NeverScrollableScrollPhysics(),
    //         shrinkWrap: true,
    //         itemCount: exercisesArr.length,
    //         itemBuilder: (context, index) {
    //           final eObj = exercisesArr[index];
    //           return ExercisesRow(
    //             eObjOrSObj: eObj,
    //             onPressed: onPressed,
    //           );
    //         },
    //       ),
    //     ],
    //   );
    // }
    return Container();
  }
}