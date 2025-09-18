import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:lottie/lottie.dart';
import 'package:techmart/features/address/service/user_current_location.dart';
import 'package:techmart/features/authentication/presentation/widgets/logout_dialog.dart';
import 'package:techmart/features/placeorder/presentation/widget/order_placed_dialog.dart';
// import 'package:techmart/features/notification/service/server_side_funtion.dart';

class HeaderWidget extends StatelessWidget {
  const HeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text("Discover", style: Theme.of(context).textTheme.displaySmall),
        IconButton(
          onPressed: () async {
            // ServerSideFuntion.sendFcmServer(
            //   "faXghh2qSDO2OjQC3sZBeL:APA91bE7CtMTKEJNprvRn2hYUZGEGdPa5y4bhumgu0H9BkWF-kxyp04CbO2XkwVOOq5IvOsdWnhzpYq_u3UAzyLN3cqth9cpCHrZDXVJxMvyoiZqb8cY1tU",
            //   "sample",
            //   "hiii test message",
            // );
          },
          icon: Icon(Icons.notifications_none, size: 35, weight: 50),
        ),
      ],
    );
  }
}
