import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hai_tegal_getx/controller/splash_controller.dart';

import '../../components/colors.dart';

class SplashScreen extends GetView<SplashController> {

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Container(
                height: screenHeight,
                width: screenWidth,
                // color: WALightColor,
                child: Image.asset(
                  'assets/img/background.png', fit: BoxFit.cover,)
            ),
            Center(
              child: Padding(
                padding: EdgeInsets.only(top: screenHeight * 0.1),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: 0.6 * MediaQuery.of(context).size.width,
                      child: Image.asset(
                        'assets/logo/HT_FULL_COLOR.png',
                        fit: BoxFit.contain,
                      ),
                    ),

                    Padding(
                      padding: EdgeInsets.only(bottom: screenHeight * 0.05),
                      child:
                      controller.loading.value == true
                          ? const Center(
                        child: CircularProgressIndicator(),
                      )
                          :
                      GestureDetector(
                        onTap: (){
                          Navigator.pushNamedAndRemoveUntil(
                              context, '/index', (route) => false);
                        },
                        child: Container(
                          width:
                          0.8 * MediaQuery.of(context).size.width,
                          height:
                          0.07 * MediaQuery.of(context).size.height,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              color: WAPrimaryColor1,
                              border: Border.all(color: WASecondary),
                              boxShadow: [
                                BoxShadow(
                                  color: WADarkColor.withOpacity(0.2),
                                  blurRadius: 2,
                                  blurStyle: BlurStyle.inner,
                                  offset: const Offset(
                                    2,
                                    6,
                                  ), // Shadow position
                                ),
                              ]),
                          child: Center(
                            child: Material(
                              color: Colors.transparent,
                              child: Text(
                                'Siap Berpetualang?',
                                style: GoogleFonts.roboto(
                                    fontSize: 16,
                                    color: WALightColor,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )

          ],
        ),
      ),
    );
  }
}
