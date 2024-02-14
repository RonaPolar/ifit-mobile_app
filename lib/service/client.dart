import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class Client extends ChangeNotifier {

  double bmi = 0;
  String? name;

  /// [fetchData]
  Future<void> fetchData() async {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final FirebaseFirestore db = FirebaseFirestore.instance;
    final User? user = auth.currentUser;

    try {
      if (user != null) {
        QuerySnapshot querySnapshot = await FirebaseFirestore.instance
            .collection('clients')
            .where('email', isEqualTo: user.email)
            .get();

        if (querySnapshot.docs.isNotEmpty) {
          var userData = querySnapshot.docs.first.data() as Map<String, dynamic>?;

          if (userData != null) {
              name = userData['name'] ?? '';
              double height =
                  double.tryParse(userData['height'] ?? '0.0') ?? 0.0;
              double weight =
                  double.tryParse(userData['weight'] ?? '0.0') ?? 0.0;

              // Convert height to meters
              double heightInMeters = height / 100;

              // Calculate BMI
              bmi = weight / (heightInMeters * heightInMeters);

              if (height != 0.0 && weight != 0.0) {
                // Calculate BMI
                bmi = weight / (heightInMeters * heightInMeters);
              } else {
                print('Height or weight is zero, unable to calculate BMI');
              }
          }
        }
      }
    } catch (e) {
      print('Error fetching data: $e');
    }
    notifyListeners();
  }

}
