import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hostelmanagement/MODEL/addedproduct.dart';
import 'package:hostelmanagement/pages/product_details_page.dart';
import 'package:hostelmanagement/utils/color_palette.dart';


class hosteldetails extends StatefulWidget {

  final String hostelcat;

  hosteldetails({required this.hostelcat});

  @override
  _hosteldetailsState createState() => _hosteldetailsState();
}

class _hosteldetailsState extends State<hosteldetails> {
   QuerySnapshot? hostelDetailsSnapshot;

  @override
  void initState() {
    super.initState();
    fetchHostelDetails();
  }

  Future<void> fetchHostelDetails() async {
    QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('Estates')
        .where('group', isEqualTo: widget.hostelcat)
        .get();

    setState(() {
      hostelDetailsSnapshot = snapshot;
    });
  }

  void showBookingDialog(DocumentSnapshot document) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Choose an action'),
          content: Text('Do you want to book or call?'),
          actions: [
            TextButton(
              child: Text('Book'),
              onPressed: () {
                Navigator.pop(context); // Close the dialog
                bookHostel(document.id);
              },
            ),
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.pop(context); // Close the dialog
                //   makeCall(document);
                // },
              }
            ),
          ],
        );
      },
    );
  }

  void bookHostel(String documentId) {
    // Perform the booking process and store booking details in Firestore
    // using the same document ID as a booking
    // Replace the following code with your own implementation
    // Example code to update the booking details
    FirebaseFirestore.instance.collection('bookings').doc(documentId).set({
      'user': 'John Doe',
      'date': DateTime.now(),
      // Add more booking details as per your requirements
    });
  }

  void makeCall(DocumentSnapshot document) {
    // Perform call functionality using the provided document
    // Replace the following code with your own implementation
    String phoneNumber = document['phone'];
    // Use a phone calling library or platform-specific functionality
    // to make the call with the given phone number
    print('Making call to: $phoneNumber');
  }

  @override
  Widget build(BuildContext context) {

   if (hostelDetailsSnapshot == null) {
      return Center(child: CircularProgressIndicator());
    }
   return Scaffold(

    body: Column(
      children:[


        Padding(
          padding: const EdgeInsets.only(top:28.0),
          child: Container(
            height: 50,
            padding: const EdgeInsets.only(
              top: 0,
              left: 10,
              right: 15,
            ),



            decoration:  BoxDecoration(

              boxShadow: [
                BoxShadow(
                  offset: const Offset(0, 5),
                  blurRadius: 6,
                  color: const Color(0xff000000).withOpacity(0.16),
                ),
              ],
              color:Colors.white70,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(36),
                topRight: Radius.circular(36),
                bottomLeft: Radius.circular(36),
                bottomRight: Radius.circular(36),
              ),
            ),

            child: Row(

              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [


                Text("Hostels",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 21),),




              ],),),
        ),
        Container(

          height: 399,

          child:
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
                  padding: const EdgeInsets.only(top:1.0),
                  child: SizedBox(
                    height: 87,
                    width: 57,
                    child: CachedNetworkImage(
                        fit: BoxFit.fill, imageUrl: document['image'],),
                  ),
                ),
                title: Padding(
                  padding: const EdgeInsets.only(top:28.0),
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
                  showBookingDialog(document);
                },
              ),
            ),
          );
        },
      ),
        )]));
  }

}
