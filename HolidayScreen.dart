import 'package:flutter/material.dart';
import 'StateModel.dart';

class HolidayScreen extends StatelessWidget {
  final StateModel selectedState;

  HolidayScreen({required this.selectedState});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Holidays in ${selectedState.name}'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'State: ${selectedState.name}',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text('Description: ${selectedState.description}'),
            // Add more content related to holidays in the selected state
          ],
        ),
      ),
    );
  }
}
