import 'dart:io';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:wasteagram/screens/new_post_screen.dart';
import 'package:wasteagram/widgets/basic_scaffold.dart';

class CameraScreen extends StatefulWidget {
  const CameraScreen(
      {required this.analytics, required this.observer, Key? key})
      : super(key: key);

  final FirebaseAnalytics analytics;
  final FirebaseAnalyticsObserver observer;

  @override
  State<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  File? image;
  String? url;

  final picker = ImagePicker();
  void getImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    image = File(pickedFile!.path);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    if (image == null) {
      getImage();
      return const BasicScaffold(
          title: Text('Loading...'), child: CircularProgressIndicator());
    } else {
      return NewPostScreen(
        image: image!,
        analytics: widget.analytics,
        observer: widget.observer,
      );
    }
  }
}
