import 'package:flutter/material.dart';

import '../FUNCTIONS/auth_method.dart';
import '../Models/user_model.dart';

class UserProvider with ChangeNotifier {
  User? _user;
  final Auth _auth = Auth();
  User get getUser => _user!;
  Future<void> refreshUser() async {
    User user = await _auth.getUserDetails();
    _user = user;
    notifyListeners();
  }
}
