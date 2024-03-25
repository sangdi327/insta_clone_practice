import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:insta_clone/components/message_popup.dart';
import 'package:insta_clone/controller/auth_controller.dart';
import 'package:insta_clone/model/post.dart';
import 'package:insta_clone/repository/post_repository.dart';
import 'package:insta_clone/utils/data_util.dart';
import 'package:insta_clone/view/upload/upload_description.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:photofilters/photofilters.dart';
import 'package:image/image.dart' as imageLib;
import 'package:path/path.dart';

class UploadController extends GetxController {
  var albums = <AssetPathEntity>[];
  RxString headerTitle = ''.obs;
  RxList imageList = <AssetEntity>[].obs;
  Rx<AssetEntity> selectedImage = const AssetEntity(
    id: '0',
    typeInt: 0,
    width: 0,
    height: 0,
  ).obs;
  File? filteredImage;
  TextEditingController textEditingController = TextEditingController();
  Post? post;

  @override
  void onInit() {
    super.onInit();
    post = Post.init(AuthController.to.user.value);
    loadPhotos();
  }

  void loadPhotos() async {
    var result = await PhotoManager.requestPermissionExtend();
    print(result);
    if (result.isAuth) {
      albums = await PhotoManager.getAssetPathList(
        type: RequestType.image,
        filterOption: FilterOptionGroup(
          imageOption: const FilterOption(
            sizeConstraint: SizeConstraint(
              minHeight: 100,
              minWidth: 100,
              ignoreSize: false,
            ),
          ),
          orders: [
            const OrderOption(
              type: OrderOptionType.createDate,
              asc: false,
            ),
          ],
        ),
      );
      loadData();
    } else {}
  }

  void loadData() {
    changeAlbum(albums.first);

    // update();
  }

  Future<void> pagingPhotos(AssetPathEntity album) async {
    imageList.clear();
    var photos = await album.getAssetListPaged(page: 0, size: 20);
    imageList.addAll(photos);
    changeSelecetedImage(imageList.first);
  }

  changeSelecetedImage(AssetEntity image) {
    selectedImage(image);
  }

  void changeAlbum(AssetPathEntity album) async {
    headerTitle(album.name);
    await pagingPhotos(album);
  }

  void gotoImageFilter() async {
    var filePath = await selectedImage.value.file;
    var fileName = basename(filePath!.path);
    var fileImage = imageLib.decodeImage(filePath.readAsBytesSync());
    var image = imageLib.copyResize(fileImage!, width: 600);
    var imagefile = await Navigator.push(
      Get.context!,
      MaterialPageRoute(
        builder: (context) => PhotoFilterSelector(
          title: const Text("Photo Filter Example"),
          image: image,
          filters: presetFiltersList,
          filename: fileName,
          loader: const Center(child: CircularProgressIndicator()),
          fit: BoxFit.contain,
        ),
      ),
    );
    if (imagefile != null && imagefile.containsKey('image_filtered')) {
      filteredImage = imagefile['image_filtered'];
      Get.to(() => const UploadDescription());
    }
  }

  uploadPost() {
    FocusScope.of(Get.context!).unfocus();
    var filename = DataUtil.makeFilePath();
    var task = uploadFile(
        filteredImage!, '/${AuthController.to.user.value.uid}/$filename');
    if (task != null) {
      task.snapshotEvents.listen((event) async {
        if (event.bytesTransferred == event.totalBytes &&
            event.state == TaskState.success) {
          var downloadUrl = await event.ref.getDownloadURL();
          var updatePost = post!.copyWith(
            thumbnail: downloadUrl,
            description: textEditingController.text,
          );
          submitPost(updatePost);
        }
      });
    }
  }

  void submitPost(Post postData) async {
    await PostRepository.updatePost(postData);
    showDialog(
      context: Get.context!,
      builder: (context) => MessagePopUp(
          title: 'Post',
          message: 'Posting is completed!',
          okCallBack: () {
            Get.until((route) => Get.currentRoute == '/');
          }),
    );
  }

  UploadTask uploadFile(File file, String filename) {
    var ref = FirebaseStorage.instance.ref().child('instagram').child(filename);
    var metadata = SettableMetadata(
      contentType: 'image/jpeg',
      customMetadata: <String, String>{'picked-file-path': file.path},
    );
    return ref.putFile(file, metadata);
  }
}
