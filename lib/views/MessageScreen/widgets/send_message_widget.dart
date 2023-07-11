import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../models/user_model.dart';
import '../../../utils/colors.dart';

class SendMessageWidget extends StatefulWidget {
  final UserModel currentUser;
  final String receiverID;
  final String receiverName;
  final String receiverImage;

  const SendMessageWidget({
    super.key,
    required this.currentUser,
    required this.receiverID,
    required this.receiverName,
    required this.receiverImage,
  });

  @override
  State<SendMessageWidget> createState() => _SendMessageWidgetState();
}

class _SendMessageWidgetState extends State<SendMessageWidget> {
  final _messageController = TextEditingController();
  String message = '';
  final auth = FirebaseAuth.instance;
  final fireStore = FirebaseFirestore.instance;

  sendMessage() async {
    String message = _messageController.text;
    _messageController.clear();
    await fireStore
        .collection('users')
        .doc(auth.currentUser!.phoneNumber)
        .collection('messages')
        .doc(widget.receiverID)
        .collection('chats')
        .add({
      'sender_number': auth.currentUser!.phoneNumber,
      'receiver_number': widget.receiverID,
      'message': message,
      'type': 'text',
      'date': DateTime.now(),
    }).then((value) {
      fireStore
          .collection('users')
          .doc(auth.currentUser!.phoneNumber)
          .collection('messages')
          .doc(widget.receiverID)
          .set({
        'last_message': message,
      });
    });

    await fireStore
        .collection('users')
        .doc(widget.receiverID)
        .collection('messages')
        .doc(auth.currentUser!.phoneNumber)
        .collection('chats')
        .add({
      'sender_number': widget.receiverID,
      'receiver_number': auth.currentUser!.phoneNumber,
      'message': message,
      'type': 'text',
      'date': DateTime.now(),
    }).then((value) {
      fireStore
          .collection('users')
          .doc(widget.receiverID)
          .collection('messages')
          .doc(auth.currentUser!.phoneNumber)
          .set({
        'last_message': message,
      });
    });
  }

  onSendTrigger() async {
    await fireStore
        .collection('users')
        .doc(widget.currentUser.phoneNumber)
        .collection('messages')
        .doc(widget.receiverID)
        .collection('chats')
        .add({
      'sender_name': widget.currentUser.name,
      'sender_id': widget.currentUser.phoneNumber,
      'sender_image': widget.currentUser.profilePicture,
      'receiver_name': widget.receiverName,
      'receiver_id': widget.receiverID,
      'receiver_image': widget.receiverImage,
      'message': message,
      'message_type': 'text',
      'date': DateTime.now(),
      'read': false,
    }).then((value) {
      fireStore
          .collection('users')
          .doc(widget.currentUser.phoneNumber)
          .collection('messages')
          .doc(widget.receiverID)
          .set({
        'last_message': message,
      });
    });

    await fireStore
        .collection('users')
        .doc(widget.receiverID)
        .collection('messages')
        .doc(widget.currentUser.phoneNumber)
        .collection('chats')
        .add({
      'sender_name': widget.currentUser.name,
      'sender_id': widget.currentUser.phoneNumber,
      'sender_image': widget.currentUser.profilePicture,
      'receiver_name': widget.receiverName,
      'receiver_id': widget.receiverID,
      'receiver_image': widget.receiverImage,
      'message': message,
      'message_type': 'text',
      'date': DateTime.now(),
      'read': false,
    }).then((value) {
      fireStore
          .collection('users')
          .doc(widget.receiverID)
          .collection('messages')
          .doc(widget.currentUser.phoneNumber)
          .set({
        'last_message': message,
      });
    });
  }

  addFriend() async {
    await fireStore
        .collection('users')
        .doc(auth.currentUser!.phoneNumber)
        .collection('friends')
        .add({
      'friend_number': widget.receiverID,
    }).then((value) {
      fireStore
          .collection('users')
          .doc(widget.receiverID)
          .collection('friends')
          .add({
        'friend_number': auth.currentUser!.phoneNumber,
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Row(
      children: [
        Expanded(
          flex: 8,
          child: Container(
            width: size.width * .9,
            decoration: BoxDecoration(
              color: appBarColor,
              borderRadius: BorderRadius.circular(30),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 8.0,
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.emoji_emotions_outlined,
                    size: 28,
                    color: white.withOpacity(.5),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  SizedBox(
                    width: size.width * .4,
                    child: TextField(
                      onChanged: (value) {
                        setState(() {
                          message = value;
                        });
                      },
                      controller: _messageController,
                      maxLines: 5,
                      minLines: 1,
                      keyboardType: TextInputType.multiline,
                      style: TextStyle(color: white.withOpacity(.5)),
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Message',
                          hintStyle: TextStyle(color: white.withOpacity(.5))),
                    ),
                  ),
                  const Spacer(),
                  Icon(
                    Icons.link_sharp,
                    size: 37,
                    color: white.withOpacity(.5),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Icon(
                    Icons.photo_camera,
                    size: 28,
                    color: white.withOpacity(.5),
                  ),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        InkWell(
          onTap: () async {
            onSendTrigger();
            // sendMessage();
            // addFriend();
          },
          child: Container(
            decoration: const BoxDecoration(
              color: primary,
              shape: BoxShape.circle,
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: Icon(
                  message.isEmpty ? Icons.mic : Icons.send,
                  color: white,
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}
