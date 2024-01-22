import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class FeedbackScreen extends StatefulWidget {
  @override
  _FeedbackScreenState createState() => _FeedbackScreenState();
}

class _FeedbackScreenState extends State<FeedbackScreen> {
  final TextEditingController _feedbackController = TextEditingController();

  Future<void> _submitFeedback() async {
    try {
      final url = Uri.https(
        'nmhk-9204c-default-rtdb.asia-southeast1.firebasedatabase.app',
        'feedback.json',
      );

      final response = await http.post(
        url,
        body: json.encode(
          {
            'feedback': _feedbackController.text.trim(),
          },
        ),
        headers: {'Content-Type': 'application/json'},
      );

      final responseData = json.decode(response.body);
      print(responseData);

      if (response.statusCode == 200) {
        // Feedback submitted successfully
        // Show a pop-up
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Feedback Submitted'),
              content: Text('Thank you for your feedback!'),
              actions: [
                TextButton(
                  onPressed: () {
                    // Close the dialog
                    Navigator.of(context).pop();

                    // Navigate back to the home screen
                    Navigator.of(context).pop();
                  },
                  child: Text('OK'),
                ),
              ],
            );
          },
        );
      } else {
        // Feedback submission failed
        // Handle the error, show a message to the user, etc.
      }
    } catch (error) {
      // Handle exceptions or errors
      print(error.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Feedback'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _feedbackController,
              decoration: InputDecoration(labelText: 'Feedback'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _submitFeedback,
              child: Text('Submit Feedback'),
            ),
          ],
        ),
      ),
    );
  }
}
