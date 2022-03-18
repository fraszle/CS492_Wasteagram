import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:wasteagram/models/food_waste_post.dart';
import 'package:wasteagram/widgets/analytics.dart';
import 'package:wasteagram/widgets/basic_scaffold.dart';
import 'package:wasteagram/widgets/post_details.dart';

class DetailsScreen extends StatelessWidget {
  const DetailsScreen(
      {required this.post,
      required this.analytics,
      required this.observer,
      Key? key})
      : super(key: key);

  final FoodWastePost post;
  final FirebaseAnalytics analytics;
  final FirebaseAnalyticsObserver observer;

  @override
  Widget build(BuildContext context) {
    logAnalytics();
    return BasicScaffold(
        title: const Text('Post Details'),
        child: PostDetails(
          post: post,
        ));
  }

  Future<void> logAnalytics() async {
    Analytics analyticsRecorder = Analytics(analytics, observer);
    await analyticsRecorder.logScreenViews('${post.date}-Detail-View');
  }
}
