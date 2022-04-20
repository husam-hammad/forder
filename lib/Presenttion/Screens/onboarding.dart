import 'package:flashorder/Constants/colors.dart';
import 'package:flashorder/Presenttion/Screens/Auth/login.dart';
/* import 'package:flashorder/Presenttion/Screens/home_screen.dart'; */
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';

class OnBoardingPage extends StatefulWidget {
  const OnBoardingPage({Key? key}) : super(key: key);

  @override
  _OnBoardingPageState createState() => _OnBoardingPageState();
}

class _OnBoardingPageState extends State<OnBoardingPage> {
  final introKey = GlobalKey<IntroductionScreenState>();

  void _onIntroEnd(context) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => const Login()),
    );
  }

  Widget _buildImage(String assetName, [double width = 200]) {
    return Image.asset('assets/images/intro/$assetName', width: width);
  }

  @override
  Widget build(BuildContext context) {
    const bodyStyle =
        TextStyle(fontSize: 19.0, fontFamily: "Cairo", color: AppColors.grey);

    const pageDecoration = PageDecoration(
      titleTextStyle: TextStyle(
          fontSize: 28.0,
          fontWeight: FontWeight.w700,
          fontFamily: "Cairo",
          color: AppColors.pink),
      bodyTextStyle: bodyStyle,
      bodyPadding: EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 16.0),
      pageColor: Colors.white,
      imagePadding: EdgeInsets.all(20),
    );

    return IntroductionScreen(
      key: introKey,
      globalBackgroundColor: Colors.white,

      pages: [
        PageViewModel(
          title: "استكشف وجباتك المفضلة",
          body:
              "تصفح الوجبات المختلفة من مختلف المطاعم السورية مع مكوناتها وأسعارها",
          image: _buildImage('1.png'),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "تصفح عروض المطاعم",
          body: "يمكنك الدخول لأي مطعم واستكشاف قائمة الطعام الخاصة به",
          image: _buildImage('3.png'),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "بسرعة البرق",
          body:
              "سيصل إليك طلبك بأقصى سرعة ممكنة عبر شبكة التوصيل الخاصة بنا , ويمكنك تتبع طلبك مباشرة عبر الخارطة .",
          image: _buildImage('2.png'),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "إجمع النقاط واستبدلها بالوجبات",
          body:
              "ستحصل على هدايا من النقاط عند استخدامك  للتطبيق أو شراء الوجبات , يمكنك فيما بعد استبدالها بوجباتك المفضلة .",
          image: _buildImage('4.png'),
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
      skip: const Text('تجاوز',
          style: TextStyle(fontWeight: FontWeight.w600, fontFamily: "Cairo")),
      next: const Icon(Icons.arrow_forward, color: AppColors.green),
      done: const Text('تم',
          style: TextStyle(fontWeight: FontWeight.w600, fontFamily: "Cairo")),
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
    );
  }
}
