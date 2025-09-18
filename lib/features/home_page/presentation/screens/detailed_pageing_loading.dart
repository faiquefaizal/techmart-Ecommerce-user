import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:techmart/features/home_page/models/product_variet_model.dart';

class ProductDetailsShimmer extends StatelessWidget {
  const ProductDetailsShimmer({super.key, required this.varientModel});

  final ProductVarientModel? varientModel;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Hero(
            tag: varientModel!.variantImageUrls!.first,
            child: Image.network(
              varientModel!.variantImageUrls!.first,
              fit: BoxFit.cover,
            ),
          ),
          Shimmer.fromColors(
            baseColor: Colors.grey.shade300,
            highlightColor: Colors.grey.shade100,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(height: 20, width: 120, color: Colors.white),
                const SizedBox(height: 16),

                Container(height: 28, width: 200, color: Colors.white),
                const SizedBox(height: 16),

                Container(height: 20, width: 100, color: Colors.white),
                const SizedBox(height: 16),

                Container(height: 18, width: 120, color: Colors.white),
                const SizedBox(height: 16),

                Container(
                  height: 14,
                  width: double.infinity,
                  color: Colors.white,
                ),
                const SizedBox(height: 8),
                Container(
                  height: 14,
                  width: double.infinity,
                  color: Colors.white,
                ),
                const SizedBox(height: 8),
                Container(height: 14, width: 200, color: Colors.white),
                const SizedBox(height: 16),

                Container(height: 20, width: 160, color: Colors.white),
                const SizedBox(height: 12),

                Wrap(
                  spacing: 8,
                  children: List.generate(
                    3,
                    (index) =>
                        Container(height: 36, width: 72, color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
