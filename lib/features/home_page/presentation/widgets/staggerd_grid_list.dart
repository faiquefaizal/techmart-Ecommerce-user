import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:techmart/features/home_page/models/peoduct_model.dart';
import 'package:techmart/features/home_page/presentation/widgets/product_card_widget.dart';

class StaggerdGridList extends StatelessWidget {
  const StaggerdGridList({
    super.key,
    required this.rowCount,
    required this.product,
    required this.child,
  });

  final int rowCount;
  final ProductModel product;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return AnimationConfiguration.staggeredGrid(
      columnCount: 2,
      position: rowCount,
      duration: Duration(milliseconds: 1000),

      child: ScaleAnimation(
        scale: 0.9,

        curve: Curves.easeOutQuart,
        child: FadeInAnimation(
          child: SlideAnimation(
            verticalOffset: 50.0,
            curve: Curves.easeOutQuart,
            child: child,
          ),
        ),
      ),
    );
  }
}
