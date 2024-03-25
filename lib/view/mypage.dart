import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:insta_clone/components/avatar_widget.dart';
import 'package:insta_clone/components/image_data.dart';
import 'package:insta_clone/components/user_card.dart';
import 'package:insta_clone/controller/mypage_controller.dart';

class MyPage extends GetView<MypageController> {
  const MyPage({super.key});

  Widget statisOne(String title, int value) {
    return Column(
      children: [
        Text(
          value.toString(),
          style: const TextStyle(
            fontSize: 20,
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          title,
          style: const TextStyle(
            fontSize: 15,
            color: Colors.black,
          ),
        ),
      ],
    );
  }

  Widget info() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Obx(
        () => Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                AvatarWidget(
                  thumbPath: controller.targetUser.value.thumbnail!,
                  type: AvatarType.type3,
                  size: 70,
                ),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(child: statisOne('Post', 15)),
                      Expanded(child: statisOne('Followers', 15)),
                      Expanded(child: statisOne('Following', 15)),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              controller.targetUser.value.description!,
              style: const TextStyle(
                fontSize: 13,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget menu() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 25),
      child: Row(
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 7),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(3),
                border: Border.all(
                  color: const Color(0xffdedede),
                ),
              ),
              child: const Text(
                'Edit profile',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          const SizedBox(
            width: 8,
          ),
          Container(
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(3),
              border: Border.all(
                color: const Color(0xffdedede),
              ),
              color: const Color(0xffefefef),
            ),
            child: ImageData(IconsPath.addFriend),
          ),
        ],
      ),
    );
  }

  Widget discoverPeople() {
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Discover people',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                  color: Colors.black,
                ),
              ),
              Text(
                'See all',
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 15,
                  color: Colors.blue,
                ),
              ),
            ],
          ),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            children: List.generate(
              10,
              (index) => UserCard(
                userId: '한식집$index',
                description: '한식집$index님이 팔로우합니다.',
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget tabMenu() {
    return TabBar(
      controller: controller.tabController,
      indicatorColor: Colors.black,
      indicatorWeight: 1,
      tabs: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: ImageData(IconsPath.gridViewOn),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: ImageData(IconsPath.myTagImageOff),
        ),
      ],
    );
  }

  Widget tabView() {
    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: 30,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        childAspectRatio: 1,
        mainAxisSpacing: 1,
        crossAxisSpacing: 1,
      ),
      itemBuilder: (context, index) {
        return Container(
          color: Colors.grey,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        title: Obx(
          () => Text(
            controller.targetUser.value.nickname!,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
              color: Colors.black,
            ),
          ),
        ),
        actions: [
          GestureDetector(
            onTap: () {},
            child: ImageData(
              IconsPath.uploadIcon,
              width: 50,
            ),
          ),
          GestureDetector(
            onTap: () {},
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: ImageData(
                IconsPath.menuIcon,
                width: 50,
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            info(),
            menu(),
            discoverPeople(),
            const SizedBox(
              height: 20,
            ),
            tabMenu(),
            tabView(),
          ],
        ),
      ),
    );
  }
}
