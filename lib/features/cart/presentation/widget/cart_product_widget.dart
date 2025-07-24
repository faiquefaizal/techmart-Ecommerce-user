import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:techmart/core/widgets/custem_alrert_dialog.dart';
import 'package:techmart/features/cart/bloc/cart_bloc.dart';
import 'package:techmart/features/cart/model/product_cart_model.dart';
import 'package:techmart/features/home_page/utils/product_color_util.dart';

class CustomProductCard extends StatelessWidget {
  final ProductCartModel cartModel;

  const CustomProductCard({super.key, required this.cartModel});

  @override
  Widget build(BuildContext context) {
    final discount = ProductUtils.calculateDiscountFromSellingAndBuyongPrice(
      int.parse(cartModel.sellingPrice),
      int.parse(cartModel.regularPrice),
    );

    return Card(
      elevation: 2,

      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,

          children: [
            Container(
              width: 100,
              height: 120,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.0),
                border: Border.all(color: Colors.grey, width: 1),
                image: DecorationImage(
                  image: NetworkImage(cartModel.imageUrl),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(width: 16.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        cartModel.productName,
                        style: const TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.w600,
                          color: Colors.black87,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      IconButton(
                        onPressed: () {
                          showDeleteConfirmationDialog(
                            context,
                            () {
                              context.read<CartBloc>().add(
                                DeleteFromCartEvent(cartModel.cartId!),
                              );
                            },
                            "Cart Removed",
                            Colors.red,
                          );
                        },
                        icon: Icon(
                          Icons.delete_outline_outlined,
                          color: Colors.red,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4.0),

                  Text(
                    cartModel.varientAttribute.entries
                        .map((value) => "${value.key}: ${value.value}")
                        .join(" • "),
                    style: const TextStyle(
                      fontSize: 12.0,
                      color: Colors.black54,
                    ),
                  ),
                  const SizedBox(height: 12.0),

                  FittedBox(
                    child: Row(
                      children: [
                        Text(
                          '₹${cartModel.sellingPrice}',
                          style: const TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(width: 8.0),

                        Text(
                          '₹${cartModel.regularPrice}',
                          style: const TextStyle(
                            fontSize: 14.0,
                            color: Colors.black54,
                            decoration: TextDecoration.lineThrough,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(width: 8.0),

                        if (discount > 0)
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 6,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.black.withAlpha(25),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Text(
                              '$discount% OFF',
                              style: const TextStyle(
                                fontSize: 12.0,
                                color: Colors.black87,
                                fontWeight: FontWeight.bold,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12.0),

                  Align(
                    alignment: Alignment.centerRight,
                    child: Container(
                      height: 35,
                      decoration: BoxDecoration(
                        color: Colors.black,
                        border: Border.all(color: Colors.black26),
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.remove, size: 20),
                            color: Colors.white,
                            onPressed: () {
                              context.read<CartBloc>().add(
                                DecreaseQtyEvent(cartModel),
                              );
                            },
                          ),
                          Container(
                            width: 30,
                            alignment: Alignment.center,
                            child: Text(
                              cartModel.quatity.toString(),
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          IconButton(
                            icon: const Icon(Icons.add, size: 20),
                            color: Colors.white,
                            onPressed: () {
                              context.read<CartBloc>().add(
                                IncreaseQtyEvent(cartModel),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
