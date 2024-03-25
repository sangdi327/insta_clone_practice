import 'dart:io';

import 'package:flutter/material.dart';
import 'package:insta_clone/controller/auth_controller.dart';
import 'package:insta_clone/model/instagram_user.dart';
import 'package:image_picker/image_picker.dart';

class SignUp extends StatefulWidget {
  final String uid;
  const SignUp({super.key, required this.uid});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController nicknameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  final ImagePicker picker = ImagePicker();
  XFile? thumbnailImage;

  void update() => setState(() {});

  Widget avatar() {
    return Column(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(100),
          child: SizedBox(
            width: 100,
            height: 100,
            child: thumbnailImage != null
                ? Image.file(
                    File(thumbnailImage!.path),
                    fit: BoxFit.cover,
                  )
                : Image.asset(
                    'assets/images/default_image.png',
                    fit: BoxFit.cover,
                  ),
          ),
        ),
        const SizedBox(
          height: 15,
        ),
        ElevatedButton(
          onPressed: () async {
            thumbnailImage = await picker.pickImage(
                source: ImageSource.gallery, imageQuality: 10);
            update();
          },
          child: const Text(
            'change your image',
          ),
        ),
      ],
    );
  }

  Widget nickname() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 50),
      child: TextField(
        controller: nicknameController,
        decoration: const InputDecoration(
          contentPadding: EdgeInsets.all(10),
          hintText: 'nickname',
        ),
      ),
    );
  }

  Widget description() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 50),
      child: TextField(
        controller: descriptionController,
        decoration: const InputDecoration(
          contentPadding: EdgeInsets.all(10),
          hintText: 'explanation',
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Sign up!',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              const SizedBox(
                height: 30,
              ),
              avatar(),
              const SizedBox(
                height: 30,
              ),
              nickname(),
              const SizedBox(
                height: 30,
              ),
              description(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 50),
        child: ElevatedButton(
          onPressed: () {
            var signupUser = IUser(
              uid: widget.uid,
              nickname: nicknameController.text,
              description: descriptionController.text,
            );

            AuthController.to.signUp(signupUser, thumbnailImage);
          },
          child: const Text('Sign up!'),
        ),
      ),
    );
  }
}
