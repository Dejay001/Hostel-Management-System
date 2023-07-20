import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hostelmanagement/MODEL/assistantmethods.dart';
import 'package:hostelmanagement/utils/color_palette.dart';
class bookedhostels extends StatefulWidget {
   bookedhostels({Key? key}) : super(key: key);

  @override
  State<bookedhostels> createState() => _bookedhostelsState();
}

class _bookedhostelsState extends State<bookedhostels> {

  String? bookingId;
String? apartmentId;
bool isLoading = false;
  QuerySnapshot? hostelDetailsSnapshot;

  Future<void> fetchHostelDetails() async {
    QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('Estates')
        .where('Bookstatus', isEqualTo:"pending")
        .get();

    setState(() {
      hostelDetailsSnapshot = snapshot;
    });
  }

  @override
  void initState() {
    super.initState();
    fetchHostelDetails();
    AssistantMethods.getCurrentOnlineUserInfo(context);
  }

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
            ListView.builder(
              itemCount: hostelDetailsSnapshot!.docs.length,
              itemBuilder: (BuildContext context, int index) {
                DocumentSnapshot document = hostelDetailsSnapshot!.docs[index];
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    height: 127,
                    decoration: BoxDecoration(
                      color: ColorPalette.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          offset: const Offset(0, 5),
                          blurRadius: 6,
                          color: const Color(0xff000000).withOpacity(0.06),
                        ),
                      ],
                    ),
                    child: ListTile(
                      leading: Padding(
                        padding: const EdgeInsets.only(top: 1.0),
                        child: SizedBox(
                          height: 87,
                          width: 57,
                          child: CachedNetworkImage(
                            fit: BoxFit.fill,
                            imageUrl: document['image'],
                          ),
                        ),
                      ),
                      title: Padding(
                        padding: const EdgeInsets.only(top: 28.0),
                        child: Text(document['name']),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Cost: \GHS ${document['Cost']}'),
                          Text('Available Rooms: ${document['quantity']}'),
                        ],
                      ),
                      onTap: () {
                        // showBookingDialog(document);
                      },
                    ),
                  ),
                );
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