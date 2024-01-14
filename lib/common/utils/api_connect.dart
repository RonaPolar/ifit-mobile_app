import 'dart:convert';

import 'package:get/get.dart';

class ApiConnect extends GetConnect {
  Future<Response> loginUser(Map<String, dynamic> data) {
    var res = post(
      'https://ifit-api.onrender.com/login/',
      jsonEncode(data),
    );

    return res;
  }

  Future<Response> registerUser(Map<String, dynamic> data) {
    var res = post(
      'https://ifit-api.onrender.com/registration/',
      jsonEncode(data),
    );

    return res;
  }

  Future<Response> sendEmailToUser(Map<String, dynamic> data) {
    var res = post(
      'https://ifit-api.onrender.com/users/emailauser',
      jsonEncode(data),
    );

    return res;
  }
}
