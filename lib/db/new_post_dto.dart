class NewPostDTO {
  int? date;
  String? imageURL;
  int? quantity;
  double? latitude;
  double? longitude;

  NewPostDTO();

  Map<String, dynamic> getMap() {
    return {
      'date': date,
      'imageURL': imageURL,
      'quantity': quantity,
      'latitude': latitude,
      'longitude': longitude
    };
  }
}
