import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:antoh/Screens/registration_screen.dart';
import 'package:cached_network_image/cached_network_image.dart';

// import 'package:catalogue/utils/color_palette.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:antoh/MODEL/addedproduct.dart';
import 'package:image_picker/image_picker.dart';

import '../MODEL/addedproduct.dart';
import '../utils/color_palette.dart';
import '../widget/product_group_card.dart';
class propertydetails extends StatefulWidget {
  const propertydetails({Key? key}) : super(key: key);

  @override
  State<propertydetails> createState() => _propertydetailsState();
}

class _propertydetailsState extends State<propertydetails> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
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
                _firestore.collection("Utiles").snapshots(),
                builder: (
                    BuildContext context,
                    AsyncSnapshot<
                        QuerySnapshot<Map<String, dynamic>>>
                    snapshot,
                    ) {
                  if (snapshot.hasData) {
                    final List<dynamic> _productGroups =
                    snapshot.data!.docs[0].data()['List']
                    as List<dynamic>;
                    _productGroups.sort();
                    return GridView.builder(
                      gridDelegate:
                      const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 2,
                        crossAxisSpacing: 30,
                        mainAxisSpacing: 20,
                      ),
                      itemCount: _productGroups.length,
                      itemBuilder: (context, index) {
                        return ProductGroupCard(
                          name: _productGroups[index] as String,
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
