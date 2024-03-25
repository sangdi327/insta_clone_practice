import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:insta_clone/components/image_data.dart';
import 'package:insta_clone/controller/upload_controller.dart';

class UploadDescription extends GetView<UploadController> {
  const UploadDescription({super.key});

  Widget description() {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Row(
        children: [
          SizedBox(
            width: 60,
            height: 60,
            child: Image.file(
              controller.filteredImage!,
              fit: BoxFit.cover,
            ),
          ),
          Expanded(
            child: TextField(
                controller: controller.textEditingController,
                maxLines: null,
                decoration: const InputDecoration(
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                    contentPadding: EdgeInsets.only(left: 15),
                    hintText: 'texting...')),
          ),
        ],
      ),
    );
  }

  Widget infoOne(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 7, horizontal: 15),
      child: Text(
        title,
        style: const TextStyle(fontSize: 17),
      ),
    );
  }

  Widget get line => const Divider(
        color: Colors.grey,
      );

  Widget snsInfo() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Facebook',
                style: TextStyle(fontSize: 17),
              ),
              Switch(
                value: false,
                onChanged: (bool value) {},
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Twitter',
                style: TextStyle(fontSize: 17),
              ),
              Switch(
                value: false,
                onChanged: (bool value) {},
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Tumblr',
                style: TextStyle(fontSize: 17),
              ),
              Switch(
                value: false,
                onChanged: (bool value) {},
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0,
          leading: GestureDetector(
            onTap: () {
              Get.back();
            },
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: ImageData(
                IconsPath.backBtnIcon,
                width: 50,
              ),
            ),
          ),
          title: const Text(
            'New notice',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
          actions: [
            GestureDetector(
              onTap: controller.uploadPost(),
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: ImageData(
                  IconsPath.uploadComplete,
                  width: 100,
                ),
              ),
            )
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              description(),
              line,
              infoOne('tag someone'),
              line,
              infoOne('add location'),
              line,
              infoOne('notice other medias'),
              snsInfo(),
            ],
          ),
        ),
      ),
    );
  }
}
