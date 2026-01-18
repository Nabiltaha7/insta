import 'dart:io';
import 'package:flutter/material.dart';

class UserAvatar extends StatelessWidget {
  final String? imagePath;
  final double size;

  const UserAvatar({super.key, this.imagePath, this.size = 40});

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: size / 2,
      backgroundImage:
          imagePath != null &&
                  imagePath!.isNotEmpty &&
                  File(imagePath!).existsSync()
              ? FileImage(File(imagePath!))
              : null,
      child:
          (imagePath == null || imagePath!.isEmpty)
              ? Icon(Icons.person, size: size * 0.6)
              : null,
    );
  }
}
