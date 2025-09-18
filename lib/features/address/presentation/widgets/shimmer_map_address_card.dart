import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class LoadingMapAddressCard extends StatelessWidget {
  const LoadingMapAddressCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                width: 20,
                height: 20,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 8),

              Container(width: 120, height: 12, color: Colors.white),
            ],
          ),
          const SizedBox(height: 8),

          Container(width: double.infinity, height: 12, color: Colors.white),
          const SizedBox(height: 4),
          Container(width: double.infinity, height: 12, color: Colors.white),
        ],
      ),
    );
  }
}
