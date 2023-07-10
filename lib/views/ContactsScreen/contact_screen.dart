import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lottie/lottie.dart';
import 'package:whatsapp_chat/components/page_route.dart';
import 'package:whatsapp_chat/models/user_model.dart';
import 'package:whatsapp_chat/utils/colors.dart';
import 'package:whatsapp_chat/views/MessageScreen/message_screen.dart';
import 'package:whatsapp_chat/widgets/custom_snack_bar.dart';

import '../../widgets/custom_app_bar.dart';
import '../../widgets/custom_button.dart';

class ContactScreen extends StatefulWidget {
  final UserModel user;

  const ContactScreen({
    super.key,
    required this.user,
  });

  @override
  State<ContactScreen> createState() => _ContactScreenState();
}

class _ContactScreenState extends State<ContactScreen> {
  String selectedCountry = '+880';
  List countryData = [];
  String number = '';
  final _numberController = TextEditingController();
  bool isLoading = false;
  Map resultData = {};

  Future<void> readJson() async {
    final String response =
        await rootBundle.loadString('assets/json/country_list.json');
    final data = await json.decode(response);
    setState(() {
      countryData = data;
    });
  }

  void onButtonTrigger() async {
    await FirebaseFirestore.instance
        .collection('users')
        .where(
          'phone_number',
          isEqualTo: selectedCountry + number,
        )
        .get()
        .then((value) {
      setState(() {
        isLoading = true;
      });
      if (value.docs.isEmpty) {
        setState(() {
          isLoading = false;
        });
        showDialog(
            context: context,
            builder: (_) => AlertDialog(
                  backgroundColor: background,
                  title: const Text(
                    'User Not Found!',
                    style: TextStyle(
                      color: white,
                    ),
                  ),
                  content: Text(
                    'Currently the user $selectedCountry$number not using this app. Do you want to invite?',
                    style: const TextStyle(color: white),
                  ),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text(
                        'No',
                        style: TextStyle(color: white),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        print('Invite');
                      },
                      child: const Text(
                        'Invite',
                        style: TextStyle(color: primary),
                      ),
                    )
                  ],
                ));
        return;
      }
      for (var usersData in value.docs) {
        setState(() {
          isLoading = false;
        });
        if (usersData.data()['phone_number'] != widget.user.phoneNumber) {
          resultData = usersData.data();
          navigator(
              context,
              MessageScreen(
                name: resultData['name'],
                image: resultData['profile_picture'],
                receiverID: resultData['phone_number'],
              ));
        } else {
          setState(() {
            isLoading = false;
          });
          snackBar(
            context: context,
            message: 'You can\'t send message to you.',
          );
        }
      }
    });
  }

  @override
  void initState() {
    super.initState();
    readJson();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Scaffold(
      backgroundColor: background,
      appBar: customAppBar(
        title: 'Add Friends',
        context: context,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Lottie.asset(
                'assets/json/network.json',
                width: 200,
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                'Add Friends',
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
                                                  countryData[index]
                                                      ['dial_code'];
                                            });
                                            Navigator.pop(context);
                                          },
                                          title: Text(
                                            countryData[index]['name'],
                                            style:
                                                const TextStyle(color: white),
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
                          if (selectedCountry == '+880' &&
                              number.startsWith('0')) {
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
                title: 'ADD',
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
                    onButtonTrigger();
                  }
                },
              ),
            ],
          ),
        ),
      ),
      // body: Center(
      //   child: Column(
      //     crossAxisAlignment: CrossAxisAlignment.center,
      //     mainAxisAlignment: MainAxisAlignment.start,
      //     children: [
      //       const SizedBox(
      //         height: 20,
      //       ),
      //       Container(
      //         width: size.width * .9,
      //         decoration: BoxDecoration(
      //           color: white.withOpacity(.1),
      //           borderRadius: BorderRadius.circular(15),
      //         ),
      //         child: Center(
      //           child: TextFormField(
      //             controller: _searchDataController,
      //             style: const TextStyle(
      //               color: white,
      //             ),
      //             onChanged: (value) {
      //               setState(() {
      //                 searchValue = value;
      //               });
      //               if (searchValue.startsWith(RegExp(r'[0-9]'))) {
      //                 _searchDataController.clear();
      //                 snackBar(
      //                   context: context,
      //                   message:
      //                       'Number should be start with (+) and country code',
      //                 );
      //               } else if (searchValue.contains(' ')) {
      //                 snackBar(
      //                   context: context,
      //                   message: 'Please remove space from the number',
      //                 );
      //               }
      //               print(searchValue);
      //             },
      //             decoration: InputDecoration(
      //                 border: InputBorder.none,
      //                 prefixIcon: Icon(
      //                   Icons.person,
      //                   color: white.withOpacity(.5),
      //                 ),
      //                 suffixIcon: IconButton(
      //                   onPressed: () {
      //                     onSearchTrigger();
      //                   },
      //                   icon: const Icon(
      //                     Icons.search,
      //                     color: white,
      //                   ),
      //                 ),
      //                 labelText: 'Search',
      //                 labelStyle: TextStyle(color: white.withOpacity(.5)),
      //                 hintText: '(+1) xxxxxxxxxx',
      //                 hintStyle: TextStyle(color: white.withOpacity(.5))),
      //           ),
      //         ),
      //       ),
      //       const SizedBox(
      //         height: 10,
      //       ),
      //       if (searchData.isNotEmpty)
      //         Expanded(
      //           child: ListView.builder(
      //             shrinkWrap: true,
      //             itemCount: searchData.length,
      //             itemBuilder: (_, index) {
      //               final data = searchData[index];
      //               return ListTile(
      //                 leading: CircleAvatar(
      //                   radius: 25,
      //                   backgroundColor: primary.withOpacity(.5),
      //                   backgroundImage: NetworkImage(data['profile_picture']),
      //                 ),
      //                 title: Text(
      //                   data['name'],
      //                   style: const TextStyle(
      //                     color: white,
      //                     fontSize: 18,
      //                   ),
      //                 ),
      //                 subtitle: Text(
      //                   data['phone_number'],
      //                   style: TextStyle(
      //                     color: white.withOpacity(.5),
      //                   ),
      //                 ),
      //               );
      //             },
      //           ),
      //         )
      //       else if (isLoading == true)
      //         const Center(
      //           child: CircularProgressIndicator(),
      //         ),
      //     ],
      //   ),
      // ),
    );
  }
}
