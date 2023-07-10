import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../../utils/colors.dart';
import '../../../utils/data.dart';

class StatusScreen extends StatelessWidget {
  const StatusScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final snapshot = FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.phoneNumber)
        .snapshots();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(
          height: 10,
        ),
        StreamBuilder(
            stream: snapshot,
            builder: (_, snap) {
              if(snap.connectionState == ConnectionState.waiting){
                return ListTile(
                  leading: Container(
                    alignment: Alignment.bottomRight,
                    height: 60,
                    width: 60,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: AssetImage('assets/images/profile.jpg'),
                      ),
                    ),
                    child: Container(
                        decoration: const BoxDecoration(
                            color: primary, shape: BoxShape.circle),
                        child: const Icon(
                          Icons.add,
                          color: white,
                        )),
                  ),
                  title: const Text(
                    'My status',
                    style: TextStyle(color: white, fontSize: 18),
                  ),
                  subtitle: Text(
                    'Tap to add status update',
                    style: TextStyle(color: white.withOpacity(.5)),
                  ),
                );
              } else{
                return ListTile(
                  leading: Container(
                    alignment: Alignment.bottomRight,
                    height: 60,
                    width: 60,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: NetworkImage(snap.data!['profile_picture']),
                      ),
                    ),
                    child: Container(
                        decoration: const BoxDecoration(
                            color: primary, shape: BoxShape.circle),
                        child: const Icon(
                          Icons.add,
                          color: white,
                        )),
                  ),
                  title: const Text(
                    'My status',
                    style: TextStyle(color: white, fontSize: 18),
                  ),
                  subtitle: Text(
                    'Tap to add status update',
                    style: TextStyle(color: white.withOpacity(.5)),
                  ),
                );
              }
            }),
        Divider(
          color: white.withOpacity(.1),
        ),
        const SizedBox(
          height: 5,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              Icons.lock,
              color: white.withOpacity(.5),
              size: 15,
            ),
            const SizedBox(
              width: 5,
            ),
            Text(
              'Your status updates are',
              style: TextStyle(
                color: white.withOpacity(.5),
                fontSize: 12,
              ),
            ),
            const SizedBox(
              width: 4,
            ),
            const Text(
              'end-to-end encrypted',
              style: TextStyle(
                color: primary,
                fontSize: 12,
              ),
            )
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        ListView.builder(
          shrinkWrap: true,
          primary: false,
          itemCount: 3,
          itemBuilder: (_, index) {
            return ListTile(
              contentPadding: const EdgeInsets.only(left: 15),
              leading: Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: primary,
                    width: 1,
                  ),
                  shape: BoxShape.circle,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(
                    4.0,
                  ),
                  child: CircleAvatar(
                    radius: 25,
                    backgroundImage: NetworkImage(chats[index]['image']),
                  ),
                ),
              ),
              title: Text(
                chats[index]['name'],
                style: const TextStyle(
                  color: white,
                ),
              ),
              subtitle: Text(
                'Today, ${chats[index]['story_time']}',
                style: TextStyle(color: white.withOpacity(.5)),
              ),
            );
          },
        ),
      ],
    );
  }
}
