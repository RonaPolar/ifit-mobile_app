// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:ifit/common/constant/string.dart';
// import 'package:ifit/service/auth.dart';
// import 'package:ifit/views/screens/Experts_main_screens/exp_bottom_bar.dart';
// import 'package:ifit/views/screens/clients_main_screens/main_bottom_bar.dart';
// import 'package:provider/provider.dart';
//
// class AuthWrapperScreen extends StatefulWidget {
//   const AuthWrapperScreen({
//     required this.child,
//     super.key,
//   });
//
//   final Widget child;
//
//   @override
//   State<AuthWrapperScreen> createState() => _AuthWrapperScreenState();
// }
//
// class _AuthWrapperScreenState extends State<AuthWrapperScreen> {
//
//
//   @override
//   Widget build(BuildContext context) {
//     String userType = "";
//
//     final Auth auth = Provider.of<Auth>(context);
//
//     Future<void> getUserType(User? data) async {
//
//       if (data != null) {
//
//         await FirebaseFirestore.instance
//             .collection(tExpertPath)
//             .where('uid', isEqualTo: data.uid)
//             .get()
//             .then((QuerySnapshot querySnapshot) {
//           if (querySnapshot.docs.isEmpty) {
//             return "";
//           } else {
//             final data = querySnapshot.docs.first.data() as Map<String, dynamic>;
//             setState(() {
//               userType = data["user_type"];
//             });
//           }
//         });
//
//
//         await FirebaseFirestore.instance
//             .collection(tClientPath)
//             .where('uid', isEqualTo: data.uid)
//             .get()
//             .then((QuerySnapshot querySnapshot) {
//           if (querySnapshot.docs.isEmpty) {
//             return "";
//           } else {
//             final data = querySnapshot.docs.first.data() as Map<String, dynamic>;
//             setState(() {
//               userType = data["user_type"];
//             });
//           }
//         });
//       }
//     }
//
//     return StreamBuilder<User?>(
//       stream: auth.userStream,
//       builder: (context, snapshot) {
//
//
//         if (snapshot.hasData) {
//           final data = snapshot.data;
//
//           final userType = getUserType(snapshot.data);
//
//           userType.then((value) {
//
//             print("Value: $");
//             if (user == tExpertPath) {
//               return const ExpBottomBar();
//             } else {
//               return const HomeNavBar();
//             }
//           });
//         } else if (snapshot.hasError) {
//           return Center(
//             child: Text("Something went wrong. ${snapshot.error}"),
//           );
//         } else if (!snapshot.hasData) {
//           return widget.child;
//         } else {
//           return const Center(
//             child: CircularProgressIndicator(),
//           );
//         }
//         return const SizedBox();
//       },
//     );
//   }
// }
