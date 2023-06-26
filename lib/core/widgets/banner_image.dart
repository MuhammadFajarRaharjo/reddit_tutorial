import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';

Widget bannerImage(
    {required Color color, required Widget child, void Function()? onTap}) {
  return GestureDetector(
    onTap: onTap,
    child: DottedBorder(
      color: color,
      dashPattern: const [10, 2],
      borderType: BorderType.RRect,
      radius: const Radius.circular(10),
      child: Container(
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(30)),
        width: double.infinity,
        height: 150,
        child: child,
      ),
    ),
  );
}
