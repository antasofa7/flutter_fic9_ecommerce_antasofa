import 'package:flutter/material.dart';

import '../../../common/common.dart';
import '../../../data/models/responses/addAddress/add_address_response_model.dart';

class AddressTileWidget extends StatelessWidget {
  final AddAddressResponseModel data;
  final bool isSelected;
  final void Function()? onTap;
  final void Function()? onEditTap;
  final void Function()? onDeleteTap;
  const AddressTileWidget(
      {super.key,
      required this.data,
      this.isSelected = false,
      this.onTap,
      this.onEditTap,
      this.onDeleteTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: onTap,
        child: Card(
            color: ColorName.white,
            surfaceTintColor: ColorName.white,
            elevation: isSelected ? 2 : 1,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0),
                side: BorderSide(
                    color: isSelected ? ColorName.primary : ColorName.border)),
            child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        data.attributes!.name,
                        style: const TextStyle(
                            fontSize: 14.0, fontWeight: FontWeight.bold),
                      ),
                      const SpaceHeight(16.0),
                      Text(
                        data.attributes!.address,
                        style: const TextStyle(
                            fontSize: 12.0, color: ColorName.grey),
                      ),
                      const SpaceHeight(16.0),
                      Text(
                        data.attributes!.phone,
                        style: const TextStyle(
                            fontSize: 12.0, color: ColorName.grey),
                      ),
                      const SpaceHeight(16.0),
                      Wrap(spacing: 16.0, children: [
                        SizedBox(
                          width: 100,
                          child: Button.filled(
                            label: 'Edit',
                            onPressed: onEditTap,
                          ),
                        ),
                        IconButton(
                            onPressed: onDeleteTap,
                            icon: const ImageIcon(
                              AssetImage(Images.iconTrash),
                              color: ColorName.red,
                            ))
                      ])
                    ]))));
  }
}
