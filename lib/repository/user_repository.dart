import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:insta_clone/model/instagram_user.dart';

class UserRepository {
  static Future<IUser?> loginUserByUid(String uid) async {
    print(uid);
    var data = await FirebaseFirestore.instance
        .collection('users')
        .where('uid', isEqualTo: uid)
        .get();

    if (data.size == 0) {
      return null;
    } else {
      return IUser.fromJson(data.docs.first.data());
    }
  }

  static Future<bool> signUp(IUser user) async {
    try {
      await FirebaseFirestore.instance.collection('users').add(user.toMap());
      return true;
    } catch (e) {
      return false;
    }
  }
}
