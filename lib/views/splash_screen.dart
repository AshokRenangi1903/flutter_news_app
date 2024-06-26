import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_app/views/home.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(Duration(seconds: 3), () {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (_) => Home()));
    });
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.sizeOf(context).height;
    return Scaffold(
      body: Container(
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Center(
              child: Image.asset(
                "lib/resources/news_logo_png.png",
                height: height * 0.5,
                fit: BoxFit.cover,
              ),
            ),
            Container(
              // color: Colors.green,
              height: height * 0.2,
              child: Column(
                children: [
                  Text(
                    "NEWS APP",
                    style: GoogleFonts.poppins(
                        fontSize: 28, fontWeight: FontWeight.w600),
                  ),
                  Text("created by ASHOK RENANGI")
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
