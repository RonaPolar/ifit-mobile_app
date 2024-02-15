import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:ifit/common/utils/app_styles.dart';
import 'package:ifit/views/screens/Experts_main_screens/exp_program_screens/create_program_screens/create_work.dart';

class AddEquipmentsWidget extends StatelessWidget {
  const AddEquipmentsWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {

    return Text("");
    // return Column(
    //   children: [
    //     Text(
    //       "Equipments Needed",
    //       style: Styles.title,
    //     ),
    //     const Gap(5),
    //     TextfieldContainer(
    //       hitText: 'Equipment with Quantity',
    //       icon: Icons.fitness_center_outlined,
    //       obscureText: false,
    //       onItemAdded: (newItem) {
    //         allItems.add(newItem);
    //       },
    //     ),
    //     Column(
    //       children: [
    //         Row(
    //           children: [
    //             IconButton(
    //                 onPressed: () {
    //                   setState(() {
    //                     allItemsControllers.removeLast();
    //                   });
    //                 },
    //                 icon: const Icon(Icons.remove)),
    //             const Padding(
    //               padding: EdgeInsets.all(8.0),
    //               child: Text("Items"),
    //             ),
    //             IconButton(
    //                 onPressed: () {
    //                   setState(() {
    //                     allItemsControllers
    //                         .add(TextEditingController());
    //                   });
    //                 },
    //                 icon: const Icon(Icons.add))
    //           ],
    //         ),
    //         // Use ListView.builder to dynamically generate TextfieldContainer widgets
    //         ListView.builder(
    //           shrinkWrap: true,
    //           itemCount: allItemsControllers.length,
    //           itemBuilder: (context, index) {
    //             return Column(
    //               children: [
    //                 Padding(
    //                   padding:
    //                   const EdgeInsets.symmetric(vertical: 8.0),
    //                   child: TextfieldContainer(
    //                     controller: allItemsControllers[index],
    //                     hitText: 'Equipment with Quantity',
    //                     icon: Icons.fitness_center_outlined,
    //                     obscureText: false,
    //                   ),
    //                 )
    //               ],
    //             );
    //           },
    //         ),
    //       ],
    //     ),
    //     const Gap(20),
    //     Row(
    //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //       children: [
    //         Text(
    //           "Exercises",
    //           style: Styles.title,
    //         ),
    //         Text("Indicate how many sets",
    //             style: Styles.text15normal),
    //       ],
    //     ),
    //     Column(
    //       children: [
    //         Row(
    //           children: [
    //             IconButton(
    //                 onPressed: () {
    //                   setState(() {
    //                     exerciseinstructions_list.removeLast();
    //                   });
    //                 },
    //                 icon: const Icon(Icons.remove)),
    //             const Padding(
    //               padding: EdgeInsets.all(8.0),
    //               child: Text("New Exercise"),
    //             ),
    //             IconButton(
    //                 onPressed: () {
    //                   setState(() {
    //                     exerciseinstructions_list
    //                         .add(ExcerciseInstructions());
    //                   });
    //                 },
    //                 icon: const Icon(Icons.add))
    //           ],
    //         ),
    //         // Use ListView.builder to dynamically generate TextfieldContainer widgets
    //         ListView.builder(
    //           controller: ScrollController(),
    //           shrinkWrap: true,
    //           itemCount: exerciseinstructions_list.length,
    //           itemBuilder: (context, index) {
    //             const names = ["Name", "Description", "Countings"];
    //             var controllers = [
    //               TextEditingController(
    //                   text: exerciseinstructions_list[index].name),
    //               TextEditingController(
    //                   text: exerciseinstructions_list[index].descriptions),
    //               TextEditingController(
    //                   text: exerciseinstructions_list[index]
    //                       .countings
    //                       .toString()),
    //             ];
    //             var keytypes = [
    //               TextInputType.name,
    //               TextInputType.text,
    //               TextInputType.number,
    //             ];
    //             var steps = <TextEditingController>[
    //               ...exerciseinstructions_list[index]
    //                   .instructions
    //                   .map((e) => TextEditingController(text: e))
    //             ];
    //
    //             return GestureDetector(
    //               onTap: () {
    //                 showDialog(
    //                     context: context,
    //                     barrierDismissible: false,
    //                     builder: (builder) {
    //                       var SCSVscroller = ScrollController();
    //                       return StatefulBuilder(
    //                           builder: (context, thissetState) {
    //                             return AlertDialog(
    //                               title: const Text("Edit Exercise"),
    //                               content: SizedBox(
    //                                 width: double.maxFinite,
    //                                 height: double.maxFinite,
    //                                 child: SingleChildScrollView(
    //                                     controller: SCSVscroller,
    //                                     child: Column(
    //                                       mainAxisSize:
    //                                       MainAxisSize.max,
    //                                       children: [
    //                                         GestureDetector(
    //                                           onTap: () async {
    //                                             // FilePickerResult? result = await FilePicker.platform.pickFiles();
    //                                             //
    //                                             // if (result != null) {
    //                                             //   File file = File(result.files.single.path!);
    //                                             // } else {
    //                                             //
    //                                             // }
    //                                           },
    //                                           child: Card(
    //                                               child: Padding(
    //                                                 padding:
    //                                                 const EdgeInsets
    //                                                     .all(8.0),
    //                                                 child: Container(
    //                                                     width: double
    //                                                         .maxFinite,
    //                                                     child: Text(
    //                                                         "Video file picker")),
    //                                               )),
    //                                         ),
    //                                         ListView.builder(
    //                                             shrinkWrap: true,
    //                                             itemCount: names.length,
    //                                             itemBuilder:
    //                                                 (context, index) {
    //                                               return Padding(
    //                                                 padding:
    //                                                 const EdgeInsets
    //                                                     .symmetric(
    //                                                     vertical:
    //                                                     8.0),
    //                                                 child: Column(
    //                                                   crossAxisAlignment:
    //                                                   CrossAxisAlignment
    //                                                       .start,
    //                                                   children: [
    //                                                     Text(names[
    //                                                     index]),
    //                                                     TextField(
    //                                                         controller:
    //                                                         controllers[
    //                                                         index],
    //                                                         keyboardType:
    //                                                         keytypes[
    //                                                         index])
    //                                                   ],
    //                                                 ),
    //                                               );
    //                                             }),
    //                                         Row(
    //                                           mainAxisSize:
    //                                           MainAxisSize.min,
    //                                           children: [
    //                                             IconButton(
    //                                                 onPressed: () {
    //                                                   thissetState(() {
    //                                                     steps
    //                                                         .removeLast();
    //                                                   });
    //                                                 },
    //                                                 icon: const Icon(
    //                                                     Icons.remove)),
    //                                             const Padding(
    //                                               padding:
    //                                               EdgeInsets.all(
    //                                                   8.0),
    //                                               child: Text("Steps"),
    //                                             ),
    //                                             IconButton(
    //                                                 onPressed: () {
    //                                                   SCSVscroller.animateTo(
    //                                                       SCSVscroller
    //                                                           .position
    //                                                           .maxScrollExtent,
    //                                                       duration: const Duration(
    //                                                           milliseconds:
    //                                                           500),
    //                                                       curve: Curves
    //                                                           .easeIn);
    //                                                   thissetState(() {
    //                                                     steps.add(
    //                                                         TextEditingController());
    //                                                   });
    //                                                 },
    //                                                 icon: const Icon(
    //                                                     Icons.add)),
    //                                           ],
    //                                         ),
    //                                         ListView.builder(
    //                                             shrinkWrap: true,
    //                                             controller:
    //                                             ScrollController(),
    //                                             itemCount: steps.length,
    //                                             itemBuilder:
    //                                                 (context, index) {
    //                                               return Padding(
    //                                                 padding:
    //                                                 const EdgeInsets
    //                                                     .symmetric(
    //                                                     vertical:
    //                                                     8.0),
    //                                                 child: Card(
    //                                                   child: Column(
    //                                                     crossAxisAlignment:
    //                                                     CrossAxisAlignment
    //                                                         .start,
    //                                                     children: [
    //                                                       Text(
    //                                                           "step ${index + 1}"),
    //                                                       TextField(
    //                                                         controller:
    //                                                         steps[
    //                                                         index],
    //                                                         textInputAction:
    //                                                         TextInputAction
    //                                                             .next,
    //                                                       )
    //                                                     ],
    //                                                   ),
    //                                                 ),
    //                                               );
    //                                             }),
    //                                       ],
    //                                     )),
    //                               ),
    //                               actions: [
    //                                 TextButton(
    //                                     onPressed: () {
    //                                       setState(() {
    //                                         exerciseinstructions_list[
    //                                         index] =
    //                                             ExcerciseInstructions()
    //                                                 .fill(
    //                                                 controllers[0]
    //                                                     .text,
    //                                                 "null",
    //                                                 int.parse(
    //                                                     controllers[
    //                                                     2]
    //                                                         .text),
    //                                                 controllers[1]
    //                                                     .text,
    //                                                 steps
    //                                                     .map((e) =>
    //                                                 e.text)
    //                                                     .toList());
    //                                       });
    //                                       Navigator.pop(context);
    //                                     },
    //                                     child: const Text("OK"))
    //                               ],
    //                             );
    //                           });
    //                     });
    //               },
    //               child: Card(
    //                 child: Padding(
    //                   padding: const EdgeInsets.all(8.0),
    //                   child: Column(
    //                     crossAxisAlignment:
    //                     CrossAxisAlignment.start,
    //                     children: [
    //                       Text(
    //                           "Workout name: ${exerciseinstructions_list[index].name}"),
    //                       Text(
    //                           "Steps: ${exerciseinstructions_list[index].instructions.length}"),
    //                     ],
    //                   ),
    //                 ),
    //               ),
    //             );
    //           },
    //         ),
    //       ],
    //     ),
    //   ],
    // );

  }
}
