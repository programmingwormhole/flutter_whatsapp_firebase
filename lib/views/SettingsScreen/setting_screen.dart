import 'package:flutter/material.dart';
import 'package:whatsapp_chat/utils/colors.dart';
import 'package:whatsapp_chat/widgets/custom_app_bar.dart';
import 'package:whatsapp_chat/widgets/custom_setting_items.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      appBar: customWidget(title: 'Settings'),
      body: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Column(
          children: [
            const SizedBox(
              height: 5,
            ),
            ListTile(
              leading: const CircleAvatar(
                radius: 30,
                backgroundImage: NetworkImage(
                    'https://scontent.fdac147-1.fna.fbcdn.net/v/t39.30808-6/355248707_2000434660314527_6084837114673299240_n.jpg?_nc_cat=110&ccb=1-7&_nc_sid=09cbfe&_nc_eui2=AeErgjxVMFDbBQrm3Z41Or6IQEW6IJatGzBARboglq0bMBd46dFrRBdRsNklogfgdZD4gwq18aImRDykmsW7kZx9&_nc_ohc=LSzn3WD9ydQAX8d7l-s&_nc_ht=scontent.fdac147-1.fna&oh=00_AfBokbb2uwQ9EDjBctxPa8EzXOH1bRjmmoPp6jQ8WCvXNg&oe=64A9E117'),
              ),
              title: const Text(
                'Md Shirajul Islam',
                style: TextStyle(
                  color: white,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              subtitle: Text(
                'Before you judge me, make sure you are perfect!',
                overflow: TextOverflow.ellipsis,
                style: TextStyle(color: white.withOpacity(.5), fontSize: 12),
              ),
              trailing: IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.qr_code,
                    color: primary,
                    size: 30,
                  )),
            ),
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
