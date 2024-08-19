class HotelModel {
  final String title;
  final String description;
  final String price;
  final String location;
  final String phoneNumber;

  HotelModel({
    required this.title,
    required this.description,
    required this.price,
    required this.location,
    required this.phoneNumber,
  });

  factory HotelModel.fromJson(Map<String, dynamic> json) {
    return HotelModel(
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      price: json['price'] ?? '',
      location: json['location'] ?? '',
      phoneNumber: json['phoneNumber'] ?? '',
    );
  }
}
