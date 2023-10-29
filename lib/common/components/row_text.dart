import 'package:flutter/material.dart';

import '../common.dart';

class RowText extends StatelessWidget {
  final String label, value;
  final Color valueColor;
  final FontWeight fontWeight;
  const RowText(
      {super.key,
      required this.label,
      required this.value,
      this.valueColor = ColorName.black,
      this.fontWeight = FontWeight.normal});

  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      Text(label, style: TextStyle(fontSize: 12.0, fontWeight: fontWeight)),
      Flexible(
          child: Text(value,
              style: TextStyle(fontWeight: fontWeight, color: valueColor)))
    ]);
  }
}
