import 'package:get/get.dart';
import '../controller/controller.dart';


class AuthBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AuthController>(() => AuthController());
    Get.lazyPut<NoteController>(() => NoteController());
    Get.lazyPut<SplashController>(() => SplashController());
  }
}
