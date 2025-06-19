import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

import 'package:techmart/screens/account_screen.dart';
import 'package:techmart/screens/cart_screen.dart';
import 'package:techmart/screens/favorites_screen.dart';
import 'package:techmart/screens/home_screen.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Widget> screens = [
    UserHomepage(),
    FavoritesScreen(),
    CartScreen(),
    AccountScreen(),
  ];
  int selectedScreen = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[selectedScreen],
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.all(Radius.circular(20)),
          ),

          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 6, vertical: 4),
            child: GNav(
              gap: 3,
              tabBorderRadius: 15,
              tabMargin: EdgeInsets.symmetric(horizontal: 0.1),
              selectedIndex: selectedScreen,
              backgroundColor: Colors.black,
              onTabChange: (index) {
                setState(() {
                  selectedScreen = index;
                });
              },
              iconSize: 18,

              textStyle: TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
              rippleColor: Colors.grey,
              color: Colors.white,
              tabBackgroundColor: Colors.white,
              activeColor: Colors.black,

              tabs: [
                GButton(icon: Icons.home, text: "HOME"),
                GButton(icon: Icons.favorite, text: "FAVORITE"),
                GButton(icon: Icons.shopping_cart_rounded, text: "CART"),
                GButton(icon: Icons.account_circle, text: "ACCOUNT"),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
