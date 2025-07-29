import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class AddressShimmer extends StatelessWidget {
  const AddressShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          Shimmer.fromColors(
            baseColor: Colors.grey.shade400,
            highlightColor: Colors.grey.shade100,
            child: Container(width: 50, color: Colors.black12),
          ),
          Container(width: 30, color: Colors.black12),
        ],
      ),
    );
  }
}
