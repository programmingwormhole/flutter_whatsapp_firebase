import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:whatsapp_chat/components/page_route.dart';
import 'package:whatsapp_chat/models/user_model.dart';
import 'package:whatsapp_chat/utils/colors.dart';
import 'package:whatsapp_chat/views/MessageScreen/message_screen.dart';
import '../../../utils/data.dart';

class ChatTab extends StatelessWidget {
  final UserModel user;

  const ChatTab({
    super.key,
    required this.user,
  });

  @override
  Widget build(BuildContext context) {
    final fireStore = FirebaseFirestore.instance;

    final size = MediaQuery.of(context).size;
    return StreamBuilder(
        stream: fireStore.collection('users').snapshots(),
        builder: (_, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (_, index) {
                final data = snapshot.data!.docs[index];
                return ListTile(
                  onTap: () {
                    navigator(
                      context,
                      MessageScreen(
                        receiverID: data['phone_number'],
                        currentUser: user,
                        receiverName: data['name'],
                        receiverImage: data['profile_picture'],
                      ),
                    );
                  },
                  leading: InkWell(
                    onTap: () {
                      showDialog(
                          context: context,
                          builder: (_) => Container(
                                height: size.height * .6,
                                width: size.width * .9,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  image: DecorationImage(
                                    image: NetworkImage(
                                      data['profile_picture'],
                                    ),
                                  ),
                                ),
                              ));
                    },
                    child: CircleAvatar(
                      backgroundColor: white.withOpacity(.1),
                      radius: 25,
                      backgroundImage: NetworkImage(data['profile_picture']),
                    ),
                  ),
                  title: Text(
                    data['name'],
                    style: TextStyle(
                      color: white,
                      fontWeight: chats[index]['status']['read'] == 0
                          ? FontWeight.w600
                          : null,
                    ),
                  ),
                  subtitle: Text(
                    chats[index]['message'],
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: TextStyle(
                      color: white.withOpacity(.5),
                      fontWeight: chats[index]['status']['read'] == 0
                          ? FontWeight.w500
                          : null,
                    ),
                  ),
                  trailing: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        chats[index]['time'],
                        style: TextStyle(
                          color: chats[index]['status']['read'] == 0
                              ? primary
                              : white.withOpacity(.5),
                        ),
                      ),
                      chats[index]['status']['read'] == 1
                          ? const SizedBox()
                          : Container(
                              decoration: const BoxDecoration(
                                color: primary,
                                shape: BoxShape.circle,
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8),
                                child: Text(
                                  chats[index]['status']['count'].toString(),
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                            )
                    ],
                  ),
                );
              },
            );
          }
        });
  }
}
