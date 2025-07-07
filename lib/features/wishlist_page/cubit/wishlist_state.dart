part of 'wishlist_cubit.dart';

sealed class WishlistState extends Equatable {
  const WishlistState();

  @override
  List<Object> get props => [];
}

final class WishlistInitial extends WishlistState {}

final class EmptyWishlistState extends WishlistState {}

final class WishlistLoaded extends WishlistState {
  final List<WishListModel> wishList;
  const WishlistLoaded(this.wishList);

  bool isWishList(String productId, String varientId) {
    return wishList.any(
      (element) =>
          element.productId == productId && element.varientId == varientId,
    );
  }

  @override
  List<Object> get props => [wishList];
}

final class wishlistError extends WishlistState {
  String error;
  wishlistError(this.error);
}
