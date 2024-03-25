import 'package:flutter/material.dart';
import 'package:insta_clone/components/avatar_widget.dart';

class ActiveHistory extends StatelessWidget {
  const ActiveHistory({super.key});

  Widget activeitemOne() {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          AvatarWidget(
            thumbPath:
                'https://cdn.pixabay.com/photo/2014/04/10/11/06/tomatoes-320860_1280.jpg',
            type: AvatarType.type2,
            size: 40,
          ),
          SizedBox(
            width: 10,
          ),
          Expanded(
            child: Text.rich(
              TextSpan(
                  text: '한식집',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                  children: [
                    TextSpan(
                      text: '님이 회원님의 게시물을 좋아합니다.',
                      style: TextStyle(
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                    TextSpan(
                      text: '5일 전',
                      style: TextStyle(
                        fontWeight: FontWeight.normal,
                        fontSize: 13,
                        color: Colors.black54,
                      ),
                    ),
                  ]),
            ),
          ),
        ],
      ),
    );
  }

  Widget todayView(String day) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            day,
            style: const TextStyle(
              fontSize: 16,
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          activeitemOne(),
          activeitemOne(),
          activeitemOne(),
          activeitemOne(),
          activeitemOne(),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Activity',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            todayView('Today'),
            todayView('This week'),
            todayView('This month'),
          ],
        ),
      ),
    );
  }
}
