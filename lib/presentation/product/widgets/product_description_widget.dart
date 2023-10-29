import 'package:fic9_ecommerce_template_app/common/components/space_height.dart';
import 'package:flutter/material.dart';

class ProductDescriptionWidget extends StatelessWidget {
  final String description;
  final EdgeInsetsGeometry padding;

  const ProductDescriptionWidget(
      {super.key, required this.description, required this.padding});

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Padding(
          padding: padding,
          child: const Text('Deskripsi Produk',
              style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500))),
      const SpaceHeight(10.0),
      Padding(
          padding: padding,
          child: Text(description,
              style: const TextStyle(
                fontSize: 12.0,
              ))),
    ]);
  }
}
