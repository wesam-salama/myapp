import 'package:flutter/material.dart';
import 'package:splashscreen/splashscreen.dart';

class SplashScreens extends StatelessWidget {
  final Widget screen;
  SplashScreens({this.screen});
  @override
  Widget build(BuildContext context) {
    return SplashScreen(
      loaderColor: Colors.white,
      gradientBackground: LinearGradient(
        // begin: Alignment.topCenter,
        // end: Alignment.bottomCenter,
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
        // stops: [0.1, 0.4],
        colors: [
          Color(0xfffbb448),
          Color(0xfff7892b)
          // Color(0xFF3594DD),
          // Color(0xFF4563DB),
          // Color(0xFF5036D5),
          // Color(0xFF5B16D0),
        ],
      ),
      seconds: 3,
      navigateAfterSeconds: screen,
      // loadingText: Text('data'),
      // title: Text('data'),

      image: Image(
        image: AssetImage('assets/devrnz.png'),
      ),
      // backgroundColor: Colors.transparent,
      photoSize: 100.0,
    );
  }
}
