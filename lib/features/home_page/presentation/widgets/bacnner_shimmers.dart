import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

Widget bannerShimmerPlaceholder() {
  return Shimmer.fromColors(
    baseColor: Colors.grey[300]!,
    highlightColor: Colors.grey[100]!,
    child: Container(
      margin: const EdgeInsets.symmetric(horizontal: 12.0),
      height: 150, // Match height of your actual banner carousel
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
    ),
  );
}
