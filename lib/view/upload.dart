import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:insta_clone/controller/upload_controller.dart';
import 'package:photo_manager/photo_manager.dart';

import '../components/image_data.dart';

class Upload extends GetView<UploadController> {
  const Upload({super.key});

  Widget imagePreview(BuildContext context) {
    return Obx(
      () => Container(
        height: MediaQuery.of(context).size.width,
        color: Colors.grey,
        child: FutureBuilder(
          future: controller.selectedImage.value.thumbnailDataWithSize(
            const ThumbnailSize(500, 500),
          ),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Image.memory(
                snapshot.data!,
                fit: BoxFit.cover,
              );
            } else {
              return Container();
            }
          },
        ),
      ),
    );
  }

  Widget header(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () {
              showModalBottomSheet(
                context: context,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
                isScrollControlled:
                    controller.albums.length > 10 ? true : false,
                constraints: BoxConstraints(
                    maxHeight: MediaQuery.of(context).size.height -
                        MediaQuery.of(context).padding.top),
                builder: (context) => SizedBox(
                  height: controller.albums.length > 10
                      ? Size.infinite.height
                      : controller.albums.length * 60,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Center(
                        child: Container(
                          margin: const EdgeInsets.only(top: 7),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.black54,
                          ),
                          width: 40,
                          height: 4,
                        ),
                      ),
                      Expanded(
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: List.generate(
                              controller.albums.length,
                              (index) => GestureDetector(
                                onTap: () {
                                  controller
                                      .changeAlbum(controller.albums[index]);
                                  Get.back();
                                },
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 15, horizontal: 20),
                                  child: Text(
                                    controller.albums[index].name,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
            child: Row(
              children: [
                Obx(
                  () => Text(
                    controller.headerTitle.value,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                    ),
                  ),
                ),
                const Icon(Icons.arrow_drop_down),
              ],
            ),
          ),
          Row(
            children: [
              Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                decoration: BoxDecoration(
                  color: const Color(0xff808080),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Row(
                  children: [
                    ImageData(IconsPath.imageSelectIcon),
                    const SizedBox(
                      width: 7,
                    ),
                    const Text(
                      'Choose pictures',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                width: 5,
              ),
              Container(
                padding: const EdgeInsets.all(6),
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0xff808080),
                ),
                child: ImageData(IconsPath.cameraIcon),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget imageSelectList() {
    return Obx(
      () => GridView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
            mainAxisSpacing: 1,
            crossAxisSpacing: 1,
            childAspectRatio: 1,
          ),
          itemCount: controller.imageList.length,
          itemBuilder: (context, index) {
            return photoWidget(controller.imageList[index]);
          }),
    );
  }

  Widget photoWidget(AssetEntity asset) {
    return FutureBuilder(
      future: asset.thumbnailDataWithSize(const ThumbnailSize(200, 200)),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return GestureDetector(
            onTap: () {
              controller.changeSelecetedImage(asset);
              // update();
            },
            child: Obx(
              () => Opacity(
                opacity: asset == controller.selectedImage.value ? 0.4 : 1,
                child: Image.memory(
                  snapshot.data!,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          );
        } else {
          return Container();
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: GestureDetector(
          onTap: () {
            Get.back();
          },
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: ImageData(
              IconsPath.closeImage,
            ),
          ),
        ),
        title: const Text(
          'New post',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
            color: Colors.black,
          ),
        ),
        actions: [
          GestureDetector(
            onTap: () {
              controller.gotoImageFilter();
            },
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: ImageData(
                IconsPath.nextImage,
                width: 50,
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            imagePreview(context),
            header(context),
            imageSelectList(),
          ],
        ),
      ),
    );
  }
}
