import 'package:flutter/material.dart';
import '../../../utils/colors.dart';
import '../../../utils/data.dart';

class StatusScreen extends StatelessWidget {
  const StatusScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(
          height: 10,
        ),
        ListTile(
          leading: Container(
            alignment: Alignment.bottomRight,
            height: 60,
            width: 60,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                image: NetworkImage(
                    'https://scontent.fdac147-1.fna.fbcdn.net/v/t39.30808-6/355248707_2000434660314527_6084837114673299240_n.jpg?_nc_cat=110&ccb=1-7&_nc_sid=09cbfe&_nc_eui2=AeErgjxVMFDbBQrm3Z41Or6IQEW6IJatGzBARboglq0bMBd46dFrRBdRsNklogfgdZD4gwq18aImRDykmsW7kZx9&_nc_ohc=LSzn3WD9ydQAX8d7l-s&_nc_ht=scontent.fdac147-1.fna&oh=00_AfBokbb2uwQ9EDjBctxPa8EzXOH1bRjmmoPp6jQ8WCvXNg&oe=64A9E117'),
              ),
            ),
            child: Container(
                decoration:
                    const BoxDecoration(color: primary, shape: BoxShape.circle),
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
        ),
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
