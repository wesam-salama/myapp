import 'dart:ui';
import 'package:al_madina_taxi/providrs/map_provide.dart';
import 'package:al_madina_taxi/tracking/realtime.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'components/components.dart';
import 'helper/ui_helper.dart';
import '../providrs/home_ui_provide.dart';
import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';

class GoogleMapPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _GoogleMapState();
  }
}

class _GoogleMapState extends State<GoogleMapPage>
    with TickerProviderStateMixin {
  AnimationController animationControllerExplore;
  AnimationController animationControllerSearch;
  AnimationController animationControllerMenu;
  CurvedAnimation curve;
  Animation<double> animationExplore;
  Animation<double> animationSearch;
  Animation<double> animationMenu;

  HomeProvide mProvide;

  /// animate Explore
  ///
  /// if [open] is true , make Explore open
  /// else make Explore close
  void animateExplore(bool open) {
    animationControllerExplore = AnimationController(
        duration: Duration(
            milliseconds: 1 +
                (800 *
                        (mProvide.isExploreOpen
                            ? mProvide.currentExplorePercent
                            : (1 - mProvide.currentExplorePercent)))
                    .toInt()),
        vsync: this);
    curve =
        CurvedAnimation(parent: animationControllerExplore, curve: Curves.ease);
    animationExplore =
        Tween(begin: mProvide.offsetExplore, end: open ? 760.0 - 122 : 0.0)
            .animate(curve)
              ..addListener(() {
                mProvide.notifyChange(explore: animationExplore.value);
              })
              ..addStatusListener((status) {
                if (status == AnimationStatus.completed) {
                  mProvide.isExploreOpen = open;
                }
              });
    animationControllerExplore.forward();
  }

  void animateSearch(bool open) {
    animationControllerSearch = AnimationController(
        duration: Duration(
            milliseconds: 1 +
                (800 *
                        (mProvide.isSearchOpen
                            ? mProvide.currentSearchPercent
                            : (1 - mProvide.currentSearchPercent)))
                    .toInt()),
        vsync: this);
    curve =
        CurvedAnimation(parent: animationControllerSearch, curve: Curves.ease);
    animationSearch =
        Tween(begin: mProvide.offsetSearch, end: open ? 347.0 - 68.0 : 0.0)
            .animate(curve)
              ..addListener(() {
                mProvide.notifyChange(search: animationSearch.value);
              })
              ..addStatusListener((status) {
                if (status == AnimationStatus.completed) {
                  mProvide.isSearchOpen = open;
                }
              });
    animationControllerSearch.forward();
  }

  void animateMenu(bool open) {
    animationControllerMenu =
        AnimationController(duration: Duration(milliseconds: 500), vsync: this);
    curve =
        CurvedAnimation(parent: animationControllerMenu, curve: Curves.ease);
    animationMenu =
        Tween(begin: open ? 0.0 : 358.0, end: open ? 358.0 : 0.0).animate(curve)
          ..addListener(() {
            mProvide.notifyChange(menu: animationMenu.value);
          })
          ..addStatusListener((status) {
            if (status == AnimationStatus.completed) {
              mProvide.isMenuOpen = open;
            }
          });
    animationControllerMenu.forward();
  }

  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIOverlays([]);
  }

  // @override
  // void didChangeDependencies() {
  //   super.didChangeDependencies();
  //   getUsers();
  // }

  @override
  void dispose() {
    animationControllerExplore?.dispose();
    animationControllerSearch?.dispose();
    animationControllerMenu?.dispose();
    super.dispose();
  }

  // getUsers() {
  //   // Provider.of<MapProvider>(context).getUserLocation();
  //   Provider.of<MapProvider>(context).storeUserLocation();
  // }

  // Completer<GoogleMapController> _controller = Completer();

  // List<Marker> markers = [];

  // getUserLocation() {
  //   setState(() {
  //     FirebaseFirestore.instance
  //         .collection('users')
  //         .snapshots()
  //         .listen((event) {
  //       event.docChanges.forEach((change) {
  //         markers.add(Marker(
  //             markerId: MarkerId(change.doc.id),
  //             infoWindow:
  //                 InfoWindow(title: change.doc.data()['name'].toString()),
  //             position: LatLng(change.doc.data()['location'].latitude,
  //                 change.doc.data()['location'].longitude)));
  //       });
  //     });
  //   });
  //   // notifyListeners();
  // }

  @override
  Widget build(BuildContext context) {
    // getUserLocation();
    print("rebuild");
    screenWidth ??= MediaQuery.of(context).size.width;
    screenHeight ??= MediaQuery.of(context).size.height;
    mProvide ??= Provider.of<HomeProvide>(context);
    return Scaffold(
      body: SizedBox(
        width: screenWidth,
        height: screenHeight,
        child: Stack(
          children: <Widget>[
            // GoogleMap(
            //   mapType: MapType.normal,
            //   initialCameraPosition: CameraPosition(
            //     target: LatLng(31.4167, 34.3333),
            //     zoom: 10.5,
            //   ),
            //   onMapCreated: (GoogleMapController controller) {
            //     _controller.complete(controller);
            //   },
            //   markers: markers.toSet(),
            // ),
            RealtimeMapScrren(),
            //explore
            ExploreWidget(
              currentExplorePercent:
                  Provider.of<HomeProvide>(context).currentExplorePercent,
              currentSearchPercent:
                  Provider.of<HomeProvide>(context).currentSearchPercent,
              animateExplore: animateExplore,
              isExploreOpen: Provider.of<HomeProvide>(context).isExploreOpen,
              onVerticalDragUpdate:
                  Provider.of<HomeProvide>(context).onExploreVerticalUpdate,
              onPanDown: () => animationControllerExplore?.stop(),
            ),
            //blur
            Provider.of<HomeProvide>(context).offsetSearch != 0
                ? BackdropFilter(
                    filter: ImageFilter.blur(
                        sigmaX: 10 *
                            Provider.of<HomeProvide>(context)
                                .currentSearchPercent,
                        sigmaY: 10 *
                            Provider.of<HomeProvide>(context)
                                .currentSearchPercent),
                    child: Container(
                      color: Colors.white.withOpacity(0.1 *
                          Provider.of<HomeProvide>(context)
                              .currentSearchPercent),
                      width: screenWidth,
                      height: screenHeight,
                    ),
                  )
                : const Padding(
                    padding: const EdgeInsets.all(0),
                  ),
            //explore content
            ExploreContentWidget(
              currentExplorePercent:
                  Provider.of<HomeProvide>(context).currentExplorePercent,
            ),
            //recent search
            RecentSearchWidget(
              currentSearchPercent:
                  Provider.of<HomeProvide>(context).currentSearchPercent,
            ),
            //search menu background
            Provider.of<HomeProvide>(context).offsetSearch != 0
                ? Positioned(
                    bottom: realH(88),
                    left: realW((standardWidth - 320) / 2),
                    width: realW(320),
                    height: realH(135 *
                        Provider.of<HomeProvide>(context).currentSearchPercent),
                    child: Opacity(
                      opacity: Provider.of<HomeProvide>(context)
                          .currentSearchPercent,
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(realW(33)),
                                topRight: Radius.circular(realW(33)))),
                      ),
                    ),
                  )
                : const Padding(
                    padding: const EdgeInsets.all(0),
                  ),
            //search menu
            SearchMenuWidget(
              currentSearchPercent:
                  Provider.of<HomeProvide>(context).currentSearchPercent,
            ),
            //search
            SearchWidget(
              currentSearchPercent:
                  Provider.of<HomeProvide>(context).currentSearchPercent,
              currentExplorePercent:
                  Provider.of<HomeProvide>(context).currentExplorePercent,
              isSearchOpen: Provider.of<HomeProvide>(context).isSearchOpen,
              animateSearch: animateSearch,
              onHorizontalDragUpdate: Provider.of<HomeProvide>(context)
                  .onSearchHorizontalDragUpdate,
              onPanDown: () => animationControllerSearch?.stop(),
            ),
            //search back
            SearchBackWidget(
              currentSearchPercent:
                  Provider.of<HomeProvide>(context).currentSearchPercent,
              animateSearch: animateSearch,
            ),
            //layer button
            MapButton(
              currentExplorePercent:
                  Provider.of<HomeProvide>(context).currentExplorePercent,
              currentSearchPercent:
                  Provider.of<HomeProvide>(context).currentSearchPercent,
              bottom: 243,
              offsetX: -71,
              width: 71,
              height: 71,
              isRight: false,
              icon: Icons.layers,
            ),
            //directions button
            MapButton(
              currentSearchPercent:
                  Provider.of<HomeProvide>(context).currentSearchPercent,
              currentExplorePercent:
                  Provider.of<HomeProvide>(context).currentExplorePercent,
              bottom: 243,
              offsetX: -68,
              width: 68,
              height: 71,
              icon: Icons.directions,
              iconColor: Colors.white,
              gradient: const LinearGradient(colors: [
                Color(0xFF59C2FF),
                Color(0xFF1270E3),
              ]),
            ),
            //my_location button
            MapButton(
              currentSearchPercent:
                  Provider.of<HomeProvide>(context).currentSearchPercent,
              currentExplorePercent:
                  Provider.of<HomeProvide>(context).currentExplorePercent,
              bottom: 148,
              offsetX: -68,
              width: 68,
              height: 71,
              icon: Icons.my_location,
              iconColor: Colors.blue,
            ),
            //menu button
            Positioned(
              bottom: realH(53),
              left: realW(-71 *
                  (Provider.of<HomeProvide>(context).currentExplorePercent +
                      Provider.of<HomeProvide>(context).currentSearchPercent)),
              child: GestureDetector(
                onTap: () {
                  animateMenu(true);
                },
                child: Opacity(
                  opacity: 1 -
                      (Provider.of<HomeProvide>(context).currentSearchPercent +
                          Provider.of<HomeProvide>(context)
                              .currentExplorePercent),
                  child: Container(
                    width: realW(71),
                    height: realH(71),
                    alignment: Alignment.centerLeft,
                    padding: EdgeInsets.only(left: realW(17)),
                    child: Icon(
                      Icons.menu,
                      size: realW(34),
                    ),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            bottomRight: Radius.circular(realW(36)),
                            topRight: Radius.circular(realW(36))),
                        boxShadow: [
                          BoxShadow(
                              color: Color.fromRGBO(0, 0, 0, 0.3),
                              blurRadius: realW(36)),
                        ]),
                  ),
                ),
              ),
            ),
            //menu
            MenuWidget(
                currentMenuPercent:
                    Provider.of<HomeProvide>(context).currentMenuPercent,
                animateMenu: animateMenu),
          ],
        ),
      ),
    );
  }
}
