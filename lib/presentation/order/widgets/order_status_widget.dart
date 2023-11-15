import 'package:flutter/material.dart';

import '../../../common/common.dart';

class OrderStatusWidget extends StatelessWidget {
  final List<String> status;
  const OrderStatusWidget({super.key, required this.status});

  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      _Status(
        label: 'Dikemas',
        isActive: status.contains('Dikemas') ||
            status.contains('Dikirim') ||
            status.contains('Diterima'),
        isFirst: true,
      ),
      _Status(
        label: 'Dikirim',
        isActive: status.contains('Diterima') || status.contains('Dikirim'),
      ),
      _Status(
        label: 'Diterima',
        isActive: status.contains('Diterima'),
        isLast: true,
      )
    ]);
  }
}

class _Status extends StatelessWidget {
  final String label;
  final bool isActive;
  final bool isFirst;
  final bool isLast;
  const _Status({
    required this.label,
    required this.isActive,
    this.isFirst = false,
    this.isLast = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Row(children: [
        Container(
          color: isFirst
              ? Colors.transparent
              : isActive
                  ? ColorName.primary
                  : ColorName.border,
          height: 2.0,
          width: MediaQuery.of(context).size.width / 11.88,
        ),
        Icon(
          Icons.check_circle,
          color: isActive ? ColorName.primary : ColorName.border,
          size: 32,
        ),
        Container(
          color: isLast
              ? Colors.transparent
              : isActive
                  ? ColorName.primary
                  : ColorName.border,
          height: 2.0,
          width: MediaQuery.of(context).size.width / 11.88,
        )
      ]),
      const SpaceHeight(12.0),
      Text(label,
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 14.0,
              color: isActive ? ColorName.primary : ColorName.border))
    ]);
  }
}
