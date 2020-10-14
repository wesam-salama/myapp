import 'dart:async';

import 'package:al_madina_taxi/helper/shared_helper.dart';
import 'package:al_madina_taxi/providrs/auth_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'dart:async';

class RealtimeMapScrren extends StatefulWidget {
  @override
  _RealtimeMapScrrenState createState() => _RealtimeMapScrrenState();
}

class _RealtimeMapScrrenState extends State<RealtimeMapScrren> {
  BitmapDescriptor pinLocationIcon;
  Completer<GoogleMapController> _controller = Completer();
  List<Marker> markers = [];
  String uid;

  @override
  void initState() {
    super.initState();
    storeUserLocation();
    getUID();
    BitmapDescriptor.fromAssetImage(
            ImageConfiguration(devicePixelRatio: 2.5), 'assets/car_icon.png')
        .then((onValue) {
      pinLocationIcon = onValue;
    });
  }

  getUID() async {
    uid = await ShaerdHelper.sHelper.getUid();
  }

  getUserLocation() {
    setState(() {
      FirebaseFirestore.instance
          .collection('users')
          .snapshots()
          .listen((event) {
        event.docChanges.forEach((change) {
          print(change.doc.data());
          markers.add(
            Marker(
              markerId: MarkerId(change.doc.id),
              infoWindow:
                  InfoWindow(title: change.doc.data()['name'].toString()),
              position: LatLng(
                change.doc.data()['location'].latitude,
                change.doc.data()['location'].longitude,
              ),
              icon: pinLocationIcon,
              // rotation: change.doc.data()['location'].heading,
              draggable: false,
              zIndex: 2,
              flat: true,
              anchor: Offset(0.5, 0.5),
            ),
          );
          setState(() {});
        });
      });
    });
    // notifyListeners();
  }

  storeUserLocation() {
    StreamSubscription<Position> positionStream =
        getPositionStream(desiredAccuracy: LocationAccuracy.best)
            .listen((Position position) async {
      await FirebaseFirestore.instance.collection('users').doc(uid).set({
        'name': 'wesam',
        'location': GeoPoint(position.latitude, position.longitude)
      });
    });
    // Location location = new Location();

    // location.onLocationChanged.listen((LocationData currentLocation) async {
    //   await FirebaseFirestore.instance
    //       .collection('users')
    //       .doc('8GbNffmippn441O9bjQE')
    //       .set({
    //     'name': 'wesam',
    //     'location':
    //         GeoPoint(currentLocation.latitude, currentLocation.longitude)
    //   });
    // });
  }

  @override
  Widget build(BuildContext context) {
    getUserLocation();
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('Realtime Map'),
      // ),
      body: GoogleMap(
        mapType: MapType.terrain,
        initialCameraPosition: CameraPosition(
          target: LatLng(31.4167, 34.3333),
          zoom: 10.5,
        ),
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
        markers: markers.toSet(),
      ),
    );
  }
}
