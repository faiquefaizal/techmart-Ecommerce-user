import 'package:flutter/material.dart';

class SignOut extends StatelessWidget {
  VoidCallback ontap;
  String name;
  Icon icon;
  SignOut({
    super.key,
    required this.ontap,
    required this.name,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ontap,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: SizedBox(
          width: double.infinity,
          child: Row(
            spacing: 15,
            children: [
              icon,

              Text(
                name,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w400,
                  color: Colors.red,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
