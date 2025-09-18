import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:techmart/core/widgets/custem_appbar.dart';
import 'package:techmart/features/accounts/presentation/screens/faq_screen.dart';
import 'package:techmart/features/address/presentation/screens/address_screen.dart';
import 'package:techmart/features/accounts/presentation/widgets/option_widget.dart';
import 'package:techmart/features/authentication/bloc/auth_bloc.dart';
import 'package:techmart/features/authentication/presentation/screens/login_screen.dart';
import 'package:techmart/features/authentication/presentation/widgets/logout_dialog.dart';
import 'package:techmart/features/orders/bloc/order_bloc.dart';
import 'package:techmart/features/orders/presentation/cubit/select_cubit.dart';
import 'package:techmart/features/orders/presentation/presentation/screens/order_screen.dart';
import 'package:techmart/features/orders/service/order_service.dart';
import 'package:techmart/features/profile/cubit/userdetails_cubit.dart';
import 'package:techmart/features/profile/presentation/screens/profile_screen.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: custemAppbar(heading: "Account", context: context),
      body: Column(
        children: [
          OptionWidget(
            wrapWithCubic: true,
            pushScreenWidget: OrderScreen(),

            name: "My Orders",
            icon: SvgPicture.asset(
              "assets/ineventaory.svg",
              width: 25,
              height: 25,
            ),
          ),
          OptionWidget(
            pushScreenWidget: AddressScreen(),
            name: "Address Book",
            icon: Icon(Icons.home, size: 25, color: Colors.black),
          ),
          OptionWidget(
            pushScreenWidget: BlocProvider(
              create: (context) => UserCubit()..fetchUser(),
              child: ProfileScreen(),
            ),
            name: "My Details",
            icon: Icon(Icons.account_circle, color: Colors.black),
          ),
          OptionWidget(
            pushScreenWidget: FaqScreen(),
            name: "FAQs",
            icon: SvgPicture.asset("assets/help.svg", width: 25, height: 25),
          ),
          BlocListener<AuthBlocBloc, AuthBlocState>(
            listener: (context, state) {
              if (state is UnAuthenticated) {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => LoginScreen()),
                  (Route route) => false,
                );
              }
            },
            child: SignOut(
              ontap: () {
                logOutDialog(context);
              },
              name: "Logout",
              icon: Icon(Icons.logout, color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }
}
