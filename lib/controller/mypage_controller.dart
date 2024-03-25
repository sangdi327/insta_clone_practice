import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:insta_clone/controller/auth_controller.dart';
import 'package:insta_clone/model/instagram_user.dart';

class MypageController extends GetxController with GetTickerProviderStateMixin {
  late TabController tabController;
  Rx<IUser> targetUser = IUser().obs;

  @override
  void onInit() {
    super.onInit();
    tabController = TabController(length: 2, vsync: this);
    loadData();
  }

  void setTargetUser() {
    var uid = Get.parameters['targetUid'];
    if (uid == null) {
      targetUser(AuthController.to.user.value);
    } else {}
  }

  void loadData() {
    setTargetUser();
  }
}
