import 'package:flutter/material.dart';
import 'package:whatsapp_chat/utils/colors.dart';

import '../../widgets/custom_app_bar.dart';

class ContactScreen extends StatefulWidget {
  const ContactScreen({super.key});

  @override
  State<ContactScreen> createState() => _ContactScreenState();
}

class _ContactScreenState extends State<ContactScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      appBar: customAppBar(
          title: 'Select Contact', context: context, subtitle: '341 contacts'),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            ListTile(
              leading: const CircleAvatar(
                backgroundColor: primary,
                radius: 25,
                child: Center(
                  child: Icon(
                    Icons.person_add_sharp,
                    color: white,
                  ),
                ),
              ),
              title: Text(
                'New contact',
                style: TextStyle(color: white.withOpacity(.8), fontSize: 18),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            ListView.builder(
                itemCount: 15,
                shrinkWrap: true,
                primary: false,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (_, index) {
                  return Padding(
                    padding: const EdgeInsets.only(
                      bottom: 10.0,
                    ),
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: primary.withOpacity(.5),
                        radius: 25,
                        child: const Center(
                          child: Icon(
                            Icons.person,
                            color: white,
                          ),
                        ),
                      ),
                      title: const Text('Md Shirajul Islam',
                      style: TextStyle(
                        color: white,
                      ),),
                      subtitle: Text('Available',
                        style: TextStyle(
                          color: white.withOpacity(.5),
                        ),),
                      trailing: InkWell(
                        onTap: (){
                        },
                        child: const Text('Invite',
                        style: TextStyle(
                          color: primary
                        ),),
                      ),
                    ),
                  );
                }),
          ],
        ),
      ),
    );
  }
}
