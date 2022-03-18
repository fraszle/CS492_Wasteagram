import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:wasteagram/models/food_waste_post.dart';

class PostDetails extends StatelessWidget {
  const PostDetails({required this.post, Key? key}) : super(key: key);

  final FoodWastePost post;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Text(
          DateFormat.yMMMEd().format(post.date),
          style: Theme.of(context).textTheme.headline4,
        ),
        SizedBox(height: 300, width: 300, child: Image.network(post.imageURL)),
        Text(
          post.quantity.toString(),
          style: Theme.of(context).textTheme.headline4,
        ),
        Text('Location: (${post.latitude}, ${post.longitude})')
      ],
    );
  }
}
