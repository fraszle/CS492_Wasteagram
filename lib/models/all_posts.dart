import 'package:wasteagram/models/food_waste_post.dart';

class AllPosts {
  List<FoodWastePost> posts = [];

  AllPosts();

  void createPosts(Map<String, dynamic> dbPost) {
    posts.add(FoodWastePost.fromMap(dbPost));
  }

  List<FoodWastePost> getPosts() {
    return posts;
  }

  int tallyTotalWaste() {
    int total = 0;
    for (var item in posts) {
      total += item.quantity;
    }
    return total;
  }

  int getLength() {
    return posts.length;
  }
}
