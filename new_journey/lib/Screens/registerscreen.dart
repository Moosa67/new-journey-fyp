import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:geolocator/geolocator.dart';
// import 'package:new_journey/Screens/location_picker.dart';
import 'package:new_journey/Themes/colors.dart';
import 'package:new_journey/controllers/controllers.dart';
import 'package:new_journey/routes/routes.dart';
import '../controllers/validation_helper.dart';


class RegistrationScreen extends StatefulWidget {
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  String userType = "buyer";
  bool isOwnerFieldsVisible = false;
  double? ownerLatitude;
  double? ownerLongitude;

  final controller = Get.put(AuthController());
  final _formKey = GlobalKey<FormState>();
  bool isRegistrationButtonClicked = false;

  @override
  void initState() {
    super.initState();
    // _getCurrentLocation();
  }

  // Future<void> _getCurrentLocation() async {
  //   final position = await _getCurrentPosition();
  //   if (position != null) {
  //     setState(() {
  //       ownerLatitude = position.latitude;
  //       ownerLongitude = position.longitude;
  //       controller.locationController.text =
  //           "Lat: $ownerLatitude, Long: $ownerLongitude";
  //     });
  //   }
  // }

  Future<void> register() async {
    setState(() {
      isRegistrationButtonClicked = true;
    });

    if (_formKey.currentState!.validate()) {
      await controller.registerUser(
        name: controller.nameController.text,
        email: controller.emailController.text,
        password: controller.passwordController.text,
        cnic: controller.cnicController.text,
        phoneNumber: controller.phoneNumberController.text,
      );
      RouteManager.goToLogin();
    }
  }

  void onUserTypeChanged(String? value) {
    if (value != null) {
      setState(() {
        userType = value;
        isOwnerFieldsVisible = value == "owner";
      });
    }
  }

  Future<Position?> _getCurrentPosition() async {
    try {
      final status = await Geolocator.requestPermission();
      if (status == LocationPermission.denied) {
        return null;
      }
      final position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      return position;
    } catch (e) {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: secondary,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                const SizedBox(height: 20.0),
                Image.asset(
                  'assets/fyplogo.png',
                  width: 200,
                ),
                const SizedBox(height: 20),
                const Text(
                  "Create Your Account",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: primary,
                  ),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: controller.nameController,
                  style: const TextStyle(color: Colors.black),
                  decoration: const InputDecoration(
                    labelText: "Name",
                    labelStyle: TextStyle(color: Colors.black),
                    prefixIcon: Icon(Icons.person, color: Colors.black),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                    ),
                  ),
                  validator: (value) {
                    return ValidationHelper.validateName(value);
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: controller.emailController,
                  style: const TextStyle(color: Colors.black),
                  decoration: const InputDecoration(
                    labelText: "Email",
                    labelStyle: TextStyle(color: Colors.black),
                    prefixIcon: Icon(Icons.email, color: Colors.black),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                    ),
                  ),
                  validator: (value) {
                    return ValidationHelper.validateEmail(value);
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: controller.passwordController,
                  obscureText: true,
                  style: const TextStyle(color: Colors.black),
                  decoration: const InputDecoration(
                    labelText: "Password",
                    labelStyle: TextStyle(color: Colors.black),
                    prefixIcon: Icon(Icons.lock, color: Colors.black),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                    ),
                  ),
                  validator: (value) {
                    return ValidationHelper.validatePassword(value);
                  },
                ),
                Column(
                  children: [
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: controller.cnicController,
                      style: const TextStyle(color: Colors.black),
                      decoration: const InputDecoration(
                        labelText: "CNIC",
                        labelStyle: TextStyle(color: Colors.black),
                        prefixIcon: Icon(Icons.credit_card, color: Colors.black),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                        ),
                      ),
                      validator: (value) {
                        return ValidationHelper.validateCnic(value, userType);
                      },
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: controller.phoneNumberController,
                      style: const TextStyle(color: Colors.black),
                      decoration: const InputDecoration(
                        labelText: "Phone Number",
                        labelStyle: TextStyle(color: Colors.black),
                        prefixIcon: Icon(Icons.phone, color: Colors.black),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    // ElevatedButton(
                    //   onPressed: () async {
                    //     var result = await showDialog(
                    //       context: context,
                    //       builder: (BuildContext context) {
                    //         return MyLocationPickerDialog();
                    //       },
                    //     );
                    //     if (result != null) {
                    //       print(result[0]);
                    //       print(result[1]);
                    //       controller.locationController.text =
                    //           "Lat: ${result[0]}, Long: ${result[1]}";
                    //     } else {
                    //       print('Dialog closed without a result');
                    //     }
                    //   },
                    //   style: ElevatedButton.styleFrom(
                    //     primary: Colors.black, // Set the desired color
                    //   ),
                    //   child: Container(
                    //     height: 50,
                    //     width: 400, // Set the desired width for the button
                    //     child: const Center(
                    //       child: Text(
                    //         "Get Location",
                    //         style: TextStyle(color: Colors.white),
                    //       ),
                    //     ),
                    //   ),
                    // ),
                    const SizedBox(height: 16),
                  ],
                ),
                Container(
                  height: 50, // Set the desired height for the button
                  width: 400, // Set the desired width for the button
                  child: ElevatedButton(
                    onPressed: register,
                    style: ElevatedButton.styleFrom(
                      primary: Colors.black,
                    ),
                    child: const Text(
                      'Register',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
