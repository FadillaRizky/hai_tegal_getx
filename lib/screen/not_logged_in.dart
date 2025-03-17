import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hai_tegal_getx/components/colors.dart';

class NotLoggedIn extends StatelessWidget {
  const NotLoggedIn({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Align(
          alignment: Alignment.center,
          child: SizedBox(
            width: 0.3 * MediaQuery.of(context).size.width,
            height: 0.3 * MediaQuery.of(context).size.width,
            child: Image.asset('assets/img/profile_img.png', fit: BoxFit.contain),
          ),
        ),
        SizedBox(height: 0.05 * MediaQuery.of(context).size.height),
        Text(
          'Anda Belum Login',
          style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 0.03 * MediaQuery.of(context).size.height),
        Text(
          'Silakan Login untuk mengeksplore aplikasi lebih jauh dan mereview tempat favorite Anda',
          style: GoogleFonts.poppins(fontSize: 14),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 0.05 * MediaQuery.of(context).size.height),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            GestureDetector(
              onTap: () {
                Get.toNamed('/login');
              },
              child: Container(
                width: 0.4 * MediaQuery.of(context).size.width,
                height: 0.07 * MediaQuery.of(context).size.height,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: WAPrimaryColor1,
                  border: Border.all(color: WASecondary),
                  boxShadow: [
                    BoxShadow(
                      color: WADarkColor.withOpacity(0.2),
                      blurRadius: 2,
                      blurStyle: BlurStyle.inner,
                      offset: const Offset(2, 4), // Shadow position
                    ),
                  ],
                ),
                child: Center(
                  child: Material(
                    color: Colors.transparent,
                    child: Text(
                      'Login',
                      style: GoogleFonts.roboto(
                        fontSize: 16,
                        color: WALightColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                Get.toNamed('/register');
              },
              child: Container(
                width: 0.4 * MediaQuery.of(context).size.width,
                height: 0.07 * MediaQuery.of(context).size.height,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: WALightColor,
                  border: Border.all(color: WASecondary),
                  boxShadow: [
                    BoxShadow(
                      color: WADarkColor.withOpacity(0.2),
                      blurRadius: 2,
                      blurStyle: BlurStyle.inner,
                      offset: const Offset(2, 4), // Shadow position
                    ),
                  ],
                ),
                child: Center(
                  child: Material(
                    color: Colors.transparent,
                    child: Text(
                      'Register',
                      style: GoogleFonts.roboto(
                        fontSize: 16,
                        color: WADarkColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
