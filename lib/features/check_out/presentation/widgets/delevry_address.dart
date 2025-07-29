import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:techmart/features/check_out/cubit/selected_address_cubit.dart';
import 'package:techmart/features/check_out/presentation/screens/address_select_page.dart';

class AddressDelivery extends StatelessWidget {
  final String title;
  final String address;
  final SelectedAddressCubit selectCubic;

  const AddressDelivery({
    super.key,
    required this.title,
    required this.address,
    required this.selectCubic,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Delivery Address",
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            TextButton(
              onPressed:
                  () => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder:
                          (context) => BlocProvider.value(
                            value: selectCubic,
                            child: (AddressSelectPage()),
                          ),
                    ),
                  ),
              child: Text(
                "Change",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
          ],
        ),

        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
          child: Row(
            children: [
              Icon(Icons.location_on_outlined, color: Colors.black54),
              const SizedBox(width: 8),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,

                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
                    Text(
                      address,
                      style: TextStyle(color: Colors.black54),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
