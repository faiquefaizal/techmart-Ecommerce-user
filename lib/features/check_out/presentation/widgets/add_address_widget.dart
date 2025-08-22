import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:getwidget/components/border/gf_border.dart';
import 'package:techmart/core/widgets/spacing_widget.dart';
import 'package:techmart/features/address/presentation/screens/address_screen.dart';
import 'package:techmart/features/check_out/presentation/screens/address_select_page.dart';

class AddAddressWidget extends StatelessWidget {
  const AddAddressWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Delivery Address",
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        VerticalSpaceWisget(10),
        Container(
          padding: EdgeInsets.symmetric(vertical: 2, horizontal: 2),
          height: 100,
          // decoration: BoxDecoration(

          //   border: Border.all(color: Colors.grey.shade300, width: 1,style: ),
          //   borderRadius: BorderRadius.circular(15),
          // ),
          child: GFBorder(
            color: Colors.black,
            dashedLine: [4, 6],
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("No address added yet."),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.add),
                    GestureDetector(
                      onTap:
                          () => Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => (AddressScreen()),
                            ),
                          ),
                      child: Text(
                        "Add Address",
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
