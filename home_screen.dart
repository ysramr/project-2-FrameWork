import 'package:flutter/material.dart';
import 'FeedbackScreen.dart';
import 'PlaceSearchScreen.dart';
import 'QAScreen.dart';
import 'DestinationScreen.dart';
import 'StateModel.dart';
import 'login_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<StateModel> _destinations = statesList;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('AmMap'),
        backgroundColor: Colors.green,
        actions: [
          IconButton(
            icon: Icon(Icons.place),
            onPressed: () {
              _openDestinationScreen();
            },
          ),
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              _logout();
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Welcome to AmMap!',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
                color: Colors.green,
              ),
            ),
            SizedBox(height: 16.0),
            Text(
              'Let\' Learn the AmMap:',
              style: TextStyle(
                fontSize: 18.0,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 16.0),
            CakeStep(number: 1, instruction: 'after Login you can choose icon location at bottom for see all state.'),
            CakeStep(number: 2, instruction: 'you can give admin some feedback in icon feedback, .'),
            CakeStep(number: 3, instruction: 'you can ask me any question.'),
            CakeStep(number: 4, instruction: 'you can using the Search/ notes to save your travel.'),
            // ... continue with the rest of the steps
            SizedBox(height: 20),
            
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.green,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              icon: Icon(Icons.feedback),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => FeedbackScreen()),
                );
              },
            ),
            IconButton(
              icon: Icon(Icons.notes),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PlaceSearchScreen()),
                );
              },
            ),
            IconButton(
              icon: Icon(Icons.question_answer),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => QAScreen()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  void _openDestinationScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DestinationScreen(destinations: _destinations),
      ),
    );
  }

  void _logout() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LoginScreen()),
    );
  }
}

class CakeStep extends StatelessWidget {
  final int number;
  final String instruction;

  CakeStep({required this.number, required this.instruction});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: CircleAvatar(
        backgroundColor: Colors.green,
        child: Text(
          '$number',
          style: TextStyle(color: Colors.white),
        ),
      ),
      title: Text(
        instruction,
        style: TextStyle(fontSize: 16.0),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: HomeScreen(),
    theme: ThemeData(
      primaryColor: Colors.green,
    ),
  ));
}
