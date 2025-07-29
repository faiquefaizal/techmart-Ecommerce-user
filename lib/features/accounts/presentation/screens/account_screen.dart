import 'package:flutter/material.dart';
import 'package:techmart/core/widgets/custem_appbar.dart';
import 'package:techmart/features/accounts/features/address/presentation/screens/address_screen.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: custemAppbar(heading: "Account", context: context),
      body: Column(
        children: [
          GestureDetector(
            onTap: () {
              Navigator.of(
                context,
              ).push(MaterialPageRoute(builder: (context) => AddressScreen()));
            },
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                spacing: 15,
                children: [
                  Icon(Icons.home, size: 25),
                  Text(
                    "Address Book",
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
