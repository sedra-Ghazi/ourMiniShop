import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_application_5/ui/screen/home_page_screen.dart/home_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

   @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Wait for 3 seconds then navigate
    Future.delayed(Duration(seconds:3), () {
      Navigator.pushReplacement(
        // ignore: use_build_context_synchronously
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
      );
    });

    Timer(
      Duration(seconds: 3),
      () => Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: const Color.fromARGB(255, 165, 123, 239),
      
      
    );
  }
}
 
