import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:techmart/core/utils/price_formater.dart';
import 'package:techmart/core/widgets/custem_appbar.dart';
import 'package:techmart/features/home_page/bloc/product_bloc.dart';
import 'package:techmart/features/home_page/features/image_preview/cubit/image_index_cubit.dart';
import 'package:techmart/features/home_page/models/peoduct_model.dart';
import 'package:techmart/features/home_page/models/product_variet_model.dart';
import 'package:techmart/features/home_page/presentation/widgets/favorite_button_widget.dart';
import 'package:techmart/features/home_page/presentation/widgets/loading_product_card.dart';
import 'package:techmart/features/wishlist/presentation/screens/empty_wishlist_screen.dart';
import 'package:techmart/features/home_page/presentation/screens/product_detailed_screen.dart';
import 'package:techmart/features/home_page/service/product_service.dart';
import 'package:techmart/features/home_page/utils/product_color_util.dart';
import 'package:techmart/features/home_page/utils/text_util.dart';
import 'package:techmart/features/wishlist/cubit/wishlist_cubit.dart';
import 'package:techmart/features/wishlist/presentation/screens/loading_favorites_screen.dart';
import 'package:techmart/features/wishlist/service/wishlistservice.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WishlistCubit, WishlistState>(
      builder: (context, state) {
        if (state is WishlistInitial) {
          return loadingShimmerGrid();
        }
        if (state is EmptyWishlistState) {
          return EmptyWishlistScreen();
        } else if (state is wishlistError) {
          log(state.error);
        }
        if (state is WishlistLoaded) {
          return LoadingFavoritesScreen(state: state);
        }
        return SizedBox.shrink();
      },
    );
  }
}
