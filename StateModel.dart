import 'package:flutter/material.dart';

class StateModel {
  final String name;
  final String description;

  StateModel({
    required this.name,
    required this.description,
  });
}

List<StateModel> statesList = [
  StateModel(name: 'Terengganu, Pulau Redang', description: 'Redang Beach Resort, which is located at Pasir Panjang on Redang Island, is an ideal place to stay for your holiday. It stretches across a white sandy beach and provides an easy access to the nearby coral gardens. Redang Beach Resort offers basic and comfortable accommodation of 22 Standard units, 76 Superior units and 40 Club Deluxe units for your choices. All rooms are air-conditioned with attached toilets and bathrooms. These rooms are specially designed to cater the needs of family, couple and individual trips. '),
  StateModel(name: 'Penang, Escape Pineng', description: 'ESCAPE Penang is the fun destination with exciting rides and games hosted in a natural environment. ESCAPE Penang re-introduces the play and values of yesteryear so to inject reality into a world overdependent on an isolation-inducing electronic lifestyle. Through fun activities, with an emphasis on self-directed and self-powered play, the visitor experiences Low Tech, High Fun. ESCAPE Penang demonstrates there’s no age limit to having fun as the rides and games are designed for a wide range of age groups, abilities, and energy levels.'),
  StateModel(name: 'Kedah, Pulau Langkawi', description: 'Langkawi, officially known by its sobriquet Langkawi, the Jewel of Kedah (Malay: Langkawi Permata Kedah), is a duty-free island and an archipelago of 99 islands (plus five small islands visible only at low tide in the Strait of Malacca) located some 30 km off the coast of northwestern Malaysia and a few kilometres.'),
  StateModel(name: 'Kelantan, Pasar Khadijah', description: 'Pasar ini mempunyai 4 tingkat dan berbentuk segi lapan. Tingkat bawah dikhususkan untuk barangan basah seperti ikan, sayur-sayuran, ayam dan sebagainya. Tingkat 1 pula diperuntukkan kepada barangan makanan kering seperti serunding, iaitu sejenis makanan Kelantan yang sangat terkenal..'),
  StateModel(name: 'Johor, Lego Land', description: 'Home to the most successful rides, slides, shows and attractions from LEGOLAND Parks around the world, LEGOLAND Malaysia Resort is tailor-made for the local environment. It covers the same area of more than 50 full size football pitches and contains more than 15,000 LEGO models made from over 60 million LEGO bricks. Other LEGOLAND Resorts are located in Japan, United Arab Emirates, Denmark, Germany, United States, and the United Kingdom..'),
  StateModel(name: 'Kuala Lumpur, Petronas Twin Tower', description: 'oaring to a height of 451.9 metres, the 88-storey twin structure is Kuala Lumpu s crown jewel. Majestic by day and dazzling at night, the PETRONAS Twin Towers is inspired by Tun Mahathir Mohamads vision for Malaysia to be a global player..'),
  
];

void main() {
  runApp(MaterialApp(
    home: HomeScreen(),
    theme: ThemeData(
      primaryColor: Colors.green,
    ),
  ));
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('State Details'),
        backgroundColor: Colors.green,
      ),
      body: ListView.builder(
        itemCount: statesList.length,
        itemBuilder: (context, index) {
          return CakeStep(
            number: index + 1,
            name: statesList[index].name,
            description: statesList[index].description,
          );
        },
      ),
    );
  }
}

class CakeStep extends StatelessWidget {
  final int number;
  final String name;
  final String description;

  CakeStep({
    required this.number,
    required this.name,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        // Navigate to the state details screen
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => StateDetailsScreen(
              stateName: name,
              stateDescription: description,
            ),
          ),
        );
      },
      child: ListTile(
        contentPadding: EdgeInsets.zero,
        leading: CircleAvatar(
          backgroundColor: Colors.green,
          child: Text(
            '$number',
            style: TextStyle(color: Colors.white),
          ),
        ),
        title: Text(
          name,
          style: TextStyle(fontSize: 16.0),
        ),
      ),
    );
  }
}

class StateDetailsScreen extends StatelessWidget {
  final String stateName;
  final String stateDescription;

  StateDetailsScreen({
    required this.stateName,
    required this.stateDescription,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(stateName),
        backgroundColor: Colors.green,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              stateName,
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
                color: Colors.green,
              ),
            ),
            SizedBox(height: 16.0),
            Text(
              stateDescription,
              style: TextStyle(
                fontSize: 18.0,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}