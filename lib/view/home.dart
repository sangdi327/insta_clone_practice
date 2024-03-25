import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:insta_clone/components/avatar_widget.dart';
import 'package:insta_clone/components/image_data.dart';
import 'package:insta_clone/components/post_widget.dart';
import 'package:insta_clone/controller/home_controller.dart';

class Home extends GetView<HomeController> {
  const Home({super.key});

  Widget myStory() {
    return Stack(
      children: [
        const AvatarWidget(
          thumbPath:
              'https://cdn.pixabay.com/photo/2014/06/21/08/43/rabbit-373691_1280.jpg',
          type: AvatarType.type2,
          size: 70,
        ),
        Positioned(
          right: 5,
          bottom: 0,
          child: Container(
            width: 25,
            height: 25,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.blue,
              border: Border.all(
                color: Colors.white,
                width: 2,
              ),
            ),
            child: const Center(
              child: Icon(
                Icons.add,
                color: Colors.white,
                size: 15,
              ),
            ),
          ),
        )
      ],
    );
  }

  Widget storyBoardList() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(children: [
        const SizedBox(
          width: 15,
        ),
        myStory(),
        const SizedBox(
          width: 5,
        ),
        ...List.generate(
          20,
          (index) => const AvatarWidget(
            thumbPath:
                'https://cdn.pixabay.com/photo/2022/09/08/15/23/marmot-7441231_1280.jpg',
            type: AvatarType.type1,
          ),
        ),
      ]),
    );
  }

  Widget postList() {
    return Obx(
      () => Column(
        children: List.generate(
          controller.postList.length,
          (index) => PostWidget(
            post: controller.postList[index],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: ImageData(
          IconsPath.logo,
          width: 270,
        ),
        actions: [
          GestureDetector(
            onTap: () {},
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: ImageData(
                IconsPath.directMessage,
                width: 50,
              ),
            ),
          )
        ],
      ),
      body: ListView(
        children: [
          storyBoardList(),
          postList(),
        ],
      ),
    );
  }
}
