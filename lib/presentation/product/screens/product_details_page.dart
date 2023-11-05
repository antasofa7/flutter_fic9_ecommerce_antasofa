import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:fic9_ecommerce_template_app/common/components/button.dart';
import 'package:fic9_ecommerce_template_app/common/components/space_height.dart';
import 'package:fic9_ecommerce_template_app/common/constants/colors.dart';
import 'package:fic9_ecommerce_template_app/common/extensions/on_context.dart';
import 'package:fic9_ecommerce_template_app/presentation/home/widgets/image_slider.dart';
import 'package:fic9_ecommerce_template_app/presentation/product/widgets/product_description_widget.dart';

import '../../../data/models/models.dart';
import '../../cart/bloc/cart/cart_bloc.dart';
import '../../cart/screens/cart_page.dart';
import '../widgets/product_info_widget.dart';

class ProductDetailsPage extends StatelessWidget {
  final ProdutctDataModel product;
  const ProductDetailsPage({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    EdgeInsets paddingHorizontal = const EdgeInsets.symmetric(horizontal: 20.0);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Produk'),
      ),
      body: ListView(children: [
        ImageSlider(
          items: product.attributes!.images!.data!,
          fromAsset: false,
        ),
        const SpaceHeight(16.0),
        ProductInfoWidget(
            product: product,
            padding: paddingHorizontal,
            onWishListTap: ((isWishList) {})),
        const SpaceHeight(16.0),
        ProductDescriptionWidget(
            description: product.attributes!.description,
            padding: paddingHorizontal),
        const SpaceHeight(10.0),
        Padding(
          padding: paddingHorizontal,
          child: Divider(
            color: ColorName.grey.withOpacity(.2),
          ),
        )
      ]),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(20.0),
        decoration: BoxDecoration(
            border:
                Border(top: BorderSide(color: ColorName.grey.withOpacity(.2)))),
        child: Row(
          children: [
            Flexible(
                child: Button.filled(
                    onPressed: () {
                      context.read<CartBloc>().add(CartEvent.add(CartModel(
                          product: product,
                          quantity: 1,
                          deliveryPrice: 80000)));
                      context.to(child: const CartPage());
                    },
                    label: 'Add To Cart')),
            const SpaceWidth(16.0),
            Flexible(
              child: Button.outlined(
                onPressed: () {},
                label: "Buy Now",
                color: ColorName.light,
              ),
            )
          ],
        ),
      ),
    );
  }
}
