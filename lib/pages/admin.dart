import 'dart:io';

import 'package:hostelmanagement/pages//registration_screen.dart';
import 'package:cached_network_image/cached_network_image.dart';

// import 'package:catalogue/utils/color_palette.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hostelmanagement/MODEL/addedproduct.dart';
import 'package:hostelmanagement/utils/color_palette.dart';
import 'package:image_picker/image_picker.dart';



import '../widget/product_group_card.dart';

class admin extends StatefulWidget {
   admin({Key? key}) : super(key: key);

  @override
  State<admin> createState() => _adminState();
}

class _adminState extends State<admin> {

  final TextEditingController _newProductGroup = TextEditingController();

  final addedProduct newProduct = addedProduct();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(

        automaticallyImplyLeading : false,
        backgroundColor:    Colors.black,
        centerTitle: true,
        title:         Row(
          children: [

             Text(
              "Hostel Management",
              style: TextStyle(
                fontFamily: "Nunito",
                fontSize: 18,
                color: ColorPalette.white,
              ),
            ),
          ],
        ),
        actions: [ Padding(
          padding: const EdgeInsets.only(right: 10),
          child: IconButton(
            onPressed: () {


              showDialog<void>(
                context: context,
                barrierDismissible: false, // user must tap button!
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text('Sign Out'),
                    backgroundColor: Colors.white,
                    content: SingleChildScrollView(
                      child: Column(
                        children: <Widget>[
                          Text('Are you certain you want to Sign Out?'),
                        ],
                      ),
                    ),
                    actions: <Widget>[
                      TextButton(
                        child: Text(
                          'Yes',
                          style: TextStyle(color: Colors.black),
                        ),
                        onPressed: () {
                          print('yes');
                          FirebaseAuth.instance.signOut();
                          Navigator.pushNamedAndRemoveUntil(
                              context, "/SignIn", (route) => false);
                          // Navigator.of(context).pop();
                        },
                      ),
                      TextButton(
                        child: Text(
                          'Cancel',
                          style: TextStyle(color: Colors.red),
                        ),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  );
                },
              );
            },
            icon: const Icon(
              Icons.logout,
              color: Colors.black38,
            ),
          ),
        ),],

      ),

      body:
        SafeArea(
          child: Container(
            color: ColorPalette.aquaHaze,
            height: double.infinity,
            width: double.infinity,
            child: Column(
              children: [
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                          top:10.0,
                      left: 10,
                      right:10),
                      child: Container(

                        padding: const EdgeInsets.only(
                          top: 0,
                          left: 10,
                          right: 15,
                        ),
                        width: 170,
                        height: 160,

                        decoration: const BoxDecoration(
                          color:Colors.white,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(36),
                            topRight: Radius.circular(36),
                            bottomLeft: Radius.circular(36),
                            bottomRight: Radius.circular(36),
                          ),
                        ),

                        child: Padding(
                          padding: const EdgeInsets.all(13.0),
                          child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Text("Hi",style: TextStyle(
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold

                                ),),




                              ],
                            ),

                                Padding(
                                  padding: const EdgeInsets.all(28.0),
                                  child: GestureDetector(



                                      onTap: () {
                                        showDialog(
                                          context: context,
                                          builder: (context) {
                                            return AlertDialog(
                                              title: const Text(
                                                "Add Estate Category ",
                                                style: TextStyle(fontFamily: "Nunito"),
                                              ),
                                              content: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  Container(
                                                    decoration: BoxDecoration(
                                                      color: ColorPalette.white,
                                                      borderRadius: BorderRadius.circular(12),
                                                      boxShadow: [
                                                        BoxShadow(
                                                          offset: const Offset(0, 3),
                                                          blurRadius: 6,
                                                          color: const Color(0xff000000).withOpacity(0.16),
                                                        ),
                                                      ],
                                                    ),
                                                    height: 50,
                                                    child: TextField(
                                                      textInputAction: TextInputAction.next,
                                                      key: UniqueKey(),
                                                      controller: _newProductGroup,
                                                      keyboardType: TextInputType.text,
                                                      style: const TextStyle(
                                                        fontFamily: "Nunito",
                                                        fontSize: 16,
                                                        color: ColorPalette.nileBlue,
                                                      ),
                                                      decoration: InputDecoration(
                                                        border: InputBorder.none,
                                                        hintText: "Add Estate Category",
                                                        filled: true,
                                                        fillColor: Colors.transparent,
                                                        hintStyle: TextStyle(
                                                          fontFamily: "Nunito",
                                                          fontSize: 16,
                                                          color: ColorPalette.nileBlue.withOpacity(0.58),
                                                        ),
                                                      ),
                                                      cursorColor: ColorPalette.timberGreen,
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    height: 20,
                                                  ),
                                                  GestureDetector(
                                                    onTap: () async {
                                                      if (_newProductGroup.text != null &&
                                                          _newProductGroup.text != "") {
                                                        try {
                                                          final DocumentSnapshot<Map<String, dynamic>>
                                                          _doc = await _firestore
                                                              .collection("Utiles")
                                                              .doc("EstateCategories ")
                                                              .get();
                                                          final List<dynamic> _tempList =
                                                          _doc.data()!['list'] as List<dynamic>;
                                                          if (_tempList.contains(_newProductGroup.text)) {
                                                            displayToast("Group Name already created",context,);
                                                          } else {
                                                            _tempList.add(_newProductGroup.text);
                                                            _firestore
                                                                .collection('Utiles')
                                                                .doc("EstateCategories ")
                                                                .update({'list': _tempList});
                                                            displayToast("Added Successfully",context,);
                                                          }
                                                        } catch (e) {
                                                          displayToast("An Error Occured!",context,);
                                                        }
                                                        // ignore: use_build_context_synchronously
                                                        Navigator.of(context).pop();
                                                        _newProductGroup.text = "";
                                                      } else {
                                                        displayToast("Enter Valid Name!",context,);
                                                      }
                                                    },
                                                    child: Container(
                                                      height: 45,
                                                      width: 90,
                                                      decoration: BoxDecoration(
                                                        borderRadius: BorderRadius.circular(20),
                                                        color: ColorPalette.white,
                                                        boxShadow: [
                                                          BoxShadow(
                                                            offset: const Offset(0, 3),
                                                            blurRadius: 6,
                                                            color:
                                                            const Color(0xff000000).withOpacity(0.16),
                                                          ),
                                                        ],
                                                      ),
                                                      child: const Center(
                                                        child: Text(
                                                          "Done",
                                                          style: TextStyle(

                                                            fontSize: 15,
                                                            fontFamily: "Nunito",
                                                            color: Colors.black,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            );
                                          },
                                        );
                                      },
                                      // onTap: (){
                                      //   Navigator.pushNamed(
                                      //       context,"/addproduct");
                                      //
                                      // },
                                      child: Icon(Icons.add,
                                      color:   Color.fromRGBO(216, 78, 16, 1),)),
                                ),



                          ],
                      ),
                        ),

                      ),
                    ),
                  ],
                ),
     SizedBox(height: 28,),
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
                )
              ],
            ),
          ),
        ),


    );}

}
