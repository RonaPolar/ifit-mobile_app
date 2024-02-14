import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:ifit/common/constant/string.dart';
import 'package:ifit/service/functions/dialog.dart';
import 'package:image_picker/image_picker.dart';

class Auth extends ChangeNotifier {

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore db = FirebaseFirestore.instance;
  final FirebaseStorage ref = FirebaseStorage.instance;

  static TextEditingController firstName = TextEditingController();
  static TextEditingController lastName = TextEditingController();
  static TextEditingController email = TextEditingController();
  static TextEditingController password = TextEditingController();
  static TextEditingController birthday = TextEditingController();
  static TextEditingController phone = TextEditingController();
  static TextEditingController profession = TextEditingController();

  String? gender;

  Future<void> createUser() async {
    UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
      email: email.text,
      password: password.text
    );

    String? uid = userCredential.user?.uid;

    await db.collection(tExpertPath).doc(uid).set({
      'date_creation': FieldValue.serverTimestamp(),
      'uid': uid,
      'name': firstName.text,
      'email': email.text,
      'user_type': 'Expert',
      'verified': false,
    });
  }

  /// EXPERTS -------------------->
  XFile? professionId;
  XFile? proofOfStudy;

  Future<void> uploadProfessionId(BuildContext context) async {
    DialogService().showUploadImage(context,
      onPressed: () async {
        final img = await ImagePicker().pickImage(
          source: ImageSource.gallery,
        );

        professionId = img;
        notifyListeners();
      },
    );
  }

  Future<void> uploadProofOfStudy(BuildContext context) async {
    DialogService().showUploadImage(context,
      onPressed: () async {
        final img = await ImagePicker().pickImage(
          source: ImageSource.gallery,
        );
        try {
          proofOfStudy = img;
          notifyListeners();
        } catch (e) {
          print("No image selected");
        }
      },
    );
  }

  String? professionIdUrl;
  String? proofOfStudyUrl;

  Future<void> next({
    required String uid,
  }) async {
    Future.wait([
      storeProfessionalId(),
      storeProofOfStudy(),
    ]).then((value) async {
      await db.collection(tExpertPath).doc(uid).update({
        "profession_id": professionIdUrl,
        "proof_of_field_of_study": proofOfStudyUrl,
        "gender": gender,
        "birth_date": birthday.text,
        "phone_number": phone.text,
        "profession": profession.text,
      });
    });
  }

  Future<void> storeProfessionalId() async {
    // store professionId to storage
    final file = File(professionId!.path);
    final ref = FirebaseStorage.instance.ref()
        .child(tExpertPath)
        .child(professionId!.name);
    await ref.putFile(file);

    // store professionId to firestore
    professionIdUrl = await ref.getDownloadURL();
  }

  Future<void> storeProofOfStudy() async {
    // store proof of study to storage
    final file = File(proofOfStudy!.path);
    final ref = FirebaseStorage.instance.ref()
        .child(tExpertPath)
        .child(proofOfStudy!.name);
    await ref.putFile(file);

    // store proof of study to firestore
    proofOfStudyUrl = await ref.getDownloadURL();
  }

}