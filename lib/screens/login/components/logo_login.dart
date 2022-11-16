import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

class LogoLoginComponent extends StatelessWidget {
  const LogoLoginComponent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 25.h,
        ),
        Text(
          'Separação',
          style: GoogleFonts.bebasNeue(
            fontSize: 40,
            color: const Color.fromRGBO(196, 161, 109, 1),
          ),
        ),

        Text(
          'Conferência',
          style: GoogleFonts.bebasNeue(
            fontSize: 40,
            color: const Color.fromARGB(255, 255, 255, 255),
          ),
        ),

        // Image.asset(
        //   "images/box.png",
        //   height: 25.h,
        // ),
        // InkWell(
        //   child: Image.asset(
        //     "images/box.png",
        //     height: 15.h,
        //   ),
        // ),
        SizedBox(
          height: 3.h,
        ),
      ],
    );
  }
}
