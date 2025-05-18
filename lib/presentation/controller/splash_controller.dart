import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class SplashController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool _isLoading = true;
  User? _currentUser;

  bool get isLoading => _isLoading;
  User? get currentUser => _currentUser;


  Future<bool> checkUser() async {
    try {
      await Future.delayed(const Duration(seconds: 2));
      _currentUser = _auth.currentUser;
      _isLoading = false;
      update();
      return _currentUser != null;
    } catch (e) {
      _isLoading = false;
      update();
      return false;
    }
  }
}