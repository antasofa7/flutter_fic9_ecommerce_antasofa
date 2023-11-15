import 'package:fic9_ecommerce_template_app/common/constants/colors.dart';
import 'package:flutter/material.dart';

class CustomChipWidget extends StatelessWidget {
  const CustomChipWidget({
    super.key,
    required this.label,
    this.color,
  });

  final String label;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 20.0,
      width: 94.0,
      alignment: Alignment.center,
      decoration: ShapeDecoration(
          color: (color ?? ColorName.red).withOpacity(.05),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5.0),
              side: BorderSide(color: color ?? ColorName.red))),
      child: Text(label,
          style: TextStyle(
              fontSize: 11.0,
              color: color ?? ColorName.red,
              fontWeight: FontWeight.w500)),
    );
  }
}
