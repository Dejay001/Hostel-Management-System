import 'package:flutter/material.dart';

class FilterPage extends StatefulWidget {
  @override
  _FilterPageState createState() => _FilterPageState();
}

class _FilterPageState extends State<FilterPage> {
  String? selectedLocation;

  List<String> locations = [
    "Greater Accra",
    "Central",
    "Eastern",
    "North",
    // Add more locations as needed
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Filter Page"),
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Select Location:",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            DropdownButton<String>(
              value: selectedLocation,
              onChanged: (newValue) {
                setState(() {
                  selectedLocation = newValue;
                });
              },
              items: locations.map((location) {
                return DropdownMenuItem<String>(
                  value: location,
                  child: Text(location),
                );
              }).toList(),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Return the selected location to the previous screen
                Navigator.of(context).pop(selectedLocation);
              },
              child: Text("Apply Filter"),
            ),
          ],
        ),
      ),
    );
  }
}
