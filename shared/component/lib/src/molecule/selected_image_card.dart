import 'package:flutter/material.dart';
import 'package:preferences/preferences.dart';

class SelectedImageCard extends StatelessWidget {
  const SelectedImageCard(
      {Key? key, required this.image, required this.fileName, this.onRemove})
      : super(key: key);

  final ImageProvider image;
  final String fileName;
  final VoidCallback? onRemove;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(Dimens.dp4),
        color: Theme.of(context).disabledColor.withOpacity(0.1),
      ),
      width: Dimens.dp100,
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(Dimens.dp4),
            child: Stack(
              children: [
                Image(
                  image: image,
                  width: Dimens.dp100,
                  height: Dimens.dp100,
                  fit: BoxFit.cover,
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) return child;
                    return const SizedBox(
                      height: Dimens.dp100,
                      width: Dimens.dp100,
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    );
                  },
                ),
                if (onRemove != null)
                  Align(
                    alignment: Alignment.topRight,
                    child: IconButton(
                      padding: EdgeInsets.zero,
                      constraints: BoxConstraints.loose(
                          const Size(Dimens.dp24, Dimens.dp24)),
                      onPressed: onRemove,
                      icon: const Icon(Icons.clear),
                      color: StaticColors.red,
                    ),
                  )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(Dimens.dp6),
            child: Text(
              fileName,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          )
        ],
      ),
    );
  }
}
