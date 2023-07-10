import 'package:flutter/material.dart';
import 'package:whatsapp_chat/utils/colors.dart';

PreferredSizeWidget customAppBar({
  required String title,
  String? subtitle,
  required context,
  List<Widget>? action,
  bool? showAction,
}) {
  return AppBar(
    backgroundColor: appBarColor,
    leading: IconButton(
      onPressed: () {
        Navigator.pop(context);
      },
      icon: const Icon(
        Icons.arrow_back,
        color: white,
      ),
    ),
    title: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            color: white.withOpacity(.5),
          ),
        ),
        subtitle == null
            ? const SizedBox()
            : Text(
                subtitle,
                style: TextStyle(color: white.withOpacity(.5), fontSize: 12),
              ),
      ],
    ),
    actions: showAction == true ? action : null,
  );
}
