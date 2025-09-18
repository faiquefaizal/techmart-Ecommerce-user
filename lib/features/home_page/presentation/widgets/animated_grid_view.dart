import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:techmart/features/home_page/models/peoduct_model.dart';
import 'package:techmart/features/home_page/presentation/widgets/product_card_widget.dart';
import 'package:techmart/features/home_page/presentation/widgets/staggerd_grid_list.dart';

class AnimatedGridView extends StatelessWidget {
  const AnimatedGridView({super.key, required this.products});

  final List<ProductModel> products;

  @override
  Widget build(BuildContext context) {
    return AnimationLimiter(
      child: GridView.builder(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          mainAxisSpacing: 0,
          crossAxisSpacing: 0,
          crossAxisCount: 2,
          childAspectRatio: 0.70,
        ),
        itemCount: products.length,
        itemBuilder: (context, index) {
          final rowCount = index ~/ 2;
          final product = products[index];
          return StaggerdGridList(
            rowCount: rowCount,
            product: product,
            child: ProductCard(product: product),
          );
        },
      ),
    );
  }
}
