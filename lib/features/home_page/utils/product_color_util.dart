import 'package:techmart/features/home_page/models/product_variet_model.dart';

class ProductUtils {
  static int calculateDiscount(ProductVarientModel variant) {
    return variant.sellingPrice > 0
        ? ((variant.sellingPrice - variant.regularPrice) /
                variant.sellingPrice *
                100)
            .round()
        : 0;
  }

  static Map<String, Map<String, List<ProductVarientModel>>> groupVariants(
    List<ProductVarientModel> variants,
  ) {
    final variantGroups = <String, Map<String, List<ProductVarientModel>>>{};
    for (var variant in variants) {
      for (var entry in variant.variantAttributes.entries) {
        final attributeName = entry.key;
        final attributeValue = entry.value ?? '';
        variantGroups
            .putIfAbsent(attributeName, () => {})
            .putIfAbsent(attributeValue, () => [])
            .add(variant);
      }
    }
    return variantGroups;
  }

  static ProductVarientModel getEffectiveVariant(
    Map<String, Map<String, List<ProductVarientModel>>> variantGroups,
    ProductVarientModel? selectedVariant,
    List<ProductVarientModel> variants,
  ) {
    return variantGroups.values
            .expand((group) => group.values.expand((v) => v))
            .contains(selectedVariant)
        ? selectedVariant!
        : variants.first;
  }
}
