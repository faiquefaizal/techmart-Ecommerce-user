import 'package:flutter/material.dart';
import 'package:techmart/features/orders/presentation/widgets/tab_header_widget.dart';

class TabBarWidget extends StatelessWidget {
  const TabBarWidget({super.key, required this.selectedIndex});

  final int selectedIndex;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.grey.shade300,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(child: ordertab("Ongoing", 0, selectedIndex, context)),

          Expanded(child: ordertab("Completed", 1, selectedIndex, context)),
        ],
      ),
    );
  }
}
