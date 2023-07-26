
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hostelmanagement/MODEL/addedproduct.dart';
import 'package:hostelmanagement/pages/filterpage.dart';
import 'package:hostelmanagement/widget/filterbutton.dart';
import '../utils/color_palette.dart';
import '../widget/product_card.dart';
import 'addestate.dart';


class ProductGroupPage extends StatefulWidget {
  final String? name;
  ProductGroupPage({Key? key, this.name}) : super(key: key);
  String? selectedLocation; // Store the selected location for filtering
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  @override
  _ProductGroupPageState createState() => _ProductGroupPageState(name);
}

class _ProductGroupPageState extends State<ProductGroupPage> {

  final String? name;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  String? selectedLocation;

  _ProductGroupPageState(this.name); // Store the selected location for filtering

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(
          bottom: 10,
          right: 10,
        ),
        child: FloatingActionButton(
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) {
                  return addproduct(
                    group: name,
                  );
                },
              ),
            );
          },
          splashColor: Colors.black,
          backgroundColor: Colors.black,
          child: const Icon(
            Icons.add,
            color: ColorPalette.white,
          ),
        ),
      ),
      body: Container(
        color: Colors.black,
        child: SafeArea(
          child: Container(
            color: ColorPalette.aquaHaze,
            height: double.infinity,
            width: double.infinity,
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.only(
                    top: 10,
                    left: 10,
                    right: 15,
                  ),
                  width: double.infinity,
                  height: 90,
                  decoration: const BoxDecoration(
                    color:  Colors.black,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(16),
                      bottomRight: Radius.circular(16),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          IconButton(
                            icon: const Icon(
                              Icons.chevron_left_rounded,
                              size: 35,
                              color:  Colors.white,
                            ),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                          Text(
                            name!.length > 14
                                ? '${name!.substring(0, 12)}..'
                                : name!,
                            style: const TextStyle(
                              fontFamily: "Nunito",
                              fontSize: 28,
                              color: ColorPalette.white,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [

    FilterButton(onFilter: (location) {
      setState(() {
        selectedLocation = location;
      });
      // IconButton(
      //   splashColor: ColorPalette.timberGreen,
      //   icon: const Icon(
      //     Icons.search,
      //     color: ColorPalette.white,
      //   ),
      //   onPressed: () {
      //     // Navigator.of(context).push(
      //     //   MaterialPageRoute(
      //     //     builder: (context) =>
      //     //         SearchProductInGroupPage(
      //     //       name: name,
      //     //     ),
      //       //),
      //     //);
      //   },
      // ),


      // IconButton(
      //   icon: Icon(Icons.filter_list),
      //   onPressed: () {
      //     // Navigate to the filter page and get the selected location
      //     Navigator.of(context)
      //         .push(MaterialPageRoute(
      //       builder: (context) => FilterHostelGroupsApp(),
      //     ))
      //         .then((selectedLocation) {
      //       // Update the selected location when the filter page is popped
      //       if (selectedLocation != null) {
      //         this.selectedLocation = selectedLocation;
      //       }
      //     });
      //   },
      // ),
      IconButton(
        icon: const Icon(
          Icons.delete,
          color: ColorPalette.white,
        ),
        onPressed: () {
          //TODO
        },
      );
    } )],
                      )
                    ],
                  ),
                ),



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
                          const Text(
                            "Hostels",
                            style: TextStyle(
                              color: ColorPalette.timberGreen,
                              fontSize: 20,
                              fontFamily: "Nunito",
                            ),
                          ),
                           Text(
                            "${name}",
                            style: TextStyle(
                              color: ColorPalette.timberGreen,
                              fontSize: 20,
                              fontFamily: "Nunito",
                            ),
                          ),
    //
    //                       GestureDetector(
    //
    //                           onTap: (){
    // Navigator.of(context).push(MaterialPageRoute(
    // builder: (context) {
    // return               FilterHostelGroupsApp();     }));},
    //                           child: Text("filtered")),
                          const SizedBox(height: 20),
                          Expanded(
                            child: StreamBuilder(
                              stream: _firestore
                                  .collection("Estates")
                                  .where("group", isEqualTo: name)
                                  .where("Regions", isEqualTo: selectedLocation) // Apply the filter based on selectedLocation
                                  .snapshots(),
                              builder: (
                                BuildContext context,
                                AsyncSnapshot<
                                        QuerySnapshot<Map<String, dynamic>>>
                                    snapshot,
                              ) {
                                if (!snapshot.hasData) {
                                  return  Center(
                                    child: SizedBox(
                                      height: 40,
                                      width: 40,
                                      child: CircularProgressIndicator(
                                        color: Colors.black,
                                      ),
                                    ),
                                  );
                                }
                                return ListView.builder(
                                  itemCount: snapshot.data!.docs.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return ProductCard(
                                    Product: addedProduct.fromMap( snapshot.data!.docs[index].data(),),
                                    docID: snapshot.data!.docs[index].id,
                                    );
                                  },
                                );

                              },
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
}

