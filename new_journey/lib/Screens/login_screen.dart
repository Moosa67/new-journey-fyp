import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_journey/Screens/owner_dashboard.dart';
import 'package:new_journey/controllers/controllers.dart';
import '../controllers/validation_helper.dart';
import '../routes/routes.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  String _userType = "guest";
  bool _passwordVisible = false;

  final _formKey = GlobalKey<FormState>();
  final AuthController controller = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 20.0),
                Image.asset(
                  'assets/fyplogo.png',
                  width: 200,
                ),
                const SizedBox(height: 20),
                const Text(
                  "Login to Your Account",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),
                Column(
                  children: [
                    TextFormField(
                      controller: emailController,
                      style: const TextStyle(color: Colors.black),
                      validator: (value) {
                        return ValidationHelper.validateEmail(value);
                      },
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
                    ),
                    const SizedBox(height: 8),
                  ],
                ),
                const SizedBox(height: 16),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black),
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: ListTile(
                          leading: Radio(
                            value: "guest",
                            groupValue: _userType,
                            onChanged: (value) {
                              setState(() {
                                _userType = value!;
                              });
                            },
                          ),
                          title: const Text("guest",
                              style: TextStyle(color: Colors.black)),
                        ),
                      ),
                      const VerticalDivider(),
                      Expanded(
                        child: ListTile(
                          leading: Radio(
                            value: "owner",
                            groupValue: _userType,
                            onChanged: (value) {
                              setState(() {
                                _userType = value!;
                              });
                            },
                          ),
                          title: const Text("Owner",
                              style: TextStyle(color: Colors.black)),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: passwordController,
                  obscureText: !_passwordVisible,
                  style: const TextStyle(color: Colors.black),
                  validator: (value) {
                    return ValidationHelper.validatePassword(value);
                  },
                  decoration: InputDecoration(
                    labelText: "Password",
                    labelStyle: const TextStyle(color: Colors.black),
                    prefixIcon: const Icon(Icons.lock, color: Colors.black),
                    suffixIcon: GestureDetector(
                      onTap: () {
                        setState(() {
                          _passwordVisible = !_passwordVisible;
                        });
                      },
                      child: Icon(
                        _passwordVisible
                            ? Icons.visibility
                            : Icons.visibility_off,
                        color: Colors.black,
                      ),
                    ),
                    border: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                    ),
                    focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                    ),
                    enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {
                      // Add logic for "Forgot Password"
                    },
                    child: const Text("Forgot Password?",
                        style: TextStyle(color: Colors.black)),
                  ),
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: () async {
                    login(
                      emailController.text,
                      passwordController.text,
                      _userType,
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    primary: const Color.fromARGB(255, 66, 66, 66),
                    minimumSize: const Size(double.infinity, 50),
                  ),
                  child: const Text("Login"),
                ),
                const SizedBox(height: 16),
                GestureDetector(
                  onTap: () {
                    RouteManager.navigateToRegistrationScreen();
                  },
                  child: const Text(
                    "Don't have an account? Register",
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
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

  Future<void> login(String email, String password, String userType) async {
    if (_formKey.currentState!.validate()) {
      try {
        await controller.loginUser(
          email: email,
          password: password,
          type: _userType,
        );
        final type = controller.getUserType();
        if(type == 'owner'){
          Get.offAll(OwnerDashboard());
        }
        else{

        RouteManager.goToDashboard();
        }
      } catch (e) {
        Get.snackbar('Error', e.toString());
      }
    }
  }
}
