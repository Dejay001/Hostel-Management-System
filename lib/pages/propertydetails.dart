import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

// import 'package:catalogue/utils/color_palette.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hostelmanagement/data/data_home.dart';
import 'package:image_picker/image_picker.dart';

import '../MODEL/addedproduct.dart';
import '../utils/color_palette.dart';
import '../widget/product_group_card.dart';
class propertydetails extends  StatefulWidget {
   propertydetails({Key? key,  this.hostelcat}) : super(key: key);


   final  String? hostelcat;

  @override
  State<propertydetails> createState() => _propertydetailsState(hostelcat);
}

class _propertydetailsState extends State<propertydetails> {

 final  String? hostelcat;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  _propertydetailsState( this.hostelcat);
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
appBar: AppBar(
title: Text("PROPERTY DETAILS",style: TextStyle(color: Colors.white),),
),
      body: Container(
height: 566,
        child: Row(
          children: [
            Expanded(
              child: StreamBuilder(
                stream:
                _firestore.collection("Estates").where("group" ,isEqualTo:hostelcat ).snapshots(),
                builder: (
                    BuildContext context,
                    AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                    snapshot,
                    ) {
                  if (snapshot.hasData) {
                    // final List<dynamic> _productGroups =
                    // snapshot.data!.docs[0].data()['List']
                    // as List<dynamic>;
                    // _productGroups.sort();
                    return GridView.builder(
                      gridDelegate:
                      const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 2,
                        crossAxisSpacing: 30,
                        mainAxisSpacing: 20,
                      ),
                      itemCount: snapshot.data?.docs.length,
                      itemBuilder: (context, index) {
                        var data = snapshot.data!.docs;
                        return ProductGroupCard(
                          name: data[index]['name'],
                          key: UniqueKey(),
                        );
                      },
                    );
                  } else {
                    return const Center(
                      child: SizedBox(
                        height: 40,
                        width: 40,
                        child: CircularProgressIndicator(
                          color: ColorPalette.pacificBlue,
                        ),
                      ),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
