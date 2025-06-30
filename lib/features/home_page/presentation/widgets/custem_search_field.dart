import 'package:flutter/material.dart';
import 'package:techmart/core/utils/genrate_text_from_image/generate_text.dart';

class CustemSearchField extends StatelessWidget {
  final Function(String)? onChanged;
  const CustemSearchField({super.key, this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: SizedBox(
          height: 60,
          child: Row(
            children: [
              const Icon(Icons.search, color: Colors.grey),
              const SizedBox(width: 10),
              Expanded(
                child: TextField(
                  onChanged: onChanged,
                  decoration: InputDecoration(
                    hintText: "Search electronics...",
                    hintStyle: TextStyle(
                      color: Colors.grey.shade400,
                      fontWeight: FontWeight.w500,
                    ),
                    border: InputBorder.none,
                  ),
                ),
              ),
              const IconButton(
                icon: Icon(Icons.camera_alt_outlined, color: Colors.grey),
                onPressed: imageSearch,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

void imageSearch() async {
  await generateText();
}
