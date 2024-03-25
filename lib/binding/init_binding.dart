import 'package:get/get.dart';
import 'package:insta_clone/controller/auth_controller.dart';
import 'package:insta_clone/controller/bottom_nav_controller.dart';
import 'package:insta_clone/controller/home_controller.dart';
import 'package:insta_clone/controller/mypage_controller.dart';
import 'package:insta_clone/controller/upload_controller.dart';

class InitBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(BottomNavController(), permanent: true);
    Get.put(AuthController(), permanent: true);
  }

  static additionalBinding() {
    Get.put(MypageController());
    Get.put(UploadController());
    Get.put(HomeController());
  }
}
