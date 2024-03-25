import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:insta_clone/controller/auth_controller.dart';
import 'package:insta_clone/model/instagram_user.dart';
import 'package:insta_clone/view/app.dart';
import 'package:insta_clone/view/login.dart';
import 'package:insta_clone/view/signup.dart';

class Root extends GetView<AuthController> {
  const Root({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return FutureBuilder<IUser?>(
            future: controller.loginUser(snapshot.data!.uid),
            builder: (context, snapshot1) {
              if (snapshot1.hasData) {
                return const App();
              } else {
                return Obx(
                  () => controller.user.value.uid != null
                      ? const App()
                      : SignUp(
                          uid: snapshot.data!.uid,
                        ),
                );
              }
            },
          );
        } else {
          return const Login();
        }
      },
    );
  }
}
