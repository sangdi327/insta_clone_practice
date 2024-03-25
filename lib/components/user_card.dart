import 'package:flutter/material.dart';
import 'package:insta_clone/components/avatar_widget.dart';

class UserCard extends StatelessWidget {
  const UserCard({
    super.key,
    required this.userId,
    required this.description,
  });

  final String userId;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 5),
      width: 170,
      height: 220,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(3),
        border: Border.all(
          color: Colors.black12,
        ),
      ),
      child: Stack(
        children: [
          Positioned(
            left: 15,
            right: 15,
            top: 0,
            bottom: 0,
            child: Column(
              children: [
                const SizedBox(
                  height: 10,
                ),
                const AvatarWidget(
                  thumbPath:
                      'https://cdn.pixabay.com/photo/2014/04/10/11/06/tomatoes-320860_1280.jpg',
                  type: AvatarType.type2,
                  size: 80,
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  userId,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                  ),
                ),
                Text(
                  description,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                  ),
                  textAlign: TextAlign.center,
                ),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(10, 20),
                  ),
                  child: const Text('Follow'),
                ),
              ],
            ),
          ),
          Positioned(
            right: 5,
            top: 5,
            child: GestureDetector(
              onTap: () {},
              child: const Icon(
                Icons.close,
                size: 15,
                color: Colors.grey,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
