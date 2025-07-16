import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:techmart/features/home_page/bloc/product_bloc.dart';
import 'package:techmart/features/home_page/models/product_variet_model.dart';

class varient_button_widget extends StatelessWidget {
  const varient_button_widget({
    super.key,
    required this.variants,
    required this.effectiveVariant,
    required this.representativeVariant,
    required this.value,
  });

  final List<ProductVarientModel> variants;
  final ProductVarientModel effectiveVariant;
  final ProductVarientModel representativeVariant;
  final String value;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        if (variants.contains(effectiveVariant)) {
          context.read<ProductBloc>().add(VariantSelected(effectiveVariant));
        } else {
          context.read<ProductBloc>().add(
            VariantSelected(representativeVariant),
          );
        }
      },
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          side: BorderSide(color: Colors.black, width: 2),
          borderRadius: BorderRadiusGeometry.circular(5),
        ),
        backgroundColor:
            variants.contains(effectiveVariant) ? Colors.black : Colors.white,
        foregroundColor: Colors.white,
      ),
      child: Text(
        value,
        style: TextStyle(
          color:
              variants.contains(effectiveVariant) ? Colors.white : Colors.black,
        ),
      ),
    );
  }
}
