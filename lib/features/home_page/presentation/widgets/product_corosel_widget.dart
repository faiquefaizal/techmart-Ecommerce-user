// lib/features/home_page/presentation/widgets/product_carousel_widget.dart

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:techmart/features/wishlist/cubit/wishlist_cubit.dart';

class ProductCarouselWidget extends StatelessWidget {
  final List<String>? imageUrls;

  const ProductCarouselWidget({super.key, required this.imageUrls});

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      options: CarouselOptions(
        height: 300,
        aspectRatio: 16 / 9,
        viewportFraction: 1.0,
      ),
      items:
          imageUrls?.map((url) {
            return Hero(
              tag: imageUrls!.first,
              child: Material(
                type: MaterialType.transparency,
                child: Image.network(
                  url,
                  fit: BoxFit.cover,
                  width: double.infinity,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      height: 300,
                      width: double.infinity,
                      color: Colors.grey[200],
                      child: const Icon(
                        Icons.image,
                        color: Colors.grey,
                        size: 50,
                      ),
                    );
                  },
                ),
              ),
            );
          }).toList() ??
          [const Center(child: Text('No images'))],
    );
  }
}
