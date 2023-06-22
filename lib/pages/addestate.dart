import 'dart:io';

// import 'package:antoh/Pages/homepage.dart';
import 'package:antoh/functions/toast.dart';
import 'package:antoh/main.dart';
import 'package:antoh/MODEL//Users.dart';

import 'package:antoh/utils/color_palette.dart';
import 'package:antoh/widget/progressDialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'dart:io' as io;
import 'package:path/path.dart';
import 'package:provider/provider.dart';

import '../MODEL/addedproduct.dart';
class addproduct extends StatefulWidget {
  const addproduct({Key? key, this.group}) : super(key: key);
final  String? group;
  @override
  State<addproduct> createState() => _addproductState( group);
}


class _addproductState extends State<addproduct> {
  List<File> _image = [];

  String? group;
  _addproductState(this.group);
  final picker = ImagePicker();
  double val = 0;
  final ImagePicker imagePicker = ImagePicker();
  bool uploading = false;
  final addedProduct newProduct = addedProduct();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  CollectionReference? imgRef;
  firebase_storage.Reference? ref;


  @override
  Widget build(BuildContext context) {

//     var firstname = Provider
//         .of<Users>(context)
//         .userInfo
//         ?.id!;
// var newprojectname=  newProduct.name;









    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: true,
        foregroundColor:  Color(0xff202020),
        backgroundColor: Colors.white,
        title: Row(
          children: [
            const Text(
              "New Estate",
              style: TextStyle(
                fontFamily: "Nunito",
                fontSize: 28,
                color: ColorPalette.timberGreen,
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(
          bottom: 10,
          right: 10,
        ),
        child: FloatingActionButton(
           onPressed: () async{
             showDialog(
                 context: context,
                 barrierDismissible: false,
                 builder: (BuildContext context) {
                   return ProgressDialog(
                     message: "Adding New Estate,Please wait.....",
                   );
                 });
             String url = await  uploadsFile();
             uploadsFile();
             Occupationdb();
            newProduct.group = group;
            _firestore
                .collection("Estates")
                .add({

              'image': url.toString(),
              'name': newProduct.name.toString(),
              'description': newProduct.description.toString(),
              'group': newProduct.group.toString(),
              'Company': newProduct.company.toString(),
              'Cost': newProduct.cost.toString(),
              'location': newProduct.location,
              'quantity': newProduct.quantity,
              //newProduct.toMap()
               })
                .then((value) {
              Navigator.of(context).pop();
              Navigator.of(context).pop();

              showTextToast('Added Sucessfully!');
            }).catchError((e) {
              showTextToast('Failed!');
            });
            // Navigator.of(context).pop();
           },
          splashColor: ColorPalette.bondyBlue,
          backgroundColor: Colors.white,
          child: const Icon(
            Icons.done,
            color:  Color.fromRGBO(216, 78, 16, 1),
          ),
        ),
      ),
      body: Container(
        color: ColorPalette.pacificBlue,
        child: SafeArea(
          child: Container(
            color: ColorPalette.aquaHaze,
            height: double.infinity,
            width: double.infinity,
            child: Column(
              children: [

                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: SizedBox(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: const [
                              SizedBox(
                                height: 20,
                              ),
                            ],
                          ),
                          Expanded(
                            child: Stack(
                              children: [
                                Container(
                                  height: double.infinity,
                                  width: double.infinity,
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 20,
                                    vertical: 50,
                                  ),
                                  margin: const EdgeInsets.only(top: 75),
                                  decoration: const BoxDecoration(
                                    color: Color(0xffd5e2e3),
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(16),
                                      topRight: Radius.circular(16),
                                    ),
                                  ),
                                  child: SingleChildScrollView(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(
                                            left: 8,
                                            bottom: 12,
                                          ),
                                          child: Column(
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                  left: 8, bottom: 12,),
                                                child: Text(
                                                  "Estate Type  : $group",
                                                  style: const TextStyle(
                                                    fontFamily: "Nunito",
                                                    fontSize: 17,
                                                    color: ColorPalette.nileBlue,
                                                  ),
                                                ),
                                              ),



                                            ],
                                          ),
                                        ),
                                        Container(
                                          decoration: BoxDecoration(
                                            color: ColorPalette.white,
                                            borderRadius:
                                                BorderRadius.circular(12),
                                            boxShadow: [
                                              BoxShadow(
                                                offset: const Offset(0, 3),
                                                blurRadius: 6,
                                                color: ColorPalette.nileBlue
                                                    .withOpacity(0.1),
                                              ),
                                            ],
                                          ),
                                          height: 50,
                                          child: TextFormField(
                                            initialValue: newProduct.name ?? '',
                                            onChanged: (value) {
                                              newProduct.name = value;
                                            },
                                            textInputAction:
                                                TextInputAction.next,
                                            key: UniqueKey(),
                                            keyboardType: TextInputType.text,
                                            style: const TextStyle(
                                              fontFamily: "Nunito",
                                              fontSize: 16,
                                              color: ColorPalette.nileBlue,
                                            ),
                                            decoration: InputDecoration(
                                              border: InputBorder.none,
                                              hintText: "Estate Name",
                                              filled: true,
                                              fillColor: Colors.transparent,
                                              hintStyle: TextStyle(
                                                fontFamily: "Nunito",
                                                fontSize: 16,
                                                color: ColorPalette.nileBlue
                                                    .withOpacity(0.58),
                                              ),
                                            ),
                                            cursorColor:
                                                ColorPalette.timberGreen,
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 20,
                                        ),
                                        Row(
                                          children: [
                                            Expanded(
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  color: ColorPalette.white,
                                                  borderRadius:
                                                      BorderRadius.circular(12),
                                                  boxShadow: [
                                                    BoxShadow(
                                                      offset:
                                                          const Offset(0, 3),
                                                      blurRadius: 6,
                                                      color: ColorPalette
                                                          .nileBlue
                                                          .withOpacity(0.1),
                                                    ),
                                                  ],
                                                ),
                                                height: 50,
                                                child: TextFormField(
                                                  initialValue:
                                                      newProduct.cost == null
                                                          ? ''
                                                          : newProduct.cost
                                                              .toString(),
                                                  onChanged: (value) {
                                                    newProduct.cost = value;
                                                    //    double.parse(value);
                                                  },
                                                  textInputAction:
                                                      TextInputAction.next,
                                                  key: UniqueKey(),
                                                  keyboardType:
                                                      TextInputType.number,
                                                  style: const TextStyle(
                                                    fontFamily: "Nunito",
                                                    fontSize: 16,
                                                    color:
                                                        ColorPalette.nileBlue,
                                                  ),
                                                  decoration: InputDecoration(
                                                    border: InputBorder.none,
                                                    hintText: "Cost",
                                                    filled: true,
                                                    fillColor:
                                                        Colors.transparent,
                                                    hintStyle: TextStyle(
                                                      fontFamily: "Nunito",
                                                      fontSize: 16,
                                                      color: ColorPalette
                                                          .nileBlue
                                                          .withOpacity(0.58),
                                                    ),
                                                  ),
                                                  cursorColor:
                                                      ColorPalette.timberGreen,
                                                ),
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 20,
                                            ),
                                            Expanded(
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  color: ColorPalette.white,
                                                  borderRadius:
                                                      BorderRadius.circular(12),
                                                  boxShadow: [
                                                    BoxShadow(
                                                      offset:
                                                          const Offset(0, 3),
                                                      blurRadius: 6,
                                                      color: ColorPalette
                                                          .nileBlue
                                                          .withOpacity(0.1),
                                                    ),
                                                  ],
                                                ),
                                                height: 50,
                                                child: TextFormField(
                                                  initialValue:
                                                      newProduct.quantity ==
                                                              null
                                                          ? ''
                                                          : newProduct.quantity
                                                              .toString(),
                                                  onChanged: (value) {
                                                    newProduct.quantity =
                                                        int.parse(value);
                                                  },
                                                  textInputAction:
                                                      TextInputAction.next,
                                                  key: UniqueKey(),
                                                  keyboardType:
                                                      TextInputType.number,
                                                  style: const TextStyle(
                                                    fontFamily: "Nunito",
                                                    fontSize: 16,
                                                    color:
                                                        ColorPalette.nileBlue,
                                                  ),
                                                  decoration: InputDecoration(
                                                    border: InputBorder.none,
                                                    hintText: "Room N0.",
                                                    filled: true,
                                                    fillColor:
                                                        Colors.transparent,
                                                    hintStyle: TextStyle(
                                                      fontFamily: "Nunito",
                                                      fontSize: 16,
                                                      color: ColorPalette
                                                          .nileBlue
                                                          .withOpacity(0.58),
                                                    ),
                                                  ),
                                                  cursorColor:
                                                      ColorPalette.timberGreen,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 20,
                                        ),
                                        Container(
                                          decoration: BoxDecoration(
                                            color: ColorPalette.white,
                                            borderRadius:
                                                BorderRadius.circular(12),
                                            boxShadow: [
                                              BoxShadow(
                                                offset: const Offset(0, 3),
                                                blurRadius: 6,
                                                color: ColorPalette.nileBlue
                                                    .withOpacity(0.1),
                                              ),
                                            ],
                                          ),
                                          height: 50,
                                          child: TextFormField(
                                            initialValue:
                                                newProduct.company ?? '',
                                            onChanged: (value) {
                                              newProduct.company = value;
                                            },
                                            textInputAction:
                                                TextInputAction.next,
                                            key: UniqueKey(),
                                            keyboardType: TextInputType.text,
                                            style: const TextStyle(
                                              fontFamily: "Nunito",
                                              fontSize: 16,
                                              color: ColorPalette.nileBlue,
                                            ),
                                            decoration: InputDecoration(
                                              border: InputBorder.none,
                                              hintText: "Company",
                                              filled: true,
                                              fillColor: Colors.transparent,
                                              hintStyle: TextStyle(
                                                fontFamily: "Nunito",
                                                fontSize: 16,
                                                color: ColorPalette.nileBlue
                                                    .withOpacity(0.58),
                                              ),
                                            ),
                                            cursorColor:
                                                ColorPalette.timberGreen,
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 20,
                                        ),
                                        Container(
                                          decoration: BoxDecoration(
                                            color: ColorPalette.white,
                                            borderRadius:
                                                BorderRadius.circular(12),
                                            boxShadow: [
                                              BoxShadow(
                                                offset: const Offset(0, 3),
                                                blurRadius: 6,
                                                color: ColorPalette.nileBlue
                                                    .withOpacity(0.1),
                                              ),
                                            ],
                                          ),
                                          height: 50,
                                          child: TextFormField(
                                            initialValue:
                                                newProduct.description ?? '',
                                            onChanged: (value) {
                                              newProduct.description = value;
                                            },
                                            textInputAction:
                                                TextInputAction.next,
                                            key: UniqueKey(),
                                            keyboardType: TextInputType.text,
                                            style: const TextStyle(
                                              fontFamily: "Nunito",
                                              fontSize: 16,
                                              color: ColorPalette.nileBlue,
                                            ),
                                            decoration: InputDecoration(
                                              border: InputBorder.none,
                                              hintText: "Description",
                                              filled: true,
                                              fillColor: Colors.transparent,
                                              hintStyle: TextStyle(
                                                fontFamily: "Nunito",
                                                fontSize: 16,
                                                color: ColorPalette.nileBlue
                                                    .withOpacity(0.58),
                                              ),
                                            ),
                                            cursorColor:
                                                ColorPalette.timberGreen,
                                          ),
                                        ),
                                        const SizedBox(height: 20),
                                         Padding(
                                          padding: EdgeInsets.only(
                                            left: 8,
                                            bottom: 5,
                                          ),
                                          child: Column(
                                            children: [


                                              Container(


                                                  decoration: BoxDecoration(
                                                    color: ColorPalette.white,
                                                    borderRadius:
                                                    BorderRadius.circular(12),
                                                    boxShadow: [
                                                      BoxShadow(
                                                        offset: const Offset(0, 3),
                                                        blurRadius: 6,
                                                        color: ColorPalette.nileBlue
                                                            .withOpacity(0.1),
                                                      ),
                                                    ],
                                                  ),
                                                  height: 50,
                                                child: TextFormField(
                                                  initialValue:
                                                  newProduct.location ?? '',
                                                  onChanged: (value) {
                                                    newProduct.location = value;
                                                  },
                                                  textInputAction:
                                                  TextInputAction.next,
                                                  key: UniqueKey(),
                                                  keyboardType: TextInputType.text,
                                                  style: const TextStyle(
                                                    fontFamily: "Nunito",
                                                    fontSize: 16,
                                                    color: ColorPalette.nileBlue,
                                                  ),
                                                  decoration: InputDecoration(
                                                    border: InputBorder.none,
                                                    hintText: "Location/Digital Address",
                                                    filled: true,
                                                    fillColor: Colors.transparent,
                                                    hintStyle: TextStyle(
                                                      fontFamily: "Nunito",
                                                      fontSize: 16,
                                                      color: ColorPalette.nileBlue
                                                          .withOpacity(0.58),
                                                    ),
                                                  ),
                                                  cursorColor:
                                                  ColorPalette.timberGreen,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        //LocationDD(product: newProduct),
                                      ],
                                    ),
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.topCenter,
                                  child: Padding(
                                    padding: const EdgeInsets.only(top: 10),
                                    child: SizedBox(
                                      height: 100,
                                      width: 100,
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(11),
                                        child: Container(
                                          color: ColorPalette.white,
                                          child: SizedBox(
                                            height: 250,
                                            child: Card(
                                              elevation: 8,
                                              shadowColor: Colors.grey,
                                              shape:
                                                  const RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.all(
                                                        Radius.circular(20),
                                                      ),
                                                      side: BorderSide(
                                                          width: 2,
                                                          color:
                                                              Colors.white24)),
                                              child: Container(
                                                padding: EdgeInsets.all(4),
                                                child: GridView.builder(
                                                    itemCount:
                                                        _image.length + 1,
                                                    gridDelegate:
                                                        SliverGridDelegateWithFixedCrossAxisCount(
                                                            crossAxisCount: 3),
                                                    itemBuilder:
                                                        (context, index) {
                                                      return index == 0
                                                          ? Center(
                                                              child: IconButton(
                                                                  icon: Icon(
                                                                      Icons
                                                                          .add),
                                                                  onPressed: () =>
                                                                      !uploading
                                                                          ? chooseImage()
                                                                          : null),
                                                            )
                                                          : Container(
                                                              margin: EdgeInsets
                                                                  .all(3),
                                                              decoration: BoxDecoration(
                                                                  image: DecorationImage(
                                                                      image: FileImage(_image[
                                                                          index -
                                                                              1]),
                                                                      fit: BoxFit
                                                                          .cover)),
                                                            );
                                                    }),
                                              ),
                                            ),
                                          ),

                                          // Container(
                                          //   color: ColorPalette.timberGreen
                                          //       .withOpacity(0.1),
                                          //   child: (newProduct.image == null)
                                          //       ? Center(
                                          //     child: Icon(
                                          //       Icons.image,
                                          //       color: ColorPalette
                                          //           .nileBlue
                                          //           .withOpacity(0.5),
                                          //     ),
                                          //   )
                                          //       : CachedNetworkImage(
                                          //     fit: BoxFit.cover,
                                          //     imageUrl: newProduct.image!,
                                          //     errorWidget:
                                          //         (context, s, a) {
                                          //       return Icon(
                                          //         Icons.image,
                                          //         color: ColorPalette
                                          //             .nileBlue
                                          //             .withOpacity(0.5),
                                          //       );
                                          //     },
                                          //   ),
                                          // ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
  Future<String> uploadsFile() async {
    int i = 1;

    for (var img in _image) {
      setState(() {
        val = i / _image.length;
      });
      ref = firebase_storage.FirebaseStorage.instance
          .ref()
          .child('$group/${newProduct.description}/${basename(img.path)}');
      await ref!.putFile(img).whenComplete(() async {
        await ref!.getDownloadURL().then((value) {
          imgRef?.add({'url': value});
          i++;
        });
      });
    }

    String downloadUrl;
    downloadUrl = await ref!.getDownloadURL();

    return downloadUrl;
  }
  io.File? image;
  Future<String> uploadFile(io.File image) async {
    // showDialog(
    //     context: context,
    //     barrierDismissible: false,
    //     builder: (BuildContext context)
    //     {
    //       //return ;
    //     }
    // );


    final FirebaseAuth auth = FirebaseAuth.instance;
    final User? user = auth.currentUser;
    final myUid = user?.uid;

    final userId = currentfirebaseUser?.email;
    final _storage = FirebaseStorage.instance;

    String downloadUrl;

    //upload to firebase storage

    Reference ref = FirebaseStorage.instance
        .ref()
        .child("$group/${basename(image.path)}");

    await ref.putFile(image);


    downloadUrl = await ref.getDownloadURL();


    return downloadUrl;
  }




  Occupationdb() async {
    String url = await  uploadsFile();
    Map userDataMap = {
      'Estate': url.toString(),
      'name': newProduct.name.toString(),
      'description': newProduct.description.toString(),
      'group': newProduct.group.toString(),
      'Company': newProduct.company.toString(),
      'Cost': newProduct.cost.toString(),
      // 'Location': _currentAddress?.trim().toString(),
      'quantity': newProduct.quantity.toString(),
    };

    EstateList.child("Estates").set(userDataMap);
  }




  // Future uploadFile() async {
  //   int i = 1;
  //
  //   for (var img in _image) {
  //     setState(() {
  //       val = i / _image.length;
  //     });
  //     ref = firebase_storage.FirebaseStorage.instance
  //         .ref()
  //         .child('$firstname/${basename(img.path)}');
  //     await ref!.putFile(img).whenComplete(() async {
  //       await ref!.getDownloadURL().then((value) {
  //         imgRef?.add({'url': value});
  //         i++;
  //       });
  //     });
  //   }
  // }
  chooseImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    setState(() {
      _image.add(File(pickedFile!.path));
    });
    if (pickedFile!.path == null) retrieveLostData();
  }

  Future<void> retrieveLostData() async {
    final LostData response = await picker.getLostData();
    if (response.isEmpty) {
      return;
    }
    if (response.file != null) {
      setState(() {
        _image.add(File(response.file!.path));
      });
    } else {
      print(response.file);
    }
  }
}
