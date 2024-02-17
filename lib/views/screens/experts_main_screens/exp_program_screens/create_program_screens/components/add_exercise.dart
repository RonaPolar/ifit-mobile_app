import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:ifit/service/Expert.dart';
import 'package:ifit/views/widgets/text_field/text_field_container.dart';
import 'package:provider/provider.dart';

class AddExerciseScreen extends StatelessWidget {
  const AddExerciseScreen({

    super.key,
  });

  @override
  Widget build(BuildContext context) {

    final ExpertProvider expertProvider = Provider.of<ExpertProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Exercise"),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFieldContainer(
                  hintText: 'Exercise',
                  icon: Icons.title,
                  controller: ExpertProvider.exerciseTitle,
                ),
                const Gap(5.0),
                TextFieldContainer(
                  controller: ExpertProvider.exerciseVideo,
                  hintText: 'Url Video',
                  icon: Icons.fitness_center_outlined,
                ),
                const Gap(5.0),
                TextFieldContainer(
                  controller: ExpertProvider.exerciseDescription,
                  hintText: 'Description',
                  icon: Icons.description,
                ),
                const Gap(10),
                Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        expertProvider.updateIsCounting();
                      },
                      icon: Icon(expertProvider.isCounting
                        ? Icons.numbers
                        : Icons.lock_clock,
                      ),
                    ),
                    Expanded(
                      child: TextFieldContainer(
                        controller: ExpertProvider.exerciseTime,
                        hintText: expertProvider.isCounting ? "Counting" : "Time",
                        icon: Icons.description,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    IconButton(
                      onPressed: () => expertProvider.updateSteps(false),
                      icon: const Icon(
                        Icons.remove,
                      ),
                    ),
                    const Text("Steps"),
                    IconButton(
                      onPressed: () => expertProvider.updateSteps(true),
                      icon: const Icon(
                        Icons.add,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  child: ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: expertProvider.steps.length,
                    itemBuilder: (context, index) {
                      final TextEditingController step = expertProvider.steps[index];

                      return Card(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextFieldContainer(
                              icon: Icons.directions_walk,
                              controller: step,
                              hintText: "Step: ${index + 1}",
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),

                TextButton(
                  onPressed: () {
                    expertProvider.addExercise();
                    Navigator.pop(context);
                  },
                  child: const Text("Add"),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
