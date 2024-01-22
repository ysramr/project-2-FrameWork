import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'home_screen.dart'; // Import your home screen
import 'register_screen.dart'; // Import your register screen
import 'forgot_password.dart'; // Import your forgot password screen

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  Future<void> _login() async {
    // Check if email and password are not empty
    if (_emailController.text.trim().isEmpty || _passwordController.text.trim().isEmpty) {
      // Display a warning to fill in both email and password
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Warning'),
          content: Text('Please fill in both email and password.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('OK'),
            ),
          ],
        ),
      );
      return;
    }

    try {
      final url = Uri.https(
        'nmhk-9204c-default-rtdb.asia-southeast1.firebasedatabase.app',
        'signup.json',
      );

      final response = await http.get(url);
      final responseData = json.decode(response.body);

      bool isUserFound = false;

      // Check if the entered email and password match any registered user
      for (final user in responseData.entries) {
        if (user.value['email'] == _emailController.text.trim() &&
            user.value['password'] == _passwordController.text.trim()) {
          isUserFound = true;
          break;
        }
      }

      if (isUserFound) {
        // Login successful, navigate to home screen
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HomeScreen()),
        );
      } else {
        // Invalid login, handle the error or show a message
        print('Invalid login');
      }
    } catch (error) {
      // Handle login errors
      print(error.toString());
    }
  }

  void _register() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => RegisterScreen()),
    );
  }

  void _forgotPassword() {
    // Navigate to the forgot password screen
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ForgotPasswordScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
        backgroundColor: Colors.green, // Set app bar background color
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _emailController,
              decoration: InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 10),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(
                labelText: 'Password',
                border: OutlineInputBorder(),
              ),
              obscureText: true,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _login,
              child: Text('Login'),
              style: ElevatedButton.styleFrom(
                primary: Colors.blue, // Set button background color
              ),
            ),
            SizedBox(height: 10),
            TextButton(
              onPressed: _register,
              child: Text(
                'Don\'t have an account? Register',
                style: TextStyle(color: Colors.blue),
              ),
            ),
            TextButton(
              onPressed: _forgotPassword,
              child: Text(
                'Forgot Password?',
                style: TextStyle(color: Colors.blue),
              ),
            ),
          ],
        ),
      ),
      backgroundColor: Colors.grey[200], // Set background color of the screen
    );
  }
}
