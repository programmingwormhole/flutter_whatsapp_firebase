import 'package:flutter/material.dart';

PopupMenuItem<dynamic> popupMenuItem({
  required String title,
  Widget? child,
  void Function()? onTap,
  required int value,
  Color? color,
}) {
  return PopupMenuItem(
    value: value,
    child: Text(
      title,
      style: TextStyle(
        color: color
      ),
    ),
  );
}
