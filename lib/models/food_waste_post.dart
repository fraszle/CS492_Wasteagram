class FoodWastePost {
  DateTime date;
  String imageURL;
  int quantity;
  double latitude;
  double longitude;

  FoodWastePost(
      this.date, this.imageURL, this.latitude, this.longitude, this.quantity);

  factory FoodWastePost.fromMap(Map<String, dynamic> dbPost) {
    DateTime date = DateTime.fromMillisecondsSinceEpoch(dbPost['date']);
    return FoodWastePost(date, dbPost['imageURL'], dbPost['latitude'],
        dbPost['longitude'], dbPost['quantity']);
  }
}
