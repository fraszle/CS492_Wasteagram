import 'package:firebase_analytics/firebase_analytics.dart';

class Analytics {
  final FirebaseAnalytics analytics;
  final FirebaseAnalyticsObserver observer;

  Analytics(this.analytics, this.observer);

  Future<void> logAppOpening() async {
    await analytics.logAppOpen();
  }

  Future<void> logScreenViews(String screenName) async {
    await analytics.logScreenView(screenName: screenName);
  }

  Future<void> sendAnalyticsEvent(int date, String imageURL, int quantity,
      double latitude, double longitude) async {
    await analytics.logEvent(
      name: 'new_post_submitted',
      parameters: <String, dynamic>{
        'date': date,
        'imageURL': imageURL,
        'quantity': quantity,
        'latitude': latitude,
        'longitude': longitude
      },
    );
  }
}
