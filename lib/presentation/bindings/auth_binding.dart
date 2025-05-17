import 'package:get/get.dart';
import '../controller/auth_controller.dart';
import '../controller/note_controller.dart';

class AuthBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AuthController>(() => AuthController());
    Get.lazyPut<NoteController>(() => NoteController());
  }
}
