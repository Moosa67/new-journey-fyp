import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:new_journey/controllers/api_constants.dart';

class OwnerController extends GetxController {
  static const String baseUrl = ApiConstants.baseUrl;

//   Future<void> uploadHotel({
//     required String title,
//     required String description,
//     required String price,
//     required String location,
//     required String phoneNumber,
//   }) async {
//     final url = Uri.parse('$baseUrl/hotels');
//     try {
//       final response = await http.post(
//         url,
//         headers: {
//           'Content-Type': 'application/json',
//         },
//         body: jsonEncode({
//           'title': title,
//           'description': description,
//           'price': price,
//           'location': location,
//           'phoneNumber': phoneNumber,
//         }),
//       );

//       if (response.statusCode == 201) {
//         print('Hotel uploaded successfully');
//       } else {
//         print('Failed to upload hotel. Status code: ${response.statusCode}');
//         throw Exception('Failed to upload hotel');
//       }
//     } catch (error) {
//       print('Error uploading hotel: $error');
//       throw Exception('Error uploading hotel');
//     }
//   }
// }
Future<void> uploadHotel({
  required String title,
  required String description,
  required String price,
  required String location,
  required String phoneNumber,
}) async {
  try {
    final response = await http.post(
      Uri.parse('$baseUrl/hotel'),  // Update route path here
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'title': title,
        'description': description,
        'price': price,
        'location': location,
        'phoneNumber': phoneNumber,
      }),
    );

    if (response.statusCode == 201) {
      print('Hotel uploaded successfully');
    } else {
      print('Failed to upload hotel. Status code: ${response.statusCode}');
      throw Exception('Failed to upload hotel');
    }
  } catch (error) {
    print('Error uploading hotel: $error');
    throw Exception('Error uploading hotel');
  }
}
}
