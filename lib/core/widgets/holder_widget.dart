import 'package:flutter/material.dart';

class HolderWIdget extends StatelessWidget {
  const HolderWIdget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: 8,
        width: 70,
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 235, 235, 235),
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}
