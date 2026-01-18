import 'package:flutter/material.dart';
import 'package:get/get.dart';

class VideoView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('video'.tr)),
      body: Center(
        child: Text('Video Page (Coming Soon)', style: TextStyle(fontSize: 18)),
      ),
    );
  }
}
