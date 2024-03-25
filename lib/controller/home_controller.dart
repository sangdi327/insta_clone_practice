import 'package:get/get.dart';
import 'package:insta_clone/model/post.dart';
import 'package:insta_clone/repository/post_repository.dart';

class HomeController extends GetxController {
  RxList<Post> postList = <Post>[].obs;
  @override
  void onInit() {
    super.onInit();
    loadFeedList();
  }

  void loadFeedList() async {
    var feedList = await PostRepository.loadFeedList();
    postList.addAll(feedList);
    print(feedList.length);
  }
}
