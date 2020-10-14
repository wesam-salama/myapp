import 'package:al_madina_taxi/providrs/map_provide.dart';
import 'package:al_madina_taxi/tracking/realtime.dart';
import 'package:al_madina_taxi/ui/home_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'helper/shared_helper.dart';
import 'providrs/home_ui_provide.dart';
import 'ui/newScreens/on_boarding.dart';
import 'ui/newScreens/splash_screens.dart';
import 'ui/newScreens/welcomePage.dart';
import 'package:al_madina_taxi/providrs/auth_provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // SharedPreferences.setMockInitialValues({});
  bool isSeen = await ShaerdHelper.sHelper.getValueisSeen();
  bool isSeenOnBoarding = await ShaerdHelper.sHelper.getValueisSeenOnBoarding();
  Widget screen;
  if (isSeenOnBoarding == false || isSeenOnBoarding == null) {
    screen = OnBording();
    // print(isSeenOnBoarding);
  } else if (isSeen == false || isSeen == null) {
    screen = WelcomePage();
  } else {
    screen = RealtimeMapScrren();
  }
  await Firebase.initializeApp();
  runApp(StartPoint(screen: screen));
}

class StartPoint extends StatefulWidget {
  final Widget screen;
  StartPoint({this.screen});

  @override
  _StartPointState createState() => _StartPointState();
}

class _StartPointState extends State<StartPoint> {
  // @override
  // void initState() {
  //   super.initState();
  //   // storeUserLocation();
  // }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        // ChangeNotifierProvider<MapProvider>(
        //   create: (context) => MapProvider(),
        // ),
        ChangeNotifierProvider<HomeProvide>(
          create: (context) => HomeProvide(),
        ),
        ChangeNotifierProvider<AuthProvider>(
          create: (context) => AuthProvider(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primaryColor: Color(0xFF707070),
        ),
        home: SplashScreens(screen: widget.screen),
      ),
    );
  }

  // void storeUserLocation() {
  //   Provider.of<MapProvider>(context).storeUserLocation();
  // }
}

// class MyHomePage extends StatefulWidget {
//   // This widget is the root of your application.
//   @override
//   _MyHomePageState createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   @override
//   void initState() {
//     super.initState();
//     storeUserLocation();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return MultiProvider(
//       providers: [
//         ChangeNotifierProvider<MapProvider>(
//           create: (context) => MapProvider(),
//         ),
//         ChangeNotifierProvider<HomeProvide>(
//           create: (context) => HomeProvide(),
//         ),
//       ],
//       child: MaterialApp(
//         debugShowCheckedModeBanner: false,
//         title: 'Flutter Demo',
//         theme: ThemeData(
//           primaryColor: Color(0xFF707070),
//         ),
//         home: GoogleMapPage(),
//       ),
//     );
//   }

// storeUserLocation() {
//   Location location = new Location();

//   location.onLocationChanged.listen((LocationData currentLocation) {
//     FirebaseFirestore.instance
//         .collection('users')
//         .doc('8GbNffmippn441O9bjQE')
//         .set({
//       'name': 'hamam',
//       'location':
//           GeoPoint(currentLocation.latitude, currentLocation.longitude)
//     });
//   });
// }
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: 'Flutter Demo',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: MyHomePage(),
//     );
//   }
// }

// class MyHomePage extends StatefulWidget {
//   @override
//   _MyHomePageState createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   @override
//   void initState() {
//     super.initState();

//     storeUserLocation();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Location Pratice'),
//       ),
//       body: Center(
//         child: FlatButton(
//           onPressed: () {
//             Navigator.push(context,
//                 MaterialPageRoute(builder: (context) => RealtimeMapScrren()));
//           },
//           child: Text('Realtime Tracking Map'),
//           color: Colors.black,
//           textColor: Colors.white,
//         ),
//       ),
//     );
//   }

//   storeUserLocation() {
//     Location location = new Location();

//     location.onLocationChanged.listen((LocationData currentLocation) {
//       Firestore.instance
//           .collection('users')
//           .document('AtUrxcRXiPuH2fr2EJRU')
//           .setData({
//         'name': 'wesam',
//         'location':
//             GeoPoint(currentLocation.latitude, currentLocation.longitude)
//       });
//     });
//   }
// }
