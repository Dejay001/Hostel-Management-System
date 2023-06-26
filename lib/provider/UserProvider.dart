import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hostelmanagement/MODEL/UerModel.dart';


class UserProvider with ChangeNotifier {
  late UserModel _authenticatedUser;
  UserModel get authenticatedUser {
    return _authenticatedUser;
  }

  Future<FirebaseApp> initFirebase() async {
    FirebaseApp response;
    response = await Firebase.initializeApp();
    return response;
  }
  Future<Map<String, dynamic>?> register(Map<String, dynamic> user) async {


    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: user['email'], 
              password: user['password'],
              );
          await  addUser(userCredential.user!.uid, user);
          currentUser();

      return {'success': true, 'message': "Created !"};

    } on FirebaseAuthException catch (e) {

      if (e.code == 'weak-password') {
        return {
          'success': false,
          'message': "The password provided is too weak."
        };
      } else if (e.code == 'email-already-in-use') {
        return {
          'success': false,
          'message': "The account already exists for that email."
        };
      }

    } catch (e) {
      print(e);
      return null ;
    }
      
    
  }


  Future<Map<String, dynamic>?> Login(Map<String, dynamic> user) async {

    try {

     UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: user['email'],
        password: user['password']
        );
              
      return {'success': true, 'message': "Logged"};

    } on FirebaseAuthException catch (e) {

      if (e.code == 'user-not-found') {
        return {'success': false, 'message': "No user found for that email."};
      } else if (e.code == 'wrong-password') {
        return {
          'success': false,
          'message': "Wrong password provided for that user."
        };
      }
      return null;
    }
  }
  void currentUser() {
    
		User? currentUser = FirebaseAuth.instance.currentUser;

    if (currentUser != null) {
      print(currentUser.uid);
      print(currentUser);
    }

  }
  void signOut() async {
    await FirebaseAuth.instance.signOut();
  }

  Future<void> addUser(String uid, Map<String, dynamic> user) async {

    await FirebaseFirestore.instance
        .collection('Users')
        .doc(uid)
        .set(user)
        .catchError((e) {
      print(e);
    });
  }
  

  void getUserDetails() async {

    DocumentSnapshot userDetailsDSnapchot = await FirebaseFirestore.instance
        .collection("Users")
        .doc("AbIZhzgdSwbUOU70Ye0u8xIg3Fm1")
        .get();
        
    print(userDetailsDSnapchot.data());
  }

  Future<void> updateUser(String docId) async {

  await FirebaseFirestore.instance
		.collection('Users')
    .doc(docId)
    .update({'company': 'Stokes and Sons'})
    .then((value) => print("User Updated"))
    .catchError((error) => print("Failed to update user: $error"));

}

Future<void> deletUser(String docId) async {

  await FirebaseFirestore.instance
		.collection('Users')
    .doc(docId)
    .delete()
    .then((value) => print("User deleted"))
    .catchError((error) => print("Failed to update user: $error"));

}

Future<void> deletAccount() async {

  try {
    await FirebaseAuth.instance.currentUser!.delete();
  } on FirebaseAuthException catch (e) {
    if (e.code == 'requires-recent-login') {
      print('The user must reauthenticate before this operation can be executed.');
    }
  }

}

  
}

