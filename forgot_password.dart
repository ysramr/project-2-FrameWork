import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ForgotPasswordScreen extends StatefulWidget {
  @override
  _ForgotPasswordScreenState createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  TextEditingController _emailController = TextEditingController();

  Future<void> _forgotPassword() async {
    try {
      final url = Uri.https(
        'your-reset-password-endpoint-url', // Replace with your actual reset password endpoint
        'reset_password',
      );

      final response = await http.post(
        url,
        body: json.encode(
          {
            'email': _emailController.text.trim(),
          },
        ),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        // Password reset link sent successfully
        print('Password reset link sent. Check your email.');
      } else {
        // Password reset link request failed
        print('Failed to request password reset. Please try again.');
      }
    } catch (error) {
      // Handle errors
      print(error.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Forgot Password'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _forgotPassword,
              child: Text('Reset Password'),
            ),
          ],
        ),
      ),
    );
  }
}
