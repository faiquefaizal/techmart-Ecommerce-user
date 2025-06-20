import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: Text("cart")));
  }
}


// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:techmart/core/models/product_model.dart';
// import 'package:techmart/screens/user_detailed_screen.dart';

// class UserHomepage extends StatefulWidget {
//   const UserHomepage({Key? key}) : super(key: key);

//   @override
//   State<UserHomepage> createState() => _UserHomepageState();
// }

// class _UserHomepageState extends State<UserHomepage> {
//   final CollectionReference _productsRef = FirebaseFirestore.instance
//       .collection("Products");

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         elevation: 0,
//         title: const Text(
//           'Discover',
//           style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
//         ),
//         actions: [
//           IconButton(
//             icon: const Icon(Icons.notifications_none, color: Colors.black),
//             onPressed: () {},
//           ),
//           IconButton(
//             icon: const Icon(Icons.grid_view, color: Colors.black),
//             onPressed: () {},
//           ),
//         ],
//         bottom: PreferredSize(
//           preferredSize: const Size.fromHeight(56.0),
//           child: Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 16.0),
//             child: Row(
//               children: [
//                 Expanded(
//                   child: TextField(
//                     decoration: InputDecoration(
//                       hintText: 'Search electronics...',
//                       prefixIcon: const Icon(Icons.search),
//                       border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(10),
//                         borderSide: BorderSide.none,
//                       ),
//                       filled: true,
//                       fillColor: Colors.grey[200],
//                     ),
//                   ),
//                 ),
//                 const SizedBox(width: 8),
//                 CircleAvatar(
//                   backgroundColor: Colors.grey[200],
//                   child: const Icon(Icons.mail_outline, color: Colors.black),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//       body: Column(
//         children: [
//           // Category/Filter Chips
//           SizedBox(
//             height: 60,
//             child: ListView(
//               scrollDirection: Axis.horizontal,
//               padding: const EdgeInsets.symmetric(
//                 horizontal: 16.0,
//                 vertical: 8.0,
//               ),
//               children: [
//                 _buildFilterChip('PHONE', Icons.phone_android),
//                 _buildFilterChip('KEYBOARD', Icons.keyboard),
//                 _buildFilterChip('LAPTOP', Icons.laptop_mac),
//                 _buildFilterChip('HEADPHONE', Icons.headset),
//                 _buildFilterChip('WATCH', Icons.watch),
//               ],
//             ),
//           ),
//           // Product Grid
//           Expanded(
//             child: StreamBuilder<QuerySnapshot>(
//               stream: _productsRef.snapshots(),
//               builder: (context, snapshot) {
//                 if (snapshot.connectionState == ConnectionState.waiting) {
//                   return const Center(child: CircularProgressIndicator());
//                 }
//                 if (snapshot.hasError) {
//                   return Center(child: Text('Error: ${snapshot.error}'));
//                 }
//                 if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
//                   return const Center(child: Text('No products found.'));
//                 }

//                 final products =
//                     snapshot.data!.docs.map((doc) {
//                       return ProductModel.fromMap(
//                         doc.data() as Map<String, dynamic>,
//                       );
//                     }).toList();

//                 return GridView.builder(
//                   padding: const EdgeInsets.all(16.0),
//                   gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                     crossAxisCount: 2,
//                     childAspectRatio: 0.75, // Adjust as needed
//                     crossAxisSpacing: 16.0,
//                     mainAxisSpacing: 16.0,
//                   ),
//                   itemCount: products.length,
//                   itemBuilder: (context, index) {
//                     final product = products[index];
//                     return GestureDetector(
//                       onTap: () {
//                         // Navigator.push(
//                         //   context,
//                         //   // MaterialPageRoute(
//                         //   //   builder:
//                         //   //       (context) =>
//                         //   //           // UserProductDetailScreen(product: product),
//                         //   // );
//                         // );
//                       },
//                       child: Card(
//                         elevation: 2,
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(15),
//                         ),
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Stack(
//                               children: [
//                                 ClipRRect(
//                                   borderRadius: const BorderRadius.vertical(
//                                     top: Radius.circular(15),
//                                   ),
//                                   child:
//                                       product.imageUrls != null &&
//                                               product.imageUrls!.isNotEmpty
//                                           ? Image.network(
//                                             product.imageUrls!.first,
//                                             height: 120,
//                                             width: double.infinity,
//                                             fit: BoxFit.cover,
//                                             errorBuilder:
//                                                 (context, error, stackTrace) =>
//                                                     Container(
//                                                       height: 120,
//                                                       width: double.infinity,
//                                                       color: Colors.grey[200],
//                                                       child: Icon(
//                                                         Icons.broken_image,
//                                                         color: Colors.grey[400],
//                                                       ),
//                                                     ),
//                                           )
//                                           : Container(
//                                             height: 120,
//                                             width: double.infinity,
//                                             color: Colors.grey[200],
//                                             child: Icon(
//                                               Icons.image,
//                                               color: Colors.grey[400],
//                                             ),
//                                           ),
//                                 ),
//                                 Positioned(
//                                   top: 8,
//                                   right: 8,
//                                   child: CircleAvatar(
//                                     backgroundColor: Colors.white,
//                                     radius: 15,
//                                     child: Icon(
//                                       Icons.favorite_border,
//                                       size: 20,
//                                       color: Colors.grey[700],
//                                     ),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                             Padding(
//                               padding: const EdgeInsets.all(8.0),
//                               child: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   Text(
//                                     product.productName,
//                                     style: const TextStyle(
//                                       fontWeight: FontWeight.bold,
//                                       fontSize: 16,
//                                     ),
//                                     maxLines: 1,
//                                     overflow: TextOverflow.ellipsis,
//                                   ),
//                                   const SizedBox(height: 4),
//                                   Text(
//                                     '₹ ${product.varients.isNotEmpty ? product.varients.first.sellingPrice.toStringAsFixed(0) : 'N/A'}',
//                                     style: const TextStyle(
//                                       fontWeight: FontWeight.bold,
//                                       fontSize: 15,
//                                       color: Colors.black,
//                                     ),
//                                   ),
//                                   if (product.varients.isNotEmpty &&
//                                       product.varients.first.regularPrice >
//                                           product.varients.first.sellingPrice)
//                                     Text(
//                                       '₹ ${product.varients.first.regularPrice.toStringAsFixed(0)}',
//                                       style: const TextStyle(
//                                         fontSize: 12,
//                                         color: Colors.grey,
//                                         decoration: TextDecoration.lineThrough,
//                                       ),
//                                     ),
//                                 ],
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     );
//                   },
//                 );
//               },
//             ),
//           ),
//         ],
//       ),
//       bottomNavigationBar: BottomNavigationBar(
//         type: BottomNavigationBarType.fixed,
//         selectedItemColor: Colors.blue, // Or your brand color
//         unselectedItemColor: Colors.grey,
//         items: const [
//           BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.favorite_border),
//             label: 'Saved',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.shopping_cart_outlined),
//             label: 'Cart',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.discount_outlined),
//             label: 'Discount',
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildFilterChip(String label, IconData icon) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 4.0),
//       child: Chip(
//         avatar: Icon(icon, color: Colors.grey[700], size: 18),
//         label: Text(label),
//         backgroundColor: Colors.grey[200],
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
//         padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
//       ),
//     );
//   }
// }