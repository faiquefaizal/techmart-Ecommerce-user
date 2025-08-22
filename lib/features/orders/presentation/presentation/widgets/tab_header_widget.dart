import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:techmart/features/orders/presentation/cubit/select_cubit.dart';

GestureDetector ordertab(
  String label,
  int index,
  int currentIndex,
  BuildContext context,
) {
  bool isSelected = currentIndex == index;
  return GestureDetector(
    onTap: () {
      context.read<TabSelectCubic>().selected(index);
    },
    child: Container(
      margin: EdgeInsets.all(7),
      width: double.infinity,
      padding:
          isSelected
              ? EdgeInsets.symmetric(horizontal: 22, vertical: 12)
              : EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      decoration: BoxDecoration(
        color: isSelected ? Colors.white : Colors.transparent,
        borderRadius: BorderRadius.circular(10),
      ),

      child: Text(
        label,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontWeight: FontWeight.w500,
          color: isSelected ? null : Colors.black26,
        ),
      ),
    ),
  );
}
