import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:techmart/features/home_page/models/peoduct_model.dart';
import 'package:techmart/features/wishlist/model/wish_list_model.dart';
import 'package:techmart/features/wishlist/service/wishlistservice.dart';

part 'wishlist_state.dart';

class WishlistCubit extends Cubit<WishlistState> {
  StreamSubscription? _streamSubscription;
  WishlistCubit() : super(WishlistInitial());

  void fetchWisList() {
    emit(WishlistInitial());

    _streamSubscription?.cancel();
    _streamSubscription = WishlistService.getAllWishList().listen((wishlist) {
      if (wishlist.isEmpty) {
        emit(EmptyWishlistState());
      }
      if (wishlist.isNotEmpty) {
        log(wishlist.length.toString());
        emit(WishlistLoaded(wishlist));
      }
    });
  }

  Future<void> toggleWishList(String productId, String vairientId) async {
    final wishlistId = await WishlistService.checkifProductExistInWishList(
      productId,
      vairientId,
    );
    if (wishlistId != null) {
      WishlistService.delete(wishlistId);
    } else {
      WishlistService.addWishList(productId, vairientId);
    }
  }

  @override
  Future<void> close() {
    _streamSubscription?.cancel();
    return super.close();
  }

  clearWishList() {
    _streamSubscription?.cancel();
    emit(WishlistInitial());
  }
}
