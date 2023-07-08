import 'package:flutter/material.dart';
import 'package:whatsapp_chat/utils/colors.dart';

PreferredSizeWidget customWidget({
  required String title,
}) {
  return AppBar(
    backgroundColor: appBarColor,
    leading: IconButton(
      onPressed: () {},
      icon: const Icon(
        Icons.arrow_back,
        color: white,
      ),
    ),
    title: Text(
      title,
      style: TextStyle(
        color: white.withOpacity(.5),
      ),
    ),
    actions: [
      IconButton(
        onPressed: () {},
        icon: const Icon(
          Icons.search,
          color: white,
        ),
      )
    ],
  );
}
