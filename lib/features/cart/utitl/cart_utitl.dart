import 'package:techmart/features/cart/model/product_cart_model.dart';
import 'package:techmart/features/home_page/utils/product_color_util.dart';

String getSubTotalFromCart(List<ProductCartModel> cartModel) {
  final subTotal = cartModel.reduce(
    (a, b) => int.parse(a.regularPrice) > int.parse(b.regularPrice) ? a : b,
  );
  return subTotal.regularPrice.toString();
}

String getTotalDiscounts(List<ProductCartModel> cartList) {
  final discountList =
      cartList
          .map(
            (cart) => ProductUtils.calculateDiscountFromSellingAndBuyongPrice(
              int.parse(cart.sellingPrice),
              int.parse(cart.regularPrice),
            ),
          )
          .toList();
  return discountList.reduce((a, b) => a + b).toString();
}
