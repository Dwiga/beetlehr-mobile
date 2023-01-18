import 'package:flutter/material.dart';
import 'package:l10n/l10n.dart';
import 'package:preferences/preferences.dart';

import '../../component.dart';

class SelectFileMethod extends StatelessWidget {
  const SelectFileMethod({
    Key? key,
    this.onTapGallery,
    this.onTapCamera,
  }) : super(key: key);

  final VoidCallback? onTapGallery;
  final VoidCallback? onTapCamera;

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      elevation: 0,
      title: Text(S.of(context).pick_file_from_title),
      contentPadding: const EdgeInsets.all(Dimens.dp16),
      children: [
        _buildGalleryButton(context),
        const SizedBox(height: Dimens.dp16),
        _buildCameraButton(context),
      ],
    );
  }

  Widget _buildGalleryButton(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(Dimens.dp8),
        border: Border.all(color: Theme.of(context).dividerColor),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(Dimens.dp8),
        onTap: onTapGallery,
        child: Padding(
          padding: const EdgeInsets.all(Dimens.dp16),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.photo_library_outlined),
              const SizedBox(width: Dimens.dp24),
              SubTitle1Text(
                S.of(context).gallery,
                style: const TextStyle(fontSize: Dimens.dp12),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCameraButton(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(Dimens.dp8),
        border: Border.all(color: Theme.of(context).dividerColor),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(Dimens.dp8),
        onTap: onTapCamera,
        child: Padding(
          padding: const EdgeInsets.all(Dimens.dp16),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.photo_camera_outlined),
              const SizedBox(width: Dimens.dp24),
              SubTitle1Text(
                S.of(context).camera,
                style: const TextStyle(fontSize: Dimens.dp12),
              )
            ],
          ),
        ),
      ),
    );
  }
}
