import 'package:firebase_core/firebase_core.dart';
import 'package:tourmate1/Register.dart';
import 'package:tourmate1/allAreasCustomization.dart';
import 'package:tourmate1/entertainmentDataCustomization.dart';
import 'package:tourmate1/eventDataCustomization.dart';
import 'package:tourmate1/hotelsData_customization.dart';
import 'package:tourmate1/parkDataCustomization.dart';
import 'package:tourmate1/restaurantDataCustomization.dart';
import 'package:tourmate1/roomtypes.dart';
import 'package:tourmate1/basic.dart';
import 'package:tourmate1/booking_room.dart';
import 'package:tourmate1/transportDataCustomization.dart';
import 'package:tourmate1/user_info.dart';
import 'about.dart';
import 'login.dart';
import 'provider.dart';
import 'review_full.dart';
import 'teamMembers.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'Contact_us.dart';
import 'Register.dart';
import 'allHotel.dart';
import 'allResturent.dart';
import 'allTransport.dart';
import 'all_distination.dart';
import 'home.dart';
import 'routes.dart';
import 'search_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Tour Mate',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: EntertainmentDataCustomization(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ProductProvider>(
      create: (context) => ProductProvider(),
      child: FutureBuilder(
        // Initialize FlutterFire:
        future: _initialization,
        builder: (context, snapshot) {
          // Check for errors
          if (snapshot.hasError) {
            print("Error");
          }
          //show something whilst waiting for initialization to complete
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Material(
                child: Scaffold(
                    body: SafeArea(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,  
                  children: [
                    CircularProgressIndicator(),
                    SizedBox(height: 5),
                    Text("Loading",
                        style: TextStyle(color: Colors.blue, fontSize: 16.0))
                  ],
                ),
              ),
            )));
          }
          // Otherwise, show app
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            themeMode: ThemeMode.light,
            theme: ThemeData(
                primaryIconTheme: IconThemeData(color: Colors.black),
                primarySwatch: Colors.blue,
                primaryTextTheme:
                    TextTheme(headline6: TextStyle(color: Colors.black))),
            darkTheme: ThemeData(
              brightness: Brightness.dark,
            ),
            // initialRoute: MyRoute.MainHome,
            routes: {
              MyRoute.review: (context) => Review(),
              MyRoute.MainHome: (context) => MainHome(index: 0),
              MyRoute.login: (context) => login(),
              MyRoute.signup: (context) => register(),
              MyRoute.home: (context) => home(),
              MyRoute.hotel: (context) => Hotel(),
              MyRoute.transport: (context) => transport(),
              MyRoute.resturent: (context) => resturent(),
              MyRoute.searchPage: (context) => SearchPage(),
              MyRoute.allDistinations: (context) => AllDistinations(),
              MyRoute.contactUs: (context) => ContactUs(),
              MyRoute.aboutUs: (context) => AboutUS(),
              MyRoute.ourTeam: (context) => TeamMembers(),
              MyRoute.review: (context) => Review()
            },
          );
        },
      ),
    );
  }
}
