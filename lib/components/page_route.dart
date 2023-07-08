import 'package:flutter/material.dart';

Future navigator(context, Widget child) {
  return Navigator.push(
    context,
    MaterialPageRoute(
      builder: (_) => child,
    ),
  );
}
