import 'package:flutter/material.dart';
import 'StateModel.dart';

class ChooseDestinationScreen extends StatelessWidget {
  final List<StateModel> statesList;

  ChooseDestinationScreen({required this.statesList});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Choose Destination'),
      ),
      body: ListView.builder(
        itemCount: statesList.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(statesList[index].name),
            subtitle: Text(statesList[index].description),
            onTap: () {
              _chooseState(context, statesList[index]);
            },
          );
        },
      ),
    );
  }

  void _chooseState(BuildContext context, StateModel chosenState) {
    Navigator.pop(context, chosenState);
  }
}
