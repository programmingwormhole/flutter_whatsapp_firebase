// ignore_for_file: use_build_context_synchronously

import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:whatsapp_chat/components/page_route.dart';
import 'package:whatsapp_chat/models/user_model.dart';
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
    Timer(const Duration(seconds: 2), () async {
      if (user != null) {
        DocumentSnapshot userData = await FirebaseFirestore.instance
            .collection('users')
            .doc(user!.phoneNumber)
            .get();
        UserModel userModel = UserModel.fromJson(userData);
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (_) => HomeScreen(user: userModel,)),
          (route) => false,
        );
      } else {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (_) => const WelcomeScreen()),
          (route) => false,
        );
      }
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
