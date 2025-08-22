import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class SearchNotFound extends StatelessWidget {
  final String? error;
  const SearchNotFound({super.key, this.error});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          SizedBox(height: 100),
          Lottie.asset("assets/search_not_found.json", width: 200, height: 200),
          Text(
            'No Results Found!',
            style: Theme.of(context).textTheme.headlineSmall,
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 10),

          error == null
              ? Text(
                "Error$error",
                style: TextStyle(fontSize: 14, color: Colors.grey[400]),
                textAlign: TextAlign.center,
              )
              : Text(
                "We couldn't find any products matching your search",
                style: TextStyle(fontSize: 14, color: Colors.grey[400]),
                textAlign: TextAlign.center,
              ),
        ],
      ),
    );
  }
}
