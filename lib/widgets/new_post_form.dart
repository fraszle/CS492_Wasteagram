import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:location/location.dart';
import 'package:wasteagram/db/new_post_dto.dart';
import 'package:wasteagram/widgets/analytics.dart';

class NewPostForm extends StatelessWidget {
  const NewPostForm(
      {required this.url,
      required this.image,
      required this.locationData,
      required this.formKey,
      required this.analytics,
      required this.observer,
      Key? key})
      : super(key: key);

  final GlobalKey<FormState> formKey;
  final LocationData locationData;
  final File image;
  final String url;
  final FirebaseAnalytics analytics;
  final FirebaseAnalyticsObserver observer;

  @override
  Widget build(BuildContext context) {
    NewPostDTO newPost = NewPostDTO();

    return Form(
      key: formKey,
      child: Column(
        children: [
          Center(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                Semantics(
                    image: true,
                    child: SizedBox(
                      width: 300,
                      height: 300,
                      child: Image.file(
                        image,
                        semanticLabel: 'Selected image displayed',
                      ),
                    )),
                const SizedBox(
                  height: 40,
                ),
              ])),
          Semantics(
            textField: true,
            enabled: true,
            label: 'Text field to enter number of items',
            hint: 'Enter an integer representing the quantity of items',
            child: TextFormField(
              textAlign: TextAlign.center,
              decoration: const InputDecoration(labelText: 'Number of items'),
              style: Theme.of(context).textTheme.headline5,
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.digitsOnly
              ],
              validator: (value) {
                if (int.tryParse(value!) is int) {
                  return null;
                }
                return 'Please enter an integer';
              },
              onSaved: (value) {
                newPost.quantity = int.tryParse(value!);
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Semantics(
              button: true,
              enabled: true,
              label: 'Button to submit the form',
              onTapHint: 'Submit form',
              child: ElevatedButton(
                  onPressed: (() {
                    if (formKey.currentState!.validate()) {
                      formKey.currentState!.save();
                      fillDTOandLog(newPost);
                      saveToFirebase(newPost);
                      Navigator.pop(context);
                    }
                  }),
                  child: const Text('Upload')),
            ),
          ),
        ],
      ),
    );
  }

  void logPostEvent(int date, NewPostDTO newPost) {
    Analytics analyticsRecorder = Analytics(analytics, observer);
    analyticsRecorder.logScreenViews('New-post-form-screen');
    analyticsRecorder.sendAnalyticsEvent(date, url, newPost.quantity!,
        locationData.latitude!, locationData.longitude!);
  }

  void fillDTOandLog(NewPostDTO newPost) {
    int currDate = DateTime.now().millisecondsSinceEpoch;
    newPost.date = currDate;
    newPost.latitude = locationData.latitude;
    newPost.longitude = locationData.longitude;
    newPost.imageURL = url;
    logPostEvent(currDate, newPost);
  }

  void saveToFirebase(NewPostDTO newPost) {
    FirebaseFirestore.instance.collection('posts').add(newPost.getMap());
  }
}
