import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../../../constants/colors.dart';

class AnimationsPage extends StatefulWidget {
  const AnimationsPage({Key? key}) : super(key: key);

  @override
  State<AnimationsPage> createState() => _AnimationsPageState();
}

class _AnimationsPageState extends State<AnimationsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.PeachMainView,
      appBar: AppBar(
        title: Text(
          'ANIMATION PAGE',
          style: TextStyle(
            color: Colors.white,
            fontSize: 26,
            fontWeight: FontWeight.w600,
          ),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              bottomRight: Radius.elliptical(700, 50),
              bottomLeft: Radius.elliptical(700, 50)),
        ),
        centerTitle: true,
        backgroundColor: AppColors.PeachMainView,
      ),
      body: ListView(
        children: [
          Container(
            padding: EdgeInsets.all(50),
            child: Column(
              children: [
                Container(
                  child:Lottie.network('https://assets5.lottiefiles.com/packages/lf20_SPnqHN6Dq3.json'),
                ),
                SizedBox(height: 20),
                Container(child: Lottie.network('https://assets8.lottiefiles.com/private_files/lf30_vgpgmuxr.json'))
              ],
            )
          ),
        ],
      ),
    );
  }
}
