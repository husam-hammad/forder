import 'package:flashorder/BussinessLogic/Controllers/auth_controller.dart';
import 'package:flashorder/Constants/colors.dart';
import 'package:flashorder/Constants/routes.dart';
import 'package:flashorder/Constants/textstyles.dart';
import 'package:flashorder/Presenttion/Screens/Auth/login.dart';
/* import 'package:flashorder/Presenttion/Screens/home_screen.dart'; */
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:lottie/lottie.dart';

class OnBoardingPage extends StatefulWidget {
  const OnBoardingPage({Key? key}) : super(key: key);

  @override
  _OnBoardingPageState createState() => _OnBoardingPageState();
}

class _OnBoardingPageState extends State<OnBoardingPage> {
  final introKey = GlobalKey<IntroductionScreenState>();
  final AuthController authController = Get.put(AuthController());

  void _onIntroEnd(context) async {
    if (await authController.checkAuth()) {
      Get.toNamed(AppRoutes.homepage);
    } else {
      Get.to(Login());
    }
  }

  Widget _buildImage(String assetName, [double width = 250]) {
    return LottieBuilder.asset('assets/images/intro/$assetName', width: width);
  }

  @override
  Widget build(BuildContext context) {
    var bodyStyle = TextStyle(
        fontSize: 15.0,
        fontFamily: AppTextStyles.family,
        color: AppColors.grey);

    var pageDecoration = PageDecoration(
      titleTextStyle: TextStyle(
          fontSize: 24.0,
          fontWeight: FontWeight.w700,
          fontFamily: AppTextStyles.family,
          color: AppColors.pink),
      bodyTextStyle: bodyStyle,
      bodyPadding: const EdgeInsets.fromLTRB(16.0, 5, 16.0, 5),
      pageColor: Colors.white,
      imagePadding: const EdgeInsets.all(5),
    );

    return SafeArea(
      child: IntroductionScreen(
        key: introKey,
        globalBackgroundColor: Colors.white,

        pages: [
          PageViewModel(
            title: "onbording1".tr,
            body: "onbording1desc".tr,
            image: _buildImage('restaurent.json'),
            decoration: pageDecoration,
          ),
          PageViewModel(
            title: "onbording2".tr,
            body: "onbording2desc".tr,
            image: _buildImage('bike.json', Get.width * 1.2),
            decoration: pageDecoration,
          ),
          PageViewModel(
            title: "onbording3".tr,
            body: "onbording3desc".tr,
            image: _buildImage('map.json', 150),
            decoration: pageDecoration,
          ),
          PageViewModel(
            title: "onbording4".tr,
            body: "onbording4desc".tr,
            image: _buildImage('24.json'),
            decoration: pageDecoration,
          ),
        ],
        onDone: () => _onIntroEnd(context),
        onSkip: () => _onIntroEnd(context), // You can override onSkip callback
        showSkipButton: false,
        skipOrBackFlex: 1,
        nextFlex: 0,
        showBackButton: true,
        //rtl: true, // Display as right-to-left
        back: const Icon(
          Icons.arrow_back,
          color: AppColors.green,
        ),
        skip: Text(
          'skip'.tr,
          style: AppTextStyles.greyRegularDetail,
        ),
        next: const Icon(Icons.arrow_forward, color: AppColors.green),
        done: Text('ok'.tr, style: AppTextStyles.greenRegularHeading),
        curve: Curves.fastLinearToSlowEaseIn,
        controlsMargin: const EdgeInsets.all(16),

        controlsPadding: kIsWeb
            ? const EdgeInsets.all(12.0)
            : const EdgeInsets.fromLTRB(8.0, 4.0, 8.0, 4.0),
        dotsDecorator: const DotsDecorator(
          activeColor: AppColors.green,
          size: Size(10.0, 10.0),
          color: Color(0xFFBDBDBD),
          activeSize: Size(22.0, 10.0),
          activeShape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(25.0)),
          ),
        ),
      ),
    );
  }
}
