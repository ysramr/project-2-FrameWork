import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class QAScreen extends StatefulWidget {
  @override
  _QAScreenState createState() => _QAScreenState();
}

class _QAScreenState extends State<QAScreen> {
  final TextEditingController _questionController = TextEditingController();

  Future<void> _askQuestion() async {
    try {
      final url = Uri.https(
        'nmhk-9204c-default-rtdb.asia-southeast1.firebasedatabase.app',
        'questions.json',
      );

      final response = await http.post(
        url,
        body: json.encode(
          {
            'question': _questionController.text.trim(),
          },
        ),
        headers: {'Content-Type': 'application/json'},
      );

      final responseData = json.decode(response.body);
      print(responseData);

      if (response.statusCode == 200) {
        // Question submitted successfully
        // Show a pop-up
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Question Submitted'),
              content: Text('Your question has been submitted!'),
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
        // Question submission failed
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
        title: Text('Q&A'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _questionController,
              decoration: InputDecoration(labelText: 'Ask a Question'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _askQuestion,
              child: Text('Ask Question'),
            ),
          ],
        ),
      ),
    );
  }
}
void main() {
  runApp(MaterialApp(
    home: QAScreen(),
    theme: ThemeData(
      primaryColor: Colors.green, // Set your primary color
    ),
  ));
}
