import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hostelmanagement/MODEL/Users.dart';
import 'package:hostelmanagement/MODEL/assistantmethods.dart';
import 'package:hostelmanagement/pages/login.dart';
import 'package:hostelmanagement/utils/color_palette.dart';
import 'package:provider/provider.dart';
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
        .where('Bookstatus', isEqualTo: "pending")
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



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false, // Set this to false to remove the back arrow
        title: Text('Booking Page'),
      ),
      body: isLoading
          ? Center(
        child: CircularProgressIndicator(),
      )
          : Padding(
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
//willdo mediaq
                height: MediaQuery
                    .of(context)
                    .size
                    .height,

                child: ListView.builder(
                  itemCount: hostelDetailsSnapshot?.docs.length,
                  itemBuilder: (BuildContext context, int index) {
                    DocumentSnapshot document = hostelDetailsSnapshot?.docs[index] as DocumentSnapshot<Object?>;
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

                              ElevatedButton(
                                onPressed: ()  {
                                  acceptBooking(document.id);

                                  },
                                child: Text('Accept Booking'),
                              ),

                            ],
                          ),
                          onTap: () {
                            // showBookingDialog(document);
                          },
                        ),
                      ),
                    );
                  },
                ),),
              // ElevatedButton(
              //   onPressed: acceptBooking,
              //   child: Text('Accept Booking'),
              // ),

            ],
          ),
        ),
      ),
    );
  }
  void acceptBooking(String documentId) async {

    String? quantity;
    DocumentSnapshot bookingSnapshot =
    await FirebaseFirestore.instance.collection('Estates')
        .doc(documentId)
        .get();
    if (bookingSnapshot.exists) {
      // Extract the apartmentId from the booking document
      int quantity = bookingSnapshot['quantity'];
      String bookedquantity = bookingSnapshot['bookedRoom'];

      num sub = quantity - int.parse(bookedquantity);

      FirebaseFirestore.instance.collection('Estates').doc(documentId).update({
        'bookeremail': Provider
            .of<Users>(context, listen: false)
            .userInfo!
            .email!,
        "bookedRoom": bookedquantity,
        "Bookstatus": "Accepted",
        "quantity": sub,

        'Accepteddate': DateTime.now(),
        'bookedAppartment': documentId,
        // Add more booking details as per your requirements
      });
      displayToast("Thank you, Your booking will be aprroved", context);
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('You Approved A Booking'),
              content: Container(
                  height: 50,
                  child: Column(
                    children: [
                      Text('Room Approved'),
                    ],
                  )),
              actions: [
                TextButton(
                    child: Text("Return"),
                    onPressed: () {
                      Navigator.pop(context); // Close the dialog
                      //   makeCall(document);
                      // },
                    }),
              ],
            );
            //
          });
    } }}