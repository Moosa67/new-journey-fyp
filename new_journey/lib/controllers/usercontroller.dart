// controllers/user_controller.dart
import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:new_journey/controllers/api_constants.dart';
import 'package:new_journey/models/hotelmodels.dart';

class UserController extends GetxController {
  final String baseUrl = ApiConstants.baseUrl; 

  final hotels = <HotelModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchHotels();
  }

  Future<void> fetchHotels() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/hotels'));

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        hotels.assignAll(data.map((hotel) => HotelModel.fromJson(hotel)).toList());
      } else {
        print('Failed to fetch hotels. Status code: ${response.statusCode}');
      }
    } catch (error) {
      print('Error fetching hotels: $error');
    }
  }
}
