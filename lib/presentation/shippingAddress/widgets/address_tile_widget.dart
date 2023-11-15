import 'package:flutter/material.dart';

import '../../../common/common.dart';
import '../../../common/components/custom_chip.dart';
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            data.attributes!.name,
                            style: const TextStyle(
                                fontSize: 14.0, fontWeight: FontWeight.bold),
                          ),
                          data.attributes!.is_default
                              ? const CustomChipWidget(
                                  label: 'Utama',
                                  color: ColorName.primary,
                                )
                              // Chip(
                              //     labelPadding: EdgeInsets.zero,
                              //     backgroundColor:
                              //         ColorName.primary.withOpacity(.1),
                              //     shape: RoundedRectangleBorder(
                              //         borderRadius: BorderRadius.circular(5.0),
                              //         side: BorderSide.none),
                              //     label: const Text(
                              //       'Utama',
                              //       style: TextStyle(
                              //           fontSize: 12.0,
                              //           fontWeight: FontWeight.bold,
                              //           color: ColorName.primary),
                              //     ))
                              : const SizedBox()
                        ],
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
                      Row(
                          // spacing: 16.0,
                          children: [
                            Flexible(
                              // width: double.infinity,
                              child: Button.outlined(
                                label: 'Edit',
                                onPressed: onEditTap,
                              ),
                            ),
                            const SpaceWidth(12.0),
                            Container(
                              decoration: ShapeDecoration(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5.0),
                                      side: const BorderSide(
                                          color: ColorName.grey))),
                              child: PopupMenuButton(
                                position: PopupMenuPosition.over,
                                icon: const Icon(Icons.more_vert,
                                    color: ColorName.grey),
                                color: ColorName.white,
                                itemBuilder: (_) => List.generate(
                                    2,
                                    (i) => PopupMenuItem(
                                            child: Text(
                                          [
                                            'Jadikan Alamat Utama',
                                            'Hapus Alamat'
                                          ][i],
                                        ))),
                              ),
                            ),
                            // MenuAnchor(
                            //     alignmentOffset: Offset(1, 2),
                            //     clipBehavior: Clip.none,
                            //     builder: (context, controller, child) {
                            //       return IconButton(
                            //         iconSize: 26.0,
                            //         style: IconButton.styleFrom(
                            //             padding: EdgeInsets.all(12.0),
                            //             shape: RoundedRectangleBorder(
                            //                 borderRadius:
                            //                     BorderRadius.circular(5.0),
                            //                 side: const BorderSide(
                            //                     color: ColorName.grey))),
                            //         onPressed: () => controller.isOpen
                            //             ? controller.close()
                            //             : controller.open(),
                            //         icon: const Icon(Icons.more_vert),
                            //         // const ImageIcon(
                            //         //   AssetImage(Images.iconTrash),
                            //         color: ColorName.grey,
                            //       );
                            //     },
                            //     menuChildren: List.generate(
                            //         2,
                            //         (i) => MenuItemButton(
                            //               // style: MenuItemButton.styleFrom(
                            //               //     backgroundColor: ColorName.white),
                            //               onPressed: [() {}, () {}][i],
                            //               child: Text([
                            //                 'Jadikan Alamat Utama',
                            //                 'Hapus Alamat'
                            //               ][i]),
                            //             )))
                          ])
                    ]))));
  }
}
