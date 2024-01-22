import 'package:flutter/material.dart';
import 'StateModel.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class PlaceSearchScreen extends StatefulWidget {
  @override
  _PlaceSearchScreenState createState() => _PlaceSearchScreenState();
}

class _PlaceSearchScreenState extends State<PlaceSearchScreen> {
  List<StateModel> _statesList = List.from(statesList);

  TextEditingController _nameController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Place Search/Notes'),
        backgroundColor: Colors.green, // Set app bar background color
      ),
      body: Container(
        color: Colors.lightGreenAccent, // Set background color of the body
        child: ListView.builder(
          itemCount: _statesList.length,
          itemBuilder: (context, index) {
            return Card(
              elevation: 3.0,
              margin: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
              child: ListTile(
                title: Text(_statesList[index].name),
                subtitle: Text(_statesList[index].description),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: Icon(Icons.edit),
                      onPressed: () {
                        _editDestination(index);
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () {
                        _deleteDestination(index);
                      },
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _addDestination();
        },
        child: Icon(Icons.notes), // Change the icon here
        backgroundColor: Colors.green, // Set FAB background color
      ),
    );
  }

  void _addDestination() async {
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Add Destination'),
          content: Column(
            children: [
              TextField(
                controller: _nameController,
                decoration: InputDecoration(labelText: 'Name'),
              ),
              TextField(
                controller: _descriptionController,
                decoration: InputDecoration(labelText: 'Description'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                _register();
                Navigator.pop(context);
              },
              child: Text('Add'),
            ),
          ],
        );
      },
    );
  }

  void _editDestination(int index) async {
    _nameController.text = _statesList[index].name;
    _descriptionController.text = _statesList[index].description;

    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Edit Destination'),
          content: Column(
            children: [
              TextField(
                controller: _nameController,
                decoration: InputDecoration(labelText: 'Name'),
              ),
              TextField(
                controller: _descriptionController,
                decoration: InputDecoration(labelText: 'Description'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  _statesList[index] = StateModel(
                    name: _nameController.text,
                    description: _descriptionController.text,
                  );
                });
                Navigator.pop(context);
              },
              child: Text('Save'),
            ),
          ],
        );
      },
    );
  }

  void _deleteDestination(int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Delete Destination'),
          content: Text('Are you sure you want to delete ${_statesList[index].name}?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  _statesList.removeAt(index);
                });
                Navigator.pop(context);
              },
              child: Text('Delete'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _register() async {
    if (_nameController.text.trim().isEmpty || _descriptionController.text.trim().isEmpty) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Warning'),
          content: Text('Please fill in both name and description.'),
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
        'notes.json',
      );

      final response = await http.post(
        url,
        body: json.encode(
          {
            'name': _nameController.text.trim(),
            'description': _descriptionController.text.trim(),
            'returnSecureToken': true,
          },
        ),
        headers: {'Content-Type': 'application/json'},
      );

      final responseData = json.decode(response.body);
      print(responseData);

      if (response.statusCode == 200) {
        setState(() {
          _statesList.add(
            StateModel(
              name: _nameController.text.trim(),
              description: _descriptionController.text.trim(),
            ),
          );
        });

        _nameController.clear();
        _descriptionController.clear();
      } else {
        // Handle the error
      }
    } catch (error) {
      print(error.toString());
    }
  }
}

void main() {
  runApp(MaterialApp(
    home: PlaceSearchScreen(),
    theme: ThemeData(
      primaryColor: Colors.green,
    ),
  ));
}
