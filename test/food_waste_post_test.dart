import 'package:test/test.dart';
import 'package:wasteagram/models/food_waste_post.dart';

void main() {
  test('Post created from a Map should have matching values', () {
    final date = DateTime.now().millisecondsSinceEpoch;
    const url = 'FAKE.org';
    const latitude = 1.0;
    const longitude = -122.0;
    const quantity = 28;

    final foodWastePost = FoodWastePost.fromMap({
      'date': date,
      'imageURL': url,
      'latitude': latitude,
      'longitude': longitude,
      'quantity': quantity
    });

    expect(foodWastePost.date, DateTime.fromMillisecondsSinceEpoch(date));
    expect(foodWastePost.imageURL, url);
    expect(foodWastePost.latitude, latitude);
    expect(foodWastePost.longitude, longitude);
    expect(foodWastePost.quantity, quantity);
  });
}
