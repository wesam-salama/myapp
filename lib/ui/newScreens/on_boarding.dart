import 'package:al_madina_taxi/helper/shared_helper.dart';
import 'package:al_madina_taxi/models/on_bording_model.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'newWidgets/single_on_boarding.dart';
import 'welcomePage.dart';

class OnBording extends StatefulWidget {
  @override
  _OnBordingState createState() => _OnBordingState();
}

class _OnBordingState extends State<OnBording> {
  PageController pageController;

  List<OnBoardingModel> onboardingList = [
    OnBoardingModel(
        title: 'Online shopping',
        description:
            'Women and Men and Baby Fashion Shopping Online - Shop from a huge range of latest  clothing at  best price',
        image: 'assets/onBoarding1.png'),
    OnBoardingModel(
      title: 'Payment Successful',
      description:
          'Your payment has been successfully completed. You will receive a confirmation email within a few minutes. ',
      image: 'assets/onBoarding3.png',
    ),
    OnBoardingModel(
      title: 'Add to cart',
      description:
          'Add to cart button works on product pages. The customizations in this section  compatible with dynamic checkout buttons',
      image: 'assets/onBoarding2.png',
    ),
  ];
  int indexPageView = 0;

  @override
  void initState() {
    super.initState();
    pageController = PageController(initialPage: 0);
  }

  @override
  void dispose() {
    super.dispose();
    pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: Colors.transparent,
      //   elevation: 0,
      // ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            // begin: Alignment.topCenter,
            // end: Alignment.bottomCenter,
            // stops: [0.1, 0.4, 0.7, 0.9],
            colors: [
              Color(0xfffbb448),
              Color(0xfff7892b)
              // Color(0xFF3594DD),
              // Color(0xFF4563DB),
              // Color(0xFF5036D5),
              // Color(0xFF5B16D0),
            ],
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Flexible(
              child: Container(
                width: double.infinity,
                height: double.infinity,
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.width * .2),
                child: PageView.builder(
                  controller: pageController,
                  itemCount: onboardingList.length,
                  onPageChanged: (newIndex) {
                    indexPageView = newIndex;
                    setState(() {});
                  },
                  itemBuilder: (context, index) {
                    return SingleOnBoarding(
                      onBoardingModel: onboardingList[index],
                    );
                  },
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(15),
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(10)),
                padding: EdgeInsets.only(left: 10, right: 10),
                height: 49.02,
                width: 414.00,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    indexPageView == onboardingList.length - 1
                        ? Container()
                        : GestureDetector(
                            onTap: () async {
                              ShaerdHelper.sHelper
                                  .setValueisSeenOnBoarding(true);
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          WelcomePage()));
                            },
                            child: Text('Skip')),
                    SmoothPageIndicator(
                      controller: pageController,
                      count: 3,
                      effect: ExpandingDotsEffect(
                          expansionFactor: 4,
                          dotWidth: 15.0,
                          dotHeight: 15.0,
                          dotColor: Colors.white,
                          activeDotColor: Colors.white),
                    ),
                    GestureDetector(
                        onTap: () {
                          ShaerdHelper.sHelper.setValueisSeenOnBoarding(true);
                          if (indexPageView == onboardingList.length - 1) {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        WelcomePage()));
                          } else {
                            indexPageView++;
                            pageController.animateToPage(indexPageView,
                                duration: Duration(milliseconds: 200),
                                curve: Curves.bounceInOut);
                          }
                        },
                        child: Text('Next')),
                  ],
                ),
              ),
            )
            // Transform.translate(
            //   offset: Offset(0, -(MediaQuery.of(context).size.height * 0.18)),
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.center,
            //     children: <Widget>[
            //       Container(
            //         child: SmoothPageIndicator(
            //           controller: pageController,
            //           count: 3,
            //           effect: ExpandingDotsEffect(
            //               expansionFactor: 4,
            //               dotWidth: 15.0,
            //               dotHeight: 15.0,
            //               dotColor: Colors.grey,
            //               activeDotColor: Colors.indigo),
            //         ),
            //       ),
            //     ],
            //   ),
            // ),
            // Container(
            //   child: Transform.translate(
            //     offset: Offset(0, -(MediaQuery.of(context).size.height * 0.005)),
            //     child: SizedBox(
            //       width: MediaQuery.of(context).size.width * 0.75,
            //       height: 48,
            //     ),
            //   ),
            // )
          ],
        ),
      ),
    );
  }
}
