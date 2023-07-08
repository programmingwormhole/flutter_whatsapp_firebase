import 'package:flutter/material.dart';
import 'package:whatsapp_chat/utils/calls_data.dart';
import 'package:whatsapp_chat/utils/colors.dart';

class CallTab extends StatelessWidget {
  const CallTab({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: calls.length,
      itemBuilder: (_, index) {
        return ListTile(
          contentPadding: const EdgeInsets.only(
            left: 15,
          ),
          leading: CircleAvatar(
            backgroundColor: white.withOpacity(.1),
            radius: 25,
            backgroundImage: NetworkImage(calls[index]['image']),
          ),
          title: Text(
            calls[index]['name'],
            style: const TextStyle(
              color: white,
            ),
          ),
          subtitle: Row(
            children: [
              Icon(
                calls[index]['status'] == 'incoming'
                    ? Icons.call_received
                    : Icons.call_made,
                color:
                    calls[index]['status'] == 'incoming' ? Colors.red : primary,
                size: 20,
              ),
              Text(
                calls[index]['time'],
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                style: TextStyle(
                  color: white.withOpacity(.5),
                ),
              ),
            ],
          ),
          trailing: IconButton(
            onPressed: () {},
            icon: Icon(
              calls[index]['call_type'] == 'audio' ? Icons.call : Icons.videocam,
              color: primary,
            ),
          ),
        );
      },
    );
  }
}
