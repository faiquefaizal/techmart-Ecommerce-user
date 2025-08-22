import 'package:flutter/material.dart';

import 'package:techmart/core/widgets/button_widgets.dart';
import 'package:techmart/features/track_order/utils/helper_funtions.dart';

class ReturnButtonWidget extends StatelessWidget {
  final DateTime date;
  final VoidCallback onpressed;
  const ReturnButtonWidget({
    super.key,
    required this.onpressed,
    required this.date,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomRight,
      child:
          ckeckEligibleforReturn(date)
              ? ConstrainedBox(
                constraints: BoxConstraints(maxWidth: 115),
                child: CustemButton(
                  padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                  color: Colors.white,
                  borderColor: Colors.grey,
                  hieght: 30,
                  textSize: 12,
                  textcolor: Colors.black,

                  label: "Return Item",
                  onpressed: onpressed,
                ),
              )
              : Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  ConstrainedBox(
                    constraints: BoxConstraints(maxWidth: 130),
                    child: CustemButton(
                      padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                      color: Colors.grey.shade300,
                      borderColor: Colors.grey,
                      hieght: 30,
                      textSize: 12,
                      textcolor: Colors.black38,
                      label: "Return period ended",
                      onpressed: onpressed,
                    ),
                  ),
                  Text(
                    "Return window closed on ${maxRetrunDate(date)}",
                    style: TextStyle(fontSize: 13),
                  ),
                ],
              ),
    );
  }
}
