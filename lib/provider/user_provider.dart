import 'package:flutter/material.dart';
import '../model/user.dart';
import '../model/user_singleton.dart';

class UserProvider with ChangeNotifier {
  final UserModel _userModel = UserModel();

  User? get currentUser => _userModel.currentUser;

  set currentUser(User? user) {
    _userModel.currentUser = user;
    notifyListeners();
  }
}
