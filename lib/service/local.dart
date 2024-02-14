import 'package:flutter/cupertino.dart';
import 'package:ifit/service/auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalProvider extends ChangeNotifier {

  Future<void> saveAccount() async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    sp.setString("email", Auth.email.text);
    sp.setString("password", Auth.password.text);
    notifyListeners();
  }
}