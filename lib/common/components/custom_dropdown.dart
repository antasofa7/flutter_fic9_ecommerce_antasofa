import 'package:flutter/material.dart';

import '../common.dart';

class CustomDropdown<T> extends StatelessWidget {
  final T value;
  final List<T> items;
  final String label;
  final void Function(T?)? onChanged;
  const CustomDropdown(
      {super.key,
      required this.value,
      required this.items,
      required this.label,
      this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(label,
          style: const TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold)),
      const SpaceHeight(12.0),
      DropdownButtonFormField<T>(
          value: value,
          onChanged: onChanged,
          items: items
              .map<DropdownMenuItem<T>>((T item) =>
                  DropdownMenuItem(value: item, child: Text(item.toString())))
              .toList(),
          decoration: InputDecoration(
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(6.0),
                  borderSide: const BorderSide(color: ColorName.grey)),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(6.0),
                  borderSide: const BorderSide(color: ColorName.grey))))
    ]);
  }
}
