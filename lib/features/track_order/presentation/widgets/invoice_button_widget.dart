import 'package:flutter/material.dart';
import 'package:techmart/core/widgets/button_widgets.dart';

class InvoiceButtonWidget extends StatelessWidget {
  final VoidCallback onpressed;
  const InvoiceButtonWidget({super.key, required this.onpressed});

  @override
  Widget build(BuildContext context) {
    return CustemButton(
      borderColor: Colors.grey,
      hieght: 50,
      padding: EdgeInsets.symmetric(vertical: 5, horizontal: 70),
      color: Colors.white,
      label: "Sample",
      onpressed: onpressed,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,

        children: [
          Icon(Icons.print, color: Colors.black),
          Text("Download Invoice", style: TextStyle(color: Colors.black)),
        ],
      ),
    );
  }
}
