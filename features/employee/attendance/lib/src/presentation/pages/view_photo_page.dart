import 'package:flutter/material.dart';
import 'package:l10n/l10n.dart';

class ViewPhotoPage extends StatelessWidget {
  final String imageUrl;

  const ViewPhotoPage({Key? key, required this.imageUrl}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).view_photo),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        alignment: Alignment.center,
        child: InteractiveViewer(
            panEnabled: false, // Set it to false to prevent panning.
            boundaryMargin: const EdgeInsets.all(80),
            minScale: 0.5,
            maxScale: 4,
            child: Image.network(
              imageUrl,
              width: double.infinity,
              height: double.infinity,
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) return child;
                return const Center(
                  child: CircularProgressIndicator(),
                );
              },
            )),
      ),
    );
  }
}
