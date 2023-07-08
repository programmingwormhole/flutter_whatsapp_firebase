import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lottie/lottie.dart';
import 'package:whatsapp_chat/components/page_route.dart';
import 'package:whatsapp_chat/utils/colors.dart';
import 'package:whatsapp_chat/utils/config.dart';
import 'package:whatsapp_chat/views/AuthScreen/OtpScreen/otp_screen.dart';
import 'package:whatsapp_chat/widgets/custom_button.dart';
import 'package:whatsapp_chat/widgets/custom_snack_bar.dart';

class NumberScreen extends StatefulWidget {
  const NumberScreen({super.key});

  @override
  State<NumberScreen> createState() => _NumberScreenState();
}

class _NumberScreenState extends State<NumberScreen> {
  String selectedCountry = '+880';
  List countryData = [];
  String number = '';
  final _numberController = TextEditingController();
  final auth = FirebaseAuth.instance;
  bool? loading = false;

  Future<void> readJson() async {
    final String response =
        await rootBundle.loadString('assets/json/country_list.json');
    final data = await json.decode(response);
    setState(() {
      countryData = data;
    });
  }

  @override
  void initState() {
    super.initState();
    readJson();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: background,
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset(
              'assets/json/number.json',
              width: 200,
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              'Welcome to $appName',
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
              'Enter your phone number to proceed',
              style: TextStyle(color: white.withOpacity(.5)),
            ),
            const SizedBox(
              height: 50,
            ),
            Container(
              width: size.width * .9,
              decoration: BoxDecoration(
                color: white.withOpacity(.1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(
                    width: 10,
                  ),
                  InkWell(
                    onTap: () {
                      showDialog(
                          context: context,
                          builder: (_) => AlertDialog(
                                backgroundColor: background,
                                title: const Text(
                                  'Select Country',
                                  style: TextStyle(color: white),
                                ),
                                content: ListView.builder(
                                    physics:
                                        const AlwaysScrollableScrollPhysics(),
                                    itemCount: countryData.length,
                                    itemBuilder: (_, index) {
                                      return ListTile(
                                        onTap: () {
                                          setState(() {
                                            selectedCountry =
                                                countryData[index]['dial_code'];
                                          });
                                          Navigator.pop(context);
                                        },
                                        title: Text(
                                          countryData[index]['name'],
                                          style: const TextStyle(color: white),
                                        ),
                                        subtitle: Text(
                                          countryData[index]['dial_code'],
                                          style: TextStyle(
                                              color: white.withOpacity(.5)),
                                        ),
                                        trailing: Text(
                                          countryData[index]['code'],
                                          style: TextStyle(
                                              color: white.withOpacity(.5)),
                                        ),
                                      );
                                    }),
                              ));
                    },
                    child: SizedBox(
                      width: 60,
                      child: TextField(
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: white,
                          wordSpacing: 1,
                          fontSize: 18,
                        ),
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                            hintText: selectedCountry,
                            hintStyle: TextStyle(
                                color: white.withOpacity(.5), fontSize: 18),
                            border: InputBorder.none,
                            enabled: false),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  const Text(
                    "|",
                    style: TextStyle(fontSize: 33, color: Colors.grey),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                      child: TextField(
                    controller: _numberController,
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(10),
                    ],
                    style: TextStyle(
                        color: white.withOpacity(.5),
                        fontSize: 18,
                        fontWeight: FontWeight.w600),
                    onChanged: (value) {
                      setState(() {
                        number = value;
                        if (selectedCountry == '+880' && number.startsWith('0')) {
                          snackBar(
                            context: context,
                            message: 'Number can\'t be start with 0',
                          );
                          _numberController.clear();
                        }
                      });
                    },
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "--- --- -- --",
                      hintStyle: TextStyle(
                        color: white.withOpacity(.5),
                        wordSpacing: 1,
                        fontSize: 18,
                      ),
                    ),
                  ))
                ],
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            customButton(
              size: size,
              title: 'SEND',
              onTap: () {
                if (number.isEmpty) {
                  snackBar(
                    context: context,
                    message: 'Please enter a valid number',
                  );
                } else if (number.length < 10) {
                  snackBar(
                    context: context,
                    message: 'Your number length should be 10',
                  );
                } else {
                  showDialog(
                    context: context,
                    builder: (_) => AlertDialog(
                      backgroundColor: background,
                      title: Text(
                        'Check the number!',
                        style: TextStyle(
                          color: white.withOpacity(.8),
                        ),
                      ),
                      content: Text(
                        '$selectedCountry$number\nIs this OK, or would you like to edit the number?',
                        textAlign: TextAlign.start,
                        style: TextStyle(color: white.withOpacity(.5)),
                      ),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text(
                            'EDIT',
                            style: TextStyle(
                              color: white,
                            ),
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                            auth.verifyPhoneNumber(
                                phoneNumber: selectedCountry +
                                    _numberController.text.toString(),
                                verificationCompleted: (_) {},
                                verificationFailed: (e) {
                                  print(e);
                                },
                                codeSent: (String verificationID, int? token) {
                                  navigator(
                                    context,
                                    OtpScreen(
                                      number: selectedCountry +
                                          _numberController.text.toString(),
                                      verificationID: verificationID,
                                      token: token.toString(),
                                    ),
                                  );
                                },
                                codeAutoRetrievalTimeout: (e) {
                                  print(e);
                                });
                          },
                          child: const Text(
                            'OK',
                            style: TextStyle(
                              color: primary,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
