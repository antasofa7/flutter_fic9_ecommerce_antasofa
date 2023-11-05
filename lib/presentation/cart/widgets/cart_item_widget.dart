import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../common/common.dart';
import '../../../common/constants/images.dart' as local_images;
import '../../../data/models/models.dart';
import '../bloc/cart/cart_bloc.dart';

class CartItemWidget extends StatelessWidget {
  final CartModel data;
  const CartItemWidget({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5.0),
            border: Border.all(color: ColorName.border)),
        child: Row(children: [
          ClipRRect(
              borderRadius: BorderRadius.circular(5.0),
              child: Image.network(
                Variables.baseUrl +
                    data.product.attributes!.images!.data!.first.attributes!.url
                        .substring(1),
                width: 72.0,
                height: 72.0,
                fit: BoxFit.cover,
              )),
          const SpaceWidth(12.0),
          Flexible(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Flexible(
                    child: Text(
                      data.product.attributes!.name,
                      style: const TextStyle(
                          fontSize: 12.0, fontWeight: FontWeight.bold),
                    ),
                  ),
                  const Spacer(),
                  InkWell(
                    onTap: () =>
                        context.read<CartBloc>().add(CartEvent.remove(data)),
                    child: const ImageIcon(
                      AssetImage(local_images.Images.iconTrash),
                      size: 24.0,
                    ),
                  )
                ],
              ),
              const SpaceHeight(20.0),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    data.priceFormat,
                    style: const TextStyle(
                        fontSize: 12.0,
                        fontWeight: FontWeight.bold,
                        color: ColorName.primary),
                  ),
                  const Spacer(),
                  Container(
                      padding: const EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                          color: ColorName.border,
                          borderRadius: BorderRadius.circular(5.0)),
                      child: Row(children: [
                        GestureDetector(
                            onTap: data.quantity > 1
                                ? () {
                                    context
                                        .read<CartBloc>()
                                        .add(CartEvent.subtract(data));
                                  }
                                : null,
                            child: ColoredBox(
                                color: ColorName.white,
                                child: Icon(
                                  Icons.remove,
                                  color: data.quantity > 1
                                      ? ColorName.black
                                      : ColorName.border,
                                ))),
                        SizedBox(
                            width: 40.0,
                            child:
                                Center(child: Text(data.quantity.toString()))),
                        GestureDetector(
                            onTap: () => context
                                .read<CartBloc>()
                                .add(CartEvent.add(data)),
                            child: const ColoredBox(
                                color: ColorName.white,
                                child: Icon(Icons.add))),
                      ]))
                ],
              )
            ],
          ))
        ]));
  }
}
