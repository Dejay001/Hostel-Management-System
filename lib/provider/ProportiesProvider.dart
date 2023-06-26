import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hostelmanagement/MODEL/DataModel.dart';

class ProportiesProvider with ChangeNotifier {
  Future<FirebaseApp> initFirebase() async {
    FirebaseApp response;
    response = await Firebase.initializeApp();
    return response;
  }
  
  List<Property> _proporties = [];
  get proporties => _proporties;

  void getProporties() async {
    await initFirebase();
     QuerySnapshot<Map<String, dynamic>> propertieSnapchot = await FirebaseFirestore.instance
        .collection("Property")
        .get();
        _proporties = [
        ...propertieSnapchot.docs.map((e) => Property.fromJson(e ))

        ];
        // print("------------------------------------------------------------------------------------------------------");
        // // Property.fromJson(propertieSnapchot.data() as Map<String, dynamic>);
        // print(_proporties);
        // print("------------------------------------------------------------------------------------------------------");
        notifyListeners();
    // _proporties = <Property>[
    //   Property(
    //     "SALE",
    //     "Clinton Villa",
    //     "3,500.00",
    //     "Los Angeles",
    //     "2,456",
    //     "4.4",
    //     "The living is easy in this impressive, generously proportioned contemporary residence with lake and ocean views, located within a level stroll to the sand and surf.",
    //     "assets/images/house_01.jpg",
    //     "assets/images/owner.jpg",
    //     [
    //       "assets/images/kitchen.jpg",
    //       "assets/images/bath_room.jpg",
    //       "assets/images/swimming_pool.jpg",
    //       "assets/images/bed_room.jpg",
    //       "assets/images/living_room.jpg",
    //     ],
    //   ),
    //   Property(
    //     "RENT",
    //     "Salu House",
    //     "3,500.00",
    //     "Miami",
    //     "3,300",
    //     "4.6",
    //     "The living is easy in this impressive, generously proportioned contemporary residence with lake and ocean views, located within a level stroll to the sand and surf.",
    //     "assets/images/house_04.jpg",
    //     "assets/images/owner.jpg",
    //     [
    //       "assets/images/kitchen.jpg",
    //       "assets/images/bath_room.jpg",
    //       "assets/images/swimming_pool.jpg",
    //       "assets/images/bed_room.jpg",
    //       "assets/images/living_room.jpg",
    //     ],
    //   ),
    //   Property(
    //     "RENT",
    //     "Hilton House",
    //     "3,100.00",
    //     "California",
    //     "2,100",
    //     "4.1",
    //     "The living is easy in this impressive, generously proportioned contemporary residence with lake and ocean views, located within a level stroll to the sand and surf.",
    //     "assets/images/house_02.jpg",
    //     "assets/images/owner.jpg",
    //     [
    //       "assets/images/kitchen.jpg",
    //       "assets/images/bath_room.jpg",
    //       "assets/images/swimming_pool.jpg",
    //       "assets/images/bed_room.jpg",
    //       "assets/images/living_room.jpg",
    //     ],
    //   ),
    //   Property(
    //     "SALE",
    //     "Ibe House",
    //     "4,500.00",
    //     "Florida",
    //     "4,100",
    //     "4.5",
    //     "The living is easy in this impressive, generously proportioned contemporary residence with lake and ocean views, located within a level stroll to the sand and surf.",
    //     "assets/images/house_03.jpg",
    //     "assets/images/owner.jpg",
    //     [
    //       "assets/images/kitchen.jpg",
    //       "assets/images/bath_room.jpg",
    //       "assets/images/swimming_pool.jpg",
    //       "assets/images/bed_room.jpg",
    //       "assets/images/living_room.jpg",
    //     ],
    //   ),
    //   Property(
    //     "SALE",
    //     "Aventura",
    //     "5,200.00",
    //     "New York",
    //     "3,100",
    //     "4.2",
    //     "The living is easy in this impressive, generously proportioned contemporary residence with lake and ocean views, located within a level stroll to the sand and surf.",
    //     "assets/images/house_05.jpg",
    //     "assets/images/owner.jpg",
    //     [
    //       "assets/images/kitchen.jpg",
    //       "assets/images/bath_room.jpg",
    //       "assets/images/swimming_pool.jpg",
    //       "assets/images/bed_room.jpg",
    //       "assets/images/living_room.jpg",
    //     ],
    //   ),
    //   Property(
    //     "SALE",
    //     "North House",
    //     "3,500.00",
    //     "Florida",
    //     "3,700",
    //     "4.0",
    //     "The living is easy in this impressive, generously proportioned contemporary residence with lake and ocean views, located within a level stroll to the sand and surf.",
    //     "assets/images/house_06.jpg",
    //     "assets/images/owner.jpg",
    //     [
    //       "assets/images/kitchen.jpg",
    //       "assets/images/bath_room.jpg",
    //       "assets/images/swimming_pool.jpg",
    //       "assets/images/bed_room.jpg",
    //       "assets/images/living_room.jpg",
    //     ],
    //   ),
    //   Property(
    //     "RENT",
    //     "Rasmus Resident",
    //     "2,900.00",
    //     "Detroit",
    //     "2,700",
    //     "4.3",
    //     "The living is easy in this impressive, generously proportioned contemporary residence with lake and ocean views, located within a level stroll to the sand and surf.",
    //     "assets/images/house_07.jpg",
    //     "assets/images/owner.jpg",
    //     [
    //       "assets/images/kitchen.jpg",
    //       "assets/images/bath_room.jpg",
    //       "assets/images/swimming_pool.jpg",
    //       "assets/images/bed_room.jpg",
    //       "assets/images/living_room.jpg",
    //     ],
    //   ),
    //   Property(
    //     "RENT",
    //     "Simone House",
    //     "3,900.00",
    //     "Florida",
    //     "3,700",
    //     "4.4",
    //     "The living is easy in this impressive, generously proportioned contemporary residence with lake and ocean views, located within a level stroll to the sand and surf.",
    //     "assets/images/house_08.jpg",
    //     "assets/images/owner.jpg",
    //     [
    //       "assets/images/kitchen.jpg",
    //       "assets/images/bath_room.jpg",
    //       "assets/images/swimming_pool.jpg",
    //       "assets/images/bed_room.jpg",
    //       "assets/images/living_room.jpg",
    //     ],
    //   ),
    // ];
    
   
  }
}
