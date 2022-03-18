import 'package:flutter/material.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:wasteagram/screens/home_screen.dart';
import 'package:wasteagram/widgets/analytics.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const App(title: 'Wasteagram'));
}

class App extends StatelessWidget {
  static FirebaseAnalytics analytics = FirebaseAnalytics.instance;
  static FirebaseAnalyticsObserver observer =
      FirebaseAnalyticsObserver(analytics: analytics);

  final String title;

  const App({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Analytics analyticsRecorder = Analytics(analytics, observer);
    analyticsRecorder.logAppOpening();
    return MaterialApp(
        title: 'Wasteagram',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        navigatorObservers: <NavigatorObserver>[observer],
        home: HomeScreen(
          analytics: analytics,
          observer: observer,
        ));
  }
}
