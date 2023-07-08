import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../utils/colors.dart';

ScaffoldFeatureController<SnackBar, SnackBarClosedReason> snackBar({
  required BuildContext context,
  required String message,
  Color? background,
  int? duration,
}) {
  return ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: background ?? primary,
      duration: Duration(seconds: duration ?? 2),
      content: Text(
        message,
        style: const TextStyle(
          color: white,
        ),
      ),
    ),
  );
}
