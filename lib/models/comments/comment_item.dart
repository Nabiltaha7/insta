import 'package:flutter/material.dart';
import '../../shared/widgets/user_avatar.dart';

class CommentItem extends StatelessWidget {
  final String username;
  final String text;
  final String? image;
  final bool isMe;

  const CommentItem({
    super.key,
    required this.username,
    required this.text,
    this.image,
    this.isMe = false,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (!isMe)
          Padding(
            padding: const EdgeInsets.only(right: 8),
            child: UserAvatar(imagePath: image, size: 35),
          ),
        Flexible(
          child: Container(
            padding: EdgeInsets.all(10),
            margin: EdgeInsets.symmetric(vertical: 4),
            decoration: BoxDecoration(
              color: isMe ? Colors.blue[100] : Colors.grey[200],
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              crossAxisAlignment:
                  isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
              children: [
                Text(
                  username,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                ),
                Text(text),
              ],
            ),
          ),
        ),
        if (isMe)
          Padding(
            padding: const EdgeInsets.only(left: 8),
            child: UserAvatar(imagePath: image, size: 35),
          ),
      ],
    );
  }
}
