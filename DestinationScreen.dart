import 'package:flutter/material.dart';
import 'StateModel.dart';
import 'ReviewDestinationScreen.dart';
import 'ChooseDestinationScreen.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class DestinationScreen extends StatefulWidget {
  final List<StateModel> destinations;

  DestinationScreen({required this.destinations});

  @override
  _DestinationScreenState createState() => _DestinationScreenState();
}

class _DestinationScreenState extends State<DestinationScreen> {
  StateModel? selectedState;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Destinations'),
      ),
      body: SafeArea(
        child: Container(
          color: Colors.green,
          child: ListView.builder(
            itemCount: widget.destinations.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(widget.destinations[index].name),
                subtitle: Text(widget.destinations[index].description),
                trailing: IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () {
                    _deleteDestination(index);
                  },
                ),
                onTap: () {
                  _openReviewScreen(widget.destinations[index]);
                },
              );
            },
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _openChooseDestinationScreen();
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.green,
      ),
    );
  }

  void _deleteDestination(int index) {
    setState(() {
      widget.destinations.removeAt(index);
    });
  }

  void _openReviewScreen(StateModel destination) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ReviewDestinationScreen(destination: destination),
      ),
    );
  }

  void _openChooseDestinationScreen() async {
    final chosenState = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ChooseDestinationScreen(statesList: widget.destinations),
      ),
    );

    if (chosenState != null && chosenState is StateModel) {
      if (!widget.destinations.contains(chosenState)) {
        setState(() {
          widget.destinations.add(chosenState);
        });
      }
    }
  }

  void fetchData() async {
    try {
      final url = Uri.https(
        'nmhk-9204c-default-rtdb.asia-southeast1.firebasedatabase.app',
        'destination.json',
      );

      final response = await http.get(url);

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
      } else {
        print('Failed to fetch data. Status code: ${response.statusCode}');
      }
    } catch (error) {
      print('Error fetching data: $error');
    }
  }
}
