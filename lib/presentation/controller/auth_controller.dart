import 'package:get/get.dart';
import '../../data/services/firebase_auth_service.dart';

class AuthController extends GetxController {
  final _firebaseAuthService = FirebaseAuthService();

  Future<bool> login(String email, String password) async {
    try {
      await _firebaseAuthService.signIn(email, password);
      return true;
    } catch (e) {
      Get.snackbar(
        'Login Failed',
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
      );
      return false;
    }
  }

  Future<bool> register(String name, String email, String password) async {
    try {
      await _firebaseAuthService.register(
        name: name,
        email: email,
        password: password,
      );
      return true;
    } catch (e) {
      Get.snackbar(
        'Registration Failed',
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
      );
      return false;
    }
  }

  Future<bool> signOut() async {
    try {
      await _firebaseAuthService.signOut();
      return true;
    } catch (e) {
      Get.snackbar('Error', 'Logout failed');
      return false;
    }
  }
}
