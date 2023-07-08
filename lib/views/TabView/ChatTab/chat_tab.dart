import 'package:flutter/material.dart';
import 'package:whatsapp_chat/components/page_route.dart';
import 'package:whatsapp_chat/utils/colors.dart';
import 'package:whatsapp_chat/views/MessageScreen/message_screen.dart';

import '../../../utils/data.dart';

class ChatTab extends StatelessWidget {
  const ChatTab({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return ListView.builder(
      itemCount: chats.length,
      itemBuilder: (_, index) {
        return ListTile(
          onTap: () {
            navigator(
              context,
              MessageScreen(
                name: chats[index]['name'], image: chats[index]['image'],
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
                              chats[index]['image'],
                            ),
                          ),
                        ),
                      ));
            },
            child: CircleAvatar(
              backgroundColor: white.withOpacity(.1),
              radius: 25,
              backgroundImage: NetworkImage(chats[index]['image']),
            ),
          ),
          title: Text(
            chats[index]['name'],
            style: TextStyle(
              color: white,
              fontWeight:
                  chats[index]['status']['read'] == 0 ? FontWeight.w600 : null,
            ),
          ),
          subtitle: Text(
            chats[index]['message'],
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
            style: TextStyle(
              color: white.withOpacity(.5),
              fontWeight:
                  chats[index]['status']['read'] == 0 ? FontWeight.w500 : null,
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
}
