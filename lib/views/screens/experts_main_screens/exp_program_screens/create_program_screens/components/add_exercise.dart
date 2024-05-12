import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:ifit/models/workout.dart';
import 'package:ifit/service/Expert.dart';
import 'package:ifit/views/widgets/text_field/text_field_container.dart';
import 'package:provider/provider.dart';

class AddExerciseScreen extends StatefulWidget {
  const AddExerciseScreen({
    this.exerciseElement,
    this.index,
    super.key,
  });

  final ExerciseElement? exerciseElement;
  final int? index;

  @override
  State<AddExerciseScreen> createState() => _AddExerciseScreenState();
}

class _AddExerciseScreenState extends State<AddExerciseScreen> {

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final ExpertProvider expertProvider = Provider.of<ExpertProvider>(context, listen: false);
      if (widget.exerciseElement != null) {
        setState(() {
          ExpertProvider.exerciseTitle.text = widget.exerciseElement!.title;
          ExpertProvider.exerciseVideo.text = widget.exerciseElement!.url;
          ExpertProvider.exerciseDescription.text = widget.exerciseElement!.description;
          expertProvider.isCounting = widget.exerciseElement!.exerciseDuration.type;
          ExpertProvider.exerciseTime.text = widget.exerciseElement!.exerciseDuration.time;

          for (String val in widget.exerciseElement!.steps) {
            expertProvider.steps.add(TextEditingController(text: val));
          }
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {

    final ExpertProvider expertProvider = Provider.of<ExpertProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Exercise"),
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
            expertProvider.clearExerciseForm();
          },
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      bottomNavigationBar:  Padding(
        padding: const EdgeInsets.all(24.0),
        child: ElevatedButton(
          onPressed: () {
            if (widget.exerciseElement != null) {
              expertProvider.updateExercise(
                isEdit: true,
                index: widget.index!,
              );
            } else {
              expertProvider.updateExercise(
                isEdit: false,
              );
            }
            Navigator.pop(context);
          },
          child: const Text("Save Exercise"),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
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
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    TextButton(
                      onPressed: () {
                        expertProvider.updateIsCounting();
                      },
                      child: Text(!expertProvider.isCounting
                        ? "Switch to counting"
                        : "Switch to time",
                      ),
                    ),
                    TextFieldContainer(
                      controller: ExpertProvider.exerciseTime,
                      hintText: expertProvider.isCounting
                          ? "Counting"
                          : "Time",
                      icon: Icons.description,
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
                const Gap(100.0),


              ],
            ),
          ),
        ),
      ),
    );
  }
}
