import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

void showImagePreview(BuildContext context, String imageUrl) {
  Navigator.of(context).push(
    PageRouteBuilder(
      opaque: false,
      pageBuilder: (BuildContext context, _, __) {
        return Scaffold(
          backgroundColor: Colors.black.withValues(alpha: 0.5),
          body: Stack(
            children: [
              Center(
                child: PhotoView(
                  imageProvider: NetworkImage(imageUrl),
                  heroAttributes: PhotoViewHeroAttributes(tag: imageUrl),
                  minScale: PhotoViewComputedScale.contained,
                  maxScale: PhotoViewComputedScale.covered * 3,
                  backgroundDecoration: const BoxDecoration(
                    color: Colors.transparent,
                  ),
                ),
              ),
              Positioned(
                top: MediaQuery.of(context).padding.top + 16,
                right: 16,
                child: IconButton(
                  icon: const Icon(Icons.close, color: Colors.white, size: 30),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ),
            ],
          ),
        );
      },
    ),
  );
}
