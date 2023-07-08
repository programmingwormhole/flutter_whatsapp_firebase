import 'package:flutter/material.dart';
import '../utils/colors.dart';

class CustomFormHelper extends StatefulWidget {
  final String title;
  final IconData icon;
  final TextEditingController? controller;

  const CustomFormHelper({
    super.key,
    this.controller,
    required this.title,
    required this.icon,
  });

  @override
  State<CustomFormHelper> createState() => _CustomFormHelperState();
}

class _CustomFormHelperState extends State<CustomFormHelper> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      width: size.width * .9,
      decoration: BoxDecoration(
        color: white.withOpacity(.1),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Center(
        child: TextFormField(
          controller: widget.controller,
          style: const TextStyle(
              color: white, fontSize: 18, fontWeight: FontWeight.w500),
          decoration: InputDecoration(
              prefixIcon: Icon(
                widget.icon,
                color: white.withOpacity(.5),
              ),
              border: InputBorder.none,
              labelText: widget.title,
              labelStyle: TextStyle(
                  color: white.withOpacity(.5),
                  fontSize: 18,
                  fontWeight: FontWeight.w500)),
        ),
      ),
    );
  }
}
