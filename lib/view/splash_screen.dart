import 'package:flutter/material.dart';

import '../components/colors.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Stack(
        children: [
          Container(
              height: screenWidth,
              width: screenHeight,
              color: WALightColor,
              child: Image.asset(
                'assets/img/background.png', fit: BoxFit.cover,)
          ),
        ],
      ),
    );
  }
}
