import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:hostelmanagement/MODEL/Users.dart';
import 'package:hostelmanagement/firebase_options.dart';
import 'package:hostelmanagement/pages/admin.dart';
import 'package:hostelmanagement/pages/filterpage.dart';
import 'package:hostelmanagement/pages/homepage.dart';
import 'package:hostelmanagement/pages/login.dart';
import 'package:hostelmanagement/pages/signup.dart';
import 'package:hostelmanagement/provider/ProportiesProvider.dart';
import 'package:hostelmanagement/provider/UserProvider.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

DatabaseReference Hos = FirebaseDatabase.instance.ref().child("Hotels");
DatabaseReference users = FirebaseDatabase.instance.ref().child("Users");
DatabaseReference EstateList = FirebaseDatabase.instance.ref().child("Hotels");

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider<Users>(
            create: (context) => Users(),
          ),
          ChangeNotifierProvider(
            create: (_) => UserProvider(),
          ),
          ChangeNotifierProvider(
            create: (_) => ProportiesProvider(),
          ),
        ],
        child: MaterialApp(
            title: 'Hostel Mangement',
            theme: ThemeData(
              // This is the theme of your application.
              //
              // Try running your application with "flutter run". You'll see the
              // application has a blue toolbar. Then, without quitting the app, try
              // changing the primarySwatch below to Colors.green and then invoke
              // "hot reload" (press "r" in the console where you ran "flutter run",
              // or simply save your changes to "hot reload" in a Flutter IDE).
              // Notice that the counter didn't reset back to zero; the application
              // is not restarted.
              primarySwatch: Colors.blue,
            ),
            debugShowCheckedModeBanner: false,
            home: LoginPage(),
            initialRoute: FirebaseAuth.instance.currentUser == null
                ? '/SignUP'
                : '/Homepage',
            routes: {
              "/admin": (context) => admin(),
              // "/filter": (context) => FilterHostelGroupsApp(),
              "/SignUP": (context) => Signup(),
              "/SignIn": (context) => LoginPage(),
              "/Homepage": (context) => homepage(),
              //    "/addproduct":(context)=>addproduct()
            }
            //home: const MyHomePage(title: 'Flutter Demo Home Page'),

            ));
  }
}
