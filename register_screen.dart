import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'login_screen.dart'; // Import your login screen
import 'forgot_password.dart'; // Import your forgot password screen

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  Future<void> _register() async {
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

      final response = await http.post(
        url,
        body: json.encode(
          {
            'email': _emailController.text.trim(),
            'password': _passwordController.text.trim(),
            'returnSecureToken': true,
          },
        ),
        headers: {'Content-Type': 'application/json'},
      );

      final responseData = json.decode(response.body);
      print(responseData);

      if (response.statusCode == 200) {
        // Registration successful
        // For simplicity, just store the email in shared preferences
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('email', _emailController.text.trim());

        // Now, navigate to login screen
        _login();
      } else {
        // Registration failed
        // Handle the error, show a message to the user, etc.
      }
    } catch (error) {
      // Handle registration errors
      print(error.toString());
      // You can show an error message to the user if needed
    }
  }

  void _login() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LoginScreen()),
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
        title: Text('Register'),
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
              onPressed: _register,
              child: Text('Register'),
              style: ElevatedButton.styleFrom(
                primary: Colors.green, // Set button background color
              ),
            ),
            SizedBox(height: 10),
            TextButton(
              onPressed: _login,
              child: Text(
                'Already have an account? Sign In',
                style: TextStyle(color: Colors.green),
              ),
            ),
            TextButton(
              onPressed: _forgotPassword,
              child: Text(
                'Forgot Password?',
                style: TextStyle(color: Colors.green),
              ),
            ),
          ],
        ),
      ),
      backgroundColor: Colors.grey[200], // Set background color of the screen
    );
  }
}
