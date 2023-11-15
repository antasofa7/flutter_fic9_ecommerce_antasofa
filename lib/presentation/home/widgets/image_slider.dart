import 'package:carousel_slider/carousel_slider.dart';
import 'package:fic9_ecommerce_template_app/common/constants/variables.dart';
import 'package:fic9_ecommerce_template_app/data/models/responses/products/products_response_model.dart';
import 'package:flutter/material.dart';

import '../../../common/components/space_height.dart';
import '../../../common/constants/colors.dart';

class ImageSlider extends StatefulWidget {
  final List<String>? itemsFromAssets;
  final List<ImageDataModel>? items;
  final bool fromAsset;
  const ImageSlider(
      {super.key, this.items, this.itemsFromAssets, this.fromAsset = true});

  @override
  State<ImageSlider> createState() => _ImageSliderState();
}

class _ImageSliderState extends State<ImageSlider> {
  int _current = 0;
  final CarouselController _controller = CarouselController();

  @override
  Widget build(BuildContext context) {
    // print(widget.items);
    return Column(
      children: [
        CarouselSlider(
          items: widget.fromAsset
              ? widget.itemsFromAssets!
                  .map((item) => Image.asset(
                        item,
                        height: 206.0,
                        width: MediaQuery.of(context).size.width,
                        fit: BoxFit.cover,
                      ))
                  .toList()
              : widget.items!
                  .map((item) => Image.network(
                        Variables.baseUrl + item.attributes!.url.substring(1),
                        height: 206.0,
                        width: MediaQuery.of(context).size.width,
                        fit: BoxFit.cover,
                      ))
                  .toList(),
          carouselController: _controller,
          options: CarouselOptions(
            autoPlay: true,
            aspectRatio: 343 / 206,
            viewportFraction: 1,
            onPageChanged: (index, reason) {
              _current = index;
              setState(() {});
            },
          ),
        ),
        const SpaceHeight(22.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: (widget.fromAsset ? widget.itemsFromAssets : widget.items)!
              .asMap()
              .entries
              .map((entry) {
            return GestureDetector(
              onTap: () => _controller.animateToPage(entry.key),
              child: Container(
                width: 12.0,
                height: 12.0,
                margin: const EdgeInsets.symmetric(horizontal: 4.0),
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: (Theme.of(context).brightness == Brightness.dark
                            ? ColorName.grey
                            : ColorName.primary)
                        .withOpacity(_current == entry.key ? 0.9 : 0.4)),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
