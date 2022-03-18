import 'dart:io';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:location/location.dart';
import 'package:wasteagram/widgets/basic_scaffold.dart';
import 'package:wasteagram/widgets/new_post_form.dart';

class NewPostScreen extends StatefulWidget {
  const NewPostScreen(
      {required this.image,
      required this.analytics,
      required this.observer,
      Key? key})
      : super(key: key);

  final File image;
  final FirebaseAnalytics analytics;
  final FirebaseAnalyticsObserver observer;

  @override
  State<NewPostScreen> createState() => _NewPostScreenState();
}

class _NewPostScreenState extends State<NewPostScreen> {
  final formKey = GlobalKey<FormState>();
  LocationData? locationData;
  var locationService = Location();
  String? url;

  Future<void> retrieveLocation() async {
    try {
      var _serviceEnabled = await locationService.serviceEnabled();
      if (!_serviceEnabled) {
        _serviceEnabled = await locationService.requestService();
        if (!_serviceEnabled) {
          print('Failed to enable service. Returning.');
          return;
        }
      }

      var _permissionGranted = await locationService.hasPermission();
      if (_permissionGranted == PermissionStatus.denied) {
        _permissionGranted = await locationService.requestPermission();
        if (_permissionGranted != PermissionStatus.granted) {
          print('Location service permission not granted. Returning.');
        }
      }

      locationData = await locationService.getLocation();
    } on PlatformException catch (e) {
      print('Error: ${e.toString()}, code: ${e.code}');
      locationData = null;
    }
    locationData = await locationService.getLocation();
  }

  Future<void> storeImage(File image) async {
    String pathname = 'img_' + DateTime.now().toString();
    Reference ref = FirebaseStorage.instance.ref().child(pathname);
    UploadTask uploadTask = ref.putFile(image);
    await uploadTask;
    url = await ref.getDownloadURL();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return BasicScaffold(
        title: const Text('New Post'), child: awaitData(locationData, url));
  }

  Widget awaitData(LocationData? locationData, String? url) {
    if (locationData == null || url == null) {
      retrieveLocation();
      storeImage(widget.image);
      return const Center(child: CircularProgressIndicator());
    } else {
      return NewPostForm(
        url: url,
        image: widget.image,
        locationData: locationData,
        formKey: formKey,
        analytics: widget.analytics,
        observer: widget.observer,
      );
    }
  }
}
