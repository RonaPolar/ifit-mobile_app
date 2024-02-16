import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:ifit/common/constant/string.dart';
import 'package:ifit/models/client.dart';

class ClientProvider extends ChangeNotifier {

  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Stream<ClientModel>? clientStream;

  Stream<ClientModel> getClient(String uid) {
    return _db.collection(tClientPath).doc(uid).snapshots().map((doc) {
      final data = doc.data() as Map<String, dynamic>;
      return ClientModel.fromJson(data);
    });
  }

  void updateClientStream({
    required String uid,
  }) {
    clientStream = getClient(uid);
    notifyListeners();
  }

  double bmi = 0;
  String? name;

  void getBmi({
    required ClientModel client,
  }) {

    final double weight = double.parse(client.weight);
    final double height = double.parse(client.height);
    final double heightInMeters = double.parse(client.height)/100;

    bmi = weight / (heightInMeters * heightInMeters);

    if (height != 0.0 && weight != 0.0) {
      // Calculate BMI
      bmi = weight / (heightInMeters * heightInMeters);
    } else {
      print('Height or weight is zero, unable to calculate BMI');
    }
    notifyListeners();
  }

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
