import 'package:fic9_ecommerce_template_app/common/components/space_height.dart';
import 'package:fic9_ecommerce_template_app/common/constants/colors.dart';
import 'package:fic9_ecommerce_template_app/common/extensions/int_ext.dart';
import 'package:fic9_ecommerce_template_app/data/models/responses/products/products_response_model.dart';
import 'package:flutter/material.dart';

class ProductInfoWidget extends StatelessWidget {
  final ProdutctDataModel product;
  final EdgeInsetsGeometry padding;
  final void Function(bool isWishList) onWishListTap;

  const ProductInfoWidget(
      {super.key,
      required this.product,
      required this.padding,
      required this.onWishListTap});

  @override
  Widget build(BuildContext context) {
    bool isWishList = false;
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Padding(
          padding: padding,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Flexible(
                child: Text(product.attributes!.name,
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold)),
              ),
              StatefulBuilder(builder: (_, setState) {
                return IconButton(
                  onPressed: () {
                    isWishList = !isWishList;
                    setState(() {});
                    onWishListTap(isWishList);
                  },
                  icon: isWishList
                      ? const Icon(
                          Icons.favorite,
                          color: ColorName.red,
                        )
                      : const Icon(Icons.favorite_border),
                  iconSize: 24.0,
                );
              }),
            ],
          )),
      const SpaceHeight(10.0),
      Padding(
        padding: padding,
        child: Text(
          int.parse(product.attributes!.price).currencyFormatRp,
          style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: ColorName.primary),
        ),
      )
    ]);
  }
}
