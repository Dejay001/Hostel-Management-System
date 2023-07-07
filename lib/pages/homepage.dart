import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hostelmanagement/MODEL/addedproduct.dart';
import 'package:hostelmanagement/data/data_home.dart';
import 'package:hostelmanagement/pages/categories.dart';
import 'package:hostelmanagement/pages/login.dart';
import 'package:hostelmanagement/pages/propertydetails.dart';
import 'package:hostelmanagement/pages/search.dart';
import 'package:hostelmanagement/provider/UserProvider.dart';
import 'package:hostelmanagement/widget/estate_card.dart';
import 'package:provider/provider.dart';

class homepage extends StatefulWidget {
  static const routeName = 'real_estate';
  static const themeColor = Colors.black;

  //Color(0xFFA95AEA);
  homepage({Key? key}) : super(key: key);
  final addedProduct newProduct = addedProduct();

  @override
  State<homepage> createState() => _homepageState();
}

class _homepageState extends State<homepage> {
  String? name;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final addedProduct newProduct = addedProduct();

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      Provider.of<UserProvider>(context, listen: false).initFirebase();
    });
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);

    return Scaffold(
      bottomNavigationBar: BottomBarWidget(),
      body: Padding(
        padding: EdgeInsets.only(top: 10, left: 20),
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            children: [
              SizedBox(
                height: 50,
              ),
              Padding(
                  padding: EdgeInsets.only(right: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Hostels",
                        style: TextStyle(
                            fontWeight: FontWeight.w700, fontSize: 25),
                      ),
                      ActionChip(
                          backgroundColor: Colors.white10,
                          label: Row(children: [
                            Icon(
                              Icons.logout_outlined,
                              color: homepage.themeColor,
                              size: 30,
                            ),
                            Text(
                              "log Out",
                              style: TextStyle(color: homepage.themeColor),
                            )
                          ]),
                          onPressed: () {
                            userProvider.signOut;
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LoginPage()),
                            );
                          })
                    ],
                  )),
              SizedBox(
                height: 20,
              ),
              Padding(padding: EdgeInsets.only(right: 20), child: searchBar),
              SizedBox(
                height: 20,
              ),
              SizedBox(
                height: 20,
              ),
              Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(right: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Categories",
                          style: TextStyle(
                              fontWeight: FontWeight.w700, fontSize: 15),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Categories(),
                              ),
                            );
                          },
                          child: Text(
                            "See All \u203A",
                            style: TextStyle(color: homepage.themeColor),
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: 10),
                  SizedBox(
                    height: 120,
                    child: ListView.builder(
                      itemBuilder: (context, position) {
                        return CategoryWidget(categoryList[position]);
                      },
                      itemCount: categoryList.length,
                      scrollDirection: Axis.horizontal,
                      physics: BouncingScrollPhysics(),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(right: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Nearby",
                          style: TextStyle(
                              fontWeight: FontWeight.w700, fontSize: 15),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Search(),
                              ),
                            );
                          },
                          child: Text(
                            "See All \u203A",
                            style: TextStyle(color: homepage.themeColor),
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: 10),
                  SizedBox(
                    height: 120,
                    child: ListView.builder(
                      itemBuilder: (context, position) {
                        return NearbyWidget(nearbyList[position]);
                      },
                      itemCount: nearbyList.length,
                      scrollDirection: Axis.horizontal,
                      physics: BouncingScrollPhysics(),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 190,
                child: Row(
                  children: [
                    Expanded(
                      child: StreamBuilder(
                        stream: _firestore
                            .collection("Estates")
                            .where("group", isEqualTo: name)
                            .snapshots(),
                        builder: (
                          BuildContext context,
                          AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                              snapshot,
                        ) {
                          if (!snapshot.hasData) {
                            return Center(
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
                            itemBuilder: (BuildContext context, int index) {
                              return EstateCard(
                                Product: addedProduct.fromMap(
                                  snapshot.data!.docs[index].data(),
                                ),
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
              SizedBox(
                height: 20,
              ),
              Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(right: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Explore",
                          style: TextStyle(
                              fontWeight: FontWeight.w700, fontSize: 15),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Search(),
                              ),
                            );
                          },
                          child: Text(
                            "See All \u203A",
                            style: TextStyle(color: homepage.themeColor),
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: 10),
                  SizedBox(
                    height: 120,
                    child: ListView.builder(
                      itemBuilder: (context, position) {
                        return NearbyWidget(exploreList[position]);
                      },
                      itemCount: exploreList.length,
                      scrollDirection: Axis.horizontal,
                      physics: BouncingScrollPhysics(),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 40,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
var searchBar = Container(
    height: 45,
    child: TextField(
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.search),
        hintText: 'Search',
        hintStyle: TextStyle(fontSize: 16),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(
            width: 0,
            style: BorderStyle.none,
          ),
        ),
        filled: true,
        contentPadding: EdgeInsets.all(16),
        fillColor: Color(0xffdddddd),
      ),
    ));
class CategoryWidget extends StatelessWidget {
  final addedProduct newProduct = addedProduct();
  final Category category;

  CategoryWidget(this.category);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GestureDetector(
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) =>
                    propertydetails( hostelcat:category.name )));
          },
          child: Padding(
            padding: EdgeInsets.only(right: 10),
            child: Container(
                width: 100.0,
                height: 120.0,
                decoration: BoxDecoration(
                  image: DecorationImage(
                      fit: BoxFit.cover, image: AssetImage(category.image)),
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                )),
          ),
        ),
        Positioned(
          left: 10,
          bottom: 10,
          child: Text(
            category.name,
            style: TextStyle(
                fontWeight: FontWeight.w500, fontSize: 12, color: Colors.white),
          ),
        ),
      ],
    );
  }
}

class NearbyWidget extends StatelessWidget {
  final String image;

  NearbyWidget(this.image);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Hero(
        tag: image,
        child: Padding(
          padding: EdgeInsets.only(right: 10),
          child: Container(
              width: 210.0,
              height: 120.0,
              decoration: BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.cover, image: AssetImage(image)),
                borderRadius: BorderRadius.all(Radius.circular(10)),
              )),
        ),
      ),
    );
  }
}

class ExploreWidget extends StatelessWidget {
  final String image;

  ExploreWidget(this.image);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Hero(
        tag: image,
        child: Padding(
          padding: EdgeInsets.only(right: 10),
          child: Container(
              width: 210.0,
              height: 120.0,
              decoration: BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.cover, image: AssetImage(image)),
                borderRadius: BorderRadius.all(Radius.circular(10)),
              )),
        ),
      ),
    );
  }


}
