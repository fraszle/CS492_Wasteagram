import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:wasteagram/models/all_posts.dart';
import 'package:wasteagram/widgets/pick_image.dart';

class BasicScaffold extends StatelessWidget {
  const BasicScaffold(
      {required this.title,
      required this.child,
      this.analytics,
      this.observer,
      this.fab = false,
      this.posts,
      Key? key})
      : super(key: key);

  final Widget child;
  final Text title;
  final FirebaseAnalytics? analytics;
  final FirebaseAnalyticsObserver? observer;
  final bool fab;
  final AllPosts? posts;

  @override
  Widget build(BuildContext context) {
    if (fab) {
      return Scaffold(
          appBar: AppBar(centerTitle: true, title: title),
          body: Center(child: child),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
          floatingActionButton: Semantics(
              enabled: true,
              button: true,
              label: 'Button to display the device\'s photo gallery',
              onTapHint: 'Select an image',
              child: FloatingActionButton(
                  child: const Icon(Icons.photo_camera),
                  onPressed: () => {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return CameraScreen(
                            analytics: analytics!,
                            observer: observer!,
                          );
                        }))
                      })));
    } else {
      return Scaffold(
        appBar: AppBar(centerTitle: true, title: title),
        body: Center(child: child),
      );
    }
  }
}
