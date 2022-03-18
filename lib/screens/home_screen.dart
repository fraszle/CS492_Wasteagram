import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:wasteagram/models/all_posts.dart';
import 'package:wasteagram/widgets/basic_scaffold.dart';
import 'package:wasteagram/widgets/post_list.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({required this.analytics, required this.observer, Key? key})
      : super(key: key);

  final FirebaseAnalytics analytics;
  final FirebaseAnalyticsObserver observer;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  CollectionReference postsCollection =
      FirebaseFirestore.instance.collection('posts');

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: postsCollection.orderBy('date', descending: true).snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return BasicScaffold(
                title: const Text('Wasteagram'),
                child: Text("Something went wrong: ${snapshot.error}"));
          }
          if (snapshot.hasData) {
            AllPosts allPosts = AllPosts();

            for (var doc in snapshot.data!.docs) {
              allPosts.createPosts(doc.data() as Map<String, dynamic>);
            }
            if (allPosts.getLength() == 0) {
              return BasicScaffold(
                fab: true,
                title: const Text('Wasteagram'),
                analytics: widget.analytics,
                observer: widget.observer,
                child: const CircularProgressIndicator(),
              );
            } else {
              return BasicScaffold(
                fab: true,
                title: Text('Wasteagram - ${allPosts.tallyTotalWaste()}'),
                child: CreatePostList(
                  posts: allPosts.posts,
                  analytics: widget.analytics,
                  observer: widget.observer,
                ),
                analytics: widget.analytics,
                observer: widget.observer,
              );
            }
          } else {
            return const BasicScaffold(
              title: Text('Wasteagram'),
              child: CircularProgressIndicator(),
            );
          }
        });
  }
}
