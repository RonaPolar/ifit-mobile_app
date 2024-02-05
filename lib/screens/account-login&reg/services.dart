import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Services {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // ignore: non_constant_identifier_names
  SignIn(String email, String password) async {
    UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email, password: password);

    final user = userCredential.user;

    if (user != null) {
      // Access 'uid' and other properties
      print("User is . Authentication success.");
      // Continue with the login process
    } else {
      // Handle the case where the user is null
      print("User is null. Authentication failed.");
    }
  }

  Signup(String firstname, String email, String password) async {
    UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email, password: password);
    String? uid = userCredential.user?.uid;

    FirebaseFirestore.instance.collection('experts').doc(uid).set({
      'date_creation': FieldValue.serverTimestamp(),
      'uid': uid,
      'name': firstname,
      'email': email,
      'user_type': 'expert',
      'verified': false
    });
  }

  updateExpert(String uid, String? gender, String birth_date,
      String phone_number, String profession) {
    FirebaseFirestore.instance.collection('experts').doc(uid).update({
      'gender': gender,
      'birth_date': birth_date,
      'phone_number': phone_number,
      'profession': profession,
    });
  }
}
