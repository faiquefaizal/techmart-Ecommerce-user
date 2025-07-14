import 'package:techmart/features/cart/model/product_cart_model.dart';
import 'package:techmart/features/home_page/utils/product_color_util.dart';

String getSubTotalFromCart(List<ProductCartModel> cartModel) {
  final subTotal = cartModel.fold<int>(
    0,
    (a, b) => a + int.parse(b.regularPrice) * b.quatity,
  );
  return subTotal.toString();
}

String getTotalDiscounts(List<ProductCartModel> cartList) {
  if (cartList.isEmpty) return '0';

  final totalDiscount = cartList.fold<int>(0, (sum, cart) {
    final selling = int.tryParse(cart.sellingPrice) ?? 0;
    final regular = int.tryParse(cart.regularPrice) ?? 0;
    final quantity = cart.quatity;

    final discountPerItem =
        ProductUtils.calculateDiscountFromSellingAndBuyongPrice(
          selling,
          regular,
        );
    return sum + (discountPerItem * quantity);
  });

  return totalDiscount.toString();
}
