import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:whatsapp_chat/utils/colors.dart';

class CommunityTab extends StatelessWidget {
  const CommunityTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 15.0,
            vertical: 20,
          ),
          child: Row(
            children: [
              Stack(
                clipBehavior: Clip.none,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(.6),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Icon(
                        Icons.groups,
                        color: white.withOpacity(.8),
                        size: 40,
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: -5,
                    right: -5,
                    child: Container(
                      decoration: BoxDecoration(
                        color: primary,
                        shape: BoxShape.circle,
                        border: Border.all(color: background, width: 2),
                      ),
                      child: const Icon(
                        Icons.add,
                        color: white,
                        size: 25,
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(
                width: 15,
              ),
              const Text(
                'New community',
                style: TextStyle(color: white, fontSize: 18),
              )
            ],
          ),
        ),
        Divider(
          color: black.withOpacity(.3),
          thickness: 15,
        ),
        const SizedBox(
          height: 15,
        ),
        ListTile(
          leading: const CircleAvatar(
            radius: 25,
            backgroundImage: NetworkImage('https://scontent.fdac147-1.fna.fbcdn.net/v/t39.30808-6/350023089_761238235746758_808006141908229502_n.jpg?_nc_cat=102&ccb=1-7&_nc_sid=09cbfe&_nc_eui2=AeFnw0sRxAViFqIzcle4G5iTjGbLpLPFIKKMZsuks8UgogfIvKJnhNnDrO6GR_ft_5yCjVpKK-A534Cl9GcyAK38&_nc_ohc=1FSKEH_wshYAX8JJY8U&_nc_ht=scontent.fdac147-1.fna&oh=00_AfAE-TteUZRXHtyKuY9uB7al0aSlsOzZFNWmdijTUFLWgQ&oe=64A919EC'),
          ),
          title: Text('Programming Wormhole',
          style: TextStyle(
            color: white.withOpacity(.8),
            fontSize: 17,
            fontWeight: FontWeight.w500
          ),),
        ),
        const SizedBox(
          height: 10,
        ),
        Divider(
          color: white.withOpacity(.1),
        ),
        const SizedBox(
          height: 5,
        ),
        ListTile(
          leading: Container(
            decoration: BoxDecoration(
              color: primary,
              borderRadius: BorderRadius.circular(15),
            ),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Icon(
                Icons.notifications_on_sharp,
                color: white.withOpacity(.8),
                size: 30,
              ),
            ),
          ),
          title: Text('Announcements',
            style: TextStyle(
                color: white.withOpacity(.8),
            ),),
          subtitle: Text('✓ Your: Welcome to our community',
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            color: white.withOpacity(.5),
          ),),
          trailing: Text('7/1/23',
          style: TextStyle(
            color: white.withOpacity(.5),
          ),),
        ),
        const SizedBox(
          height: 20,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: Row(
            children: [
              Icon(Icons.arrow_forward_ios_outlined, color: white.withOpacity(.5),),
              const SizedBox(
                width: 30,
              ),
              Text('View all',style: TextStyle(
                color: white.withOpacity(.5)
              ),)
            ],
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        Divider(
          color: black.withOpacity(.3),
          thickness: 15,
        ),
      ],
    );
  }
}
