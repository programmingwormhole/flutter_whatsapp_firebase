import 'dart:async';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:whatsapp_chat/utils/colors.dart';
import 'package:whatsapp_chat/views/HomeScreen/home_screen.dart';

class InitializingScreen extends StatefulWidget {
  const InitializingScreen({super.key});

  @override
  State<InitializingScreen> createState() => _InitializingScreenState();
}

class _InitializingScreenState extends State<InitializingScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (_) => const HomeScreen()),
        (route) => false,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                children: [
                  const Text(
                    'Initializing...',
                    style: TextStyle(
                      color: white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Please fill the details below to proceed your request',
                    style: TextStyle(color: white.withOpacity(.5)),
                  ),
                ],
              ),
              Lottie.asset(
                'assets/json/loading.json',
                width: 400,
              ),
              const CircularProgressIndicator(
                color: primary,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
