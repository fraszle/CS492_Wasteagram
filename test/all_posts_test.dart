import 'package:test/test.dart';
import 'package:wasteagram/models/all_posts.dart';

void main() {
  group('All Posts', () {
    test(
        'AllPosts.tallyTotalWaste should match the summed quantity from all FoodWastePosts',
        () {
      AllPosts allPosts = AllPosts();

      for (var i = 0; i < 5; i++) {
        int msDate = DateTime.now().millisecondsSinceEpoch;

        final Map<String, dynamic> post = {
          'date': msDate,
          'imageURL': 'FAKE.org',
          'latitude': 1.0,
          'longitude': 1.0,
          'quantity': 1
        };

        allPosts.createPosts(post);
      }

      expect(allPosts.tallyTotalWaste(), 5);
    });

    test('AllPosts.getLength should match the number of FoodWastePosts created',
        () {
      AllPosts allPosts = AllPosts();

      for (var i = 0; i < 3; i++) {
        int msDate = DateTime.now().millisecondsSinceEpoch;

        final Map<String, dynamic> post = {
          'date': msDate,
          'imageURL': 'FAKE.org',
          'latitude': 1.0,
          'longitude': 1.0,
          'quantity': 1
        };

        allPosts.createPosts(post);
      }

      expect(allPosts.getLength(), 3);
    });
  });
}
