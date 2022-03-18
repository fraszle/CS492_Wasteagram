import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/food_waste_post.dart';
import '../screens/detail_screen.dart';

class CreatePostList extends StatelessWidget {
  const CreatePostList(
      {required this.posts,
      required this.analytics,
      required this.observer,
      Key? key})
      : super(key: key);

  final List<FoodWastePost> posts;
  final FirebaseAnalytics analytics;
  final FirebaseAnalyticsObserver observer;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: posts.length,
      itemBuilder: (context, index) {
        return Semantics(
          label: 'Tile displaying post date and item quantity',
          onTapHint: 'Open post detail view',
          child: ListTile(
            title: formatDate(posts[index].date),
            trailing: Text(posts[index].quantity.toString()),
            onTap: () => postDetailsNavigator(context, posts[index]),
          ),
        );
      },
    );
  }

  Text formatDate(DateTime date) {
    return Text(DateFormat.yMMMMEEEEd().format(date));
  }

  Future<dynamic> postDetailsNavigator(
      BuildContext context, FoodWastePost post) {
    return Navigator.of(context).push(MaterialPageRoute(
        builder: ((context) => DetailsScreen(
              post: post,
              analytics: analytics,
              observer: observer,
            ))));
  }
}
