import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:insta_clone/model/post.dart';

class PostRepository {
  static Future<void> updatePost(Post postData) async {
    await FirebaseFirestore.instance.collection('posts').add(postData.toMap());
  }

  static Future<List<Post>> loadFeedList() async {
    var document = FirebaseFirestore.instance
        .collection('posts')
        .orderBy('createAt', descending: true)
        .limit(10);
    var data = await document.get();
    return data.docs.map<Post>((e) => Post.fromJson(e.id, e.data())).toList();
  }
}
