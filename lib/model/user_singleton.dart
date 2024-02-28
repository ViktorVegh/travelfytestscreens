import 'user.dart';

class UserModel {
  static final UserModel _instance = UserModel._internal();
  User? _currentUser;

  factory UserModel() {
    return _instance;
  }

  UserModel._internal();

  User? get currentUser => _currentUser;

  set currentUser(User? user) {
    _currentUser = user;
  }
}
