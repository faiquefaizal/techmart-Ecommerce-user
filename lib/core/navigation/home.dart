import 'package:material_symbols_icons/material_symbols_icons.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';
import 'package:stylish_bottom_bar/stylish_bottom_bar.dart';
import 'package:techmart/core/navigation/cubit/navigation_cubit.dart';
import 'package:techmart/features/accounts/presentation/screens/account_screen.dart';
import 'package:techmart/features/cart/bloc/cart_bloc.dart';
import 'package:techmart/features/cart/presentation/screens/cart_screen.dart';
import 'package:techmart/features/home_page/bloc/product_bloc.dart';
import 'package:techmart/features/home_page/cubit/catogory_cubic_cubit.dart';
import 'package:techmart/features/home_page/cubit/cubit/banner_cubit.dart';
import 'package:techmart/features/home_page/features/image_preview/cubit/image_index_cubit.dart';
import 'package:techmart/features/home_page/features/product_filter/cubit/filter_cubit.dart';
import 'package:techmart/features/home_page/presentation/screens/sample_screen.dart';

import 'package:techmart/features/wishlist/presentation/screens/favorites_screen.dart';

class Home extends StatelessWidget {
  Home({super.key});

  List<Widget> screens = [
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) {
            final catogoryCubic = context.read<CatogoryCubicCubit>().state;
            final catId =
                (catogoryCubic is CatagoryCubicLoaded)
                    ? catogoryCubic.selectedId
                    : null;
            return ProductBloc()
              ..add(CombinedSearchAndFilter(catagoryId: catId));
          },
        ),
        BlocProvider(create: (context) => BannerCubit()..fetchBanners()),
        BlocProvider(create: (context) => FilterCubit()),
        BlocProvider(create: (context) => ImageIndexCubit()),
      ],
      child: HomeScreen(),
    ),
    // EmptyWishlistScreen(),
    FavoritesScreen(),
    CartScreen(),
    AccountScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    final navigationIndex = context.watch<NavigationCubit>().state;
    final cartBloc = context.watch<CartBloc>().state;
    final int count =
        cartBloc is CartLoaded ? (cartBloc as CartLoaded).cartItems.length : 0;
    return Scaffold(
      body: screens[navigationIndex],
      bottomNavigationBar: StylishBottomBar(
        option: AnimatedBarOptions(
          inkColor: Colors.grey.shade100,
          inkEffect: true,
          iconStyle: IconStyle.animated,
          barAnimation: BarAnimation.fade,
        ),
        onTap: (value) {
          context.read<NavigationCubit>().changePage(value);
        },

        currentIndex: navigationIndex,
        items: [
          BottomBarItem(
            title: Text("Home"),
            icon: Image.asset(
              "assets/home_30dp_1F1F1F_FILL0_wght400_GRAD0_opsz24.png",
            ),
            selectedColor: Colors.black,

            selectedIcon: Image.asset("assets/home_filled.png"),
            // label: "Home",
          ),
          BottomBarItem(
            icon: Icon(Icons.favorite_border),
            selectedColor: Colors.black,
            selectedIcon: Icon(Icons.favorite, color: Colors.black),
            title: Text("Favorite"),
          ),
          BottomBarItem(
            icon: Stack(
              clipBehavior: Clip.none,
              children: [
                Icon(Icons.shopping_cart_outlined),
                count > 0
                    ? Positioned(
                      right: -2,
                      top: -4,
                      child: Container(
                        padding: const EdgeInsets.all(
                          2,
                        ), // Gives internal spacing
                        constraints: BoxConstraints(
                          minWidth: 14,
                          minHeight: 14,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.black,
                          shape: BoxShape.circle, // Ensures perfect roundness
                        ),
                        child: Center(
                          child: Text(
                            count.toString(),
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 9,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    )
                    : SizedBox.shrink(),
              ],
            ),
            selectedColor: Colors.black,
            selectedIcon: Icon(Icons.shopping_cart, color: Colors.black),
            title: Text("Cart"),
          ),
          BottomBarItem(
            icon: Icon(Icons.account_circle_outlined),
            selectedColor: Colors.black,
            selectedIcon: Icon(Icons.account_circle, color: Colors.black),
            title: Text("Account"),
          ),
        ],
      ),
    );
  }
}
