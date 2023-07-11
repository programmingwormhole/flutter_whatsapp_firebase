import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:whatsapp_chat/models/user_model.dart';
import 'package:whatsapp_chat/utils/colors.dart';
import 'package:whatsapp_chat/utils/message_data.dart';
import 'package:whatsapp_chat/views/MessageScreen/widgets/send_message_widget.dart';
import '../../components/pop_up_menu_item.dart';

class MessageScreen extends StatefulWidget {
  final UserModel currentUser;
  final String receiverID;
  final String receiverName;
  final String receiverImage;

  const MessageScreen({
    super.key,
    required this.receiverID,
    required this.currentUser,
    required this.receiverName,
    required this.receiverImage,
  });

  @override
  State<MessageScreen> createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen> {
  List<PopupMenuEntry<dynamic>> popUpItems = [
    popupMenuItem(
      title: 'Add to contacts',
      onTap: () {},
      value: 0,
      color: white,
    ),
    popupMenuItem(
      title: 'Delete chats',
      onTap: () {},
      value: 1,
      color: white,
    ),
    popupMenuItem(
      title: 'Block',
      onTap: () {},
      value: 2,
      color: white,
    ),
    popupMenuItem(
      title: 'Report',
      onTap: () {},
      value: 3,
      color: white,
    ),
  ];
  final fireStore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: background,
      appBar: AppBar(
        backgroundColor: appBarColor,
        leadingWidth: size.width * .25,
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Row(
            children: [
              IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(
                  Icons.arrow_back_ios_new,
                  color: white,
                ),
              ),
              CircleAvatar(
                backgroundColor: white.withOpacity(.1),
                backgroundImage: NetworkImage(widget.receiverImage),
              )
            ],
          ),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.receiverName,
              style: const TextStyle(color: white, fontSize: 15),
            ),
            Text(
              'Online',
              style: TextStyle(color: white.withOpacity(.5), fontSize: 12),
            )
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.call,
              color: white,
              size: 20,
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.videocam_rounded,
              color: white,
              size: 25,
            ),
          ),
          PopupMenuButton(
            onSelected: (result) {
              switch (result) {
                case 0:
                  print('0');
                  break;
                case 1:
                  print('1');
                  break;
                case 2:
                  print('3');
                  break;
                case 3:
                  print('4');
                  break;
              }
            },
            color: appBarColor,
            icon: const Icon(
              Icons.more_vert,
              size: 26,
              color: white,
            ),
            itemBuilder: (BuildContext context) => popUpItems,
          ),
        ],
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage(
                'assets/images/wallpaper_blue.jpg',
              ),
              fit: BoxFit.cover,
              opacity: .5),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 10.0,
            horizontal: 15,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Expanded(
                child: StreamBuilder(
                    stream: fireStore
                    .collection('users')
                    .doc(widget.currentUser.phoneNumber)
                    .collection('messages')
                    .doc(widget.receiverID)
                    .collection('chats')
                    .snapshots(),
                    builder: (_, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      } else {
                        if (snapshot.data!.docs.isEmpty) {
                          return Center(
                            child: Container(
                              width: size.width * .6,
                              height: size.height * .4,
                              decoration: BoxDecoration(
                                color: white.withOpacity(.1),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(vertical: 10.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Text(
                                      'No messages here yet...',
                                      style: TextStyle(
                                        color: white,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      'Send a message or tap the\ngreetings below.',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: white.withOpacity(.5),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Lottie.asset(
                                      'assets/json/greetings.json',
                                      width: 200,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        }
                        else{
                          return ListView.builder(
                            itemCount: snapshot.data!.docs.length,
                            reverse: true,
                            physics: const BouncingScrollPhysics(),
                            itemBuilder: (_, index) {
                              final data = snapshot.data!.docs[index];
                              bool isSender = data['sender_id'] ==
                                  widget.currentUser.phoneNumber;
                              return Row(
                                mainAxisAlignment: isSender
                                    ? MainAxisAlignment.end
                                    : MainAxisAlignment.start,
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(16),
                                    margin: const EdgeInsets.all(5),
                                    constraints:
                                        const BoxConstraints(maxWidth: 200),
                                    decoration: BoxDecoration(
                                        color: isSender
                                            ? primary
                                            : white.withOpacity(.1),
                                        borderRadius: BorderRadius.circular(12)),
                                    child: Center(
                                      child: Text(data['message']),
                                    ),
                                  )
                                ],
                              );

                            },
                          );
                        }
                      }

                    }),
              ),
              SendMessageWidget(
                currentUser: widget.currentUser,
                receiverID: widget.receiverID,
                receiverName: widget.receiverName,
                receiverImage: widget.receiverImage,
              ),
              const SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
