import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
class bookedhostels extends StatefulWidget {
   bookedhostels({Key? key}) : super(key: key);

  @override
  State<bookedhostels> createState() => _bookedhostelsState();
}

class _bookedhostelsState extends State<bookedhostels> {

  String? bookingId;
String? apartmentId;
bool isLoading = false;




  Future<void> acceptBooking() async {
    setState(() {
      isLoading = true;
    });

    // Get the booking document from the bookings collection
    DocumentSnapshot bookingSnapshot =
    await FirebaseFirestore.instance.collection('bookings').doc().get();

    if (bookingSnapshot.exists) {
      // Extract the apartmentId from the booking document
      apartmentId = bookingSnapshot['Appartment'];

      // Search the estates collection for the matching apartmentId
      DocumentSnapshot estateSnapshot = await FirebaseFirestore.instance
          .collection('Estates')
          .doc(apartmentId)
          .get();

      if (estateSnapshot.exists) {
        // Update the available rooms count in the estates document
        int availableRooms = estateSnapshot['availableRooms'];
        if (availableRooms > 0) {
          // Accept the booking
          await FirebaseFirestore.instance.collection('bookings').doc(bookingId).update({
            'status': 'accepted',
            'estateDetails': estateSnapshot.data(),
          });

          // Subtract 1 from the available rooms count
          await FirebaseFirestore.instance.collection('estates').doc(apartmentId).update({
            'availableRooms': availableRooms - 1,
          });

          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('Booking Accepted'),
                content: Text('The booking has been accepted.'),
                actions: [
                  TextButton(
                    child: Text('OK'),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              );
            },
          );
        } else {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('Booking Declined'),
                content: Text('No available rooms in the selected apartment.'),
                actions: [
                  TextButton(
                    child: Text('OK'),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              );
            },
          );
        }
      }
    }

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Booking Page'),
      ),
      body: isLoading
          ? Center(
        child: CircularProgressIndicator(),
      )
          : Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Booking ID:',
              style: TextStyle(fontSize: 16),
            ),
            TextField(
              onChanged: (value) {
                setState(() {
                  bookingId = value;
                });
              },
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: acceptBooking,
              child: Text('Accept Booking'),
            ),
          ],
        ),
      ),
    );
  }
}