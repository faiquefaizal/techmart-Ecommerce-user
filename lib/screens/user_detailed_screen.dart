import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart'; // For image carousel
import 'package:techmart/core/models/product_model.dart';
import 'package:techmart/core/models/product_varient.dart';

class UserProductDetailScreen extends StatefulWidget {
  final ProductModel product;

  const UserProductDetailScreen({Key? key, required this.product})
    : super(key: key);

  @override
  State<UserProductDetailScreen> createState() =>
      _UserProductDetailScreenState();
}

class _UserProductDetailScreenState extends State<UserProductDetailScreen> {
  int _currentImageIndex = 0;
  String? _selectedColor;
  String? _selectedStorage;

  // Track the currently selected variant based on user choices
  ProductVarientModel? _selectedVariant;

  @override
  void initState() {
    super.initState();
    // Try to pre-select a default variant if available
    if (widget.product.varients.isNotEmpty) {
      _selectedVariant = widget.product.varients.first;
      // You might need more complex logic to set initial color/storage
      // if your variants have predefined initial selections.
    }
  }

  // Function to update selected variant based on color and storage choices
  void _updateSelectedVariant() {
    // Find a variant that matches current color and storage selections
    final matchingVariant = widget.product.varients.firstWhere(
      (variant) {
        bool colorMatches =
            (_selectedColor == null) ||
            (variant.variantValue.contains(_selectedColor!));
        bool storageMatches =
            (_selectedStorage == null) ||
            (variant.variantValue.contains(_selectedStorage!));

        // This logic might need refinement based on exact variantName/variantValue structure
        // e.g., if variantName is "Color" and variantValue is "Red", etc.
        // For simplicity, assuming variantValue contains the selected option string.

        // More robust check: Check if variant name/value map matches selections
        Map<String, String> variantOptionsMap = {};
        for (var option in variant.variantValue.split(', ')) {
          // "Red, 128GB"
          if (option.contains(':')) {
            var parts = option.split(':');
            variantOptionsMap[parts[0].trim()] =
                parts[1].trim(); // "Color": "Red"
          } else {
            // If it's just a value like "Red", you'd need to infer its type
          }
        }

        bool currentChoicesMatch = true;
        if (_selectedColor != null &&
            !variant.variantValue.contains(_selectedColor!)) {
          currentChoicesMatch = false;
        }
        if (_selectedStorage != null &&
            !variant.variantValue.contains(_selectedStorage!)) {
          currentChoicesMatch = false;
        }
        // This is a simplified check; actual matching depends on how variant options are structured.
        // It should match all selected options against a variant's options.
        return currentChoicesMatch;
      },
      orElse:
          () =>
              _selectedVariant!, // Fallback to current selected or first if no match
    );

    setState(() {
      _selectedVariant = matchingVariant;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Determine the product image to display based on selected variant if available
    // Otherwise, use the main product image
    List<String> imagesToDisplay = [];
    if (_selectedVariant?.variantImageUrls != null &&
        _selectedVariant!.variantImageUrls!.isNotEmpty) {
      imagesToDisplay = _selectedVariant!.variantImageUrls!;
    } else if (widget.product.imageUrls != null &&
        widget.product.imageUrls!.isNotEmpty) {
      imagesToDisplay = widget.product.imageUrls!;
    }

    // Extract unique colors and storage options from all variants
    Set<String> availableColors = {};
    Set<String> availableStorage = {};

    for (var variant in widget.product.varients) {
      // Assuming variant.variantValue might be "Color: Red, Storage: 128GB"
      // or just "Red", "128GB"
      if (variant.variantName.toLowerCase().contains('color')) {
        availableColors.add(variant.variantValue);
      } else if (variant.variantName.toLowerCase().contains('storage')) {
        availableStorage.add(variant.variantValue);
      }
      // More robust parsing needed if variantValue is a combined string like "Red, 128GB"
      // You'd need to split and assign.
      // For now, let's assume variantValue is the single option itself for simplicity.
      // If variantValue contains multiple options like "Red, 128GB", you'd need to parse them.
    }

    // A more robust way to get distinct options from variants
    Map<String, Set<String>> distinctOptions =
        {}; // { "Color": {"Red", "Blue"}, "Storage": {"128GB", "256GB"} }
    for (var variant in widget.product.varients) {
      // Split variantValue into individual option parts if it's combined
      // e.g., "Color: Red, Size: M" --> ["Color: Red", "Size: M"]
      List<String> parts =
          variant.variantValue.split(',').map((e) => e.trim()).toList();
      for (String part in parts) {
        if (part.contains(':')) {
          List<String> optionParts =
              part.split(':').map((e) => e.trim()).toList();
          if (optionParts.length == 2) {
            distinctOptions
                .putIfAbsent(optionParts[0], () => {})
                .add(optionParts[1]);
          }
        } else {
          // Fallback if variantValue is just the option, but we need the variantName from ProductVarientModel
          distinctOptions
              .putIfAbsent(variant.variantName, () => {})
              .add(variant.variantValue);
        }
      }
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Details',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.favorite_border, color: Colors.black),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Product Image Carousel
            if (imagesToDisplay.isNotEmpty)
              CarouselSlider(
                items:
                    imagesToDisplay
                        .map(
                          (url) => Image.network(
                            url,
                            fit: BoxFit.cover,
                            width: double.infinity,
                            errorBuilder:
                                (context, error, stackTrace) => Container(
                                  color: Colors.grey[200],
                                  child: Icon(
                                    Icons.broken_image,
                                    color: Colors.grey[400],
                                  ),
                                ),
                          ),
                        )
                        .toList(),
                options: CarouselOptions(
                  height: 250.0,
                  enlargeCenterPage: true,
                  autoPlay: true,
                  aspectRatio: 16 / 9,
                  autoPlayCurve: Curves.fastOutSlowIn,
                  enableInfiniteScroll: true,
                  autoPlayAnimationDuration: const Duration(milliseconds: 800),
                  viewportFraction: 0.8,
                  onPageChanged: (index, reason) {
                    setState(() {
                      _currentImageIndex = index;
                    });
                  },
                ),
              )
            else
              Container(
                height: 250,
                width: double.infinity,
                color: Colors.grey[200],
                child: Icon(Icons.image, color: Colors.grey[400]),
              ),
            const SizedBox(height: 10),

            // Product Title and Price
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.product.productName,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Text(
                        '₹ ${_selectedVariant?.sellingPrice.toStringAsFixed(0) ?? (widget.product.varients.isNotEmpty ? widget.product.varients.first.sellingPrice.toStringAsFixed(0) : 'N/A')}',
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(width: 8),
                      if (_selectedVariant != null &&
                          _selectedVariant!.regularPrice >
                              _selectedVariant!.sellingPrice)
                        Text(
                          '₹ ${_selectedVariant!.regularPrice.toStringAsFixed(0)}',
                          style: const TextStyle(
                            fontSize: 18,
                            color: Colors.grey,
                            decoration: TextDecoration.lineThrough,
                          ),
                        ),
                      const SizedBox(width: 8),
                      if (_selectedVariant != null &&
                          _selectedVariant!.regularPrice >
                              _selectedVariant!.sellingPrice)
                        Text(
                          '${(((_selectedVariant!.regularPrice - _selectedVariant!.sellingPrice) / _selectedVariant!.regularPrice) * 100).toStringAsFixed(0)}% Off',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.green,
                          ),
                        ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Choose Color
            if (distinctOptions.containsKey('Color'))
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Choose Color',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Wrap(
                      spacing: 10.0,
                      children:
                          distinctOptions['Color']!.map((color) {
                            return ChoiceChip(
                              label: Text(color),
                              selected: _selectedColor == color,
                              onSelected: (selected) {
                                setState(() {
                                  _selectedColor = selected ? color : null;
                                  _updateSelectedVariant();
                                });
                              },
                              selectedColor:
                                  Colors.orange, // Highlight selected color
                              labelStyle: TextStyle(
                                color:
                                    _selectedColor == color
                                        ? Colors.white
                                        : Colors.black,
                              ),
                              backgroundColor: Colors.grey[200],
                            );
                          }).toList(),
                    ),
                  ],
                ),
              ),
            const SizedBox(height: 20),

            // Choose Storage Capacity
            if (distinctOptions.containsKey('Storage'))
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Storage Capacity',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Wrap(
                      spacing: 10.0,
                      children:
                          distinctOptions['Storage']!.map((storage) {
                            return ChoiceChip(
                              label: Text(storage),
                              selected: _selectedStorage == storage,
                              onSelected: (selected) {
                                setState(() {
                                  _selectedStorage = selected ? storage : null;
                                  _updateSelectedVariant();
                                });
                              },
                              selectedColor:
                                  Colors.black, // Highlight selected storage
                              labelStyle: TextStyle(
                                color:
                                    _selectedStorage == storage
                                        ? Colors.white
                                        : Colors.black,
                              ),
                              backgroundColor: Colors.grey[200],
                            );
                          }).toList(),
                    ),
                  ],
                ),
              ),
            const SizedBox(height: 20),

            // Product Description
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Product Description',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  const SizedBox(height: 8),
                  Text(widget.product.productDescription),
                  const SizedBox(height: 8),
                  GestureDetector(
                    onTap: () {
                      // Implement "Read more" functionality if needed
                    },
                    child: Text(
                      'Read more',
                      style: TextStyle(
                        color: Colors.blue[700],
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Ratings & Reviews (Simplified Placeholder)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Ratings & Reviews',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Text(
                        '4.0',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Icon(Icons.star, color: Colors.orange, size: 28),
                      const SizedBox(width: 8),
                      Text(
                        '${widget.product.varients.isNotEmpty ? widget.product.varients.first.quantity : 0} Reviews',
                        style: const TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  // Placeholder for individual ratings (simplified)
                  _buildRatingBar(5, 0.8), // 80% 5-star
                  _buildRatingBar(4, 0.6), // 60% 4-star
                  _buildRatingBar(3, 0.4),
                  _buildRatingBar(2, 0.2),
                  _buildRatingBar(1, 0.1),
                ],
              ),
            ),
            const SizedBox(height: 100), // Space for bottom button
          ],
        ),
      ),
      bottomSheet: Container(
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          children: [
            Expanded(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: () {
                  // TODO: Implement Add to Cart logic
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        'Added ${_selectedVariant?.variantName ?? widget.product.productName} to cart!',
                      ),
                    ),
                  );
                },
                child: const Text(
                  'Add to Cart',
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRatingBar(int stars, double percentage) {
    return Row(
      children: [
        SizedBox(
          width: 20,
          child: Text(
            '$stars',
            style: const TextStyle(fontSize: 12, color: Colors.grey),
          ),
        ),
        const Icon(Icons.star, color: Colors.orange, size: 14),
        const SizedBox(width: 4),
        Expanded(
          child: LinearProgressIndicator(
            value: percentage,
            backgroundColor: Colors.grey[300],
            color: Colors.orange,
            minHeight: 8,
          ),
        ),
        const SizedBox(width: 8),
        Text(
          '${(percentage * 100).toStringAsFixed(0)}%',
          style: const TextStyle(fontSize: 12, color: Colors.grey),
        ),
      ],
    );
  }
}
