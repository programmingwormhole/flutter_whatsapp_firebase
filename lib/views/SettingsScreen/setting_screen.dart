import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:whatsapp_chat/utils/colors.dart';
import 'package:whatsapp_chat/widgets/custom_app_bar.dart';
import 'package:whatsapp_chat/views/SettingsScreen/widgets/custom_setting_items.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final auth = FirebaseAuth.instance;
    final fireStore = FirebaseFirestore.instance;
    return Scaffold(
      backgroundColor: background,
      appBar: customAppBar(
          title: 'Settings',
          context: context,
          showAction: true,
          action: [
            IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.search,
                color: white,
              ),
            )
          ]),
      body: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Column(
          children: [
            const SizedBox(
              height: 5,
            ),
            StreamBuilder(
                stream: fireStore
                    .collection('users')
                    .doc(auth.currentUser!.phoneNumber)
                    .snapshots(),
                builder: (_, snap) {
                  final data = snap.data!;
                  return ListTile(
                    leading: CircleAvatar(
                      radius: 30,
                      backgroundImage: NetworkImage(data['profile_picture']),
                    ),
                    title: Text(data['name'],
                      style: const TextStyle(
                        color: white,
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    subtitle: Text(
                      'Before you judge me, make sure you are perfect!',
                      overflow: TextOverflow.ellipsis,
                      style:
                          TextStyle(color: white.withOpacity(.5), fontSize: 12),
                    ),
                    trailing: IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.qr_code,
                          color: primary,
                          size: 30,
                        )),
                  );
                }),
            Divider(
              color: white.withOpacity(.1),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20.0,
              ),
              child: Column(
                children: [
                  settingItems(
                      icon: Icons.key,
                      title: 'Account',
                      subtitle: 'Security notifications, change number'),
                  settingItems(
                      icon: Icons.lock,
                      title: 'Privacy',
                      subtitle: 'Block contacts, disappearing messages'),
                  settingItems(
                      icon: Icons.emoji_emotions_sharp,
                      title: 'Avatar',
                      subtitle: 'Create, edit, profile photo'),
                  settingItems(
                      icon: Icons.message,
                      title: 'Avatar',
                      subtitle: 'Theme, wallpapers, chat history'),
                  settingItems(
                      icon: Icons.notifications,
                      title: 'Notifications',
                      subtitle: 'Message, group & call tones'),
                  settingItems(
                      icon: Icons.data_saver_off_sharp,
                      title: 'Storage and data',
                      subtitle: 'Network usage, auto-download'),
                  settingItems(
                      icon: Icons.language,
                      title: 'App language',
                      subtitle: 'Help center, contact us, privacy policy'),
                  settingItems(
                    title: 'Invite a friend',
                    icon: Icons.group,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Column(
                    children: [
                      Text(
                        'from',
                        style: TextStyle(color: white.withOpacity(.5)),
                      ),
                      Text(
                        'Programming Wormhole',
                        style: TextStyle(
                          color: white.withOpacity(.8),
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
