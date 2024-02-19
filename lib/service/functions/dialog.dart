import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:ifit/common/utils/app_styles.dart';

class DialogService {
  void showUploadImage(BuildContext context, {
    required Function() onPressed,
  }) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            title: const Text('Please choose media to select'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ElevatedButton(
                  //if user click this button, user can upload image from gallery
                  onPressed: () {
                    Navigator.pop(context);
                    onPressed();
                  },
                  child: const Row(
                    children: [
                      Icon(Icons.image),
                      Text('From Gallery'),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
    );
  }

  void showCreateProgram(BuildContext context, {
    required Function() createWorkout,
    required Function() createMeal,
  }) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            const Gap(5.0),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(Styles.secondColor),
                ),
                onPressed: createWorkout,
                  // Handle the first choice
                  // Navigator.of(context)
                  //     .push(MaterialPageRoute(builder: (context) => const CreateWorkout()));
                child: Text(
                  "Create a Workout Plan",
                  style: Styles.headline20,),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(Styles.secondColor),
                ),
                onPressed: createMeal,
                  // Handle the first choice
                  // Navigator.of(context)
                  //     .push(MaterialPageRoute(builder: (context) => const CreateMeal()));
                child: Text(
                  "Create a Meal Plan",
                  style: Styles.headline20,),
              ),
            ),
          ],
        );
      },
    );
  }

  void confirmationDialog(BuildContext context, {
    required Function() onPressed,
  }) async {

    return await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Are you sure?"),
          content: Text("Please confirm if you want to cancel the program."),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                onPressed();
              },
              child: Text("Confirm"),
            ),
          ],
        );
      },
    );
  }
}