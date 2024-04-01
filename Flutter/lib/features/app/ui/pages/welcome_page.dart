import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:registration_ui/constants/colors.dart';
import 'package:registration_ui/navigation/button_navbar_page.dart';
import 'package:page_transition/page_transition.dart';


class WelcomePage extends StatelessWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splash: Lottie.asset('assets/images/83377-wellcome.json'),
      backgroundColor: AppColors.PeachMainView,
      nextScreen: ButtonNavbarPage(),
      splashIconSize: 300,
      duration: 2100,
      splashTransition: SplashTransition.fadeTransition,
      pageTransitionType: PageTransitionType.leftToRightWithFade,
      animationDuration: const Duration(seconds: 1),
    );
  }

  // @override
  // Widget build(BuildContext context) {
  //   return AnimatedSplashScreen(
  //     splash: Lottie.network('https://assets5.lottiefiles.com/packages/lf20_oehpljw1.json'),
  //     backgroundColor: AppColors.PeachMainView,
  //     nextScreen: ButtonNavbarPage(),
  //     splashIconSize: 300,
  //     duration: 2100,
  //     splashTransition: SplashTransition.fadeTransition,
  //     pageTransitionType: PageTransitionType.leftToRightWithFade,
  //     animationDuration: const Duration(seconds: 1),
  //   );
  // }
}
