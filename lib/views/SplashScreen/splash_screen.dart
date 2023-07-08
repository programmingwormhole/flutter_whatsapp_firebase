import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:whatsapp_chat/components/page_route.dart';
import 'package:whatsapp_chat/utils/colors.dart';
import 'package:whatsapp_chat/utils/config.dart';
import 'package:whatsapp_chat/views/HomeScreen/home_screen.dart';
import 'package:whatsapp_chat/views/WelcomeScreen/welcome_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  User? user;

  @override
  void initState() {
    super.initState();
    user = FirebaseAuth.instance.currentUser;
    Timer(const Duration(seconds: 2), () {
      user != null
          ? Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (_) => const HomeScreen()),
              (route) => false,
            )
          : navigator(
              context,
              const WelcomeScreen(),
            );
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: background,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 40.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SizedBox(),
              Image.asset(
                'assets/images/logo.png',
                color: white,
                width: size.width * .2,
              ),
              const Text(
                appName,
                style: TextStyle(
                  color: primary,
                  fontSize: 16,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
