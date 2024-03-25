import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:insta_clone/components/message_popup.dart';
import 'package:insta_clone/controller/upload_controller.dart';
import 'package:insta_clone/view/upload.dart';

enum PageName { home, search, upload, activity, mypage }

class BottomNavController extends GetxController {
  static BottomNavController get to => Get.find();
  Rx<int> pageIndex = 0.obs;
  final searchPageNavigationKey = GlobalKey<NavigatorState>();
  List<int> bottomHistory = [0];

  void changeBottomNav(int value, {bool hasGesture = true}) {
    var page = PageName.values[value];
    switch (page) {
      case PageName.home:
      case PageName.search:
      case PageName.activity:
      case PageName.mypage:
        changePage(value, hasGesture: hasGesture);
      case PageName.upload:
        Get.to(() => const Upload());
    }
  }

  void changePage(int value, {bool hasGesture = true}) {
    pageIndex(value);
    if (!hasGesture) return;
    if (bottomHistory.last != value) {
      bottomHistory.add(value);
      print(bottomHistory);
    }
    // if (!bottomHistory.contains(value)) {
    //   bottomHistory.remove(value);
    // }
  }

  Future<bool> willPopAction() async {
    if (bottomHistory.length == 1) {
      print('exit');
      showDialog(
        context: Get.context!,
        builder: (context) => MessagePopUp(
          title: '앱 종료',
          message: '종료할래?',
          okCallBack: () {
            exit(0);
          },
          cancelCallBack: Get.back,
        ),
      );
      return true;
    } else {
      var page = PageName.values[bottomHistory.last];
      if (page == PageName.search) {
        var value = await searchPageNavigationKey.currentState!.maybePop();
        if (value) {
          return false;
        }
      }

      print('go to the previous page');
      bottomHistory.removeLast();
      var index = bottomHistory.last;
      changeBottomNav(index, hasGesture: false);
      print(bottomHistory);
      return false;
    }
  }
}
