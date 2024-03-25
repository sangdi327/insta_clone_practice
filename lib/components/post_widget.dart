import 'package:cached_network_image/cached_network_image.dart';
import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:insta_clone/components/avatar_widget.dart';
import 'package:insta_clone/components/image_data.dart';
import 'package:insta_clone/model/post.dart';
import 'package:timeago/timeago.dart' as timeago;

class PostWidget extends StatelessWidget {
  const PostWidget({super.key, required this.post});
  final Post post;

  Widget header() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          AvatarWidget(
            thumbPath: post.userInfo!.thumbnail!,
            type: AvatarType.type3,
            nickname: post.userInfo!.nickname,
            size: 40,
          ),
          GestureDetector(
            onTap: () {},
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ImageData(
                IconsPath.postMoreIcon,
                width: 30,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget image() {
    return CachedNetworkImage(
      imageUrl: post.thumbnail!,
    );
  }

  Widget infoCount() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              ImageData(
                IconsPath.likeOffIcon,
                width: 65,
              ),
              const SizedBox(
                width: 15,
              ),
              ImageData(
                IconsPath.replyIcon,
                width: 60,
              ),
              const SizedBox(
                width: 15,
              ),
              ImageData(
                IconsPath.directMessage,
                width: 55,
              ),
            ],
          ),
          ImageData(
            IconsPath.bookMarkOffIcon,
            width: 50,
          ),
        ],
      ),
    );
  }

  Widget description() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            '좋아요 ${post.likeCount ?? 0}개',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          ExpandableText(
            post.description ?? '',
            prefixText: post.userInfo!.nickname,
            onPrefixTap: () {},
            prefixStyle: const TextStyle(fontWeight: FontWeight.bold),
            expandText: '더보기',
            collapseText: '접기',
            maxLines: 3,
            linkColor: Colors.grey,
          ),
        ],
      ),
    );
  }

  Widget replyText() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: GestureDetector(
        onTap: () {},
        child: const Text(
          '댓글 100개 모두 보기',
          style: TextStyle(
            color: Colors.grey,
            fontSize: 13,
          ),
        ),
      ),
    );
  }

  Widget passedDate() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: Text(
        timeago.format(post.createAt!),
        style: const TextStyle(color: Colors.grey, fontSize: 13),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          header(),
          const SizedBox(
            height: 15,
          ),
          image(),
          const SizedBox(
            height: 15,
          ),
          infoCount(),
          const SizedBox(
            height: 5,
          ),
          description(),
          const SizedBox(
            height: 5,
          ),
          replyText(),
          const SizedBox(
            height: 5,
          ),
          passedDate(),
        ],
      ),
    );
  }
}
