import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class EmptyOrdersScreen extends StatelessWidget {
  final String? status;
  const EmptyOrdersScreen({super.key, this.status});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 160),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              "assets/ineventaory.svg",
              height: 100,
              width: 100,
              colorFilter: ColorFilter.linearToSrgbGamma(),
            ),
            Text(
              'No ${status ?? ""} Orders!',
              style: Theme.of(context).textTheme.headlineSmall,
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 10),
            Text(
              "You don't have any ongoing",
              style: TextStyle(fontSize: 14, color: Colors.grey[400]),
              textAlign: TextAlign.center,
            ),

            Text(
              "at this time.",
              style: TextStyle(fontSize: 14, color: Colors.grey[400]),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
