import 'package:flutter/material.dart';
import 'package:whatsapp_chat/utils/colors.dart';

Widget settingItems({
  required String title,
  String? subtitle,
  required IconData icon,
}) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 20.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          height: 60,
          width: 60,
          child: Center(
            child: Icon(icon,
              size: 32,
              color: white.withOpacity(.5),
            ),
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                color: white.withOpacity(.8),
                fontSize: 20,
              ),
            ),
            subtitle == null ? const SizedBox() : Text(subtitle!,
            style: TextStyle(
              color: white.withOpacity(.5),
              fontWeight: FontWeight.w400
            ),),
          ],
        ),
      ],
    ),
  );
}
