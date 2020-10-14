import 'package:al_madina_taxi/models/on_bording_model.dart';
import 'package:flutter/material.dart';

class SingleOnBoarding extends StatelessWidget {
  final OnBoardingModel onBoardingModel;
  SingleOnBoarding({this.onBoardingModel});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        SizedBox(
          height: 50,
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width * .95,
          height: MediaQuery.of(context).size.height * .3,
          child: Image(
            image: ExactAssetImage(onBoardingModel.image),
            // fit: BoxFit.cover,
            height: 350.0,
            width: 350.0,
          ),
        ),
        SizedBox(
          height: 24,
        ),
        Text(
          onBoardingModel.title,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
            fontFamily: 'CM Sans Serif',
            fontSize: 26.0,
            height: 1.5,
          ),
        ),
        SizedBox(
          height: 24,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 10, right: 10),
          child: Text(
            onBoardingModel.description,
            textAlign: TextAlign.justify,
            style: TextStyle(
              color: Colors.white,
              fontSize: 18.0,
              height: 1.2,
            ),
          ),
        ),
      ],
    );
  }
}
