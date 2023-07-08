import 'package:flutter/material.dart';

import '../utils/colors.dart';

Widget customButton({
  required Size size,
  required String title,
  void Function()? onTap,
}) {
  return InkWell(
    onTap: onTap,
    child: Container(
      height: 50,
      width: size.width * .85,
      decoration: BoxDecoration(
        color: primary,
        borderRadius: BorderRadius.circular(40),
      ),
      child: Center(
        child: Text(
          title,
          style: const TextStyle(color: white, fontSize: 16),
        ),
      ),
    ),
  );
}
