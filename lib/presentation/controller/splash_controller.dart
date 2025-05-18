import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User? _currentUser;
  static const String _firstLoadKey = 'first_load';

  User? get currentUser => _currentUser;

  Future<bool> checkUser() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final isFirstLoad = prefs.getBool(_firstLoadKey) ?? true;

      if (isFirstLoad) {
        await Future.delayed(const Duration(seconds: 2));
        await prefs.setBool(_firstLoadKey, false);
      }
      _currentUser = _auth.currentUser;
      update();
      return _currentUser != null;
    } catch (e) {
      return false;
    }
  }
}
